# Factorio 2.1 port status

Unofficial port of All The Overhauls Modpack (ATOM) 2.2.7 (Factorio 2.0, upstream commit `b6266d6`,
https://github.com/orangedude27/all-the-overhaul-modpack) to Factorio 2.1. Upstream is licensed GNU LGPLv3 (mod portal);
this port stays under the same license. Credit: Orangedude27, Sportacus, cackling fiend, BLackATM, amberatelier.

Branch `upstream-2.2.7` is the untouched upstream state.

## Evidence levels

Tested on 2026-11-12 with Factorio 2.1.24 and the newest 2.1 releases of all dependencies (65 mods from the mod portal
plus the mods in `ported-dependencies/`), in a separate mods folder filled by `tools/fetch_deps.py`.

| Area | Level |
| --- | --- |
| Whole pack: settings, data, data-updates, data-final-fixes | **loads without errors** (`factorio --dump-data`, exit 0) |
| New game: map creation (all `on_init` scripts, SE universe) and 600 ticks | **runs without errors** (`--create`, `--benchmark`) |
| ATOM's recipe helper lookups | every recipe and item ATOM edits through `util/legacy-recipe.lua` exists; one merge, see Deviations |
| Balance: do recipes, technologies and unlock order match the 2.0 pack? | **not checked** |
| Playing: GUIs, progression, research tree reachability, multiplayer | **not checked** (needs a human) |
| Loading a Factorio 2.0 ATOM save | **not run** |

## What changed for the 2.1 API

- `RecipePrototype::category` -> `categories` (60 recipe literals, 11 assignments, jalm `change_category`).
- Product `probability` -> `independent_probability` (90 literals plus the helper in `integrations/se.lua`).
- `ItemPrototype::fuel_category` -> `fuel_categories` (coal dust, 248k fuel rods).
- `FluidBox::hide_connection_info` -> per pipe connection (brass pipes).
- `mine-entity` research trigger: `entity` -> `entities`.
- `assembler2pipepictures()` is no longer a global in base (fluid furnace).
- Fusion science packs 1-4: `tool` -> `item` (science packs are plain items since 2.1).
- jalm (no 2.1 release) replaced by `util/legacy-recipe.lua`, written from Factorio-Stdlib's source.
  Unverified against jalm 2.0.1 itself.
- Crafting category lists are filtered to categories that exist (`basic-crafting`, `crafting-or-electromagnetics`, ...).

## Quirks kept on purpose

- `integrations/248k/nuclear-energy.lua`: the loop over `data.raw.item` at the end never matched anything in 2.0
  (it indexes the item name). Left as is.
- Science packs were `tool`s in 2.0, so the sorter never re-sorted the science pack items and the 248k burner never
  got burn recipes for them. Both skip science packs explicitly now (`atom.util.item.getSciencePacks`).

## Fixes needed for the 2.1 dependency versions

- 5dim renamed technologies: `5d-radars-<n>` -> `radar-<n+1>`, `5d-flamethrower-turrets-<n>` -> `flamethrower-<n+1>`.
  The mapping is inferred from the tier comments in ATOM's code, not checked against 5dim's 2.0 source.
- `data.raw.tool` is nil when no mod defines a tool; loops over it are guarded.
- `atom.util.Technology.addIngredient` skips a science pack the technology already has (5dim 2.1 already lists some).
- `removeByName` / `removeByNamePattern` remove unlock effects backwards; removing forwards skipped adjacent entries.
- Material recipes no longer set `subgroup = ""` (rejected by 2.1).
- bzlib 2.1.4 keeps one shared settings table for all mods that use it; with Cobalt2 and 5dim present this crashes
  bztitanium2 (reproducible with only bzlib + bztitanium2 + Cobalt2 + 5dim_core). `ported-dependencies/bzlib` 2.1.5
  resolves the settings per calling mod. Worth reporting upstream (https://github.com/Morganite-MLI/bzlib).
- BrimStuff removed entries from crafting category lists by assigning nil, leaving holes; fixed in the ported copy.

## 5dim kept at its Factorio 2.0 state

The 5dim modules were reworked for 2.1 (re-priced recipes and technologies, new machine and turret stats, and a lot of
new military content). ATOM was balanced against the 2.0 releases, so `integrations/5dim/baseline.lua` resets them:

- 2218 values that differ between 5dim's 2.0 and 2.1 releases (recipe ingredients, technology costs and prerequisites,
  speeds, energy use, module slots, health, turret ranges and damage, ...) are set back to the 2.0 value, as long as
  no other mod has changed them in the meantime. 2214 apply in the data stage.
- Everything 5dim added after 2.0 is hidden and cannot be unlocked: 103 technologies, 110 recipes and their items
  (artillery turrets and shells, slow turrets, land mines, grenades, capsules, combat robots, sniper rifle and ammo,
  uranium shotgun shells, stone/coal/uranium dust).

How the baseline was made: 5dim's 2.0 source (public repository, the commits of 5dim_core 2.0.42, _automation 2.0.3,
_nuclear 2.0.4, _resources 2.0.6, _battlefield 2.0.5) was run in Factorio 2.1.24 with a shim that absorbs missing
graphics, and its prototypes were recorded and compared with the 2.1 releases. Checked afterwards in the full pack: of
178 machine/turret stats that differ between the two releases, 155 equal the 2.0 value and 23 have a third value set by
ATOM or another mod; none is left at the 2.1 value.

