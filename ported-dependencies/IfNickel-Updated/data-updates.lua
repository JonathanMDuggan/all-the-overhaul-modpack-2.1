local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")

if parts.experimental then

  tf.removePrereq("processing-unit", "chemical-science-pack")
  tf.addPrereq("processing-unit", "injection-molding")
  
  if parts.brassExperiment then
    tf.addRecipeUnlock("mechanical-engineering", "motorized-articulator")
  end
  
  if mods["Krastorio2"] then
    --blue circuits produced in pairs
    rm.AddIngredient("processing-unit", "cooling-fan", 2)
  else
    rm.AddIngredient("processing-unit", "cooling-fan", 1)
  end
  tf.removePrereq("electric-energy-distribution-2", "chemical-science-pack")
  tf.addPrereq("electric-energy-distribution-2", "injection-molding")

  rm.AddIngredient("substation", "cooling-fan", 1)

  tf.addPrereq("construction-robotics", "injection-molding")
  tf.addPrereq("logistic-robotics", "injection-molding")
  rm.AddIngredient("roboport", "cooling-fan", 5)

  tf.addPrereq("effect-transmission", "injection-molding")
  rm.AddIngredient("beacon", "cooling-fan", 5)

  rm.AddIngredient("speed-module-3", "cooling-fan", 5)
  rm.AddIngredient("efficiency-module-3", "cooling-fan", 5)
  rm.AddIngredient("productivity-module-3", "cooling-fan", 5)

  rm.AddIngredient("kr-fusion-reactor-equipment", "cooling-fan", 100)
  rm.AddIngredient("personal-roboport-mk2-equipment", "cooling-fan", 50)
  rm.AddIngredient("energy-shield-mk2-equipment", "cooling-fan", 10)

  tf.addPrereq("solar-energy", "mechanical-engineering")
  if parts.aai then
    rm.AddIngredient("solar-panel", "motorized-articulator", 1) --sun tracking + folding up the satellite's solar panels in transit
  else
    rm.AddIngredient("solar-panel", "motorized-articulator", 2)
  end
  rm.RemoveIngredient("solar-panel", "lead-plate", 5)
  rm.RemoveIngredient("solar-panel", "copper-plate", 5)

  tf.addPrereq("robotics", "mechanical-engineering")
  rm.AddIngredient("construction-robot", "motorized-articulator", 1) --grabber
  rm.AddIngredient("logistic-robot", "motorized-articulator", 1) --grabber

  --no prereq - you can still do combinator things
  --this is a little on the expensive side but how many power switches do you even build
  rm.ReplaceIngredient("power-switch", "electronic-circuit", "motorized-articulator", 2)

  tf.addPrereq("logistics-2", "mechanical-engineering")
  rm.AddIngredient("fast-splitter", "motorized-articulator", 1)
  rm.AddIngredient("fast-transport-belt-beltbox", "motorized-articulator", 4)

  if mods["Krastorio2"] then
    rm.AddIngredient("bulk-inserter", "motorized-articulator", 2)
  else
    rm.AddIngredient("bulk-inserter", "motorized-articulator", 5)
    rm.RemoveIngredient("bulk-inserter", "iron-gear-wheel", 5)
    rm.RemoveIngredient("bulk-inserter", "electronic-circuit", 5)
  end

  tf.addPrereq("automation-2", "mechanical-engineering")
  rm.ReplaceIngredient("assembling-machine-2", "electronic-circuit", "motorized-articulator", 3)
  --rm.RemoveIngredient("assembling-machine-2", "electronic-circuit", 99999)
  if mods["aai-industry"] then
    rm.RemoveIngredient("assembling-machine-2", "motorized-articulator", 1)
    --rm.RemoveIngredient("assembling-machine-2", "electric-motor", 99999)
  end
  rm.AddIngredient("assembling-machine-2", "flow-controller", 1)
  if not rm.RemoveIngredient("assembling-machine-2", "tungsten-carbide", 1) then
    rm.RemoveIngredient("assembling-machine-2", "galvanized-steel-plate", 1)
    rm.RemoveIngredient("assembling-machine-2", "steel-plate", 1)
  end

  if not mods["space-exploration"] then
    if mods["MoreScience"] then
      if settings.startup["ifnickel-steel-valve"].value then
        rm.AddIngredient("production-science-fluid", "flow-controller", 12)
      else
        rm.AddIngredient("production-science-fluid", "flow-controller", 18)
      end
    else
      if settings.startup["ifnickel-steel-valve"].value then
        rm.AddIngredient("production-science-pack", "flow-controller", 4)
      else
        rm.AddIngredient("production-science-pack", "flow-controller", 6)
      end
    end
  end

  if not mods["galdocs-manufacturing"] then
    if not mods["LunarLandings"] then
      --You're welcome, LL players. I regret machining tools so I'm undoing them just for you.
      rm.ReplaceIngredient("electric-furnace", "tungsten-carbide", "machining-tool", 1)
    end
    rm.ReplaceIngredient("assembling-machine-2", "tungsten-carbide", "machining-tool", 1)
    tf.addRecipeUnlock("automation-2", "machining-tool")

    if mods["space-exploration"] then
      tf.addRecipeUnlock("se-space-assembling", "advanced-machining-tool")
    else
      tf.addRecipeUnlock("automation-3", "advanced-machining-tool")
    end

    rm.ReplaceIngredient("assembling-machine-3", "speed-module", "advanced-machining-tool", 4)
    rm.RemoveIngredient("assembling-machine-3", "diamond", 4) --moved to machining tool
    rm.RemoveIngredient("assembling-machine-3", "tungsten-carbide", 4) --moved to machining tool

    rm.RemoveIngredient("assembling-machine-2", parts.motor, 2) --aai adds these. lots of other stuff in the recipe has motors.
  end

  if parts.aai then
    rm.RemoveIngredient("assembling-machine-3", "advanced-circuit", 99)
    rm.ReplaceIngredient("advanced-machining-tool", "speed-module", "advanced-circuit", 4)
  end
  rm.ReplaceIngredient("pumpjack", "iron-gear-wheel", "flow-controller", 5)
  rm.RemoveIngredient("pumpjack", "tinned-cable", 5) -- moved to flow controller

  rm.ReplaceIngredient("oil-refinery", "iron-gear-wheel", "flow-controller", 10)
  rm.RemoveIngredient("oil-refinery", "electronic-circuit", 10)

  rm.ReplaceIngredient("chemical-plant", "iron-gear-wheel", "flow-controller", 5)
  rm.RemoveIngredient("chemical-plant", "electronic-circuit", 5)

  rm.ReplaceIngredient("pump", "pipe", "flow-controller", 1)

  tf.addPrereq("atomic-bomb", "gimbaled-thruster")
  rm.AddIngredient("atomic-bomb", "gimbaled-thruster", 5)
  rm.RemoveIngredient("atomic-bomb", "rocket-engine-nozzle", 10)

  rm.AddIngredient("plutonium-atomic-bomb", "gimbaled-thruster", 5)
  rm.RemoveIngredient("plutonium-atomic-bomb", "rocket-engine-nozzle", 10)


  tf.addPrereq("rocket-silo", "gimbaled-thruster")
  if mods["space-exploration"] then
    --se rocket parts are cheaper
    rm.RemoveIngredient("rocket-part", "rocket-engine-nozzle", 10) -- moved to thruster
    rm.AddIngredient("rocket-part", "gimbaled-thruster", 1)
    rm.RemoveIngredient("satellite", "rocket-engine-nozzle", 20) -- moved to thruster
    rm.AddIngredient("satellite", "gimbaled-thruster", 10)
  else
    if mods["MoreScience"] then
      tf.addPrereq("rocketpart-ion-thruster", "gimbaled-thruster")
      rm.AddIngredient("rocketpart-ion-thruster", "gimbaled-thruster", 50)
    else if not mods["LunarLandings"] then
      rm.RemoveIngredient("rocket-part", "rocket-engine-nozzle", 10) -- moved to thruster
      rm.AddIngredient("rocket-part", "gimbaled-thruster", 5)
    end end
    if mods["LunarLandings"] then
      rm.RemoveIngredient("satellite", "rocket-engine-nozzle", 99999)
      rm.AddIngredient("satellite", "gimbaled-thruster", 10)
    else
      rm.ReplaceIngredient("satellite", "rocket-engine-nozzle", "gimbaled-thruster", 20)
    end
  end

  rm.RemoveIngredient("gate", "electronic-circuit", 2)
  rm.AddIngredient("gate", "motorized-articulator", 1)
  tf.addPrereq("gate", "mechanical-engineering")

  rm.ReplaceIngredient("laser-turret", "electric-motor", "motorized-articulator", 5)

  rm.AddIngredient("science-cauldron", "flow-controller", 5)
