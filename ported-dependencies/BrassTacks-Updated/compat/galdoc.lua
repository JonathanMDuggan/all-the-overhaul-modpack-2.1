local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")
local cu = require("category-utils")

if not mods["galdocs-manufacturing"] then return end

local galdoc_advanced = data.raw.item["basic-large-paneling-machined-part"]
local advfitting = data.raw.item["airtight-seal"] and "airtight-seal" or "bolted-flange"

--flange
rm.ReplaceIngredient("bolted-flange", "brass-plate", "corrosion-resistant-paneling-machined-part", 2)
rm.AddIngredient("bolted-flange", "basic-bolts-machined-part", 1)
--pipes are no longer an ingredient to other entities
rm.AddIngredient("pipe-to-ground", "bolted-flange", 2)

--bearing
rm.ReplaceIngredient("brass-balls", "brass-plate", "brass-plate-stock", 1)
rm.ReplaceIngredient("bearing", "brass-plate", "ductile-paneling-machined-part", 2)

if not parts.experimental then return end

--flywheel
rm.ReplaceIngredient("flywheel", "zinc-plate", "zinc-plate-stock", 3)
if galdoc_advanced then
  --it's bulky
  rm.ReplaceIngredient("flywheel", "basic-fine-gearing-machined-part", "basic-gearing-machined-part", 1)
end

--gearbox
rm.RemoveIngredient("gearbox", "galvanized-steel-plate", 99999)
rm.AddIngredient("gearbox", "high-tensile-shafting-machined-part", 4)
rm.AddIngredient("gearbox", "basic-framing-machined-part", 4)
rm.AddIngredient("gearbox", "basic-bolts-machined-part", 2)
if galdoc_advanced then
  --gears of different sizes are required to change speeds
  rm.ReplaceIngredient("gearbox", "basic-fine-gearing-machined-part", "ductile-fine-gearing-machined-part", 4)
  rm.ReplaceProportional("gearbox", "basic-fine-gearing-machined-part", "ductile-gearing-machined-part", 0.67)
else
  rm.ReplaceProportional("gearbox", "basic-gearing-machined-part", "ductile-gearing-machined-part", 0.8)
end
rm.multiply("gearbox", 0.5, true, true, true)

--galdoc why
rm.RemoveIngredient("fast-transport-belt", "ductile-fine-gearing-machined-part", 99999)
rm.RemoveIngredient("fast-transport-belt", "ductile-gearing-machined-part", 99999)
rm.RemoveIngredient("fast-underground-belt", "high-tensile-fine-gearing-machined-part", 99999)
rm.RemoveIngredient("fast-underground-belt", "high-tensile-gearing-machined-part", 99999)
rm.RemoveIngredient("fast-splitter", "high-tensile-fine-gearing-machined-part", 99999)
rm.RemoveIngredient("fast-splitter", "high-tensile-gearing-machined-part", 99999)
rm.RemoveIngredient("assembling-machine-2", "ductile-fine-gearing-machined-part", 99999)
rm.RemoveIngredient("assembling-machine-2", "ductile-gearing-machined-part", 99999)

--advanced gearbox
if galdoc_advanced then
  rm.ReplaceIngredient("advanced-gearbox", "basic-fine-gearing-machined-part", "very-high-tensile-fine-gearing-machined-part", 2)
  rm.ReplaceProportional("advanced-gearbox", "basic-fine-gearing-machined-part", "very-high-tensile-gearing-machined-part", 0.67)
else
  rm.ReplaceProportional("advanced-gearbox", "basic-gearing-machined-part", "very-high-tensile-gearing-machined-part", 0.8)
end

rm.RemoveIngredient("express-transport-belt", "ductile-fine-gearing-machined-part", 99999)
rm.RemoveIngredient("express-transport-belt", "ductile-gearing-machined-part", 99999)
rm.RemoveIngredient("express-underground-belt", "very-high-tensile-fine-gearing-machined-part", 99999)
rm.RemoveIngredient("express-underground-belt", "very-high-tensile-gearing-machined-part", 99999)
rm.RemoveIngredient("express-splitter", "ductile-fine-gearing-machined-part", 99999)
rm.RemoveIngredient("express-splitter", "ductile-gearing-machined-part", 99999)
rm.RemoveIngredient("assembling-machine-3", "ductile-fine-gearing-machined-part", 99999)
rm.RemoveIngredient("assembling-machine-3", "ductile-gearing-machined-part", 99999)

--articulated mechanism
rm.ReplaceProportional("articulated-mechanism", "iron-plate-stock", "basic-bolts-machined-part", 1)
rm.ReplaceProportional("articulated-mechanism", "brass-plate", "ductile-paneling-machined-part", 1)
rm.ReplaceProportional("articulated-mechanism", "brass-plate-stock", "ductile-paneling-machined-part", 1)
rm.ReplaceProportional("articulated-mechanism", "basic-framing-machined-part", "load-bearing-shafting-machined-part", 1)

rm.RemoveIngredient("splitter", "basic-fine-gearing-machined-part", 99999)
rm.RemoveIngredient("splitter", "basic-gearing-machined-part", 99999)
rm.RemoveIngredient("inserter", "load-bearing-shafting-machined-part", 99999)


--hardened hull
--this intermediate is maybe too abstract for GM - should it go?
if galdoc_advanced then
  rm.ReplaceProportional("hardened-hull", "galvanized-steel-plate", "high-tensile-large-paneling-machined-part", 2)
else
  rm.ReplaceProportional("hardened-hull", "galvanized-steel-plate", "high-tensile-paneling-machined-part", 4)
end
rm.ReplaceProportional("hardened-hull", "iron-plate", "thermally-stable-shielding-machined-part", 0.5)
rm.ReplaceProportional("hardened-hull", "invar-plate", "thermally-stable-shielding-machined-part", 1)
rm.AddIngredient("hardened-hull", "corrosion-resistant-rivets-machined-part", 4)

rm.RemoveIngredient("oil-refinery", "corrosion-resistant-large-paneling-machined-part", 99999)
rm.RemoveIngredient("oil-refinery", "corrosion-resistant-paneling-machined-part", 99999)
rm.RemoveIngredient("chemical-plant", "corrosion-resistant-large-paneling-machined-part", 99999)
rm.RemoveIngredient("chemical-plant", "corrosion-resistant-paneling-machined-part", 99999)


--complex joint
rm.ReplaceProportional("complex-joint", "galvanized-steel-plate", "high-tensile-shafting-machined-part", 8)

--gyroscope
--if motors don't exist recipe uses gears. consider all possible load orders.
if galdoc_advanced then
  rm.ReplaceProportional("gyroscope", "basic-fine-gearing-machined-part", "ductile-fine-gearing-machined-part", 1)
  rm.ReplaceProportional("gyro", "basic-fine-gearing-machined-part", "ductile-fine-gearing-machined-part", 1)
else
  rm.ReplaceProportional("gyroscope", "basic-gearing-machined-part", "ductile-fine-gearing-machined-part", 1)
  rm.ReplaceProportional("gyro", "basic-gearing-machined-part", "ductile-fine-gearing-machined-part", 1)
end
rm.ReplaceProportional("gyroscope", "basic-fine-gearing-machined-part", "ductile-fine-gearing-machined-part", 1)
rm.ReplaceProportional("gyro", "basic-fine-gearing-machined-part", "ductile-fine-gearing-machined-part", 1)
