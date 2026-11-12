local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")

local function lasermill_recipe(recipe, lasdata)
  if data.raw.recipe[recipe] then
    data.raw.recipe[recipe].lasermill = lasdata
  end
end

tf.addRecipeUnlock("oil-processing", "oil-filtration")
rm.ReplaceProportional("basic-oil-processing", "crude-oil", "filtered-oil", 1)
rm.ReplaceProportional("advanced-oil-processing", "crude-oil", "filtered-oil", 1)
rm.ReplaceProportional("oil-processing-heavy", "crude-oil", "filtered-oil", 1)
rm.ReplaceProportional("flamethrower-ammo", "crude-oil", "filtered-oil", 1)

if not rm.CheckIngredient("basic-oil-processing", "water") then
  if data.raw.recipe["basic-oil-processing"] and data.raw.recipe["basic-oil-processing"].ingredients then
    data.raw.recipe["basic-oil-processing"].ingredients[1].fluidbox_index = 2
  end
end

tf.addRecipeUnlock("laser", "empty-amplifier-tube")
if parts.bz.gold and not (mods["ThemTharHills-Updated"] or mods["space-exploration"]) then
  tf.addPrereq("laser", "gold-processing")
end

if not mods["Krastorio2"] then
  tf.addPrereq("logistics-3", "scanner")
  rm.ReplaceProportional("express-splitter", "advanced-circuit", "scanner", 0.2)
end

tf.addPrereq("automation-3", "scanner")
if data.raw.item["advanced-machining-tool"] then
  rm.ReplaceProportional("advanced-machining-tool", "speed-module", "scanner", 1)
  rm.ReplaceProportional("advanced-machining-tool", "integrated-circuit", "scanner", 0.2)
  if not rm.CheckIngredient("advanced-machining-tool", "scanner") then
    rm.AddIngredient("advanced-machining-tool", "scanner", 1)
    rm.RemoveIngredient("advanced-machining-tool", "advanced-circuit", 99999)
  end
else
  rm.ReplaceProportional("assembling-machine-3", "speed-module", "scanner", 1)
  rm.ReplaceProportional("assembling-machine-3", "integrated-circuit", "scanner", 0.2)
  if not rm.CheckIngredient("assembling-machine-3", "scanner") then
    rm.AddIngredient("assembling-machine-3", "scanner", 2)
    rm.RemoveIngredient("assembling-machine-3", "advanced-circuit", 99999)
  end
end

if mods["ThemTharHills-Updated"] then
  tf.removePrereq("laser", "high-voltage-equipment")
  tf.addPrereq("carbon-dioxide-laser", "high-voltage-equipment")
end

if data.raw.item["tracker"] then

  tf.addPrereq("artillery", "tracking-systems")
  rm.RemoveIngredient("artillery-shell", "transceiver", 99999)
  rm.RemoveIngredient("artillery-shell", "gyroscope", 99999)
  rm.RemoveIngredient("artillery-shell", "gyro", 99999)
  rm.RemoveIngredient("artillery-shell", "radar", 99999)
  rm.AddIngredient("artillery-shell", "tracker", 1)
  if not data.raw.item["skyseeker-armature"] then
    rm.RemoveIngredient("artillery-turret", "gyroscope", 99999)
    rm.RemoveIngredient("artillery-turret", "gyro", 99999)
    rm.RemoveIngredient("artillery-wagon", "gyroscope", 99999)
    rm.RemoveIngredient("artillery-wagon", "gyro", 99999)
    rm.AddIngredient("artillery-turret", "tracker", 10)
    rm.AddIngredient("artillery-wagon", "tracker", 10)
  else
    tf.addPrereq("skyseeker-armature", "tracking-systems")
  end
  if not mods["aai-containers"] then
    tf.addPrereq("logistic-system", "tracking-systems")

    rm.RemoveIngredient("requester-chest", "advanced-circuit", 1)
    rm.ReplaceIngredient("requester-chest", "transceiver", "tracker", 1)
    rm.RemoveIngredient("buffer-chest", "advanced-circuit", 1)
    rm.ReplaceIngredient("buffer-chest", "transceiver", "tracker", 1)
    rm.RemoveIngredient("active-provider-chest", "advanced-circuit", 1)
    rm.ReplaceIngredient("active-provider-chest", "transceiver", "tracker", 1)
  end

  tf.addPrereq("personal-roboport-mk2-equipment", "tracking-systems")
  rm.AddIngredient("personal-roboport-mk2-equipment", "tracker", 20)

  if not mods["space-exploration"] then
    tf.removePrereq("logistic-system", "utility-science-pack")
  end
end

if not (mods["space-exploration"] or mods["LunarLandings"]) then
  rm.AddIngredient("satellite", "spectroscope", 100)
  tf.addPrereq("space-science-pack", "spectroscopy")
end

tf.addPrereq("effect-transmission", "helium-laser")
rm.AddIngredient("beacon", "helium-laser", 5)

