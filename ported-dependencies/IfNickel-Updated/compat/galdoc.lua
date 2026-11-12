local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")
local cu = require("category-utils")

if not mods["galdocs-manufacturing"] then return end

local galdoc_advanced = data.raw.item["basic-large-paneling-machined-part"]

--motor
rm.ReplaceProportional(parts.motor, "nickel-plate", "basic-paneling-machined-part", 0.5)
rm.ReplaceProportional(parts.motor, "basic-framing-machined-part", "basic-shafting-machined-part", 1)

--replaceproportional will round values less than 1 up. we want these to be cheap
rm.ReplaceProportional("gm-bender-recipe", "copper-cable", parts.motor, 0.01)
rm.ReplaceProportional("gm-drill-press-recipe", "copper-cable", parts.motor, 0.01)
rm.ReplaceProportional("gm-grinder-recipe", "copper-cable", parts.motor, 0.01)
rm.ReplaceProportional("gm-metal-bandsaw-recipe", "copper-cable", parts.motor, 0.01)
rm.ReplaceProportional("gm-metal-extruder-recipe", "copper-cable", parts.motor, 0.01)
rm.ReplaceProportional("gm-metal-lathe-recipe", "copper-cable", parts.motor, 0.01)
rm.ReplaceProportional("gm-mill-recipe", "copper-cable", parts.motor, 0.01)
rm.ReplaceProportional("gm-roller-recipe", "copper-cable", parts.motor, 0.01)
rm.ReplaceProportional("gm-spooler-recipe", "copper-cable", parts.motor, 0.01)
rm.ReplaceProportional("gm-threader-recipe", "copper-cable", parts.motor, 0.01)
rm.ReplaceProportional("gm-welder-recipe", "copper-cable", parts.motor, 0.01)

rm.RemoveIngredient("fast-inserter", "copper-cable", 99999)
rm.RemoveIngredient("bulk-inserter", "copper-cable", 99999)
rm.RemoveIngredient("assembling-machine-1", "copper-cable", 99999)
rm.RemoveIngredient("assembling-machine-2", "copper-cable", 99999)

--valve
rm.ReplaceProportional("invar-valve", "invar-plate", "thermally-stable-shafting-machined-part", 1)
rm.ReplaceProportional("invar-valve", "copper-plate-stock", "ductile-paneling-machined-part", 1)
rm.ReplaceProportional("invar-valve", "basic-piping-machined-part", "corrosion-resistant-piping-machined-part", 1)
rm.ReplaceProportional("invar-valve", "basic-fine-piping-machined-part", "corrosion-resistant-piping-machined-part", 1)
rm.AddIngredient("invar-valve", "high-tensile-bolts-machined-part", 1)

--valves already added
rm.RemoveIngredient("assembling-machine-2", "corrosion-resistant-piping-machined-part", 99999)
rm.RemoveIngredient("assembling-machine-2", "corrosion-resistant-fine-piping-machined-part", 99999)
rm.RemoveIngredient("assembling-machine-3", "corrosion-resistant-piping-machined-part", 99999)
rm.RemoveIngredient("assembling-machine-3", "corrosion-resistant-fine-piping-machined-part", 99999)

rm.RemoveIngredient("oil-refinery", "thermally-stable-shafting-machined-part", 99999)
rm.RemoveIngredient("chemical-plant", "thermally-stable-shafting-machined-part", 99999)

if not parts.experimental then return end

--articulator
if galdoc_advanced then
  rm.ReplaceProportional("motorized-articulator", "basic-fine-gearing-machined-part", "heavy-load-bearing-shafting-machined-part", 1)
else
  rm.ReplaceProportional("motorized-articulator", "basic-gearing-machined-part", "heavy-load-bearing-shafting-machined-part", 1)
end
rm.AddIngredient("motorized-articulator", "high-tensile-bolts-machined-part", 1)
rm.RemoveIngredient("bulk-inserter", "heavy-load-bearing-shafting", 99999)

--thruster
rm.AddIngredient("gimbaled-thruster", "thermally-stable-shielding-machined-part", 1)
