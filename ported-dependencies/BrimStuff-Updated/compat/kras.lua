local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")

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

if mods["advanced-chemical-plant"] and not mods["Krastorio2"] then
  if not (mods["BrassTacks-Updated"] or mods["IfNickel-Updated"]) then
    if not mods["ThemTharHills-Updated"] then
      rm.AddIngredient("kr-advanced-chemical-plant", "engine-unit", 8) --galaxy brain
    end
    rm.AddIngredient("kr-advanced-chemical-plant", gasket, 32*gasket_cost)
  end
end

if mods["AdvancedAssemblyMachineStandalone"] and not mods["Krastorio2"] then
  if rm.CheckIngredient("assembling-machine-3", "electric-engine-unit") then
    rm.AddIngredient("kr-advanced-assembling-machine", "drive-belt", 24)
  end
end

if mods["advanced-centrifuge"] then
  rm.AddIngredient("k11-advanced-centrifuge", "drive-belt", 20)
end

if mods["Krastorio2"] then
  if parts.waste then
    rm.AddProductRaw("ammonia-from-potassium-nitrate", {type="fluid", name="chemical-waste", amount=10})
    rm.AddProductRaw("kr-imersite-crystal", {type="fluid", name=parts.acidwaste, amount=20})

    if not mods["space-exploration"] then
      rm.AddProductRaw("kr-ai-core", {type="fluid", name=parts.acidwaste, amount=10})

    end
  end

  if parts.waste and mods["ThemTharHills-Updated"] then
    rm.AddProductRaw("kr-empty-antimatter-fuel-cell", {type="fluid", name=parts.acidwaste, amount=50})
    rm.AddProductRaw("kr-advanced-solar-panel", {type="fluid", name=parts.acidwaste, amount=25})
  end

  if not mods["ThemTharHills-Updated"] then
    tf.addRecipeUnlock("kr-advanced-chemistry", "ammonia-from-potassium-nitrate")
  end

  rm.ReplaceIngredient("kr-pollution-filter", "plastic-bar", "rubber", 1)

  if not mods["BrassTacks-Updated"] then
    rm.AddIngredient("kr-steel-pump", gasket, 2*gasket_cost)
    rm.AddIngredient("kr-rocket-fuel-with-ammonia", gasket, gasket_cost)
    rm.AddIngredient("kr-rocket-fuel-with-hydrogen-chloride", gasket, gasket_cost)
  end

  if not mods["IfNickel-Updated"] then
    rm.AddIngredient("kr-electrolysis-plant", airseal, 5*airseal_cost)
    rm.AddIngredient("kr-filtration-plant", airseal, 5*airseal_cost)
    rm.AddIngredient("kr-atmospheric-condenser", airseal, 5*airseal_cost)
    rm.AddIngredient("kr-fuel-refinery", airseal, 5*airseal_cost)
    tf.addPrereq("kr-fluids-chemistry", "rubber")
  end

  rm.AddIngredient("kr-fuel-from-light-oil", "toluene", 1)
  rm.RemoveIngredient("kr-fuel-from-light-oil", "light-oil", 10)
end

if mods["FluidMustFlow"] then
  rm.AddIngredient("duct-t-junction", gasket, 3*gasket_cost)
  rm.AddIngredient("duct-curve", gasket, 2*gasket_cost)
  rm.AddIngredient("duct-cross", gasket, 4*gasket_cost)
  rm.AddIngredient("duct-underground", gasket, 2*gasket_cost)
  if not mods["IfNickel-Updated"] then
    rm.AddIngredient("non-return-duct", gasket, 2*gasket_cost)
    if not mods["BrassTacks-Updated"] then
      rm.AddIngredient("duct-end-point-intake", gasket, 6*gasket_cost)
      rm.AddIngredient("duct-end-point-outtake", gasket, 6*gasket_cost)
    end
  end
end
