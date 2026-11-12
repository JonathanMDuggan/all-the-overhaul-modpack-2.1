local rm = require("recipe-modify")
local parts = require("variable-parts")
local tf = require("techfuncs")

local allowed_recipes = {
  "zinc-plate",
  "brass-plate",
  "bolted-flange",
  "brass-balls",
  "bearing",
  "airtight-seal",

  "flywheel",
  "articulated-mechanism",
  "galvanized-steel-plate",
  "hardened-hull",
  "complex-joint",
  parts.gyroscope,

  "enriched-zinc",
  "enriched-zinc-plate",
  "molten-zinc",

  "complex-joint-iridium",
  "hardened-hull-iridium",
  "airtight-seal-vitalic",

  "cheese-ore-processing",

  mods["Krastorio2"] and "gearbox" or nil,
  mods["Krastorio2"] and "gearbox-iridium" or nil,
  mods["Krastorio2"] and "advanced-gearbox" or nil,
}
--brass precursor not included to avoid "double dipping"
--relatively little brass is needed in the grand scheme, being able to get +40% for relatively cheap is overkill
--(prodmods in furnaces being generally worse than prodmods in assemblers)

if data.raw.recipe["brass-plate-foundry"] then
  allowed_recipes[2] = "brass-plate-foundry"
  if parts.foundryEnabled then
    data.raw.recipe["brass-plate"].localised_description = {"recipe-description.brass-plate-foundry-rules"}
    data.raw.recipe["brass-plate-foundry"].localised_description = {"recipe-description.brass-plate-foundry-rules"}
  end
end

for k, v in pairs(allowed_recipes) do
  if data.raw.recipe[v] then
    data.raw.recipe[v].allow_productivity = true
  end
end

for k, v in pairs(data.raw["map-gen-presets"]["default"]) do
  if type(v) == "table" and v.basic_settings and v.basic_settings.autoplace_controls and v.basic_settings.autoplace_controls["copper-ore"] then
    v.basic_settings.autoplace_controls["zinc-ore"] = table.deepcopy(v.basic_settings.autoplace_controls["copper-ore"])
  end
end

if mods["LunarLandings"] then
  tf.addRecipeUnlock("lunar-cheese-exploitation", "cheese-ore-processing-heat")
  data.raw.recipe["cheese-ore-processing-heat"].enabled = false
end

require("deadlock")
require("compat.final")

--for k, v in pairs(data.raw.recipe) do
--  rm.ReplaceProportional(k, "brass-pipe-fitting", "bolted-flange", 1)
--end
--you may think this would give other mods the chance to update but really this would create extra work for multiple version checking and etc.
