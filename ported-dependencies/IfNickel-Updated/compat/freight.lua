local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")

if mods["cargo-ships"] then
  rm.AddIngredient("oil_tanker", "invar-valve", 10)

  if parts.experimental then
    rm.ReplaceProportional("oil_rig", "electronic-circuit", "flow-controller", 1/3)
    rm.AddIngredient("bridge_base", "motorized-articulator", 10)
  else
    rm.ReplaceProportional("oil_rig", "pipe", "invar-valve", 1/3)
    rm.AddIngredient("bridge_base", parts.motor, 30)
  end

  --orc code
  if rm.CheckIngredient("oil_rig", "kr-steel-beam") then
    rm.RemoveIngredient("oil_rig", "kr-steel-beam", 30)
    rm.AddIngredient("oil_rig", "kr-steel-beam", 30)
  end
end

if mods["ch-concentrated-solar"] then
  if parts.experimental then
    rm.ReplaceProportional("chcs-heliostat-mirror", "electronic-circuit", "motorized-articulator", 0.4)
    rm.ReplaceProportional("chcs-solar-laser-tower", "iron-gear-wheel", "motorized-articulator", 0.5)
  else
    rm.AddIngredient("chcs-solar-laser-tower", parts.motor, 10)
  end
end

if mods["FreightForwarding"] then
  --rm.AddProductRaw("ff-slag-leaching", {type="item", name="nickel-ore", amount=1, probability=0.25})

  tf.addRecipeUnlock("ff-dredging", "meteoric-nodule-dredging")
  tf.addRecipeUnlock("ff-dredging", "meteoric-nodule-washing")
end