Limits: the repository commits are one patch version after the portal releases ATOM 2.2.7 was built against, so tiny
differences are possible. Small and big gun/laser turrets no longer exist in 5dim (ATOM had removed their technologies
anyway). Graphics, sounds, crafting categories, sort orders and the new tier overlay icons are not reset. The entities
of the hidden content still exist, they just cannot be built.

## Open points found while testing

- mini-machines 9.5.9 requires mini-micro-settings, which ATOM's history calls incompatible with its balance.
- Other dependencies (Krastorio 2, Space Exploration, BZ, Bio Industries, ...) were not compared with their 2.0
  releases the way 5dim was.

## Deviations

- Recipes ATOM moves into `electronics` now list `{ "crafting", "electronics" }`, and `electronics` is created if no
  mod provides it. Reason: with one category per recipe gone, this keeps them craftable by hand and in assemblers
  whatever the 2.1 dependency does. Machines that have `crafting` but had no `electronics` in 2.0 can craft them too.

## Dependencies

Changed in `info.json`:

- `jalm` removed (no longer used).
- `bz-dsr-bridge` removed: no 2.1 release; it only orders the original bz mods, which ATOM does not use.
- `MetalsForYou2` (meta mod, no 2.1 release) replaced by its nine sub-mods, which all have 2.1 releases.
- `se-landfill-le` -> `se-landfill-le-fork`, `WipMod_TA-miners` -> `TA-Miners-Reloaded` (2.1 continuations). Unverified.

Ported in this repository (`ported-dependencies/`, see its README): BrassTacks-Updated, IfNickel-Updated,
ThemTharHills-Updated, BrimStuff-Updated, LasingAround-Updated (all 3.0.0) and DoubleWagons (1.1.0). They load in
Factorio 2.1.24 against the base game; their compatibility code for the rest of the pack is unverified.

Made optional because no Factorio 2.1 release exists and they could not be ported:

| Mod | Why not ported | Effect while missing |
| --- | --- | --- |
| Adjustable-Inventory-Size | no public source | inventory size defaults are not applied |
| More_Repair_Packs | custom license (XFML), not reviewed | `integrations/more-repair-packs.lua` is skipped |
| 5dim_compatibility | CC BY-NC-ND 4.0 forbids sharing a modified copy | 5dim's own K2/SE compatibility tweaks are missing; effect on ATOM unknown |

## Next steps

1. Play-test: early game progression, research tree, the new 5dim content.
2. Compare recipes and technologies with a Factorio 2.0 install of the pack (needs the 2.0 mod set).
3. Compare jalm 2.0.1's `stdlib/data/recipe.lua` with `util/legacy-recipe.lua`.
4. Changelog entry and a save migration test from a 2.0 save.

Optional: brass pipes could get the circuit connector vanilla pipes gained in 2.1 (not added, to keep the port minimal).
