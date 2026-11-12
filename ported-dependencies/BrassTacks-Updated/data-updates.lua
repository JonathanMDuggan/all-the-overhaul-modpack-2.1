local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")

local advfitting = "bolted-flange"
if parts.bz.carbon or mods["BrimStuff-Updated"] then
  advfitting = "airtight-seal"
  rm.RemoveIngredient("pump", "graphite", 2)
  if parts.nickel then
    tf.addRecipeUnlock("valves", "airtight-seal")
  else
    tf.addRecipeUnlock(mods["aai-industry"] and "basic-fluid-handling" or "fluid-handling", "airtight-seal")
  end

  if mods["BrimStuff-Updated"] then
    if parts.bz.carbon then
      rm.ReplaceIngredient("airtight-seal", "graphite", "rubber", 2)
      rm.ReplaceIngredient("airtight-seal-vitalic", "graphite", "rubber", 25)
    else
      rm.ReplaceIngredient("airtight-seal", "graphite", "rubber", 4)
      rm.ReplaceIngredient("airtight-seal-vitalic", "graphite", "rubber", 50)
    end
  end
end

if parts.experimental then
  if not mods["galdocs-manufacturing"] then
    tf.addRecipeUnlock("steel-processing", "galvanized-steel-plate")
  end
  rm.RemoveIngredient("splitter", "iron-plate", 8)
  rm.RemoveIngredient("splitter", "aluminum-plate", 8)
  rm.AddIngredient("splitter", "flywheel", 2)
  rm.AddIngredient("splitter", "articulated-mechanism", 3)

  rm.AddIngredient("steam-engine", "flywheel", 2)

  rm.AddIngredient("trasport-belt-loader", "flywheel", 1)
  if parts.nickel then
    --replace all to keep ingredient count down when adding motors
    rm.ReplaceIngredient("transport-belt-beltbox", "iron-gear-wheel", "articulated-mechanism", 10)
  else
    rm.ReplaceIngredient("transport-belt-beltbox", "iron-gear-wheel", "articulated-mechanism", 5)
  end

  if parts.nickel  then
    rm.ReplaceIngredient("electric-mining-drill", "iron-gear-wheel", "articulated-mechanism", 5)
  else
    rm.ReplaceIngredient("electric-mining-drill", "iron-gear-wheel", "articulated-mechanism", 2)
  end

  if mods["aai-industry"] then
    rm.AddIngredient("gearbox", "electric-motor", 2)
  else if parts.nickel then
    rm.AddIngredient("gearbox", "motor", 2)
  end end

  if mods["Krastorio2"] then
    rm.multiply("gearbox", 2, true, true, true)
    rm.RemoveIngredient("gearbox", "galvanized-steel-plate", 1)
    if mods["aai-industry"] then
      rm.RemoveIngredient("gearbox", "electric-motor", 1) --aai motors are expensive
    end
  end

  rm.AddIngredient("electric-mining-drill", "flywheel", 1)

  if mods["aai-industry"] then
    if not mods["Krastorio2"] then -- inserter parts use AM
      rm.RemoveIngredient("burner-inserter", "iron-stick", 2)
      rm.AddIngredient("burner-inserter", "articulated-mechanism", 1)
    end
  else
    rm.ReplaceIngredient("inserter", "iron-plate", "articulated-mechanism", 1)
  end
  if mods["Krastorio2"] and not mods["aai-industry"] then
    rm.ReplaceIngredient("long-handed-inserter", "iron-plate", "articulated-mechanism", 2)
  else
    rm.ReplaceIngredient("long-handed-inserter", "iron-plate", "articulated-mechanism", 1)
  end
  rm.RemoveIngredient("inserter", "aluminum-plate", 1)
  rm.RemoveIngredient("long-handed-inserter", "aluminum-plate", 1)

  --tf.addPrereq(mods["aai-industry"] and "basic-fluid-handling" or "fluid-handling", "hardened-hull")
  if not mods["Krastorio2"] then
    rm.ReplaceIngredient("storage-tank", "steel-plate", "hardened-hull", 5)
    rm.RemoveIngredient("storage-tank", "bronze-plate", 10)
  end
  if not (mods["Krastorio2"] or mods["galdocs-manufacturing"]) then
    if mods["aai-industry"] then
      rm.ReplaceIngredient("pump", "steel-plate", "galvanized-steel-plate", 1)
    else
      rm.ReplaceIngredient("pump", "steel-plate", "galvanized-steel-plate", 1)
    end
    rm.RemoveIngredient("pump", "bronze-plate", 2)
  end

  if not mods["galdocs-manufacturing"] then
    rm.ReplaceIngredient("refined-concrete", "steel-plate", "galvanized-steel-plate", 1)
    if mods["Krastorio2"] then
      rm.ReplaceIngredient("big-electric-pole", "kr-steel-beam", "galvanized-steel-plate", 4)
      rm.ReplaceIngredient("substation", "kr-steel-beam", "galvanized-steel-plate", 8)
      rm.ReplaceIngredient("steel-chest", "steel-plate", "galvanized-steel-plate", 4)
      rm.RemoveIngredient("steel-chest", "steel-plate", 4)
    else
      rm.ReplaceIngredient("medium-electric-pole", "steel-plate", "galvanized-steel-plate", 2)
      rm.ReplaceIngredient("big-electric-pole", "steel-plate", "galvanized-steel-plate", 5)
      rm.ReplaceIngredient("substation", "steel-plate", "galvanized-steel-plate", 10)
      rm.ReplaceIngredient("steel-chest", "steel-plate", "galvanized-steel-plate", 8)
    end
    rm.ReplaceIngredient("train-stop", "steel-plate", "galvanized-steel-plate", 3)

    --this is not a compatibility thing, this is a courtesy thing.
    rm.AddIngredient("iron-chest", "articulated-mechanism", 1)
  end
  rm.AddIngredient("steel-chest", "articulated-mechanism", 1)
  rm.RemoveIngredient("refined-concrete", "kr-iron-beam", 10)

  rm.ReplaceIngredient("assembling-machine-1", "iron-gear-wheel", "articulated-mechanism", 5)

  if not mods["space-exploration"] then
    if mods["MoreScience"] then
      rm.RemoveIngredient("production-science-fluid", "rail", 90)
      rm.AddIngredient("production-science-fluid", "advanced-gearbox", 18)
      rm.AddIngredient("utility-science-fluid", "complex-joint", 9)
      tf.addPrereq("production-science-pack", "mechanical-engineering-2")
      tf.addPrereq("utility-science-pack", "mechanical-engineering-2")

      rm.AddIngredient("rocketpart-hull-component", "hardened-hull", 5)
    else
      rm.RemoveIngredient("production-science-pack", "rail", 30)
      rm.AddIngredient("production-science-pack", "advanced-gearbox", 6)
      rm.AddIngredient("utility-science-pack", "complex-joint", 3)
      tf.addPrereq("production-science-pack", "mechanical-engineering-2")
      tf.addPrereq("utility-science-pack", "mechanical-engineering-2")
    end
  end

  tf.addPrereq("automation-2", "mechanical-engineering")
  if mods["galdocs-manufacturing"] then
    if rm.CheckIngredient("assembling-machine-2", "tungsten-carbide") then
      rm.ReplaceIngredient("assembling-machine-2", "steel-plate", "galvanized-steel-plate", 1)
    else
      rm.ReplaceIngredient("assembling-machine-2", "steel-plate", "galvanized-steel-plate", 2)
    end
  end
  rm.RemoveIngredient("assembling-machine-2", "iron-gear-wheel", 5)
  rm.ReplaceIngredient("assembling-machine-2", "galvanized-steel-plate", "gearbox", 1)

  if mods["aai-industry"] then
    rm.AddIngredient("engine-unit", "articulated-mechanism", 2)
    --for the much more limited scope item that AAI makes the combustion engine, 5 ingredients is OK
  else
    if (not parts.steelValve) and not (rm.CheckIngredient("engine-unit", "spark-plug") or rm.CheckIngredient("engine-unit", "tungsten-plate") or rm.CheckIngredient("engine-unit", "basic-paneling-machined-part")) then
        rm.AddIngredient("engine-unit", "articulated-mechanism", 1)
      --i don't want engines with 5+ ingredients if they are used for EEUs
    end
  end
  rm.RemoveIngredient("engine-unit", "iron-plate", 2)

  rm.RemoveIngredient("electric-furnace", "steel-plate", 10)
  if parts.nickel then
    rm.AddIngredient("electric-furnace", "hardened-hull", 5)
  else
    rm.AddIngredient("electric-furnace", "hardened-hull", 8)
  end

  if not mods["galdocs-manufacturing"] then
    if mods["aai-industry"] then
      rm.ReplaceIngredient("pumpjack", "steel-plate", "galvanized-steel-plate", 15)
    else
      rm.ReplaceIngredient("pumpjack", "steel-plate", "galvanized-steel-plate", 5)
    end
    rm.ReplaceIngredient("centrifuge", "steel-plate", "galvanized-steel-plate", 50)
  end
  rm.ReplaceIngredient("pumpjack", "iron-gear-wheel", "flywheel", 5)

  rm.AddIngredient("gun-turret", "flywheel", 1)

  rm.ReplaceIngredient("heat-exchanger", "steel-plate", "hardened-hull", 10)
  rm.ReplaceIngredient("nuclear-reactor", "steel-plate", "hardened-hull", 500)
  if mods["LunarLandings"] then
    rm.ReplaceIngredient("rocket-silo", "steel-plate", "hardened-hull", 100)
  else
    rm.ReplaceIngredient("rocket-silo", "steel-plate", "hardened-hull", 500)
  end

  if parts.steelValve then
    rm.ReplaceIngredient("oil-refinery", "steel-plate", "hardened-hull", 5)
  else
    rm.RemoveIngredient("oil-refinery", "steel-plate", 15)
    rm.AddIngredient("oil-refinery", "hardened-hull", 10)
  end

  rm.ReplaceIngredient("chemical-plant", "steel-plate", "hardened-hull", 5)
  rm.ReplaceIngredient("tank", "steel-plate", "hardened-hull", 30)
  rm.ReplaceIngredient("artillery-wagon", "steel-plate", "hardened-hull", 20)
  if not mods["galdocs-manufacturing"] then
    rm.ReplaceIngredient("fluid-wagon", "steel-plate", "galvanized-steel-plate", 16)
    rm.ReplaceIngredient("artillery-wagon", "steel-plate", "galvanized-steel-plate", 20)
  end
  --rm.ReplaceIngredient("cargo-wagon", "steel-plate", "galvanized-steel-plate", 20, 20)
  --rm.ReplaceIngredient("locomotive", "steel-plate", "galvanized-steel-plate", 30, 30)

  if not mods["FreightForwarding"] then
    --in FF the locomotive is electric only, meaning it doesn't need a flywheel to even out the engine stroke cycle.
    --yes, i am going to be this pedantic.
    rm.AddIngredient("locomotive", "flywheel", 2)
  end

  tf.addPrereq("logistics-2", "mechanical-engineering")

  rm.RemoveIngredient("fast-transport-belt", "iron-gear-wheel", 5)
  rm.AddIngredient("fast-transport-belt", "gearbox", 1)

  rm.RemoveIngredient("fast-underground-belt", "iron-gear-wheel", 40)
  if not mods["Krastorio2"] then
    rm.AddIngredient("fast-underground-belt", "gearbox", 8)
  end

  rm.RemoveIngredient("fast-splitter", "iron-gear-wheel", 10)
  rm.AddIngredient("fast-splitter", "gearbox", 2)
  tf.removePrereq("automobilism", "logistics-2")

  if not parts.nickelExperiment then
    rm.AddIngredient("solar-panel", "articulated-mechanism", 5) --sun tracking + folding up the satellite's solar panels in transit
    rm.AddIngredient("construction-robot", "articulated-mechanism", 1) --grabber
    rm.AddIngredient("logistic-robot", "articulated-mechanism", 1) --grabber
    rm.AddIngredient("power-switch", "articulated-mechanism", 2)
    rm.AddIngredient("gate", "articulated-mechanism", 1)
  end
  rm.RemoveIngredient("gate", "steel-plate", 2)
  rm.AddIngredient("gate", "hardened-hull", 1)
  tf.addPrereq("gate", "hardened-hull")

  if not mods["galdocs-manufacturing"] then
    rm.ReplaceIngredient("solar-panel", "steel-plate", "galvanized-steel-plate", 5)
    rm.ReplaceIngredient("laser-turret", "steel-plate", "galvanized-steel-plate", 20)
  end

  rm.ReplaceProportional("transport-belt", "processing-unit", "flywheel", 200)

  tf.addPrereq("automation-3", "mechanical-engineering-2")
  rm.ReplaceIngredient("assembling-machine-3", "cermet", "complex-joint", 5)
  rm.AddIngredient("assembling-machine-3", "advanced-gearbox", 2)
  rm.RemoveIngredient("assembling-machine-3", "kr-steel-gear-wheel", 5)

  tf.addPrereq("rocket-silo", "mechanical-engineering-2")
  rm.AddIngredient("rocket-silo", "complex-joint", 100)

  tf.addPrereq("exoskeleton-equipment", "mechanical-engineering-2")
  rm.AddIngredient("exoskeleton-equipment", "complex-joint", 10)

  tf.removePrereq("logistics-3", "lubricant")
  tf.addPrereq("logistics-3", "mechanical-engineering-2")

  rm.RemoveIngredient("express-transport-belt", "iron-gear-wheel", 10)
  rm.AddIngredient("express-transport-belt", "advanced-gearbox", 1)

  rm.RemoveIngredient("express-underground-belt", "iron-gear-wheel", 80)
  if not mods["Krastorio2"] then
    rm.AddIngredient("express-underground-belt", "advanced-gearbox", 8)
  end

  rm.RemoveIngredient("express-splitter", "iron-gear-wheel", 10)
  rm.AddIngredient("express-splitter", "advanced-gearbox", 2)
  rm.AddIngredient("express-splitter", "complex-joint", 2)

  rm.AddIngredient("kr-fusion-reactor-equipment", "hardened-hull", 50)

  rm.RemoveIngredient("fast-transport-belt-beltbox", "iron-gear-wheel", 20)
  rm.AddIngredient("fast-transport-belt-beltbox", "gearbox", 4)

  rm.RemoveIngredient("express-transport-belt-beltbox", "iron-gear-wheel", 30)
  rm.AddIngredient("express-transport-belt-beltbox", "advanced-gearbox", 4)
  rm.AddIngredient("express-transport-belt-beltbox", "complex-joint", 4)

  rm.RemoveIngredient("fast-transport-belt-loader", "iron-gear-wheel", 20)
  rm.AddIngredient("fast-transport-belt-loader", "gearbox", 4)

  rm.RemoveIngredient("express-transport-belt-loader", "iron-gear-wheel", 40)
  rm.AddIngredient("express-transport-belt-loader", "advanced-gearbox", 4)

  if parts.gyroscope then
    rm.RemoveIngredient("laser-turret", parts.gyroscope, 99)
    rm.AddIngredient("laser-turret", parts.gyroscope, 1)
    tf.addPrereq("laser-turret", parts.gyroscope)

    rm.RemoveIngredient("flying-robot-frame", parts.gyroscope, 99)
    rm.RemoveIngredient("flying-robot-frame", "electronic-circuit", 99)
    if mods["aai-industry"] then
      rm.AddIngredient("flying-robot-frame", parts.gyroscope, 1)
    else
      rm.AddIngredient("flying-robot-frame", parts.gyroscope, 1)
    end
    tf.addPrereq("robotics", parts.gyroscope)

    tf.addPrereq("artillery", parts.gyroscope)
    rm.RemoveIngredient("artillery-shell", parts.gyroscope, 99)
    rm.AddIngredient("artillery-shell", parts.gyroscope, 1)

    tf.addPrereq("distractor", parts.gyroscope)
    rm.RemoveIngredient("distractor-capsule", parts.gyroscope, 99)
    rm.AddIngredient("distractor-capsule", parts.gyroscope, 1)
  else
    tf.addPrereq("skyseeker-armature", "gyro")
  end

  if mods["aai-signal-transmission"] or mods["LunarLandings"] then

    tf.addPrereq("artillery", "skyseeker-armature")
    rm.RemoveIngredient("artillery-wagon", "gyro", 99)
    rm.AddIngredient("artillery-wagon", "skyseeker-armature", 5)

    rm.RemoveIngredient("artillery-turret", "gyro", 99)
    rm.AddIngredient("artillery-turret", "skyseeker-armature", 10)
  else
    if parts.gyroscope then
      tf.addPrereq("artillery", parts.gyroscope)

      rm.RemoveIngredient("artillery-wagon", parts.gyroscope, 99)
      rm.AddIngredient("artillery-wagon", parts.gyroscope, 10)

      rm.RemoveIngredient("artillery-turret", parts.gyroscope, 99)
      rm.AddIngredient("artillery-turret", parts.gyroscope, 10)
    else
      tf.addPrereq("artillery", "mechanical-engineering-2")

      rm.AddIngredient("artillery-turret", "complex-joint", 10)
      rm.AddIngredient("artillery-wagon", "complex-joint", 10)
    end
  end
