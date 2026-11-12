local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")
local cu = require("category-utils")

local gasket = "rubber"
local gasket_cost = 2
if parts.bz.carbon and not mods["BrassTacks-Updated"] then
  gasket = "gasket"
  gasket_cost = 1
end

local airseal = nil
local airseal_cost = 1
if not mods["IfNickel-Updated"] then
  if mods["BrassTacks-Updated"] then
    airseal = "airtight-seal"
  else
    airseal = gasket
    airseal_cost = gasket_cost
  end
end

if mods["space-exploration"] then
  rm.AddIngredient("se-space-transport-belt", "drive-belt", 2)

  rm.AddIngredient("se-delivery-cannon-chest", "rubber", 30)

  if parts.waste then
    rm.AddProductRaw("se-vulcanite-ion-exchange-beads", {type="fluid", name=parts.acidwaste, amount=5})
    rm.AddProductRaw("se-cryonite-ion-exchange-beads", {type="fluid", name=parts.acidwaste, amount=5})
    rm.AddProductRaw("se-observation-frame-blank", {type="fluid", name=parts.acidwaste, amount=10})
    rm.AddProductRaw("se-observation-frame-blank-beryllium", {type="fluid", name=parts.acidwaste, amount=10})

    rm.AddProductRaw("se-bio-sludge", {type="fluid", name="chemical-waste", amount=10})
    rm.AddProductRaw("se-bio-sludge-from-biomass", {type="fluid", name="chemical-waste", amount=10})
    rm.AddProductRaw("se-bio-sludge-from-wood", {type="fluid", name="chemical-waste", amount=50})
    rm.AddProductRaw("se-bio-sludge-from-fish", {type="fluid", name="chemical-waste", amount=50})
    rm.AddProductRaw("se-bio-sludge-from-vitamelange", {type="fluid", name="chemical-waste", amount=10})
  end

  rm.RemoveIngredient("se-chemical-gel", "petroleum-gas", 10)
  rm.AddIngredient("se-chemical-gel", "toluene", 1)
  rm.multiply("se-vitalic-acid", 4, true, true, true)
  rm.AddIngredient("se-vitalic-acid", "toluene", 1)

  if not (mods["Krastorio2"] or mods["ThemTharHills-Updated"]) then
    rm.ReplaceProportional("se-cryonite-ion-exchange-beads", "sulfuric-acid", "nitric-acid", 1)
  end

  if not mods["ThemTharHills-Updated"] then
    rm.ReplaceIngredient("se-observation-frame-blank", "light-oil", mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", 10)
    rm.ReplaceIngredient("se-observation-frame-blank-beryllium", "light-oil", mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", 10)
  end

  if airseal then
    rm.AddIngredient("se-fuel-refinery", airseal, 10)
    rm.AddIngredient("se-lifesupport-facility", airseal, 20)
    rm.AddIngredient("se-space-growth-facility", airseal, 50)
    rm.AddIngredient("se-space-decontamination-facility", airseal, 50)
    rm.AddIngredient("se-space-genetics-laboratory", airseal, 50)
    rm.AddIngredient("se-space-biochemical-laboratory", airseal, 50)

    rm.AddIngredient("se-electric-boiler", airseal, 5*airseal_cost)

    rm.AddIngredient("se-space-radiator", airseal, 5)
    rm.AddIngredient("se-space-hypercooler", airseal, 10)
    rm.AddIngredient("se-condenser-turbine", airseal, 20)

    rm.AddIngredient("se-lattice-pressure-vessel", airseal, 5*airseal_cost)
    rm.AddIngredient("se-bioscrubber", airseal, 2*airseal_cost)

    rm.AddIngredient("se-pressure-containment-data", airseal, 2*airseal_cost)
  end

  rm.AddIngredient("se-tensile-strength-data", "drive-belt", 1)
  rm.AddIngredient("se-compressive-strength-data", "rubber", 1)

  if not mods["BrassTacks-Updated"] then
    if not mods["IfNickel-Updated"] then
      rm.AddIngredient("se-canister", gasket, 1)
    end
    rm.AddIngredient("se-space-pipe", gasket, 1)
    rm.AddIngredient("se-nutrient-vat", gasket, 1)
  end
end
