local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")

local function lasermill_recipe(recipe, lasdata)
  if data.raw.recipe[recipe] and not data.raw.recipe[recipe].lasermill then
    data.raw.recipe[recipe].lasermill = lasdata
  end
end

if parts.bz.carbon then
  rm.RemoveIngredient("low-density-structure", "diamond", 99999)
  rm.RemoveProduct("low-density-structure", "diamond", 99999)
  tf.removePrereq("low-density-structure", "diamond-processing")

  tf.removePrereq("laser", "diamond-processing")
  tf.addPrereq("carbon-dioxide-laser", "diamond-processing")
  if data.raw.item["ti-sapphire"] then
    tf.removeRecipeUnlock("laser", "ti-sapphire")
    tf.addRecipeUnlock("carbon-dioxide-laser", "ti-sapphire")

    tf.removePrereq("laser", "titanium-processing")
    tf.addPrereq("carbon-dioxide-laser", "titanium-processing")
  end
end

if parts.bz.gold then
  lasermill_recipe("silver-wire", {helium=1, type="gubbins", productivity=true, multiply=2})
  lasermill_recipe("mlcc", {helium=2, type="gubbins", unlock="advanced-capacitors", productivity=true})
  lasermill_recipe("temperature-sensor", {helium=2, type="gubbins", unlock="temperature-regulation", productivity=true})

  lasermill_recipe("mainboard", {helium=60, type="circuit", unlock="processing-unit"})
  
  if data.raw.item.mlcc and data.raw.item.tracker and not mods["space-exploration"] then
    rm.AddIngredient("tracker", "mlcc", 1, 1)
  end
end

if parts.bz.aluminum then
  lasermill_recipe("aluminum-cable", {helium=1, type="gubbins", productivity=true})
  lasermill_recipe("spark-plug", {helium=2, type="gubbins", productivity=true})
end

if parts.bz.tin then
  lasermill_recipe("tinned-cable", {helium=2, type="gubbins"})
end

if parts.bz.silicon then
  tf.addPrereq("helium-laser", "fiber-optics")
  lasermill_recipe("optical-fiber", {helium=1, type="gubbins", productivity=true, multiply=4})
end

if parts.bz.chlorine then
  lasermill_recipe("pcb", {helium=2, type="circuit", productivity=true, remove_fluids=true})
end

if parts.bz.gas then
  data.raw.recipe["formaldehyde"].ingredients[1].fluidbox_index = 1
  data.raw.recipe["formaldehyde"].results[1].fluidbox_index = 1
end
