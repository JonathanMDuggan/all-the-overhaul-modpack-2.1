local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")
local cu = require("category-utils")

local u = require("util")

if parts.bz.gas then
  rm.AddIngredient("gas-extractor", parts.motor, 1)
end

if parts.bz.tin and parts.experimental then
  rm.AddIngredient("cooling-fan", "solder", 1)
  --these use significantly more solder than cooling fans. however cooling fans are used for a lot of other things in high demand (blue circuits)
  rm.RemoveIngredient("roboport", "solder", 20)
  rm.RemoveIngredient("substation", "solder", 2)

  if data.raw.item["tinned-cable"] then
    tf.addPrereq("valves", "tinned-cable")
    if mods["Krastorio2"] or mods["MoreScience"] then
      tf.removeSciencePack("tinned-cable", "logistic-science-pack")
      tf.removePrereq("tinned-cable", "logistic-science-pack")
      if data.raw.technology["copper-processing"] then
        tf.addPrereq("tinned-cable", "copper-processing")
      else
        tf.addPrereq("tinned-cable", "automation")
      end
    end
  end
end

if parts.bz.tungsten and parts.experimental then
  tf.addPrereq("gimbaled-thruster", "rocketry")
end

if parts.bz.gold then

  if data.raw.item["silver-brazing-alloy"] and rm.CheckIngredient("invar-valve", "copper-plate") then
    tf.addPrereq("valves", "silver-processing")
    rm.ReplaceIngredient("invar-valve", "copper-plate", "silver-brazing-alloy", 2)
    rm.RemoveIngredient("pumpjack", "silver-brazing-alloy", 99999)
    --rm.RemoveIngredient("kr-mineral-water-pumpjack", "silver-brazing-alloy", 99999)
    rm.RemoveIngredient("oil-refinery", "silver-brazing-alloy", 99999)
    rm.RemoveIngredient("chemical-plant", "silver-brazing-alloy", 99999)
  else if rm.CheckIngredient("invar-valve", "airtight-seal") then
    --airtight seal will have SBA
    rm.RemoveIngredient("pumpjack", "silver-brazing-alloy", 99999)
    --rm.RemoveIngredient("kr-mineral-water-pumpjack", "silver-brazing-alloy", 99999)
    rm.RemoveIngredient("oil-refinery", "silver-brazing-alloy", 99999)
    rm.RemoveIngredient("chemical-plant", "silver-brazing-alloy", 99999)
  end end

  if mods["ThemTharHills-Updated"] or not mods["space-exploration"] then
    --TTH handles allowing small amounts of gold/plat/pall on nauvis
    if parts.experimental then
      if rm.CheckIngredient("mainboard", "temperature-sensor") then
        tf.removePrereq("processing-unit", "temperature-regulation")
        tf.removePrereq("injection-molding", "chemical-science-pack")
        tf.addPrereq("injection-molding", "temperature-regulation")
        rm.RemoveIngredient("mainboard", "temperature-sensor", 99999)
        rm.ReplaceIngredient("cooling-fan", "plastic-bar", "temperature-sensor", 1)
      end
    end

    if data.raw.item["titanium-palladium-flange"] and data.raw.item["advanced-flow-controller"] then
      tf.addPrereq("advanced-flow-controller", "palladium-processing")
      rm.AddIngredient("advanced-flow-controller", "titanium-palladium-flange", 2)
      rm.AddIngredient("advanced-flow-controller-biological", "titanium-palladium-flange", 6)
    end
  end

  if data.raw.item["gimbaled-thruster"] then
    --rcu is getting a bit overcrowded and the temp sensor should be in the part of the rocket that might plausibly overheat anyway
    if mods["space-exploration"] and mods["ThemTharHills-Updated"] then
      rm.AddIngredient("gimbaled-thruster", "temperature-sensor", 1)
    else if not mods["space-exploration"] then
      rm.AddIngredient("gimbaled-thruster", "temperature-sensor", 2)
    end end
  end

  if data.raw.item["silver-wire"] then
    local motor2 = u.table.deepcopy(data.raw.recipe[parts.motor])
    local m2name = parts.motor .. "-silver"
    motor2.name = m2name
    if mods["aai-industry"] then
      motor2.icons = {
        {
            icon = "__aai-industry__/graphics/icons/small-electric-motor.png",
            icon_size = 64
          },
          {
            icon = "__bzgold" .. (mods["bzgold2"] and "2" or "") .. "__/graphics/icons/silver-wire.png",
            icon_size = 64,
            icon_mipmaps = 4,
            scale = 0.25,
            shift = {-8, -8}
          }
      }
    else
      motor2.icons = {
        {
            icon = "__IfNickel-Updated__/graphics/icons/motor.png",
            icon_size = 64
          },
          {
            icon = "__bzgold" .. (mods["bzgold2"] and "2" or "") .. "__/graphics/icons/silver-wire.png",
            icon_size = 64,
            icon_mipmaps = 4,
            scale = 0.25,
            shift = {-8, -8}
          }
      }
    end
    motor2.allow_decomposition = false
    motor2.allow_as_intermediate = false
    data:extend({motor2})
    if mods["aai-industry"] then
      rm.ReplaceProportional(m2name, "aluminum-cable", "silver-wire", 6)
      rm.ReplaceProportional(m2name, "copper-cable", "silver-wire", 1)
    else
      rm.ReplaceProportional(m2name, "aluminum-cable", "silver-wire", 4)
      rm.ReplaceProportional(m2name, "copper-cable", "silver-wire", 1)
    end
    tf.addRecipeUnlock("electronics", m2name)
  end
end