else
  if not mods["galdocs-manufacturing"] then
    rm.ReplaceIngredient("splitter", "iron-plate", "iron-gear-wheel", 3)
    rm.RemoveIngredient("splitter", "aluminum-plate", 3)

    rm.AddIngredient("exoskeleton-equipment", "iron-gear-wheel", 30)
    rm.AddIngredient("assembling-machine-3", "bearing", 5)
  end

  rm.AddIngredient("express-transport-belt", "bearing", 1)
  rm.AddIngredient("express-splitter", "bearing", 2)
  rm.AddIngredient("express-underground-belt", "bearing", 8)

  rm.AddIngredient("express-transport-belt-loader", "bearing", 2)
  rm.AddIngredient("express-transport-belt-beltbox", "bearing", 6)

  rm.AddIngredient("car", "iron-gear-wheel", 10)
end

if not mods["galdocs-manufacturing"] then
  if mods["Krastorio2"] then
    if mods["space-exploration"] then
      rm.ReplaceIngredient("iron-gear-wheel", "iron-plate", "brass-plate", 1)
    else
      rm.ReplaceIngredient("iron-gear-wheel", "iron-plate", "brass-plate", 4)
    end
  else
    rm.ReplaceIngredient("iron-gear-wheel", "iron-plate", "brass-plate", 1)
  end

  if rm.CheckIngredient("iron-gear-wheel", "iron-plate") then
    data.raw.item["iron-gear-wheel"].icon = parts.qualityIconPath("brasstacks", "icons/iron-gear-wheel.png")
  else
    data.raw.item["iron-gear-wheel"].icon = parts.qualityIconPath("brasstacks", "icons/iron-gear-wheel-krastorio.png")
    data.raw.item["iron-gear-wheel"].localised_name = {"item-name.brass-gear-wheel"}
    if mods["Krastorio2"] and ((not mods["space-exploration"]) or mods["space-exploration"] < "0.6.121") then
      rm.multiply("kr-iron-gear-wheel-from-enriched-iron", 2, true, true, true)
      rm.ReplaceIngredient("kr-iron-gear-wheel-from-enriched-iron", "kr-enriched-iron", "enriched-zinc", 1)
      rm.ReplaceIngredient("kr-iron-gear-wheel-from-enriched-iron", "kr-enriched-iron", "kr-enriched-copper", 1)
      data.raw.recipe["kr-iron-gear-wheel-from-enriched-iron"].icons[1].icon = parts.qualityIconPath("brasstacks", "icons/iron-gear-wheel-krastorio.png")
      data.raw.recipe["kr-iron-gear-wheel-from-enriched-iron"].icons[2].icon = parts.qualityIconPath("brasstacks", "icons/brass-precursor.png")

      rm.multiply("kr-iron-gear-wheel-from-iron-ore", 2, true, true, true)
      rm.ReplaceIngredient("kr-iron-gear-wheel-from-iron-ore", "iron-ore", "copper-ore", 2)
      rm.ReplaceIngredient("kr-iron-gear-wheel-from-iron-ore", "iron-ore", "zinc-ore", 2)
      data.raw.recipe["kr-iron-gear-wheel-from-iron-ore"].icons[1].icon = parts.qualityIconPath("brasstacks", "icons/iron-gear-wheel-krastorio.png")
      data.raw.recipe["kr-iron-gear-wheel-from-iron-ore"].icons[2].icon = "__base__/graphics/icons/copper-ore.png"

      --tf.removeRecipeUnlock("kr-automation", "kr-iron-gear-wheel-from-iron-ore")
    end
  end

  rm.ReplaceIngredient("fast-inserter", "iron-plate", "iron-gear-wheel", 2)
  rm.RemoveIngredient("fast-inserter", "aluminum-plate", 2)
