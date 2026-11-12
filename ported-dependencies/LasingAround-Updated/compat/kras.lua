local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")

local function lasermill_recipe(recipe, lasdata)
  if data.raw.recipe[recipe] and not data.raw.recipe[recipe].lasermill then
    data.raw.recipe[recipe].lasermill = lasdata
  end
end

if mods["Krastorio2"] then
  rm.ReplaceProportional("kr-advanced-lab", "advanced-circuit", "scanner", 0.5)
  tf.addPrereq("kr-advanced-lab", "scanner")

  rm.AddIngredient("kr-fusion-reactor", "carbon-dioxide-laser", 100)

  rm.AddIngredient("kr-atmospheric-condenser", "spectroscope", 1)
  tf.addPrereq("kr-atmosphere-condensation", "spectroscopy")

  rm.AddIngredient("kr-advanced-chemical-plant", "spectroscope", 10)

  rm.AddIngredient("kr-singularity-lab", "spectroscope", 100)
  rm.AddIngredient("kr-singularity-lab", "scanner", 100)

  lasermill_recipe("kr-iron-beam", {helium=1, productivity=true})
  lasermill_recipe("kr-steel-beam", {helium=3, productivity=true})
  lasermill_recipe("kr-steel-gear-wheel", {helium=6, productivity=true})
  lasermill_recipe("kr-imersium-beam", {convert=true, helium=6, se_variant="space-crafting", se_tooltip_entity="se-space-assembling-machine", unlock="kr-imersium-processing"})
  lasermill_recipe("kr-imersium-gear-wheel", {convert=true, helium=12, se_variant="space-crafting", se_tooltip_entity="se-space-assembling-machine", unlock="kr-imersium-processing"})

  lasermill_recipe("kr-blank-tech-card", {helium=1, type="circuit", productivity=true})
  lasermill_recipe("blank-tech-card-silver", {helium=1, type="circuit", productivity=true})

  lasermill_recipe("kr-steel-pipe", {helium=8})
  lasermill_recipe("kr-steel-pipe-to-ground", {helium=25, type="entity"})

  --rm.ReplaceIngredient("kr-superior-filter-inserter", "processing-unit", "scanner", 1)

  rm.ReplaceIngredient("kr-advanced-splitter", "advanced-circuit", "scanner", 1)

  if data.raw.item["tracker"] then
    rm.AddIngredient("kr-small-roboport", "tracker", 10)
    rm.AddIngredient("kr-big-roboport", "tracker", 50)

    if settings.startup["kr-containers"].value then
      tf.addPrereq("kr-logistic-containers-1", "tracking-systems")
      tf.addPrereq("kr-logistic-containers-2", "tracking-systems")
    end

    rm.ReplaceProportional("kr-passive-provider-strongbox", "electronic-circuit", "tracker", 1/2)
    rm.ReplaceProportional("kr-active-provider-strongbox", "electronic-circuit", "tracker", 1/2)
    rm.ReplaceProportional("kr-requester-strongbox", "electronic-circuit", "tracker", 1/2)
    rm.ReplaceProportional("kr-buffer-strongbox", "electronic-circuit", "tracker", 1/2)
    rm.ReplaceProportional("kr-storage-strongbox", "electronic-circuit", "tracker", 1/2)
    rm.RemoveIngredient("kr-passive-provider-strongbox", "advanced-circuit", 99999)
    rm.RemoveIngredient("kr-active-provider-strongbox", "advanced-circuit", 99999)
    rm.RemoveIngredient("kr-requester-strongbox", "advanced-circuit", 99999)
    rm.RemoveIngredient("kr-buffer-strongbox", "advanced-circuit", 99999)
    rm.RemoveIngredient("kr-storage-strongbox", "advanced-circuit", 99999)

    rm.ReplaceProportional("kr-passive-provider-warehouse", "electronic-circuit", "tracker", 1/2)
    rm.ReplaceProportional("kr-active-provider-warehouse", "electronic-circuit", "tracker", 1/2)
    rm.ReplaceProportional("kr-requester-warehouse", "electronic-circuit", "tracker", 1/2)
    rm.ReplaceProportional("kr-buffer-warehouse", "electronic-circuit", "tracker", 1/2)
    rm.ReplaceProportional("kr-storage-warehouse", "electronic-circuit", "tracker", 1/2)
    rm.RemoveIngredient("kr-passive-provider-warehouse", "advanced-circuit", 99999)
    rm.RemoveIngredient("kr-active-provider-warehouse", "advanced-circuit", 99999)
    rm.RemoveIngredient("kr-requester-warehouse", "advanced-circuit", 99999)
    rm.RemoveIngredient("kr-buffer-warehouse", "advanced-circuit", 99999)
    rm.RemoveIngredient("kr-storage-warehouse", "advanced-circuit", 99999)

    rm.ReplaceIngredient("kr-laser-artillery-turret", "gyroscope", "tracker", 10)
    rm.RemoveIngredient("kr-laser-artillery-turret", "gyro", 10)
    rm.ReplaceIngredient("kr-railgun-turret", "gyroscope", "tracker", 10)
    rm.RemoveIngredient("kr-railgun-turret", "gyro", 10)
    rm.ReplaceIngredient("kr-rocket-turret", "gyroscope", "tracker", 10)
    rm.RemoveIngredient("kr-rocket-turret", "gyro", 10)

    rm.AddIngredient("kr-intergalactic-transceiver", "tracker", 200)
  end

  rm.AddIngredient("kr-laser-artillery-turret", "carbon-dioxide-laser", 5)
  rm.RemoveIngredient("kr-laser-artillery-turret", "diamond", 99999)
  rm.RemoveIngredient("kr-laser-artillery-turret", "ti-sapphire", 99999)

  rm.AddIngredient("kr-advanced-tech-card", "carbon-dioxide-laser", 5)

  rm.AddIngredient("kr-matter-stabilizer", "spectroscope", 1)

  if data.raw.item["micron-tolerance-components"] then
    if parts.brassExperiment then
      rm.AddIngredient("elite-gearbox", "micron-tolerance-components", 3)
    end
  end

  if settings.startup["lasingaround-k2-advanced-assembler-can-laser-mill"] then
    rm.ReplaceIngredient("kr-advanced-assembling-machine", "electric-furnace", "laser-mill", 1)
    table.insert(data.raw["assembling-machine"]["kr-advanced-assembling-machine"]["crafting_categories"], "laser-milling-exclusive")
  end
  table.insert(data.raw["assembling-machine"]["kr-advanced-assembling-machine"]["crafting_categories"], "laser-assembling")
end

if mods["FluidMustFlow"] then
  local cost = 1
  if mods["Expensive_Fluid_Must_Flow_Recipes"] then
    if parts.brassExperiment then
      cost = 10
    else
      cost = 5
    end
  else
    if parts.brassExperiment then
      cost = 2
    else
      cost = 1
    end
  end

  lasermill_recipe("duct-small", {helium=2*cost, type="entity", unlock="ducts"})
  lasermill_recipe("duct", {helium=4*cost, type="entity", unlock="ducts"})
  lasermill_recipe("duct-long", {helium=8*cost, type="entity", unlock="ducts"})
  lasermill_recipe("duct-t-junction", {helium=4*cost, type="entity", unlock="ducts"})
  lasermill_recipe("duct-curve", {helium=4*cost, type="entity", unlock="ducts"})
  lasermill_recipe("duct-cross", {helium=4*cost, type="entity", unlock="ducts"})
  lasermill_recipe("duct-underground", {helium=30*cost, type="entity", unlock="ducts"})
end
