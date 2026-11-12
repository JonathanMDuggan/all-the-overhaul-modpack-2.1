local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")

local allowed_recipes = {
  mods["Krastorio2"] and "nitric-acid-early" or "nitric-acid",
  "gold-powder",
  "gold-plate",
  "trace-gold-from-copper",

  "gold-wire",
  "integrated-circuit",
  "transceiver",
  "advanced-cable",
  "hv-power-regulator",

  "molten-gold",

  "cheese-ore-processing"
}

for k, v in pairs(allowed_recipes) do
  if data.raw.recipe[v] then
    data.raw.recipe[v].allow_productivity = true
  end
end

local function removeProdmodAllowed(recipename)
  if data.raw.recipe[recipename] then
    local va = data.raw.recipe[recipename].allowed_module_categories or {}
    local fi = -1
    for k, v in pairs(va) do
      if v == "productivity" then
        fi = k
      end
    end
    if fi > 0 then
      table.remove(va, fi) 
    end
    data.raw.recipe[recipename].allowed_module_categories = va
  end
end

if mods["248k-Redux"] then
  if mods["space-exploration"] then
    removeProdmodAllowed("fu_gold_plate")
  else
    if parts.bz.gold then
      removeProdmodAllowed("fu_gold_ingot")
      removeProdmodAllowed("fu_gold_plate")
    end
  end
  removeProdmodAllowed("gr_gold_wire")
end

for k, v in pairs(data.raw["map-gen-presets"]["default"]) do
  if type(v) == "table" and v.basic_settings and v.basic_settings.autoplace_controls and v.basic_settings.autoplace_controls["copper-ore"] then
    v.basic_settings.autoplace_controls["gold-ore"] = table.deepcopy(v.basic_settings.autoplace_controls["copper-ore"])
    if mods["LunarLandings"] then
      v.basic_settings.autoplace_controls["cheese-ore"] = table.deepcopy(v.basic_settings.autoplace_controls["copper-ore"])
    end
  end
end

if mods["LunarLandings"] then
  --LL hard-overrides the satellite recipe in DFF.
  rm.ReplaceIngredient("satellite", "advanced-circuit", "transceiver", 20)
  if not mods["BrassTacks-Updated"] then
    tf.addRecipeUnlock("lunar-cheese-exploitation", "cheese-ore-processing-heat")
    data.raw.recipe["cheese-ore-processing-heat"].enabled = false
  end
end

require("deadlock")
require("compat.final")
