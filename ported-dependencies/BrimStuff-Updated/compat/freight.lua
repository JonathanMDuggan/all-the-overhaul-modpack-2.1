local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")

if mods["cargo-ships"] then
  rm.ReplaceProportional("buoy", "iron-plate", "rubber", 1)
  rm.ReplaceProportional("chain_buoy", "iron-plate", "rubber", 1)
  rm.ReplaceProportional("floating-electric-pole", "iron-plate", "rubber", 1)

  rm.ReplaceProportional("buoy", "aluminum-plate", "rubber", 1)
  rm.ReplaceProportional("chain_buoy", "aluminum-plate", "rubber", 1)
  rm.ReplaceProportional("floating-electric-pole", "aluminum-plate", "rubber", 1)
end

if mods["IntermodalContainers"] then
  rm.AddIngredient("ic-containerization-machine-2", "drive-belt", 5)
end

if mods["FreightForwarding"] then
  if parts.waste then
    rm.AddProductRaw("ff-slag-leaching", {type="fluid", name=parts.acidwaste, amount=10})
  end
  rm.ReplaceIngredient("piercing-rounds-magazine", "lead-plate", "gunpowder", 1)
end
