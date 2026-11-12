local deepcopy = require("util").table.deepcopy
local parts = require("variable-parts")
local rm = require("recipe-modify")
local tf = require("techfuncs")

table.insert(data.raw["assembling-machine"]["assembling-machine-2"]["crafting_categories"], "laser-assembling")
table.insert(data.raw["assembling-machine"]["assembling-machine-3"]["crafting_categories"], "laser-assembling")

if mods["Krastorio2"] then
  data.raw.fluid["crude-oil"].icon = "__LasingAround-Updated__/graphics/icons/crude-oil.png"
end

if data.raw["assembling-machine"]["se-space-assembling-machine"] then
  table.insert(data.raw["assembling-machine"]["se-space-assembling-machine"]["crafting_categories"], "laser-assembling")
  table.insert(data.raw["assembling-machine"]["se-space-manufactory"]["crafting_categories"], "laser-assembling")
end

if data.raw.item["micron-tolerance-components"] then
  local microvalve = deepcopy(data.raw.recipe["invar-valve"])
  microvalve.name = "invar-valve-micron-tolerance"
  microvalve.icons = {
    {
      icon = "__IfNickel-Updated__/graphics/icons/invar-valve.png",
      icon_size = 64
    },
    {
      icon = "__LasingAround-Updated__/graphics/icons/micron-tolerance-components.png",
      icon_size = 64,
      scale = 0.25,
      shift = {-8, -8}
    }
  }
  data:extend({microvalve})
  rm.ReplaceProportional("invar-valve-micron-tolerance", "invar-plate", "micron-tolerance-components", 3)

  if data.raw.item["gimbaled-thruster"] and mods["LunarLandings"] then
    local microthruster = deepcopy(data.raw.recipe["gimbaled-thruster"])
    microthruster.name = "gimbaled-thruster-micron-tolerance"
    microthruster.icons = {
      {
        icon = "__IfNickel-Updated__/graphics/icons/gimbaled-thruster.png",
        icon_size = 64
      },
      {
        icon = "__LasingAround-Updated__/graphics/icons/micron-tolerance-components.png",
        icon_size = 64,
        scale = 0.25,
        shift = {-8, -8}
      }
    }
    data:extend({microthruster})
    rm.multiply("gimbaled-thruster-micron-tolerance", 4, true, true, true)
    rm.ReplaceProportional("gimbaled-thruster-micron-tolerance", "invar-plate", "ll-alumina", 1.5)
    rm.RemoveIngredient("gimbaled-thruster-micron-tolerance", "complex-joint", 1)
    rm.RemoveIngredient("gimbaled-thruster-micron-tolerance", "bearing", 2)
    rm.RemoveIngredient("gimbaled-thruster-micron-tolerance", "iron-gear-wheel", 4)
    rm.AddIngredient("gimbaled-thruster-micron-tolerance", "micron-tolerance-components", 4)
    tf.addRecipeUnlock("micron-tolerance-space-machines", "gimbaled-thruster-micron-tolerance")
  end

  if data.raw.item["skyseeker-armature"] and mods["LunarLandings"] then
    local microseeker = deepcopy(data.raw.recipe["skyseeker-armature"])
    microseeker.name = "skyseeker-armature-micron-tolerance"
    microseeker.icons = {
      {
        icon = parts.qualityIconPath("brasstacks", "icons/skyseeker-armature.png"),
        icon_size = 64
      },
      {
        icon = "__LasingAround-Updated__/graphics/icons/micron-tolerance-components.png",
        icon_size = 64,
        scale = 0.25,
        shift = {-8, -8}
      }
    }
    data:extend({microseeker})
    rm.ReplaceProportional("skyseeker-armature-micron-tolerance", "iron-gear-wheel", "micron-tolerance-components", 1)
    rm.ReplaceProportional("skyseeker-armature-micron-tolerance", "kr-steel-gear-wheel", "micron-tolerance-components", 0.5)
    tf.addRecipeUnlock("micron-tolerance-space-machines", "skyseeker-armature-micron-tolerance")
  end

  if data.raw.technology["micron-tolerance-instruments"] then
    local gyro_recipe
    if data.raw.recipe["gyro"] then
      gyro_recipe = deepcopy(data.raw.recipe["gyro"])
    else
      gyro_recipe = deepcopy(data.raw.recipe["gyroscope"])
    end
    if gyro_recipe then
      local old_gyro = gyro_recipe.name
      gyro_recipe.name = "gyroscope-micron-tolerance"
      data:extend({gyro_recipe})
      gyro_recipe = data.raw.recipe["gyroscope-micron-tolerance"] -- i don't know if data:extend does a deepcopy. i should refactor my recipe manipulators to allow passing a prototype as well as a name
      if rm.CheckIngredient("gyroscope-micron-tolerance", "bearing") then
        --brass tacks gyroscope
        rm.RemoveIngredient("gyroscope-micron-tolerance", "bearing", 1)
        rm.AddIngredient("gyroscope-micron-tolerance", "micron-tolerance-components", 2)
        gyro_recipe.icons = {
          {
            icon = parts.qualityIconPath("brasstacks", "icons/gyroscope.png"),
            icon_size = 64
          },
          {
            icon = "__LasingAround-Updated__/graphics/icons/micron-tolerance-components.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          }
        }
      else
        if rm.RemoveIngredient("gyroscope-micron-tolerance", "diamond", 1) then
          rm.AddIngredient("gyroscope-micron-tolerance", "micron-tolerance-components", 2)
        else if rm.RemoveIngredient("gyroscope-micron-tolerance", "titanium-plate", 1) then
          rm.AddIngredient("gyroscope-micron-tolerance", "micron-tolerance-components", 2)
        else if rm.RemoveIngredient("gyroscope-micron-tolerance", "tungsten-plate", 1) then
          rm.AddIngredient("gyroscope-micron-tolerance", "micron-tolerance-components", 1)
          for k, v in pairs(gyro_recipe.results) do
            if v.name == old_gyro then
              v.amount = 5
            end
          end
        else
          rm.AddIngredient("gyroscope-micron-tolerance", "micron-tolerance-components", 1)
          for k, v in pairs(gyro_recipe.results) do
            if v.name == old_gyro then
              v.amount = 6
            end
          end
        end end end
        gyro_recipe.icons = {
          {
            icon = "__bzsilicon" .. (mods["bzsilicon2"] and "2" or "") .. "__/graphics/icons/gyro.png",
            icon_size = 128
          },
          {
            icon = "__LasingAround-Updated__/graphics/icons/micron-tolerance-components.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          }
        }
      end
      tf.addRecipeUnlock("micron-tolerance-instruments", "gyroscope-micron-tolerance")
    else
      gyro_recipe = deepcopy(data.raw.recipe["processing-unit"])
      gyro_recipe.name = "rocket-control-unit-micron-tolerance"
      data:extend({gyro_recipe})
      gyro_recipe = data.raw.recipe["rocket-control-unit-micron-tolerance"]
      gyro_recipe.icons = {
        {
          icon = "__LasingAround-Updated__/graphics/icons/rocket-control-unit.png",
          icon_size = 64,
          icon_mipmaps = 4
        },
        {
          icon = "__LasingAround-Updated__/graphics/icons/micron-tolerance-components.png",
          icon_size = 64,
          scale = 0.25,
          shift = {-8, -8}
        }
      }
      rm.ReplaceIngredient("rocket-control-unit-micron-tolerance", "advanced-circuit", "electronic-circuit", 1)
      if rm.CheckIngredient("rocket-control-unit-micron-tolerance", "advanced-circuit") then
        rm.ReplaceIngredient("rocket-control-unit-micron-tolerance", "advanced-circuit", "electronic-circuit", 1)
        rm.AddIngredient("rocket-control-unit-micron-tolerance", "micron-tolerance-components", 3)
      else
        rm.AddIngredient("rocket-control-unit-micron-tolerance", "micron-tolerance-components", 2)
      end
      tf.addRecipeUnlock("micron-tolerance-instruments", "rocket-control-unit-micron-tolerance")
    end
  end
end

require("compat.final")
require("lasermill_recipe_generator")

if deadlock and data.raw.item["micron-tolerance-components"] then
  deadlock.add_stack("micron-tolerance-components", "__LasingAround-Updated__/graphics/icons/micron-tolerance-components-stacked.png", "deadlock-stacking-2", 64)
end

if deadlock_crating and data.raw.item["micron-tolerance-components"] then
  deadlock_crating.add_crate("micron-tolerance-components", "deadlock-crating-2")
end

if data.raw.fluid["formaldehyde"] then
   --prevent burning formaldehyde for unlimited helium
   --I won't stop you from using a flare stack but you aren't allowed to get value from it.
   --getting power from oil is fine and generally an intended use of oil.
  data.raw.fluid["formaldehyde"].fuel_value = nil
end

if data.raw["fluid-turret"]["flamethrower-turret"] and data.raw["fluid-turret"]["flamethrower-turret"].attack_parameters and data.raw["fluid-turret"]["flamethrower-turret"].attack_parameters.fluids then
  table.insert(data.raw["fluid-turret"]["flamethrower-turret"].attack_parameters.fluids, {type = "filtered-oil"})
end