tf.addPrereq("laser-turret", "carbon-dioxide-laser")
tf.removePrereq("laser-turret", "laser")
rm.RemoveIngredient("laser-turret", mods["Krastorio2"] and "kr-glass" or "glass", 99999)
rm.RemoveIngredient("laser-turret", "bismuth-glass", 99999)
rm.RemoveIngredient("laser-turret", "diamond", 99999)
rm.RemoveIngredient("laser-turret", "ti-sapphire", 99999)
rm.RemoveIngredient("laser-turret", "kr-quartz", 99999)
rm.ReplaceIngredient("laser-turret", "hv-power-regulator", "carbon-dioxide-laser", 1)

tf.removePrereq("distractor", "laser")
tf.addPrereq("distractor", "carbon-dioxide-laser")
rm.AddIngredient("distractor-capsule", "empty-amplifier-tube", 1)

if data.raw.item["micron-tolerance-components"] then
  if parts.nickelExperiment then
    if not mods["LunarLandings"] then
      if rm.CheckIngredient("gimbaled-thruster", "invar-plate") then
        rm.ReplaceProportional("gimbaled-thruster", "invar-plate", "micron-tolerance-components", 6)
      else
        rm.AddIngredient("gimbaled-thruster", "micron-tolerance-components", 4)
      end
      tf.addPrereq("gimbaled-thruster", "micron-tolerance-manufacturing")
    end

    rm.AddIngredient("advanced-machining-tool", "micron-tolerance-components", 1)
    if not mods["space-exploration"] then
      tf.addPrereq("automation-3", "micron-tolerance-manufacturing")
    end
  end
end

lasermill_recipe("iron-gear-wheel", {helium=1, productivity=true})
lasermill_recipe("barrel", {helium=2, productivity=true})
lasermill_recipe("pipe", {helium=mods["BrassTacks-Updated"] and 3 or 1, multiply=mods["BrassTacks-Updated"] and 2 or 1}) --technically an entity but screw you tbh.
lasermill_recipe("low-density-structure", {helium=mods["LunarLandings"] and 15 or 10, convert=not mods["LunarLandings"], se_variant="space-crafting", se_tooltip_entity="se-space-assembling-machine", unlock=mods["LunarLandings"] and "laser-mill" or "se-space-assembling", icon_offset = {data.raw.item["nanotubes"] and 8 or -8, -8}})

lasermill_recipe("uranium-fuel-cell", {helium=50, productivity=true, unlock="uranium-processing"})
lasermill_recipe("heat-pipe", {helium=35, type="entity", unlock="nuclear-power"})

if mods["LunarLandings"] then
  lasermill_recipe("ll-low-density-structure-aluminium", {helium=15, convert=true, se_variant="space-crafting", se_tooltip_entity="se-space-assembling-machine", unlock="ll-low-density-structure-aluminium", icon_offset = {-8, -8}})
  tf.addPrereq("ll-low-density-structure-aluminium", "laser-mill")
else
  tf.removePrereq("low-density-structure", "chemical-science-pack")
  tf.addPrereq("low-density-structure", "laser-mill")
end

lasermill_recipe("iron-stick", {helium=1, productivity=true, type="gubbins", multiply=2})
lasermill_recipe("copper-cable", {helium=1, productivity=true, type="gubbins", multiply=2})

--it's easier this way.
lasermill_recipe("electronic-circuit", {helium=parts.bz.tin and 2 or 1, productivity=true, type="circuit"})

lasermill_recipe("advanced-circuit", {helium=rm.CheckIngredient("advanced-circuit", "silicon-wafer") and 15 or 5, productivity=true, type="circuit"})
if not rm.CheckIngredient("processing-unit", "sulfuric-acid") then
  --this is the bzgold blue circuit which is quite cheap
  lasermill_recipe("processing-unit", {helium=10, productivity=true, type="circuit", unlock="processing-unit"})
end

lasermill_recipe("iron-chest", {helium=4, type="entity"})
lasermill_recipe("steel-chest", {helium=20, type="entity"})
lasermill_recipe("storage-tank", {helium=40, type="entity"})
lasermill_recipe("medium-electric-pole", {helium=5, type="entity", unlock="electric-energy-distribution-1"})
lasermill_recipe("big-electric-pole", {helium=12, type="entity", unlock="electric-energy-distribution-1"})
lasermill_recipe("pipe-to-ground", {helium=7, type="entity"})

