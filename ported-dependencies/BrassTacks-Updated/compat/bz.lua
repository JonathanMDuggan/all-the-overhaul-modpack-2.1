local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")

if parts.bz.tin and settings.startup["brasstacks-solder-absorption"].value then
  rm.AddIngredient("bolted-flange", "solder", 1)
  rm.RemoveIngredient("storage-tank", "solder", 4)
  rm.RemoveIngredient("kr-big-storage-tank", "solder", 4)
  rm.RemoveIngredient("kr-huge-storage-tank", "solder", 12)
  rm.RemoveIngredient("kr-electrolysis-plant", "solder", 10)
  rm.RemoveIngredient("kr-filtration-plant", "solder", 4)
  rm.RemoveIngredient("kr-fuel-refinery", "solder", 5)
  rm.RemoveIngredient("chemical-plant", "solder", 5)
  rm.RemoveIngredient("oil-refinery", "solder", 5)
  rm.RemoveIngredient("se-space-biochemical-laboratory", "solder", 8)
  rm.RemoveIngredient("gas-boiler", "solder", 1)
end

if parts.bz.tin and data.raw.item["bronze-plate"] then
  rm.RemoveIngredient("electric-engine-unit", "bronze-plate", 1)
  rm.ReplaceIngredient("bearing", "brass-plate", "bronze-plate", 1)
end

if parts.bz.foundry and parts.experimental then
  rm.ReplaceIngredient("electric-foundry", "steel-plate", "hardened-hull", 10)
end

if parts.bz.lead and parts.experimental then
  if mods["FreightForwarding"] then
    rm.AddIngredient("hardened-hull", "lead-plate", 2)
  else
    rm.AddIngredient("hardened-hull", "lead-plate", 1)
  end
  rm.RemoveIngredient("electric-furnace", "lead-plate", 10)
  rm.RemoveIngredient("industrial-furnace", "lead-plate", 16)
  rm.RemoveIngredient("se-space-radiation-laboratory", "lead-plate", 100)
  --everyone and their cat has already complained about the BZ electric furnace
  --why is it there anyway lol. lead has a low melting point
end

if parts.bz.gold then
  if data.raw.item["silver-brazing-alloy"] then
    rm.multiply("airtight-seal", 2, true, true, true)
    rm.AddIngredient("airtight-seal", "silver-brazing-alloy", 2)
    rm.RemoveIngredient("airtight-seal", "bolted-flange", 1)
    rm.AddIngredient("airtight-seal-vitalic", "silver-brazing-alloy", 50)
    rm.RemoveIngredient("airtight-seal-vitalic", "bolted-flange", 50)
    if mods["IfNickel-Updated"] then
      tf.addPrereq("valves", "silver-processing")
    else if mods["BrimStuff-Updated"] then
      tf.addPrereq("rubber", "silver-processing")
    else
      tf.addPrereq(mods["aai-industry"] and "basic-fluid-handling" or "fluid-handling", "silver-processing")
    end end
  end
end

if parts.experimental and parts.bz.tungsten and (not mods["IfNickel-Updated"]) and (not mods["Krastorio2"]) then
  if data.raw.item["cuw"] then
    rm.ReplaceIngredient("hardened-hull", "iron-plate", "cuw", 2)
  else
    rm.ReplaceIngredient("hardened-hull", "iron-plate", "tungsten-plate", 2)
  end
  tf.addPrereq("hardened-hull", "tungsten-processing")
end

if mods["manganese"] then
  if parts.experimental then
    tf.addPrereq("hardened-hull", "mangalloy")
    tf.removePrereq("mangalloy", "steel-processing")
    --galvanized steel is 6 ore, mangalloy is 2 ore
    rm.ReplaceProportional("hardened-hull", "galvanized-steel-plate", "mangalloy", 3)
    tf.addPrereq("hardened-hull", "mangalloy")
    tf.removePrereq("hardened-hull", "steel-processing")
    if mods["space-exploration"] then
      rm.ReplaceProportional("hardened-hull-iridium", "galvanized-steel-plate", "mangalloy", 3)
    end
    if parts.drill then
      rm.AddIngredient("industrial-drill-head", "mangalloy", 2)
    end
  end
end
