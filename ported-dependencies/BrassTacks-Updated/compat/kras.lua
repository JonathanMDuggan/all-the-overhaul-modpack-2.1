local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")

local advfitting = "bolted-flange"
if parts.bz.carbon or mods["BrimStuff-Updated"] then
  advfitting = "airtight-seal"
end

if mods["advanced-chemical-plant"] and not mods["Krastorio2"] then
  if advfitting == "airtight-seal" and not mods["IfNickel-Updated"] then
    rm.AddIngredient("kr-advanced-chemical-plant", "airtight-seal", 32)
  end
  if parts.experimental then
    rm.AddIngredient("kr-advanced-chemical-plant", "advanced-gearbox", 4)
  else if not mods["space-exploration"] then
    rm.AddIngredient("kr-advanced-chemical-plant", "bearing", 16)
  end end
  rm.AddIngredient("kr-advanced-chemical-plant", "electric-engine-unit", 4) --nobody can escape my insistence on shoving this item in every high end recipe. nobody!
end

if mods["AdvancedAssemblyMachineStandalone"] and not mods["Krastorio2"] then
  rm.RemoveIngredient("assembling-machine-3", "electric-engine-unit", 99999) -- :O
  if parts.experimental then
    rm.AddIngredient("kr-advanced-assembling-machine", "hardened-hull", 122)
  end
end

if mods["advanced-centrifuge"] then
  if parts.experimental then
    rm.AddIngredient("k11-advanced-centrifuge", "advanced-gearbox", 10)
  else
    rm.AddIngredient("k11-advanced-centrifuge", "bearing", 50)
  end
end