else
  if mods["aai-industry"] then
    rm.AddIngredient("bulk-inserter", parts.motor, 3)
  else
    rm.AddIngredient("bulk-inserter", parts.motor, 5)
  end
  
  if not parts.aai then
    rm.ReplaceIngredient("gate", "electronic-circuit", parts.motor, 1)
  end

  rm.AddIngredient("fast-splitter", parts.motor, 2)
  rm.AddIngredient("assembling-machine-2", "invar-valve", 1)

  rm.ReplaceIngredient("pumpjack", "iron-gear-wheel", "invar-valve", 5)
  rm.ReplaceIngredient("oil-refinery", "iron-gear-wheel", "invar-valve", 10)
  rm.ReplaceIngredient("chemical-plant", "iron-gear-wheel", "invar-valve", 5)
  rm.ReplaceIngredient("pump", "pipe", "invar-valve", 1)

  rm.AddIngredient("logistic-robot", parts.motor, 1)
  rm.AddIngredient("construction-robot", parts.motor, 1)

  if not parts.aai then
    rm.AddIngredient("laser-turret", parts.motor, 5)
  end

  rm.AddIngredient("science-cauldron", "invar-valve", 5)
end

if parts.brassExperiment then
  --rm.AddIngredient("gearbox", parts.motor, 2, 2)
