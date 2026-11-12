local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")
local cu = require("category-utils")

if mods["RenaiTransportation"] then
  tf.addPrereq("se-no", "rubber")

  --yes, these are the correct names
  rm.AddIngredient("BouncePlateRecipie", "rubber", 2)
  rm.AddIngredient("DirectedBouncePlateRecipie", "rubber", 2)
  rm.AddIngredient("PlayerLauncherRecipie", "rubber", 5)

  rm.AddIngredient("HatchRTRecipe", "rubber", 3)
  rm.AddIngredient("OpenContainerRecipie", "rubber", 3)

  rm.AddIngredient("RTTrainBouncePlateRecipie", "rubber", 25)
  rm.AddIngredient("RTTrainDirectedBouncePlateRecipie", "rubber", 25)

end