if mods["Krastorio2"] then
    rm.RemoveIngredient("kr-steel-gear-wheel", "steel-plate", 1)
    if not rm.CheckIngredient("kr-steel-gear-wheel", "steel-plate") then
        rm.multiply("kr-steel-gear-wheel", 4, true, true, true)
        rm.AddIngredient("kr-steel-gear-wheel", "steel-plate", 3)
    end
    rm.AddIngredient("kr-steel-gear-wheel", "brass-plate", 3)
    rm.ReplaceIngredient("kr-s-c-kr-steel-gear-wheel", "iron-plate", "brass-plate", 3)
    --rm.AddIngredient("kr-imersium-gear-wheel", "brass-plate", 2, 2)

    if parts.experimental then
      if mods["space-exploration"] then
        tf.addRecipeUnlock("se-heavy-bearing", "elite-gearbox")
      else
        tf.addRecipeUnlock("kr-imersium-processing", "elite-gearbox")
      end

      rm.RemoveIngredient("kr-inserter-parts", "iron-stick", 4)
      rm.RemoveIngredient("kr-inserter-parts", "aluminum-plate", 1)
      rm.AddIngredient("kr-inserter-parts", "articulated-mechanism", 2)

      --gearboxes
      rm.ReplaceProportional("advanced-gearbox", "iron-gear-wheel", "kr-steel-gear-wheel", 1)
      rm.RemoveIngredient("express-transport-belt", "kr-steel-gear-wheel", 10)
      rm.RemoveIngredient("express-underground-belt", "kr-steel-gear-wheel", 20)
      rm.RemoveIngredient("express-splitter", "kr-steel-gear-wheel", 20)
      rm.RemoveIngredient("express-transport-belt-loader", "kr-steel-gear-wheel", 40)
      rm.RemoveIngredient("express-transport-belt-beltbox", "kr-steel-gear-wheel", 40)

      rm.RemoveIngredient("kr-fast-loader", "iron-gear-wheel", 10)
      rm.AddIngredient("kr-fast-loader", "gearbox", 2)
      rm.RemoveIngredient("kr-express-loader", "kr-steel-gear-wheel", 10)
      rm.AddIngredient("kr-express-loader", "advanced-gearbox", 2)

      rm.AddIngredient("kr-advanced-loader", "complex-joint", 1)
      rm.AddIngredient("kr-superior-loader", "complex-joint", 2)
      rm.AddIngredient("kr-advanced-transport-belt-loader", "complex-joint", 1)
      rm.AddIngredient("kr-superior-transport-belt-loader", "complex-joint", 2)

      rm.AddIngredient("kr-advanced-loader", "advanced-gearbox", 2)
      rm.AddIngredient("kr-advanced-transport-belt", "advanced-gearbox", 1)
      rm.RemoveIngredient("kr-advanced-transport-belt", "kr-imersium-gear-wheel", 3)
      rm.AddIngredient("kr-advanced-splitter", "advanced-gearbox", 2)
      rm.RemoveIngredient("kr-advanced-splitter", "kr-imersium-gear-wheel", 2)

      rm.RemoveIngredient("kr-se-loader", "kr-steel-gear-wheel", 10)
      rm.AddIngredient("kr-se-loader", "advanced-gearbox", 2)

      rm.RemoveIngredient("kr-superior-loader", "kr-imersium-gear-wheel", 10)
      rm.AddIngredient("kr-superior-loader", "elite-gearbox", 2)

      rm.RemoveIngredient("kr-superior-transport-belt", "kr-imersium-gear-wheel", 10)
      rm.RemoveIngredient("kr-superior-transport-belt", "se-heavy-bearing", 4)
      rm.AddIngredient("kr-superior-transport-belt", "elite-gearbox", 1)

      rm.RemoveIngredient("kr-superior-splitter", "kr-imersium-gear-wheel", 10)
      rm.RemoveIngredient("kr-superior-splitter", "se-heavy-bearing", 4)
      rm.AddIngredient("kr-superior-splitter", "elite-gearbox", 2)

      rm.RemoveIngredient("kr-se-deep-space-loader-black", "kr-imersium-gear-wheel", 10)
      rm.AddIngredient("kr-se-deep-space-loader-black", "elite-gearbox", 2)

      if mods["space-exploration"] then
        rm.ReplaceIngredient("se-deep-space-transport-belt-black", "se-heavy-bearing", "elite-gearbox", 1)
        rm.ReplaceProportional("se-heavy-assembly", "kr-imersium-beam", "elite-gearbox", 0.5)
      end

      rm.ReplaceIngredient("galvanized-steel-plate", "steel-plate", "kr-steel-beam", 1)
      data.raw.item["galvanized-steel-plate"].localised_name = {"item-name.galvanized-steel-beam"}

      rm.AddIngredient("kr-gas-power-station", "flywheel", 2)
      rm.RemoveIngredient("kr-advanced-steam-turbine", "kr-steel-gear-wheel", 10)
      rm.AddIngredient("kr-advanced-steam-turbine", "advanced-gearbox", 2)

      --k2 makes the steam turbine an upgrade that takes the steam engine as a component.
      --that makes its gears valid to replace with a gearbox. them's the rules.
      rm.RemoveIngredient("steam-turbine", "iron-gear-wheel", 99999)
      rm.AddIngredient("steam-turbine", "gearbox", 2)

      rm.RemoveIngredient("kr-advanced-furnace", "kr-steel-beam", 80)
      if parts.nickel then
        rm.AddIngredient("kr-advanced-furnace", "hardened-hull", 40)
      else
        rm.AddIngredient("kr-advanced-furnace", "hardened-hull", 60)
      end

      rm.AddIngredient("kr-electric-mining-drill-mk2", "gearbox", 2)
      if mods["aai-industry"] then
        rm.AddIngredient("kr-electric-mining-drill-mk3", "elite-gearbox", 2)
        rm.RemoveIngredient("kr-electric-mining-drill-mk3", "kr-imersium-gear-wheel", 5)
        rm.RemoveIngredient("kr-electric-mining-drill-mk3", "se-heavy-bearing", 10)
      else
        rm.AddIngredient("kr-electric-mining-drill-mk3", "advanced-gearbox", 2)
      end

      if parts.drill then
        rm.AddIngredient("kr-quarry-drill", "industrial-drill-head", 10)
        rm.RemoveIngredient("kr-quarry-drill", "tungsten-carbide", 99999)
        rm.RemoveIngredient("kr-quarry-drill", "diamond", 99999)

        rm.AddIngredient("kr-electric-mining-drill-mk3", "industrial-drill-head", 5)
        rm.RemoveIngredient("kr-electric-mining-drill-mk3", "tungsten-carbide", 99999)
        rm.RemoveIngredient("kr-electric-mining-drill-mk3", "diamond", 99999)
      else
        rm.AddIngredient("kr-electric-mining-drill-mk3", "complex-joint", 10)
        rm.AddIngredient("kr-quarry-drill", "bearing", 10)
      end

      rm.AddIngredient("kr-strongbox", "articulated-mechanism", 5)
      rm.ReplaceIngredient("kr-strongbox", "kr-steel-beam", "galvanized-steel-plate", 5)
      rm.AddIngredient("kr-warehouse", "articulated-mechanism", 20)
      rm.ReplaceIngredient("kr-warehouse", "kr-steel-beam", "galvanized-steel-plate", 50)

      rm.AddIngredient("kr-passive-provider-warehouse", "complex-joint", 5)
      rm.AddIngredient("kr-active-provider-warehouse", "complex-joint", 5)
      rm.AddIngredient("kr-requester-warehouse", "complex-joint", 5)
      rm.AddIngredient("kr-buffer-warehouse", "complex-joint", 5)
      rm.AddIngredient("kr-storage-warehouse", "complex-joint", 5)

      rm.AddIngredient("kr-superior-inserter", "complex-joint", 1)
      rm.AddIngredient("kr-superior-long-inserter", "complex-joint", 2)

      rm.ReplaceIngredient("kr-big-storage-tank", "kr-steel-beam", "hardened-hull", 10)
      rm.ReplaceIngredient("kr-huge-storage-tank", "kr-steel-beam", "hardened-hull", 20)
      rm.ReplaceIngredient("kr-steel-pump", "kr-steel-beam", "galvanized-steel-plate")

      rm.RemoveIngredient("kr-nuclear-locomotive", "kr-steel-gear-wheel", 20)
      rm.AddIngredient("kr-nuclear-locomotive", "advanced-gearbox", 4)

      --hardened hulls
      rm.RemoveIngredient("pumpjack", "kr-steel-beam", 4)
      rm.RemoveIngredient("oil-refinery", "kr-steel-beam", 4)
      rm.RemoveIngredient("chemical-plant", "kr-steel-beam", 4)

      rm.ReplaceIngredient("kr-steel-pump", "kr-steel-beam", "galvanized-steel-plate", 1)

      tf.addPrereq("kr-fluids-chemistry", "hardened-hull")

      rm.ReplaceIngredient("kr-electrolysis-plant", "kr-steel-beam", "galvanized-steel-plate", 10)
      rm.ReplaceIngredient("kr-filtration-plant", "kr-steel-beam", "galvanized-steel-plate", 10)
      rm.ReplaceIngredient("kr-atmospheric-condenser", "kr-steel-beam", "galvanized-steel-plate", 10)

      rm.ReplaceIngredient("kr-fusion-reactor", "steel-plate", "hardened-hull", 500)


      if parts.gyroscope then
        rm.RemoveIngredient("kr-nuclear-locomotive", parts.gyroscope, 99)
        rm.AddIngredient("kr-nuclear-locomotive", parts.gyroscope, 4)

        rm.RemoveIngredient("kr-advanced-tank", parts.gyroscope, 99)
        rm.AddIngredient("kr-advanced-tank", parts.gyroscope, 10)

        rm.RemoveIngredient("kr-advanced-exoskeleton-equipment", parts.gyroscope, 99)
        rm.AddIngredient("kr-advanced-exoskeleton-equipment", parts.gyroscope, 8)

        rm.RemoveIngredient("kr-laser-artillery-turret", parts.gyroscope, 99)
        rm.AddIngredient("kr-laser-artillery-turret", parts.gyroscope, 10)

        rm.RemoveIngredient("kr-rocket-turret", parts.gyroscope, 99)
        rm.AddIngredient("kr-rocket-turret", parts.gyroscope, 5)

        rm.RemoveIngredient("kr-railgun-turret", parts.gyroscope, 99)
        rm.AddIngredient("kr-railgun-turret", parts.gyroscope, 5)
      end
    else

      rm.AddIngredient("kr-express-loader", "bearing", 2)
      rm.AddIngredient("kr-advanced-loader", "bearing", 2)
      rm.AddIngredient("kr-superior-loader", "bearing", 5)
      rm.AddIngredient("kr-advanced-transport-belt-loader", "bearing", 2)
      rm.AddIngredient("kr-superior-transport-belt-loader", "bearing", 5)

      rm.AddIngredient("kr-advanced-splitter", "bearing", 4)
      if not mods["space-exploration"] then
        rm.AddIngredient("kr-superior-splitter", "bearing", 10)
      end

      rm.AddIngredient("kr-passive-provider-warehouse", "iron-gear-wheel", 10)
      rm.AddIngredient("kr-active-provider-warehouse", "iron-gear-wheel", 10)
      rm.AddIngredient("kr-requester-warehouse", "iron-gear-wheel", 10)
      rm.AddIngredient("kr-buffer-warehouse", "iron-gear-wheel", 10)
      rm.AddIngredient("kr-storage-warehouse", "iron-gear-wheel", 10)

      if not mods["space-exploration"] then
        rm.AddIngredient("kr-superior-inserter", "bearing", 2)
        rm.AddIngredient("kr-superior-long-inserter", "bearing", 2)
      end
      rm.AddIngredient("kr-quarry-drill", "bearing", 10)
    end

    rm.AddIngredient("kr-big-storage-tank", "bolted-flange", 4)
    rm.AddIngredient("kr-huge-storage-tank", "bolted-flange", 12)

    tf.addRecipeUnlock(mods["aai-industry"] and "basic-fluid-handling" or "steam-power", "bolted-flange")

    if mods["space-exploration"] then
      --se heavy bearings in superior belts
      if parts.experimental then
        --rm.AddIngredient("kr-advanced-transport-belt", "complex-joint", 1, 1)
      else
        rm.AddIngredient("kr-advanced-transport-belt", "bearing", 2)
      end
    else
      rm.AddIngredient("kr-advanced-transport-belt", "bearing", 2)
      if parts.experimental then
        --rm.AddIngredient("kr-superior-transport-belt", "complex-joint", 2, 2)
      else
        rm.AddIngredient("kr-superior-transport-belt", "bearing", 5)
      end
    end

    rm.AddIngredient("kr-steel-pump", advfitting, 2)
    rm.AddIngredient("kr-rocket-fuel-with-ammonia", advfitting, 1)
    rm.AddIngredient("kr-rocket-fuel-with-hydrogen-chloride", advfitting, 1)

    rm.AddIngredient("kr-passive-provider-strongbox", "iron-gear-wheel", 2)
    rm.AddIngredient("kr-active-provider-strongbox", "iron-gear-wheel", 2)
    rm.AddIngredient("kr-requester-strongbox", "iron-gear-wheel", 2)
    rm.AddIngredient("kr-buffer-strongbox", "iron-gear-wheel", 2)
    rm.AddIngredient("kr-storage-strongbox", "iron-gear-wheel", 2)

    if not mods["aai-industry"] then
      rm.AddIngredient("kr-electric-mining-drill-mk3", "bearing", 20)
    end

    rm.AddIngredient("kr-rifle-magazine", "brass-plate", 1)
    rm.AddIngredient("kr-anti-materiel-rifle-magazine", "brass-plate", 1)

    rm.multiply("kr-steel-pipe", 5, true, true, true)
    rm.AddIngredient("kr-steel-pipe", "bolted-flange", 1)
    rm.RemoveIngredient("kr-steel-pump", "graphite", 2) -- airtight seal

    tf.addRecipeUnlock("kr-enriched-ores", "enriched-zinc")
    tf.addRecipeUnlock("kr-enriched-ores", "enriched-zinc-plate")
    tf.addRecipeUnlock("kr-enriched-ores", "dirty-water-filtration-zinc")