else
  rm.AddIngredient("fast-transport-belt", parts.motor, 1)
  rm.AddIngredient("fast-underground-belt", parts.motor, 8)
  rm.AddIngredient("fast-transport-belt-loader", parts.motor, 2)
  rm.AddIngredient("fast-transport-belt-beltbox", parts.motor, 4)

  --hull includes invar
  if not mods["galdocs-manufacturing"] then
    rm.ReplaceIngredient("oil-refinery", "steel-plate", "invar-plate", 5)
    rm.AddIngredient("heat-exchanger", "invar-plate", 20)
    rm.ReplaceIngredient("electric-furnace", "steel-plate", "invar-plate", 5)
  end
end

if not parts.aai then
  rm.ReplaceIngredient("pumpjack", "electronic-circuit", parts.motor, 5)
  rm.AddIngredient("inserter", parts.motor, 1)
  rm.AddIngredient("pump", parts.motor, 1)
end

if mods["Krastorio2"] and not mods["aai-industry"] then
  rm.AddIngredient("long-handed-inserter", parts.motor, 1)
  rm.AddIngredient("fast-inserter", parts.motor, 2)
else
  rm.ReplaceIngredient("fast-inserter", "electronic-circuit", parts.motor, 1)
end


rm.AddIngredient("fluid-wagon", "invar-valve", 6)