end

rm.AddIngredient("storage-tank", "bolted-flange", 4)
rm.AddIngredient("pump", advfitting, 2)

if mods["FreightForwarding"] then
  rm.AddIngredient("locomotive", "bearing", 20)
elseif not mods["galdocs-manufacturing"] then
  rm.AddIngredient("locomotive", "iron-gear-wheel", 10)
end
if mods["galdocs-manufacturing"] then
  rm.AddIngredient("construction-robot", "bearing", 1)
else
  rm.AddIngredient("construction-robot", "iron-gear-wheel", 2)
end
rm.AddIngredient("logistic-robot", "bearing", 2)

if not mods["galdocs-manufacturing"] then
  rm.AddIngredient("passive-provider-chest", "iron-gear-wheel", 1)
  if not mods["aai-containers"] then
    rm.AddIngredient("active-provider-chest", "iron-gear-wheel", 1)
    rm.AddIngredient("storage-chest", "iron-gear-wheel", 1)
    rm.AddIngredient("requester-chest", "iron-gear-wheel", 1)
    rm.AddIngredient("buffer-chest", "iron-gear-wheel", 1)
  end
end

rm.AddIngredient("electric-engine-unit", "bearing", 1)

if not mods["galdocs-manufacturing"] then
  rm.AddIngredient("battery", "zinc-plate", 1)
