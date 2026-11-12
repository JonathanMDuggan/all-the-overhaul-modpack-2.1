# Dependencies ported to Factorio 2.1

Unofficial Factorio 2.1 ports of mods ATOM requires that had no 2.1 release on the mod portal (checked 2026-11-11).
Each folder is a complete mod: copy it into the Factorio `mods` folder as is.

| Mod | Ported from | Version | License | Original |
| --- | --- | --- | --- | --- |
| BrassTacks-Updated | commit `7d16536` (2.4.21) | 3.0.0 | MIT | https://github.com/AtelierAmber/BrassTacks-Updated |
| IfNickel-Updated | commit `d2e9fd8` (2.2.15) | 3.0.0 | MIT | https://github.com/AtelierAmber/IfNickel-Updated |
| ThemTharHills-Updated | commit `adc01e9` (2.0.12) | 3.0.0 | MIT | https://github.com/AtelierAmber/ThemTharHills-Updated |
| BrimStuff-Updated | commit `1ea1185` (2.0.15) | 3.0.0 | MIT | https://github.com/AtelierAmber/BrimStuff-Updated |
| LasingAround-Updated | commit `0caf4c8` (2.0.14) | 3.0.0 | MIT | https://github.com/AtelierAmber/LasingAround-Updated |
| DoubleWagons (Black Wagons) | commit `e7b2a2a` (1.0.1) | 1.1.0 | Unlicense | https://github.com/Alkumist/DoubleWagons |

Licenses are as listed on the mod portal. All credit goes to the original authors (ashier / AtelierAmber for the
"Legacy" series; DellAquila, kuxynator and Alkumist for Black Wagons). These are not official releases.

## What changed

The five "Legacy" mods:

- `RecipePrototype::category` -> `categories` (recipe literals, assignments, `recipemod.SetCategory`).
- Product `probability` -> `independent_probability`.
- `always_show_products` / `show_amount_in_title` removed (no longer exist in 2.1).
- Science pack checks in `techfuncs.lua` accept plain items (science packs are no longer tools).
- `assembler2pipepictures()` / `assembler3pipepictures()` are read from the base module (no longer globals).
- BrimStuff: `fuel_category` -> `fuel_categories`.
- `info.json`: `factorio_version` 2.1, `base >= 2.1.22`.

DoubleWagons is not in git because its graphics are about 340 MB. Its port is only this, applied to the original repo:

- `info.json`: `"version": "1.1.0"`, `"factorio_version": "2.1"`,
  `"dependencies": ["base >= 2.1.22", "? elevated-rails >= 2.1.22"]`
- a changelog entry for 1.1.0

## Verification

Each mod, and all six together, load without errors in Factorio 2.1.24 with only the base game (LasingAround with
flib; DoubleWagons also with elevated rails), using `factorio --dump-data`. Not tested: their compatibility code for
Krastorio 2, Space Exploration, BZ, 248k and the other mods ATOM combines them with, and anything in a running game.
