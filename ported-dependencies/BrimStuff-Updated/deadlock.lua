if deadlock and deadlock.add_stack then
  deadlock.add_stack("potassium-nitrate", "__BrimStuff-Updated__/graphics/icons/stacking/potassium-nitrate-stacked.png", "deadlock-stacking-1", 64)
  deadlock.add_stack("rubber", "__BrimStuff-Updated__/graphics/icons/stacking/rubber-stacked.png", "deadlock-stacking-1", 64)
  deadlock.add_stack("gunpowder", "__BrimStuff-Updated__/graphics/icons/stacking/gunpowder-stacked.png", "deadlock-stacking-2", 64)
  deadlock.add_stack("toluene", "__BrimStuff-Updated__/graphics/icons/stacking/toluene-stacked.png", "deadlock-stacking-2", 64)
  data.raw.item["deadlock-stack-potassium-nitrate"].ib_badge = "KN"
end

if deadlock_crating and deadlock.add_crate  then
  deadlock_crating.add_crate("potassium-nitrate", "deadlock-crating-1")
  deadlock_crating.add_crate("rubber", "deadlock-crating-1")
  deadlock_crating.add_crate("gunpowder", "deadlock-crating-2")
  deadlock_crating.add_crate("toluene", "deadlock-crating-2")
  data.raw.item["deadlock-crate-potassium-nitrate"].ib_badge = "KN"
end