if mods["MoreScience"] then
  tf.addSciencePack("helium-extraction", "advanced-automation-science-pack")
  tf.addSciencePack("helium-laser", "electric-power-science-pack")
  tf.addSciencePack("carbon-dioxide-laser", "electric-power-science-pack")
  tf.addSciencePack("laser-mill", "electric-power-science-pack")
  tf.addSciencePack("laser-mill", "advanced-automation-science-pack")
  tf.addSciencePack("micron-tolerance-manufacturing", "advanced-automation-science-pack")
  tf.addSciencePack("spectroscopy", "advanced-automation-science-pack")
  tf.addSciencePack("scanner", "advanced-automation-science-pack")
  tf.addSciencePack("spectroscopic-helium-extraction", "advanced-automation-science-pack")
  tf.addSciencePack("spectroscopic-helium-extraction", "electric-power-science-pack")
  tf.addSciencePack("tracking-systems", "advanced-automation-science-pack")
  tf.addSciencePack("tracking-systems", "electric-power-science-pack")

  rm.AddIngredient("rocketpart-fusion-reactor", "carbon-dioxide-laser", 10)
  rm.AddIngredient("rocketpart-laser-array", "carbon-dioxide-laser", 20)
end

if mods["LunarLandings"] then
  tf.removePrereq("laser", "chemical-science-pack")
  tf.addPrereq("laser", "ll-moon-rock-processing")

  tf.addPrereq("helium-laser", "ll-luna-automation")
  tf.addPrereq("carbon-dioxide-laser", "ll-luna-automation")

  rm.AddProductRaw("ll-moon-rock-processing", {type="fluid", name="helium", amount=5, fluidbox_index=1})
  tf.addRecipeUnlock("ll-moon-rock-processing", "helium-venting")

  rm.SetCategory("helium-laser", "advanced-circuit-crafting")
  rm.SetCategory("carbon-dioxide-laser", "advanced-circuit-crafting")
  rm.SetCategory("tracker", "advanced-circuit-crafting")
  rm.SetCategory("spectroscope", "advanced-circuit-crafting")
  rm.SetCategory("scanner", "advanced-circuit-crafting")

  rm.ReplaceIngredient("carbon-dioxide-laser", "petroleum-gas", "ll-oxygen", 250)
  rm.AddIngredient("carbon-dioxide-laser", "solid-fuel", 1)

  tf.addPrereq("laser-mill", "production-science-pack")
  tf.addSciencePack("laser-mill", "production-science-pack")
  if data.raw.item["micron-tolerance-components"] then
    tf.addSciencePack("micron-tolerance-manufacturing", "production-science-pack")
    rm.SetCategory("spectroscope-micron-tolerance", "advanced-circuit-crafting")
    rm.AddIngredient("ll-quantum-resonator", "micron-tolerance-components", 50)
  end

  tf.addPrereq("ll-space-data-collection", "spectroscopy")
  rm.AddIngredient("ll-data-card", "spectroscope", 1)
  rm.AddProductRaw("ll-data-card", {type="item", name="spectroscope", amount=1, independent_probability=0.75})
  rm.AddIngredient("ll-quantum-data-card", "spectroscope", 1)
  rm.AddProductRaw("ll-quantum-data-card", {type="item", name="spectroscope", amount=1, independent_probability=0.33})

  rm.AddIngredient("ll-telescope", "spectroscope", 20)

  tf.addPrereq("ll-quantum-resonation", "carbon-dioxide-laser")
  rm.ReplaceIngredient("ll-quantum-resonator", "lab", "carbon-dioxide-laser", 5)

  rm.AddIngredient("ll-superposition-right-left", "carbon-dioxide-laser", 1)
  rm.AddProductRaw("ll-superposition-right-left", {type="item", name="carbon-dioxide-laser", amount=1, independent_probability=0.9})
  rm.AddIngredient("ll-superposition-up-down", "carbon-dioxide-laser", 1)
  rm.AddProductRaw("ll-superposition-up-down", {type="item", name="carbon-dioxide-laser", amount=1, independent_probability=0.9})

  if data.raw.item["tracker"] then
    rm.AddIngredient("rocket-part-interstellar", "tracker", 1)
  end

  tf.addPrereq("ll-interstellar-satellite", "scanner")
  rm.AddIngredient("ll-interstellar-satellite", "scanner", 100)
  rm.AddIngredient("ll-interstellar-satellite", "spectroscope", 100)
end

require("compat.aai")
require("compat.kras")
require("compat.bz")
require("compat.248k")

data.raw.item["filtered-oil-barrel"].ib_badge = "FO"
data.raw.recipe["filtered-oil-barrel"].ib_badge = "FO"
data.raw.recipe["filtered-oil-barrel"].ib_corner = "left-bottom"
data.raw.recipe["empty-filtered-oil-barrel"].ib_badge = "FO"
data.raw.recipe["empty-filtered-oil-barrel"].ib_corner = "left-bottom"

data.raw.item["helium-barrel"].ib_badge = "He"
data.raw.recipe["helium-barrel"].ib_badge = "He"
data.raw.recipe["helium-barrel"].ib_corner = "left-bottom"
data.raw.recipe["empty-helium-barrel"].ib_badge = "He"
data.raw.recipe["empty-helium-barrel"].ib_corner = "left-bottom"
