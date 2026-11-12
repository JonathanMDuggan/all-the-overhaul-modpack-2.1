local parts = require("variable-parts")

if deadlock and deadlock.add_stack then
  deadlock.add_stack("zinc-ore", "__BrassTacks-Updated__/graphics/icons/zinc-ore-stacked.png", "deadlock-stacking-1", 64)
  deadlock.add_stack("zinc-plate", parts.qualityIconPath("brasstacks", "icons/stacking/zinc-plate-stacked.png"), "deadlock-stacking-1", 64)
  deadlock.add_stack("brass-plate", parts.qualityIconPath("brasstacks", "icons/stacking/brass-plate-stacked.png"), "deadlock-stacking-1", 64)
  if data.raw.item["iron-gear-wheel"].localised_name then
    deadlock.add_stack("iron-gear-wheel", parts.qualityIconPath("brasstacks", "icons/stacking/iron-gear-wheel-krastorio-stacked.png"), "deadlock-stacking-2", 64) --fix icon
  else
    deadlock.add_stack("iron-gear-wheel", parts.qualityIconPath("brasstacks", "icons/stacking/iron-gear-wheel-stacked.png"), "deadlock-stacking-2", 64) --fix icon
  end
  deadlock.add_stack("brass-balls", parts.qualityIconPath("brasstacks", "icons/stacking/brass-balls-stacked.png"), "deadlock-stacking-2", 64)
  deadlock.add_stack("bearing", parts.qualityIconPath("brasstacks", "icons/stacking/bearing-stacked.png"), "deadlock-stacking-3", 64)
end

if deadlock and deadlock.add_crate then
  deadlock_crating.add_crate("zinc-ore", "deadlock-crating-1")
  deadlock_crating.add_crate("zinc-plate", "deadlock-crating-1")
  deadlock_crating.add_crate("brass-plate", "deadlock-crating-1")
  deadlock_crating.add_crate("brass-balls", "deadlock-crating-2")
  deadlock_crating.add_crate("bearing", "deadlock-crating-3")
end