end

if mods["FluidMustFlow"] then
  if parts.experimental then
    if mods["Expensive_Fluid_Must_Flow_Recipes"] then
      rm.ReplaceIngredient("duct-small", "steel-plate", "hardened-hull", 4)
      rm.ReplaceIngredient("duct", "steel-plate", "hardened-hull", 8)
      rm.ReplaceIngredient("duct-long", "steel-plate", "hardened-hull", 16)
      rm.ReplaceIngredient("duct-t-junction", "steel-plate", "hardened-hull", 8)
      rm.ReplaceIngredient("duct-curve", "steel-plate", "hardened-hull", 8)
      rm.ReplaceIngredient("duct-cross", "steel-plate", "hardened-hull", 8)
      rm.ReplaceIngredient("duct-underground", "steel-plate", "hardened-hull", 60)
      rm.ReplaceIngredient("non-return-duct", "steel-plate", "hardened-hull", 8)
      if not mods["IfNickel-Updated"] then
        rm.ReplaceIngredient("non-return-duct", "iron-gear-wheel", "articulated-mechanism", 8)
        rm.RemoveIngredient("non-return-duct", "kr-steel-gear-wheel", 4)
      end
    else
      rm.RemoveIngredient("duct-small", "iron-plate", 4)
      rm.RemoveIngredient("duct", "iron-plate", 8)
      rm.RemoveIngredient("duct-long", "iron-plate", 16)
      rm.RemoveIngredient("duct-t-junction", "iron-plate", 8)
      rm.RemoveIngredient("duct-curve", "iron-plate", 8)
      rm.RemoveIngredient("duct-cross", "iron-plate", 8)
      rm.RemoveIngredient("duct-underground", "iron-plate", 60)
      rm.RemoveIngredient("non-return-duct", "iron-plate", 8)

      rm.AddIngredient("duct-small", "hardened-hull", 1)
      rm.AddIngredient("duct", "hardened-hull", 2)
      rm.AddIngredient("duct-long", "hardened-hull", 4)
      rm.AddIngredient("duct-t-junction", "hardened-hull", 2)
      rm.AddIngredient("duct-curve", "hardened-hull", 2)
      rm.AddIngredient("duct-cross", "hardened-hull", 2)
      rm.AddIngredient("duct-underground", "hardened-hull", 15)
      rm.AddIngredient("non-return-duct", "hardened-hull", 2)

      if not mods["IfNickel-Updated"] then
        rm.ReplaceIngredient("non-return-duct", "iron-gear-wheel", "articulated-mechanism", 4)
      end
    end
    rm.ReplaceIngredient("duct-end-point-intake", "steel-plate", "hardened-hull", 6)
    rm.ReplaceIngredient("duct-end-point-outtake", "steel-plate", "hardened-hull", 6)
  end

  rm.AddIngredient("duct-small", "bolted-flange", 2)
  rm.AddIngredient("duct", "bolted-flange", 4)
  rm.AddIngredient("duct-long", "bolted-flange", 8)
  rm.AddIngredient("duct-t-junction", "bolted-flange", 3)
  rm.AddIngredient("duct-curve", "bolted-flange", 2)
  rm.AddIngredient("duct-cross", "bolted-flange", 4)
  rm.AddIngredient("duct-underground", "bolted-flange", 2)
  rm.AddIngredient("non-return-duct", "bolted-flange", 2)
  if not mods["IfNickel-Updated"] then
    rm.ReplaceIngredient("duct-end-point-intake", "pipe", advfitting, 6)
    rm.ReplaceIngredient("duct-end-point-outtake", "pipe", advfitting, 6)
    rm.RemoveIngredient("duct-end-point-intake", "kr-steel-pipe", 6)
    rm.RemoveIngredient("duct-end-point-outtake", "kr-steel-pipe", 6)
  end

  if rm.CheckIngredient("duct-end-point-intake", "electric-engine-unit") then
    rm.AddIngredient("duct-end-point-intake", "bearing", 6)
    rm.AddIngredient("duct-end-point-outtake", "bearing", 6)
  else
    --don't worry electric engine unit. i still love you
    tf.addPrereq("ducts", "electric-engine")
    rm.AddIngredient("duct-end-point-intake", "electric-engine-unit", 1)
    rm.AddIngredient("duct-end-point-outtake", "electric-engine-unit", 1)
  end
end

if mods["Krastorio2-more-locomotives"] then
  if parts.experimental then
    rm.ReplaceProportional("kr-fusion-locomotive", "kr-steel-gear-wheel", "advanced-gearbox", 0.2)
    rm.ReplaceProportional("kr-antimatter-locomotive", "kr-imersium-gear-wheel", "elite-gearbox", 0.2)
  else
    rm.AddIngredient("kr-fusion-locomotive", "bearing", 20)
    rm.AddIngredient("kr-antimatter-locomotive", "bearing", 100)
  end
end
