local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")

tf.addPrereq("advanced-circuit", "gold-electronics")
if parts.bz.chlorine then
  local gold_mult = 2
  if parts.bz.gold and mods["space-exploration"] then
    gold_mult = 1
  end
  rm.ReplaceIngredient("pcb", "copper-plate", parts.gold, gold_mult)
  rm.ReplaceProportional("advanced-circuit", "copper-cable", parts.wire, gold_mult)
else
  local gold_mult = 1
  if parts.bz.gold and mods["space-exploration"] then
    gold_mult = 1/2
  end
  rm.ReplaceProportional("advanced-circuit", "copper-cable", parts.wire, gold_mult)
end

if data.raw.item["pcb-solder"] then
  --bismuth y u define hardcoded items in data-updates
  rm.ReplaceIngredient("transceiver", "solder", "pcb-solder", 1)
end

if data.raw.fluid["hydrogen-chloride"] and not parts.aquaregia then
  if (mods["Krastorio2"] and parts.bz.tungsten and mods["BrimStuff-Updated"] and mods["FreightForwarding"]) then
    rm.SetCategory("gold-powder", "basic-chemistry")
    rm.SetCategory("trace-gold-from-copper", "basic-chemistry")
  else
    --bzchlorine hcl is harder to produce in bulk (needs equal sulfuric acid or else is very slow)
    --yes yes aqua regia is more hcl than hno3 but have you considered shut up
    rm.ReplaceIngredient("gold-powder", mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", "hydrogen-chloride", mods["Krastorio2"] and 10 or 2)
    rm.ReplaceIngredient("trace-gold-from-copper", mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", "hydrogen-chloride", mods["Krastorio2"] and 15 or 6)
  end
end

if mods["Krastorio2"] and not parts.bz.chlorine and (rm.CheckIngredient("gold-powder", "aqua-regia") or rm.CheckIngredient("gold-powder", "kr-hydrogen-chloride")) then
  tf.removeRecipeUnlock("kr-advanced-chemistry", "kr-hydrogen-chloride")
  tf.addRecipeUnlock("kr-fluids-chemistry", "kr-hydrogen-chloride")
end

if (mods["Krastorio2"] and parts.bz.tungsten and mods["FreightForwarding"]) and not (mods["BrimStuff-Updated"] or parts.bz.gas) then
  rm.RemoveIngredient("chemical-plant", "tungsten-plate", 99999)
  rm.RemoveIngredient("chemical-plant", "copper-tungsten", 99999)
  rm.RemoveIngredient("chemical-plant", "tungsten-carbide", 99999)
end

if rm.CheckIngredient("processing-unit", mods["Krastorio2"] and "kr-silicon" or "silicon") then
  rm.ReplaceIngredient("processing-unit", mods["Krastorio2"] and "kr-silicon" or "silicon", "integrated-circuit", 10)
else if rm.CheckIngredient("processing-unit", "silicon-wafer") then
  rm.ReplaceIngredient("processing-unit", "silicon-wafer", "integrated-circuit", 10)
else
  rm.ReplaceIngredient("processing-unit", "electronic-circuit", "integrated-circuit", 10)
end end

if rm.CheckIngredient("processing-unit", "mainboard") and not rm.CheckIngredient("mainboard", "temperature-sensor") then -- platinum is off or it's been moved to fans
  rm.RemoveIngredient("processing-unit", "integrated-circuit", 5)
  rm.AddIngredient("mainboard", "integrated-circuit", 50) -- batch of 10
end

if not data.raw.item["silicon-wafer"] then
  rm.AddIngredient("integrated-circuit", "sulfuric-acid", 1)
  rm.SetCategory("integrated-circuit", "crafting-with-fluid")
  rm.AddIngredient("integrated-circuit-silver", "sulfuric-acid", 1)
  rm.SetCategory("integrated-circuit-silver", "crafting-with-fluid")
else
  if data.raw.fluid["epoxy"] then
    rm.ReplaceIngredient("integrated-circuit", "plastic-bar", "epoxy", 2)
    rm.SetCategory("integrated-circuit", "crafting-with-fluid")
  else if mods["LasingAround-Updated"] then
    data.raw.recipe["integrated-circuit"].lasermill = {helium=5, convert=true, se_variant="space-crafting", se_tooltip_entity="se-space-assembling-machine", type="circuit"}
    tf.addPrereq("processing-unit", "laser-mill")
  end end
  --silicon wafers are pretty expensive, reduce the need for them
  rm.multiply("integrated-circuit", 2, true, true, true)
  rm.RemoveIngredient("integrated-circuit", "silicon-wafer", 1)
end

tf.addRecipeUnlock("processing-unit", "integrated-circuit")
if parts.bz.gold and data.raw.recipe["integrated-circuit-silver"] then
  tf.addRecipeUnlock("processing-unit", "integrated-circuit-silver")
end

rm.AddIngredient("speed-module", parts.wire, 5)
rm.AddIngredient("efficiency-module", parts.wire, 5)
rm.AddIngredient("productivity-module", parts.wire, 5)

if mods["space-exploration"] then
  tf.addPrereq("modules", "gold-electronics")
else
  rm.ReplaceProportional("speed-module-3", "advanced-circuit", "integrated-circuit", 2)
  rm.ReplaceProportional("efficiency-module-3", "advanced-circuit", "integrated-circuit", 2)
  rm.ReplaceProportional("productivity-module-3", "advanced-circuit", "integrated-circuit", 2)
end

rm.ReplaceProportional("beacon", "electronic-circuit", "transceiver", 1/4)
--why does aai think beacons have moving parts? the world may never know
rm.ReplaceProportional("beacon", "electric-motor", "transceiver", 1/2)
rm.ReplaceProportional("beacon", "advanced-circuit", "hv-power-regulator", 1/4)
rm.RemoveIngredient("beacon", "cooling-fan", 5)

--This is intentionally done this way because I want the items added even if cables were replaced with fiber optics
rm.RemoveIngredient("beacon", "copper-cable", 10)
if data.raw.recipe["beacon2-recipe"] or data.raw.recipe["beacon3-recipe"] then
  rm.AddIngredient("beacon", parts.wire, 10)
  rm.RemoveIngredient("beacon2-recipe", "copper-cable", 20)
  rm.RemoveIngredient("beacon3-recipe", "copper-cable", 30)
  rm.AddIngredient("beacon2-recipe", "advanced-cable", 10)
  rm.AddIngredient("beacon3-recipe", "advanced-cable", 15)
else
  rm.AddIngredient("beacon", "advanced-cable", 5)
end

if mods["BrassTacks-Updated"] and rm.CheckIngredient("advanced-cable", "silver-wire") then
  --more copper demand = more silver byproduct
  rm.AddIngredient("advanced-cable", "silver-wire", 1)
end

--i reckon the trains have radio stuff since they can tell the status of distant stations
--not literally all the train's electronics are radio related though. only replace
--all circuits if ingredient count is really getting up there.
if data.raw.item["flywheel"] then
  rm.RemoveIngredient("locomotive", "electronic-circuit", 10)
  rm.AddIngredient("locomotive", "transceiver", 2)
else
  rm.RemoveIngredient("locomotive", "electronic-circuit", 5)
  rm.AddIngredient("locomotive", "transceiver", 1)
end

if mods["FreightForwarding"] then
  rm.ReplaceProportional("locomotive", "advanced-circuit", "hv-power-regulator", 0.2)
else
  tf.addPrereq("railway", "gold-electronics")
  rm.RemoveIngredient("train-stop", "electronic-circuit", 5)
  rm.AddIngredient("train-stop", "transceiver", 1)
end

if mods["space-exploration"] and parts.bz.gold then
  rm.AddIngredient("accumulator", parts.wire, 1)
else
  if rm.CheckIngredient("accumulator", "bakelite") then
    --producing 2
    rm.AddIngredient("accumulator", parts.wire, 4)
  else
    rm.AddIngredient("accumulator", parts.wire, 2)
  end
  rm.ReplaceIngredient("rail-signal", "iron-plate", parts.wire, 1)
  rm.ReplaceIngredient("rail-chain-signal", "iron-plate", parts.wire, 1)

  if not (data.raw.item["optical-fiber"] and data.raw.item["tinned-cable"]) then
    tf.addPrereq("circuit-network", "gold-electronics")
  end

  rm.ReplaceProportional("red-wire", "copper-cable", parts.wire, 1)
  rm.ReplaceProportional("green-wire", "copper-cable", parts.wire, 1)
  rm.ReplaceProportional("arithmetic-combinator", "copper-cable", parts.wire, 1)
  rm.ReplaceProportional("constant-combinator", "copper-cable", parts.wire, 1)
  rm.ReplaceProportional("decider-combinator", "copper-cable", parts.wire, 1)
  rm.ReplaceProportional("power-switch", "copper-cable", parts.wire, 1)
  rm.ReplaceProportional("programmable-speaker", "copper-cable", parts.wire, 1)
end
tf.addPrereq("electric-energy-accumulators", "gold-electronics")

tf.addPrereq("electric-engine", "high-voltage-equipment")
rm.ReplaceProportional("electric-engine-unit", "electronic-circuit", "advanced-cable", 1)

tf.addPrereq("electric-energy-distribution-2", "high-voltage-equipment")
tf.removePrereq("electric-energy-distribution-2", "injection-molding")
rm.ReplaceIngredient("substation", "copper-plate", "advanced-cable", 5)
rm.ReplaceIngredient("substation", "cooling-fan", "hv-power-regulator", 1)
rm.RemoveIngredient("substation", "advanced-circuit", 5)

tf.addPrereq("advanced-material-processing-2", "high-voltage-equipment")
tf.removePrereq("advanced-material-processing-2", "chemical-science-pack")
rm.RemoveIngredient("electric-furnace", "advanced-circuit", 5)
rm.AddIngredient("electric-furnace", "hv-power-regulator", 1)
rm.AddIngredient("electric-furnace", "advanced-cable", 3)

rm.RemoveIngredient("flying-robot-frame", "electronic-circuit", 3)
rm.AddIngredient("flying-robot-frame", "transceiver", 1)

tf.removePrereq("construction-robotics", "injection-molding")
tf.removePrereq("logistics-robotics", "injection-molding")
rm.RemoveIngredient("roboport", "advanced-circuit", 20)
rm.ReplaceIngredient("roboport", "cooling-fan", "hv-power-regulator", 5)
rm.AddIngredient("roboport", "transceiver", 10)

rm.ReplaceProportional("passive-provider-chest", "electronic-circuit", "transceiver", 1/3)
rm.ReplaceProportional("active-provider-chest", "electronic-circuit", "transceiver", 1/3)
rm.ReplaceProportional("storage-chest", "electronic-circuit", "transceiver", 1/3)
rm.ReplaceProportional("requester-chest", "electronic-circuit", "transceiver", 1/3)
rm.ReplaceProportional("buffer-chest", "electronic-circuit", "transceiver", 1/3)

if parts.heavyGyro then
  rm.RemoveIngredient("flying-robot-frame", "kr-electronic-components", 9999)

  rm.ReplaceIngredient("artillery-shell", "radar", "transceiver", 1)
  rm.RemoveIngredient("construction-robot", "electronic-circuit", 1)
  rm.RemoveIngredient("construction-robot", "iron-gear-wheel", 1)
  rm.RemoveIngredient("logistic-robot", "advanced-circuit", 1)
  rm.RemoveIngredient("logistic-robot", "bearing", 1)
else
  rm.AddIngredient("artillery-shell", "transceiver", 1)
end

if not rm.CheckIngredient("assembling-machine-3", "electric-engine-unit") then
  rm.AddIngredient("assembling-machine-3", "electric-engine-unit", 2)
  tf.addPrereq("automation-3", "electric-engine")
end
if rm.CheckIngredient("assembling-machine-3", "speed-module") then
  rm.AddIngredient("assembling-machine-3", "hv-power-regulator", 1)
  rm.ReplaceIngredient("assembling-machine-3", "speed-module", "integrated-circuit", 20)
else
  rm.AddIngredient("assembling-machine-3", "hv-power-regulator", 1)
  rm.ReplaceIngredient("advanced-machining-tool", "speed-module", "integrated-circuit", 5)
  rm.RemoveIngredient("advanced-machining-tool", "advanced-circuit", 99)
end

tf.addPrereq("laser", "high-voltage-equipment")
rm.RemoveIngredient("laser-turret", "battery", 12)
rm.ReplaceProportional("laser-turret", "electronic-circuit", "hv-power-regulator", 0.1)
rm.ReplaceIngredient("distractor-capsule", "advanced-circuit", "advanced-cable", 3)
rm.ReplaceIngredient("destroyer-capsule", "speed-module", "hv-power-regulator", 1)

tf.addPrereq("nuclear-power", "high-voltage-equipment")
rm.AddIngredient("steam-turbine", "hv-power-regulator", 1)
rm.ReplaceProportional("steam-turbine", "copper-plate", "advanced-cable", 1/2)

tf.addPrereq("energy-shield-mk2-equipment", "high-voltage-equipment")
rm.AddIngredient("energy-shield-mk2-equipment", "advanced-cable", 10)

rm.AddIngredient("solar-panel-equipment", parts.wire, 6)
rm.AddIngredient("battery-equipment", parts.wire, 6)

tf.addPrereq("battery-mk2-equipment", "high-voltage-equipment")
rm.AddIngredient("battery-mk2-equipment", "hv-power-regulator", 5)

rm.AddIngredient("kr-fusion-reactor-equipment", "advanced-cable", 100)
rm.ReplaceIngredient("kr-fusion-reactor-equipment", "processing-unit", "hv-power-regulator", 50)

rm.AddIngredient("electric-foundry", "hv-power-regulator", 1)
rm.AddIngredient("electric-foundry", "advanced-cable", 6)

rm.AddIngredient("rocket-silo", "hv-power-regulator", mods["LunarLandings"] and 10 or 50)
if not mods["Krastorio2"] then
  rm.ReplaceIngredient("rocket-fuel", "light-oil", "nitric-acid", 10)
end

--rm.ReplaceIngredient("rocket-control-unit", "speed-module", "transceiver", 1)
if mods["space-exploration"] then
  rm.AddIngredient("satellite", "transceiver", 25)
else
  if mods["LunarLandings"] then
    --rm.AddIngredient("rocket-control-unit", "advanced-circuit", 4)
    --tf.addPrereq("rocket-control-unit", "chemical-science-pack")
  else
    rm.AddIngredient("satellite", "transceiver", 100)
    --rm.AddIngredient("rocket-control-unit", "integrated-circuit", 10)
  end
end

if mods["vtk-deepcore-mining"] then
  rm.ReplaceIngredient("vtk-deepcore-mining-gold-ore-chunk-refining", "sulfuric-acid", mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", 20)
end

if mods["MoreScience"] then
  tf.addSciencePack("gold-processing", "advanced-automation-science-pack")
  tf.addSciencePack("gold-electronics", "advanced-automation-science-pack")
  tf.addSciencePack("high-voltage-equipment", "advanced-automation-science-pack")
  tf.addSciencePack("high-voltage-equipment", "electric-power-science-pack")

  rm.AddIngredient("rocketpart-fusion-reactor", "hv-power-regulator", 20)
  rm.AddIngredient("rocketpart-shield-array", "advanced-cable", 50)
end

if mods["LunarLandings"] then
  rm.SetCategory("integrated-circuit", "advanced-circuit-crafting")
  rm.SetCategory("integrated-circuit-silver", "advanced-circuit-crafting")
  rm.SetCategory("gold-wire", "circuit-crafting")
  rm.SetCategory("transceiver", "circuit-crafting")
  rm.SetCategory("advanced-cable", "circuit-crafting")

  --rm.AddIngredient("ll-rich-moon-rock-processing", "nitric-acid", 25, 25)

  rm.RemoveIngredient("processing-unit", "ll-silicon", 99999) --already an ingredient of integrated circuits.

  if not mods["BrassTacks-Updated"] then
    rm.AddIngredient("ll-low-grav-assembling-machine", "hv-power-regulator", 2)
    rm.RemoveIngredient("ll-low-grav-assembling-machine", "advanced-circuit", 10)
  end

  rm.AddIngredient("ll-arc-furnace", "hv-power-regulator", 5)
  rm.AddIngredient("ll-arc-furnace", "advanced-cable", 25)

  if data.raw.item["micron-tolerance-components"] then
    rm.AddIngredient("ll-quantum-resonator", "hv-power-regulator", 10)
  else
    rm.AddIngredient("ll-quantum-resonator", "hv-power-regulator", 5)
    rm.AddIngredient("ll-quantum-resonator", "advanced-cable", 25)
  end

  rm.RemoveIngredient("ll-blank-data-card", "advanced-circuit", 2)
  rm.ReplaceIngredient("ll-blank-data-card", "ll-silicon", "integrated-circuit", 10)
  rm.RemoveProduct("ll-broken-data-card-recycling", "advanced-circuit", 1)

  if not (mods["BrassTacks-Updated"] or mods["IfNickel-Updated"]) then
    rm.AddIngredient("ll-core-extractor", "electric-engine-unit", 5)
    rm.AddIngredient("ll-low-grav-assembling-machine", "electric-engine-unit", 2)
  end

  if mods["BrassTacks-Updated"] then
    rm.RemoveProduct("cheese-ore-processing", "zinc-ore", 5)
    rm.AddProductRaw("cheese-ore-processing", {type="item", name="gold-ore", amount=5})
  end
end

require("compat.aai")
require("compat.kras")
require("compat.bz")
require("compat.freight")
require("compat.248k")

-- What is ib_badge??
if not mods["Krastorio2"] then
  data.raw.item["nitric-acid-barrel"].ib_badge = "NA"
  data.raw.recipe["nitric-acid-barrel"].ib_badge = "NA"
  data.raw.recipe["nitric-acid-barrel"].ib_corner = "left-bottom"
  data.raw.recipe["empty-nitric-acid-barrel"].ib_badge = "NA"
  data.raw.recipe["empty-nitric-acid-barrel"].ib_corner = "left-bottom"
end
if parts.aquaregia then
  data.raw.item["aqua-regia-barrel"].ib_badge = "AR"
  data.raw.recipe["aqua-regia-barrel"].ib_badge = "AR"
  data.raw.recipe["aqua-regia-barrel"].ib_corner = "left-bottom"
  data.raw.recipe["empty-aqua-regia-barrel"].ib_badge = "AR"
  data.raw.recipe["empty-aqua-regia-barrel"].ib_corner = "left-bottom"
end
if mods["Krastorio2"] then
  data.raw.item["potassium-nitrate"].ib_badge = "KN"
end
