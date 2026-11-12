local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")
local cu = require("category-utils")

if mods["Bio_Industries"] then
  tf.removeRecipeUnlock("bi-tech-bio-farming", "bi-wood-from-pulp")

  if not parts.bz.tungsten then --tech deadlock if lamps are later
    tf.addPrereq("rubber", "bi-tech-bio-farming")
    rm.ReplaceProportional("rubber", "wood", "resin", 1)
  end

  rm.ReplaceProportional("toluene-wood", "wood", "resin", 1)
  rm.SetCategory("bi-resin-wood", "basic-chemistry")
  rm.SetCategory("bi-resin-pulp", "basic-chemistry")
  rm.AddProductRaw("bi-resin-wood", {type="item", name="toluene", amount=1, independent_probability=0.01})

  if parts.coke_tol then
    rm.AddProductRaw("bi-charcoal-2", {type="item", name="toluene", amount=1, independent_probability=0.25})
    rm.AddProductRaw("bi-coal-1", {type="item", name="toluene", amount=1, independent_probability=0.05})
    rm.AddProductRaw("bi-coal-2", {type="item", name="toluene", amount=1, independent_probability=0.05})
    rm.AddProductRaw("bi-pellet-coke", {type="item", name="toluene", amount=1, independent_probability=0.05}) --made of solid fuel, solid fuel is made with toluene. no infinite toluene from this process.
    rm.AddProductRaw("bi-coke-coal", {type="item", name="toluene", amount=1, independent_probability=0.5})
  end
  rm.multiply("bi-solid-fuel", 3, true, true, true)
  rm.RemoveIngredient("bi-solid-fuel", "wood-bricks", 2)
  rm.AddIngredient("bi-solid-fuel", "toluene", 1)

  rm.multiply("bi-fertilizer-1", 2, true, true, true)
  rm.ReplaceIngredient("bi-fertilizer-1", "sulfur", "potassium-nitrate", 1)
  rm.AddIngredient("bi-adv-fertilizer-2", mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", 30)

  rm.AddIngredient("bi-biomass-conversion-1", "toluene", 3)
  rm.AddIngredient("bi-biomass-conversion-2", "toluene", 1)
  rm.AddIngredient("bi-biomass-conversion-3", "toluene", 1)
  rm.AddIngredient("bi-plastic-2", "toluene", 1)
  if parts.waste then
    rm.AddProductRaw("bi-fertilizer-1", {type="fluid", name="chemical-waste", amount=20})
    rm.AddProductRaw("bi-adv-fertilizer-2", {type="fluid", name="chemical-waste", amount=50})
    rm.AddProductRaw("bi-sulfur", {type="fluid", name=parts.acidwaste, amount=parts.acidwaste == "depleted-acid" and 2 or 10})
  end
end
