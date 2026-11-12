# Factorio 2.1 port status

Unofficial port of All The Overhauls Modpack (ATOM) 2.2.7 (Factorio 2.0, upstream commit `b6266d6`,
https://github.com/orangedude27/all-the-overhaul-modpack) to Factorio 2.1. Upstream is licensed GNU LGPLv3 (mod portal);
this port stays under the same license. Credit: Orangedude27, Sportacus, cackling fiend, BLackATM, amberatelier.

Branch `upstream-2.2.7` is the untouched upstream state.

## Evidence levels

| Area | Level |
| --- | --- |
| All 156 Lua files compile with Factorio 2.1.24's Lua | tested in engine |
| `util/legacy-recipe.lua` (jalm replacement), new `atom.util` helpers | tested in engine (unit checks) |
| Fluid furnace, brass pipe + pipe to ground, recipe / item / technology shapes used by the port | loaded in Factorio 2.1.24 against base only |
| 248k-Redux prototype names (260 references) | checked statically against 248k-Redux 2.1.49 |
| Everything that touches Krastorio 2, Space Exploration, 5dim, BZ, Bio Industries, AAI, mini-machines ... | **unverified**, needs a load test with the real mods |
| Full pack load, gameplay, save migration from 2.0 | **not run** |

The engine check is `build_check.py` style: a throwaway mod that compiles ATOM's sources and loads the parts that only
need the base game, run with `factorio --dump-data` in an isolated mod directory.

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

Still required but **without a Factorio 2.1 release** (checked on the mod portal 2026-11-11). ATOM cannot be enabled
until these exist for 2.1:

| Mod | License | Note |
| --- | --- | --- |
| BrassTacks-Updated, IfNickel-Updated, ThemTharHills-Updated, BrimStuff-Updated, LasingAround-Updated | MIT | core content, sources at github.com/AtelierAmber |
| Adjustable-Inventory-Size | MIT | settings-updates.lua touches its settings unguarded |
| More_Repair_Packs | custom (XFML) | `integrations/more-repair-packs.lua` is unguarded |
| DoubleWagons | Unlicense | `content/trains` is unguarded |
| 5dim_compatibility | CC BY-NC-ND 4.0 | no derivatives: cannot be ported and shared |

## Next steps

1. Decide for the nine mods above: port them (MIT / Unlicense ones) or make them optional with guards.
2. Load test with the 2.1 releases of all dependencies and fix what the game reports.
3. Compare jalm 2.0.1's `stdlib/data/recipe.lua` with `util/legacy-recipe.lua`.
4. Changelog entry and a save migration test from a 2.0 save.

Optional: brass pipes could get the circuit connector vanilla pipes gained in 2.1 (not added, to keep the port minimal).
