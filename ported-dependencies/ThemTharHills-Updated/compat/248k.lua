local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")

--[[
local function nukeItem(itemname)
  data.raw.item[itemname] = nil
  --delete 248k duplication recipe
  data.raw.recipe["gr_white_hole_cycle_"..itemname.."_recipe"] = nil
  --delete voiding recipes
  --if you make a dynamic voiding mod with expensive variants i will eat your eyeballs
  for recname, recipe in pairs(data.raw.recipe) do
    if recipe.results and #recipe.results == 0 then
      if rm.CheckIngredient(recname, itemname) then
        data.raw.recipe[recname] = nil
      end
    end
  end
end
]]--

if mods["248k-Redux"] then
  rm.RemoveIngredient("processing-unit", "fi_gold", 99999)
  rm.RemoveIngredient("processing-unit", "fi_gold", 99999)
  --rm.ReplaceProportional("gr_circuit_recipe", "gr_materials_gold_wire", "gold-wire", 1)
  --rm.ReplaceProportional("gr_plasma_cube_recipe", "fi_materials_gold", "gold-plate", 1)

  --this conserves acid instead of gold
  if parts.bz.gold then
    rm.AddIngredient("fi_pure_gold", "gold-ore", 2)
  else
    rm.AddIngredient("fi_pure_gold", "gold-ore", 6)
  end

  --data.raw.recipe["fi_cast_gold_recipe"].results = {{type="item", name="gold-plate", amount=1}}
  --data.raw.recipe["fi_cast_gold_recipe"].main_product = "gold-plate"
  --data.raw.recipe["gr_gold_wire_recipe"] = nil
  tf.removeRecipeUnlock("gr_circuit_tech", "gr_gold_wire")

  --nukeItem("fi_materials_gold")
  --nukeItem("gr_materials_gold_wire")

  --data.raw.recipe["kr-vc-fi_materials_gold"] = nil
  --data.raw.recipe["kr-vc-gr_materials_gold_wire"] = nil

  if mods["space-exploration"] then
    data.raw.recipe["fu_gold_ingot"].results = {{type="item", name="fu_slag", amount=1}, {type="item", name="gold-ingot", amount=1}}
    data.raw.recipe["fu_gold_ingot"].main_product = "gold-ingot"
    rm.AddIngredient("fu_gold_ingot", "fi_arc_gold", 825)
    --data.raw.recipe["fu_gold_plate_recipe"] = nil
    tf.removeRecipeUnlock("fu_gold_ingot_tech", "fu_gold_plate")
    --nukeItem("fu_materials_gold_ingot")
  else
    if parts.bz.gold then
      --I want that tech obliterated
      --data.raw.technology["fu_gold_ingot_tech"] = nil
      --data.raw.recipe["fu_gold_ingot_recipe"] = nil
      --data.raw.recipe["fu_gold_plate_recipe"] = nil
      --nukeItem("fu_materials_gold_ingot")
    else
      --data.raw.recipe["fu_gold_plate_recipe"].results = {{type="item", name="gold-plate", amount=2}}
      --data.raw.recipe["fu_gold_plate_recipe"].main_product = "gold-plate"
    end
  end

  --fission era
  rm.RemoveIngredient("electric-engine-unit", "fi_gold", 99999)
  if not (mods["BrassTacks-Updated"] or mods["IfNickel-Updated"]) then
    rm.ReplaceProportional("fi_crusher", "engine-unit", "electric-engine-unit", 0.67)
    rm.ReplaceProportional("fi_fiberer", "engine-unit", "electric-engine-unit", 0.67)
    rm.ReplaceProportional("fi_compound_machine", "engine-unit", "electric-engine-unit", 0.67)
    tf.removePrereq("electric-engine", "fi_caster_tech")
    tf.addPrereq("fi_crusher_tech", "electric-engine")
  end

  rm.AddIngredient("fi_fiberer", "hv-power-regulator", 1)
  rm.AddIngredient("fi_compound_machine", "hv-power-regulator", 1)
  rm.AddIngredient("fi_crusher", "hv-power-regulator", 1)
  rm.AddIngredient("fi_refinery", "hv-power-regulator", 1)
  rm.AddIngredient("fi_robo_charger", "hv-power-regulator", 5)
  rm.AddIngredient("fi_ki_circuit", "hv-power-regulator", 1)
  rm.AddIngredient("fi_ki_beacon", "hv-power-regulator", 1)
  rm.AddIngredient("fi_ki_core", "hv-power-regulator", 10)

  --fusion era
  rm.AddIngredient("fu_activator", "hv-power-regulator", 10)
  rm.AddIngredient("fu_fusor", "hv-power-regulator", 10)
  rm.AddIngredient("fu_lab", "hv-power-regulator", 10)
  rm.AddIngredient("fu_magnet", "hv-power-regulator", 10)

  rm.AddIngredient("fu_tech_sign", "integrated-circuit", 1)
end