rm.AddIngredient("active-provider-chest", parts.motor, 1)
if not mods["aai-containers"] then
  rm.AddIngredient("passive-provider-chest", parts.motor, 1)
  rm.AddIngredient("storage-chest", parts.motor, 1)
  rm.AddIngredient("requester-chest", parts.motor, 1)
  rm.AddIngredient("buffer-chest", parts.motor, 1)
end

if not parts.aai  then
  rm.AddIngredient("roboport", parts.motor, 15)
  rm.AddIngredient("steam-engine", parts.motor, 5) --maybe a bit on the heavy side
  rm.AddIngredient("steam-turbine", parts.motor, 10)
end

if not mods["galdocs-manufacturing"] then
  rm.ReplaceIngredient("heat-pipe", "steel-plate", "invar-plate", 10)
  if not parts.brassExperiment then
    rm.AddIngredient("nuclear-reactor", "invar-plate", 100)
  end
end

if not parts.nitinol then
  rm.AddIngredient("steam-turbine", "invar-valve", 10)
  rm.AddIngredient("heat-exchanger", "invar-valve", 10)
end

if parts.aai then
  rm.AddIngredient("assembling-machine-1", parts.motor, 1)
  rm.RemoveIngredient("electric-mining-drill", parts.motor, 1)
else
  rm.AddIngredient("assembling-machine-1", parts.motor, 3)
  rm.ReplaceIngredient("electric-mining-drill", "electronic-circuit", parts.motor, 3)
  rm.RemoveIngredient("electric-mining-drill", "aluminum-cable", 3)
  rm.ReplaceIngredient("offshore-pump", "electronic-circuit", parts.motor, 1)
  rm.RemoveIngredient("offshore-pump", "aluminum-cable", 1)
end

if not mods["galdocs-manufacturing"] then
  rm.AddIngredient("electric-mining-drill", "nickel-plate", 5)

  tf.addPrereq("advanced-material-processing", "invar-processing")
  rm.ReplaceIngredient("steel-furnace", "steel-plate", "invar-plate", 1)
end

tf.addPrereq("automation-2", "valves")

if not parts.zinc and not parts.aai then
  tf.addPrereq("automation-3", "electric-engine")
  rm.AddIngredient("assembling-machine-3", "electric-engine-unit", 2)
end

if not parts.aai then
  rm.AddIngredient("chemical-plant", parts.motor, 5)
  rm.ReplaceIngredient("centrifuge", "iron-gear-wheel", parts.motor, 50)
end

if not (parts.brassExperiment or mods["galdocs-manufacturing"]) then
  if mods["LunarLandings"] then
    rm.ReplaceIngredient("rocket-silo", "steel-plate", "invar-plate", 40)
  else
    rm.ReplaceIngredient("rocket-silo", "steel-plate", "invar-plate", 200)
  end
end

if parts.foundryEnabled then
  rm.AddIngredient("foundry", "nickel-plate", 10)
  if not (parts.brassExperiment or mods["galdocs-manufacturing"]) then
    rm.AddIngredient("electric-foundry", "invar-plate", 10)
  end
end

rm.AddIngredient("flamethrower", "invar-valve", 5)
if not mods["galdocs-manufacturing"] then
  rm.AddIngredient("flamethrower", "invar-plate", 5)
  rm.AddIngredient("flamethrower-turret", "invar-plate", 10)

  rm.ReplaceIngredient("piercing-rounds-magazine", "steel-plate", "invar-plate", 1)
  rm.ReplaceIngredient("piercing-shotgun-shell", "steel-plate", "invar-plate", 2)
  rm.ReplaceIngredient("cannon-shell", "steel-plate", "invar-plate", 1)
  rm.ReplaceIngredient("explosive-cannon-shell", "steel-plate", "invar-plate", 1)

  rm.RemoveIngredient("flamethrower-ammo", "steel-plate", 4)
  rm.AddIngredient("flamethrower-ammo", "invar-plate", 1)

  rm.AddIngredient("modular-armor", "invar-plate", 20)
  rm.AddIngredient("power-armor", "invar-plate", 20)

  rm.AddIngredient("light-armor", "nickel-plate", 10)
  rm.AddIngredient("heavy-armor", "nickel-plate", 10)

  tf.removePrereq("military-2", "steel-processing")
  tf.addPrereq("military-2", "invar-processing")
  tf.addPrereq("gate", "steel-processing")

  rm.ReplaceIngredient("gun-turret", "iron-plate", "nickel-plate", 6)