end

tf.addRecipeUnlock("lubricant", "brass-balls")
tf.addRecipeUnlock("lubricant", "bearing")

if not mods["aai-industry"] then
  --aai already adds this
  tf.addPrereq("automation-3", "electric-engine")
  rm.AddIngredient("assembling-machine-3", "electric-engine-unit", 2)
end

tf.addPrereq("uranium-processing", "lubricant")
rm.AddIngredient("centrifuge", "bearing", 20)
rm.AddIngredient("steam-turbine", "bearing", 5)

if not parts.gyroscope then
  local thegear = mods["Krastorio2"] and "kr-steel-gear-wheel" or "iron-gear-wheel"
  if mods["IfNickel-Updated"] or mods["aai-industry"] then
    rm.AddIngredient("laser-turret", thegear, 5)
  else
    rm.AddIngredient("laser-turret", thegear, 10)
  end
end

--never use the bloody thing because it's so expensive but hey!
rm.ReplaceIngredient("flamethrower-ammo", "steel-plate", advfitting, 1)

if not mods["galdocs-manufacturing"] then
  rm.AddIngredient("firearm-magazine", "brass-plate", 1)
  rm.AddIngredient("shotgun-shell", "brass-plate", 1)
  rm.AddIngredient("cannon-shell", "brass-plate", 2)
  rm.AddIngredient("explosive-cannon-shell", "brass-plate", 2)
  if parts.bz.lead and settings.startup["bzlead-more-ammo"].value == "yes" then
    --it produces 2 mags, so 2x the casings
    rm.AddIngredient("firearm-magazine-iron-lead", "brass-plate", 2)
    rm.AddIngredient("firearm-magazine-iron-only", "brass-plate", 1)
    rm.AddIngredient("firearm-magazine-copper-lead", "brass-plate", 1)

    rm.AddIngredient("rifle-magazine-iron-lead", "brass-plate", 2)
    rm.AddIngredient("rifle-magazine-iron", "brass-plate", 1)
    rm.AddIngredient("rifle-magazine-copper-lead", "brass-plate", 1)
  end
