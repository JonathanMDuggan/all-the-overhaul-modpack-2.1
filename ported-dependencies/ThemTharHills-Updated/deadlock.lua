local parts = require("variable-parts")

if deadlock and deadlock.add_stack then
  deadlock.add_stack("gold-ore", "__ThemTharHills-Updated__/graphics/icons/stacking/gold-ore-stacked.png", "deadlock-stacking-1", 64)
  deadlock.add_stack(parts.gold, "__ThemTharHills-Updated__/graphics/icons/stacking/gold-plate-stacked.png", "deadlock-stacking-1", 64)
  deadlock.add_stack("gold-powder", "__ThemTharHills-Updated__/graphics/icons/stacking/gold-powder-stacked.png", "deadlock-stacking-1", 64)
  deadlock.add_stack(parts.wire, "__ThemTharHills-Updated__/graphics/icons/stacking/gold-wire-stacked.png", "deadlock-stacking-2", 64)
  deadlock.add_stack("integrated-circuit", "__ThemTharHills-Updated__/graphics/icons/stacking/integrated-circuit-stacked.png", "deadlock-stacking-3", 64)
  if mods["Krastorio2"] then
    deadlock.add_stack("potassium-nitrate", "__ThemTharHills-Updated__/graphics/icons/stacking/potassium-nitrate-stacked.png", "deadlock-stacking-1", 64)
    data.raw.item["deadlock-stack-potassium-nitrate"].ib_badge = "KN"
  end
  data.raw.item["deadlock-stack-" .. parts.wire].ib_badge = "Au"
  data.raw.item["deadlock-stack-" .. parts.gold].ib_badge = "Au"
  data.raw.item["deadlock-stack-gold-ore"].ib_badge = "Au"
  data.raw.item["deadlock-stack-gold-powder"].ib_badge = "Au"
end

if deadlock and deadlock.add_crate then
  deadlock_crating.add_crate("gold-ore", "deadlock-crating-1")
  deadlock_crating.add_crate(parts.gold, "deadlock-crating-1")
  deadlock_crating.add_crate("gold-powder", "deadlock-crating-1")
  deadlock_crating.add_crate(parts.wire, "deadlock-crating-2")
  deadlock_crating.add_crate("integrated-circuit", "deadlock-crating-3")
  if mods["Krastorio2"] then
    deadlock_crating.add_crate("potassium-nitrate", "deadlock-crating-1")
    data.raw.item["deadlock-crate-potassium-nitrate"].ib_badge = "KN"
  end
  data.raw.item["deadlock-crate-" .. parts.wire].ib_badge = "Au"
  data.raw.item["deadlock-crate-" .. parts.gold].ib_badge = "Au"
  data.raw.item["deadlock-crate-gold-ore"].ib_badge = "Au"
  data.raw.item["deadlock-crate-gold-powder"].ib_badge = "Au"
end