end

rm.AddIngredient("flamethrower-ammo", "invar-valve", 1)

rm.AddIngredient("modular-armor", parts.motor, 20)

if not parts.aai then
  rm.AddIngredient("radar", parts.motor, 1)
end

tf.addPrereq("engine", "valves")

rm.RemoveIngredient("engine-unit", "pipe", 2)
rm.AddIngredient("engine-unit", "invar-valve", 1)

if parts.aai then
  rm.RemoveIngredient("electric-motor", "iron-plate", 99)
  rm.RemoveIngredient("electric-motor", "aluminum-plate", 99)
  rm.AddIngredient("electric-motor", "nickel-plate", parts.experimental and 2 or 3)
  if rm.CheckIngredient("electric-motor", "bismanol") then
    rm.RemoveIngredient("electric-motor", "nickel-plate", 1)
  end
elseif not mods["galdocs-manufacturing"] then
  --aaii's recipe for the eeu uses normal motors, so this is superfluous
  rm.AddIngredient("electric-engine-unit", "nickel-plate", 5)
end

if not mods["galdocs-manufacturing"] then
  if rm.CheckIngredient("battery", "lead-plate") then
    rm.ReplaceIngredient("battery", "copper-plate", "nickel-plate", 1)
  else
    rm.ReplaceIngredient("battery", "iron-plate", "nickel-plate", 1)
  end
  rm.AddIngredient("rocket-engine-nozzle", "invar-plate", 1)
end

if settings.startup["ifnickel-steel-valve"].value then
  tf.addPrereq("valves", "steel-processing")

  if parts.brassExperiment then
    rm.AddIngredient("invar-valve", "galvanized-steel-plate", 1)
  else
    rm.AddIngredient("invar-valve", "steel-plate", 1)
  end

  rm.RemoveIngredient("fluid-wagon", "steel-plate", 6)
  rm.RemoveIngredient("fluid-wagon", "galvanized-steel-plate", 6)

  rm.RemoveIngredient("pump", "steel-plate", 1)
  rm.RemoveIngredient("pump", "galvanized-steel-plate", 1)

  rm.RemoveIngredient("pumpjack", "steel-plate", 5)
  rm.RemoveIngredient("pumpjack", "galvanized-steel-plate", 5)

  rm.RemoveIngredient("assembling-machine-2", "steel-plate", 1)
  rm.RemoveIngredient("assembling-machine-2", "galvanized-steel-plate", 1)

  rm.RemoveIngredient("heat-exchanger", "steel-plate", 10)
  rm.RemoveIngredient("oil-refinery", "steel-plate", 10)
  rm.RemoveIngredient("chemical-plant", "steel-plate", 5)
  rm.RemoveIngredient("flamethrower-ammo", "steel-plate", 1)
  rm.RemoveIngredient("engine-unit", "steel-plate", 1)
end

if mods["MoreScience"] and parts.experimental then
  tf.addPrereq("injection-molding", "electric-power-science-pack")
  tf.addSciencePack("injection-molding", "electric-power-science-pack")
  tf.addSciencePack("injection-molding", "advanced-automation-science-pack")
end

if not (mods["space-exploration"] or mods["galdocs-manufacturing"]) then
  rm.AddIngredient("low-density-structure", "invar-plate", 2) --heat shielding. not how it works but has truthiness
end

