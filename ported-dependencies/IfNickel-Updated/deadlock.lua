local parts = require("variable-parts")

if deadlock and deadlock.add_stack then
  deadlock.add_stack("nickel-ore", "__IfNickel-Updated__/graphics/icons/stacking/nickel-ore-stacked.png", "deadlock-stacking-1", 64)
  deadlock.add_stack("nickel-plate", "__IfNickel-Updated__/graphics/icons/stacking/nickel-plate-stacked.png", "deadlock-stacking-1", 64)
  deadlock.add_stack("invar-plate", "__IfNickel-Updated__/graphics/icons/stacking/invar-plate-stacked.png", "deadlock-stacking-2", 64)
  deadlock.add_stack(parts.motor, "__IfNickel-Updated__/graphics/icons/stacking/motor-stacked.png", "deadlock-stacking-2", 64)
end

if deadlock and deadlock.add_crate then
  deadlock_crating.add_crate("nickel-ore", "deadlock-crating-1")
  deadlock_crating.add_crate("nickel-plate", "deadlock-crating-1")
  deadlock_crating.add_crate("invar-plate", "deadlock-crating-2")
  deadlock_crating.add_crate(parts.motor, "deadlock-crating-2")
end
