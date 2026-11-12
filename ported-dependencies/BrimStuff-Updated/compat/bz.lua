local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")
local cu = require("category-utils")

if parts.waste then
  if parts.bz.carbon then
    rm.AddProductRaw("graphene", {type="fluid", name=parts.acidwaste, amount=5})
  end

  if parts.bz.chlorine then
    rm.AddProductRaw("hydrogen-chloride-salt", {type="fluid", name="chemical-waste", amount=10})
    if mods["ThemTharHills-Updated"] then
      rm.AddProductRaw("ferric-chloride-hcl", {type="fluid", name="depleted-acid", amount=15})
    else
      rm.AddProductRaw("ferric-chloride-hcl", {type="fluid", name="chemical-waste", amount=40})
    end
  end

  if false then
    rm.AddProductRaw("advanced-waste-treatment", {type="fluid", name="gas", amount=1})
    rm.AddProductRaw("pyro-waste-treatment", {type="fluid", name="gas", amount=2})
  end
end

if parts.bz.carbon then
  rm.AddIngredient("nanotubes", "toluene", 1)
  if not mods["Krastorio2"] then
    rm.multiply("fullerenes", 2, true, true, true)
  end
  rm.AddIngredient("fullerenes", "toluene", 1)
end