end

if not mods["LunarLandings"] then
  rm.AddIngredient("rocket-fuel", advfitting, 1)
end

rm.multiply("pipe", 5, true, true, true)
rm.AddIngredient("pipe", "bolted-flange", 1)

if parts.foundryEnabled then
  tf.addRecipeUnlock("foundry", "brass-plate-foundry")
elseif data.raw.technology["copper-processing"] then
  if data.raw.recipe["brass-plate-foundry"] then
    tf.addRecipeUnlock("copper-processing", "brass-plate-foundry")
  end
  if data.raw.recipe["brass-precursor-foundry"] then
    tf.addRecipeUnlock("copper-processing", "brass-precursor-foundry")
  end
end

if mods["MoreScience"] and parts.experimental then
  if parts.gyroscope then
    tf.addPrereq(parts.gyroscope, "electric-power-science-pack")
    tf.addSciencePack(parts.gyroscope, "electric-power-science-pack")
    tf.addSciencePack(parts.gyroscope, "advanced-automation-science-pack")
  end
  tf.addSciencePack("mechanical-engineering-2", "advanced-automation-science-pack")
end

if mods["vtk-deep-core-mining"] and parts.experimental then
  if not mods["galdocs-manufacturing"] then
    rm.ReplaceIngredient("vtk-deepcore-mining-moho", "steel-plate", "galvanized-steel-plate", 20)
    rm.ReplaceIngredient("vtk-deepcore-mining-drill", "steel-plate", "hardened-hull", 20)
    rm.ReplaceIngredient("vtk-deepcore-mining-drill-advanced", "steel-plate", "hardened-hull", 50)
  end

  tf.addPrereq("vtk-deepcore", "mechanical-engineering-2")
  rm.AddIngredient("vtk-deepcore-mining-moho", "complex-joint", 10)
  rm.AddIngredient("vtk-deepcore-mining-drill", "complex-joint", 20)
  rm.AddIngredient("vtk-deepcore-mining-drill-advanced", "complex-joint", 50)
  if parts.drill then
    data.raw.item["vtk-deepcore-mining-drone"].fuel_value = "160MJ"
    rm.AddIngredient("vtk-deepcore-mining-drone", "industrial-drill-head", 1)
    rm.RemoveIngredient("vtk-deepcore-mining-drone", "tungsten-carbide", 99999)
    rm.RemoveIngredient("vtk-deepcore-mining-drone", "diamond", 99999)

    rm.AddIngredient("vtk-deepcore-mining-moho", "industrial-drill-head", 10)
    rm.RemoveIngredient("vtk-deepcore-mining-moho", "tungsten-carbide", 99999)
    rm.RemoveIngredient("vtk-deepcore-mining-moho", "diamond", 99999)

    rm.AddIngredient("vtk-deepcore-mining-drill", "industrial-drill-head", 20)
    rm.RemoveIngredient("vtk-deepcore-mining-drill", "tungsten-carbide", 99999)
    rm.RemoveIngredient("vtk-deepcore-mining-drill", "diamond", 99999)

    rm.AddIngredient("vtk-deepcore-mining-drill-advanced", "industrial-drill-head", 50)
    rm.RemoveIngredient("vtk-deepcore-mining-drill-advanced", "tungsten-carbide", 99999)
    rm.RemoveIngredient("vtk-deepcore-mining-drill-advanced", "diamond", 99999)
  end
