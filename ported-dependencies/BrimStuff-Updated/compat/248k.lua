local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")
local cu = require("category-utils")

local gasket_item = "rubber"
local gasket_ratio = 2
if mods["BrassTacks-Updated"] then
  gasket_item = "airtight-seal"
  gasket_ratio = 1
else if parts.bz.carbon then
  gasket_item = "gasket"
  gasket_ratio = 1
end end

if mods["248k-Redux"] then
  if not mods["IfNickel-Updated"] then
    rm.AddIngredient("fu_burner", gasket_item, 5 * gasket_ratio)
    rm.ReplaceProportional("el_grower", "iron-gear-wheel", gasket_item, gasket_ratio)
    rm.AddIngredient("el_burner_kerosene", gasket_item, 5 * gasket_ratio)
    rm.AddIngredient("el_pressurizer", gasket_item, 10 * gasket_ratio)
    rm.AddIngredient("fi_refinery", gasket_item, 20 * gasket_ratio)
    rm.AddIngredient("fu_turbine", gasket_item, 20 * gasket_ratio)
    rm.AddIngredient("fu_boiler", gasket_item, 20 * gasket_ratio)
    rm.AddIngredient("fu_exchanger", gasket_item, 20 * gasket_ratio)
  end
end