if rm.RemoveIngredient("pump", "graphite", 2) then
  --graphite in pump represents gaskets but is the only thing that uses graphite in this way. add graphite-as-gaskets to everything that might reasonably use them!
  --brasstacks removes pump graphite in favor of the airtight seal which valves will preferentially use
  --so if it has already been removed, there is no reason to add it here.
  rm.AddIngredient("invar-valve", "graphite", 1)
end

rm.AddIngredient("transport-belt-beltbox", parts.motor, 1)
rm.AddIngredient("express-transport-belt-beltbox", "electric-engine-unit", 1)
if deadlock and data.raw["technology"]["deadlock-stacking-3"] then
  tf.addPrereq("deadlock-stacking-3", "electric-engine")
end

if mods["Flow Control"] then
  --tf.addPrereq("flow_control_valves_tech", "valves")
  rm.ReplaceIngredient("check-valve", "iron-gear-wheel", "invar-valve", 1)
  if parts.experimental then
    rm.ReplaceIngredient("overflow-valve", "iron-gear-wheel", "flow-controller", 1)
    rm.ReplaceIngredient("underflow-valve", "iron-gear-wheel", "flow-controller", 1)
    rm.RemoveIngredient("overflow-valve", "electronic-circuit", 1)
    rm.RemoveIngredient("underflow-valve", "electronic-circuit", 1)
  else
    rm.ReplaceIngredient("overflow-valve", "iron-gear-wheel", "invar-valve", 1)
    rm.ReplaceIngredient("underflow-valve", "iron-gear-wheel", "invar-valve", 1)
  end
end

if mods["LunarLandings"] then

  rm.AddIngredient("ll-low-density-structure-aluminium", "invar-plate", 2)

  --rm.AddProductRaw("ll-red-mud-recovery", {type="item", name="nickel-ore", amount_min=0, amount_max=6})
  --rm.SetCategory(parts.motor, "circuit-crafting") --eh. it's electrical.

  if not parts.brassExperiment then
    rm.ReplaceIngredient("ll-heat-shielding", "steel-plate", "invar-plate", 2)
    rm.AddIngredient("ll-telescope", "motor", 10)
  end

  if parts.experimental then
    rm.AddIngredient("rocket-part", "gimbaled-thruster", 2)
    rm.AddIngredient("rocket-part-luna", "gimbaled-thruster", 1)
    rm.AddIngredient("rocket-part-interstellar", "gimbaled-thruster", 5)

    rm.ReplaceIngredient("ll-steam-condenser", "electronic-circuit", "flow-controller", 10)

    --prod science is getting up in ingredients. Remove module because it's the least interesting and there's enough electronics focus in LL already.
    rm.RemoveIngredient("production-science-pack", "productivity-module", 1)
    rm.RemoveIngredient("ll-low-grav-assembling-machine", "iron-gear-wheel", 20)
    rm.AddIngredient("ll-low-grav-assembling-machine", "motorized-articulator", 8)

    rm.RemoveIngredient("ll-oxygen-diffuser", "copper-cable", 10)
    rm.AddIngredient("ll-oxygen-diffuser", "flow-controller", 5)
    rm.AddIngredient("ll-interstellar-satellite", "gimbaled-thruster", 50)
    tf.addRecipeUnlock("gimbaled-thruster", "pack-gimbaled-thruster")
    tf.addRecipeUnlock("gimbaled-thruster", "unpack-gimbaled-thruster")
  else
    rm.ReplaceIngredient("ll-steam-condenser", "electronic-circuit", "invar-valve", 10)
    rm.AddIngredient("ll-oxygen-diffuser", "invar-valve", 5)
  end

  if not mods["BrassTacks-Updated"] then
    rm.AddIngredient("ll-core-extractor", "electric-engine-unit", 5)
    rm.AddIngredient("ll-low-grav-assembling-machine", "electric-engine-unit", 2)
  end
end

require("compat.aai")
require("compat.kras")
require("compat.bz")
require("compat.freight")
require("compat.248k")
--require("compat.galdoc")