end

if mods["Flow Control"] and not mods["IfNickel-Updated"] and advfitting == "airtight-seal" then
  rm.AddIngredient("check-valve", "airtight-seal", 1)
  rm.AddIngredient("overflow-valve", "airtight-seal", 1)
  rm.AddIngredient("underflow-valve", "airtight-seal", 1)
end

if mods["leighzerscrapyards"] and data.raw.recipe["iron-gear-wheel-reclamation"] then
  rm.AddIngredient("iron-gear-wheel-reclamation", "iron-gear-wheel", 2)
  rm.AddProductRaw("iron-gear-wheel-reclamation", {type="item", name="brass-plate", amount=1})
  if mods["Krastorio2"] then
    rm.RemoveProduct("iron-gear-wheel-reclamation", "iron-plate", 99999)
    data.raw.recipe["iron-gear-wheel-reclamation"].icons[2].icon = parts.qualityIconPath("brasstacks", "icons/brass-plate.png")
  end
end

if mods["LunarLandings"] then
  rm.AddIngredient("ll-core-extractor", "electric-engine-unit", 5)
  rm.ReplaceIngredient("ll-core-extractor", "iron-gear-wheel", "bearing", 25)
  rm.AddIngredient("ll-low-grav-assembling-machine", "electric-engine-unit", 2)

  if parts.experimental then
    rm.ReplaceProportional("ll-heat-shielding", "steel-plate", "hardened-hull", 0.5)
    rm.ReplaceProportional("ll-arc-furnace", "steel-plate", "hardened-hull", 0.4)

    if parts.nickelExperiment then
      rm.ReplaceIngredient("ll-low-grav-assembling-machine", "steel-plate", "complex-joint", 10)
    else
      rm.ReplaceProportional("ll-low-grav-assembling-machine", "iron-gear-wheel", "gearbox", 0.2)
      rm.ReplaceIngredient("ll-low-grav-assembling-machine", "steel-plate", "complex-joint", 5)
    end
    rm.AddIngredient("ll-rocket-silo-interstellar", "complex-joint", 200)

    if mods["IfNickel-Updated"] then
      tf.addRecipeUnlock("ll-rich-moon-rock-processing", "hardened-hull-alumina")
    end

    rm.RemoveIngredient("ll-telescope", "iron-gear-wheel", 20)
    rm.AddIngredient("ll-telescope", "skyseeker-armature", 5)
    rm.AddIngredient("ll-data-card", "skyseeker-armature", 1)
    rm.AddProductRaw("ll-data-card", {type="item", name="skyseeker-armature", amount=1, independent_probability=0.95})
    tf.addPrereq("ll-space-data-collection", "skyseeker-armature")
  else
    rm.AddIngredient("ll-low-grav-assembling-machine", "bearing", 10)
  end
end

require("compat.bob")
require("compat.aai")
require("compat.kras")
require("compat.bz")
require("compat.freight")
require("compat.248k")
--require("compat.galdoc")
