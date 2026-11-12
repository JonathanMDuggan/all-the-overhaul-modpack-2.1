"""Download the Factorio 2.1 dependencies of ATOM into a separate test mods folder.

What it does:
  1. Reads all-the-overhaul-modpack/info.json and resolves every required dependency (recursively) to its newest
     Factorio 2.1 release on the official mod portal (https://mods.factorio.com).
  2. Skips mods that are part of the game and mods that live in ported-dependencies/ (those are copied instead).
  3. Downloads the zips from the mod portal with YOUR Factorio account and verifies their SHA-1.
  4. Copies ATOM and the ported dependencies next to them.

Nothing is written outside the target folder. Your normal mods folder is not touched.

The mod portal only allows downloads with a username and token. The script looks for them in player-data.json
(the file the game itself stores them in); if it finds none it asks you. The token is at https://factorio.com/profile.
It is sent only to mods.factorio.com and never printed.

usage:
  python tools/fetch_deps.py --dry-run                 # only list what would be downloaded
  python tools/fetch_deps.py                           # download into ../atom-2.1-test/mods
  python tools/fetch_deps.py --target D:/somewhere/mods

Then start the game with:  factorio.exe --mod-directory <target>
"""
import argparse
import getpass
import glob
import hashlib
import json
import os
import pathlib
import re
import shutil
import sys
import urllib.error
import urllib.parse
import urllib.request

REPO = pathlib.Path(__file__).resolve().parent.parent
ATOM = REPO / "all-the-overhaul-modpack"
PORTED = REPO / "ported-dependencies"
BUILTIN = {"base", "core", "elevated-rails", "quality", "space-age", "recycler"}
FACTORIO_VERSION = "2.1"
PORTAL = "https://mods.factorio.com"
AGENT = {"User-Agent": "atom-fetch-deps"}


def parse_dependency(text):
    """Returns (prefix, name) of a dependency string such as "? foo >= 1.0"."""
    match = re.match(r"^\s*(\(\?\)|[!?~+])?\s*([^<>=]+?)\s*(?:(?:>=|<=|=|<|>)\s*[\d.]+)?\s*$", text)
    return (match.group(1) or ""), match.group(2).strip()


def version_key(version):
    return tuple(int(part) for part in version.split("."))


def portal_info(name):
    request = urllib.request.Request("%s/api/mods/%s/full" % (PORTAL, urllib.parse.quote(name)), headers=AGENT)
    try:
        with urllib.request.urlopen(request, timeout=60) as response:
            return json.load(response)
    except urllib.error.HTTPError as error:
        if error.code == 404:
            return None
        raise


def newest_release(info):
    releases = [r for r in info.get("releases", []) if r["info_json"].get("factorio_version") == FACTORIO_VERSION]
    return max(releases, key=lambda r: version_key(r["version"])) if releases else None


def local_mods():
    """Mods that are in this repository: name -> folder."""
    result = {"all-the-overhaul-modpack": ATOM}
    if PORTED.is_dir():
        for folder in PORTED.iterdir():
            if (folder / "info.json").is_file():
                result[json.loads((folder / "info.json").read_text(encoding="utf-8"))["name"]] = folder
    return result


def resolve():
    """Returns ({name: release}, [problems]) for everything that has to come from the mod portal."""
    local = local_mods()
    wanted, problems, seen = {}, [], set()
    queue = []
    for folder in local.values():
        info = json.loads((folder / "info.json").read_text(encoding="utf-8"))
        queue += [(dep, info["name"]) for dep in info.get("dependencies", [])]
    for name in ("DoubleWagons",):
        if name not in local:
            problems.append("%s: not in ported-dependencies/ (see ported-dependencies/README.md)" % name)
    while queue:
        text, parent = queue.pop()
        prefix, name = parse_dependency(text)
        if prefix or name in BUILTIN or name in local or name in seen:
            continue
        seen.add(name)
        info = portal_info(name)
        release = newest_release(info) if info else None
        if not release:
            problems.append("%s (needed by %s): no Factorio %s release on the mod portal" % (name, parent, FACTORIO_VERSION))
            continue
        wanted[name] = release
        queue += [(dep, name) for dep in release["info_json"].get("dependencies", [])]
    return wanted, problems


def find_credentials():
    candidates = [os.path.join(os.environ.get("APPDATA", ""), "Factorio", "player-data.json")]
    candidates += glob.glob(r"C:\Program Files (x86)\Steam\userdata\*\427520\remote\player-data.json")
    for path in candidates:
        try:
            data = json.loads(pathlib.Path(path).read_text(encoding="utf-8"))
        except (OSError, ValueError):
            continue
        if data.get("service-username") and data.get("service-token"):
            print("Using the Factorio login stored in", path)
            return data["service-username"], data["service-token"]
    print("No stored Factorio login found. Your token is shown at https://factorio.com/profile")
    return input("Factorio username: ").strip(), getpass.getpass("Factorio token (hidden): ").strip()


def download(release, target, username, token):
    destination = target / release["file_name"]
    if destination.is_file() and hashlib.sha1(destination.read_bytes()).hexdigest() == release["sha1"]:
        return "already there"
    query = urllib.parse.urlencode({"username": username, "token": token})
    request = urllib.request.Request("%s%s?%s" % (PORTAL, release["download_url"], query), headers=AGENT)
    digest = hashlib.sha1()
    temporary = destination.with_suffix(".part")
    with urllib.request.urlopen(request, timeout=300) as response, open(temporary, "wb") as output:
        while True:
            chunk = response.read(1 << 20)
            if not chunk:
                break
            digest.update(chunk)
            output.write(chunk)
    if digest.hexdigest() != release["sha1"]:
        temporary.unlink(missing_ok=True)
        raise SystemExit("Checksum mismatch for %s. If this is the first file, the username/token was probably "
                         "rejected (the portal then returns a login page instead of the mod)." % release["file_name"])
    temporary.replace(destination)
    return "%.1f MB" % (destination.stat().st_size / 1e6)


def main():
    parser = argparse.ArgumentParser(description="Download ATOM's Factorio 2.1 dependencies into a test mods folder.")
    parser.add_argument("--target", default=str(REPO.parent / "atom-2.1-test" / "mods"))
    parser.add_argument("--dry-run", action="store_true", help="only list what would be downloaded")
    arguments = parser.parse_args()
    target = pathlib.Path(arguments.target)

    print("Resolving dependencies on the mod portal ...")
    wanted, problems = resolve()
    for name in sorted(wanted, key=str.lower):
        print("  %-42s %s" % (name, wanted[name]["version"]))
    print("%d mods to download, plus %d from this repository." % (len(wanted), len(local_mods())))
    for problem in problems:
        print("  PROBLEM:", problem)
    if arguments.dry_run:
        return

    username, token = find_credentials()
    target.mkdir(parents=True, exist_ok=True)
    for index, name in enumerate(sorted(wanted, key=str.lower), 1):
        result = download(wanted[name], target, username, token)
        print("[%d/%d] %-42s %s" % (index, len(wanted), wanted[name]["file_name"], result))
    for name, folder in local_mods().items():
        destination = target / name
        if destination.exists():
            shutil.rmtree(destination)
        shutil.copytree(folder, destination)
        print("copied", name)
    print("\nDone. Test mods folder:", target)
    if problems:
        print("Not everything could be resolved, see PROBLEM lines above.")


if __name__ == "__main__":
    sys.exit(main())
