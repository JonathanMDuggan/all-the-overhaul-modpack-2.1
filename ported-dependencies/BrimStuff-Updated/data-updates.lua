local rm = require("recipe-modify")
local parts = require("variable-parts")
local tf = require("techfuncs")

if parts.waste then
  rm.AddProductRaw("sulfur", {type="fluid", name="chemical-waste", amount=mods["Krastorio2"] and 30 or 15})

  local plastic_toxic = 15
  if rm.CheckIngredient("plastic-bar", "phenol") then
    plastic_toxic = plastic_toxic + 15
  end
  if rm.CheckIngredient("plastic-bar", "vinyl-chloride") then
    plastic_toxic = plastic_toxic + 15
  end
  rm.AddProductRaw("plastic-bar", {type="fluid", name="chemical-waste", amount=plastic_toxic})
  if mods["ThemTharHills-Updated"] then
    if not rm.CheckIngredient("integrated-circuit", "silicon-wafer") then
      rm.AddProductRaw("integrated-circuit", {type="fluid", name="depleted-acid", amount=1})
      if data.raw.recipe["integrated-circuit-silver"] then
        rm.AddProductRaw("integrated-circuit-silver", {type="fluid", name="depleted-acid", amount=1})
      end
    end
    rm.AddProductRaw("gold-powder", {type="fluid", name="depleted-acid", amount=mods["Krastorio2"] and 20 or 10})
    if parts.bz.gold then
      rm.AddProductRaw("cpu", {type="fluid", name="depleted-acid", amount=50})
    else
      rm.AddProductRaw("processing-unit", {type="fluid", name="depleted-acid", amount=mods["Krastorio2"] and 10 or 5})
    end
    rm.AddProductRaw("silicon-wafer", {type="fluid", name="depleted-acid", amount=20})
    rm.AddProductRaw("trace-gold-from-copper", {type="fluid", name="depleted-acid", amount=30})
  else
    if parts.bz.gold then
      rm.AddProductRaw("cpu", {type="fluid", name="chemical-waste", amount=50})
    else
      rm.AddProductRaw("processing-unit", {type="fluid", name="chemical-waste", amount=mods["Krastorio2"] and 10 or 5})
    end
    rm.AddProductRaw("silicon-wafer", {type="fluid", name="chemical-waste", amount=20})
  end

  if parts.bz.gas then
    rm.AddProductRaw("bakelite", {type="fluid", name="chemical-waste", amount=10})
    rm.AddProductRaw("bakelite-hcl", {type="fluid", name="chemical-waste", amount=15})
    rm.AddProductRaw("phenol-from-oil", {type="fluid", name="chemical-waste", amount=10})
  end

  if parts.bz.bzcarbon then
    rm.AddProductRaw("polyacrylonitrile", {type="fluid", name="chemical-waste", amount=5})
    rm.AddProductRaw("fullerenes", {type="fluid", name="chemical-waste", amount=20})
    rm.AddProductRaw("nanotubes", {type="fluid", name=parts.acidwaste, amount=1})
    rm.RemoveProduct("nanotubes", "kr-dirty-water", 99999)
    rm.AddProductRaw("carbon-black", {type="fluid", name="chemical-waste", amount=mods["Krastorio2"] and 10 or 5})
    rm.AddProductRaw("graphite-carbon-black", {type="fluid", name="chemical-waste", amount=mods["Krastorio2"] and 30 or 15})
  end
end
rm.RemoveProduct("sulfur", "sulfur", 1)
tf.removeRecipeUnlock("sulfur-processing", "sulfur")
tf.addRecipeUnlock("advanced-oil-processing", "sulfur")

if rm.CheckIngredient("chemical-plant", "stone-brick") then
  rm.AddIngredient("basic-chemical-plant", "stone-brick", 5)
  rm.RemoveIngredient("chemical-plant", "stone-brick", 99999)
  rm.RemoveIngredient("oil-refinery", "stone-brick", 99999)
end
if data.raw.item["silver-plate"] then
  --silver plate already in burner chemical plant.
  rm.RemoveIngredient("chemical-plant", "silver-plate", 5)
  tf.addPrereq("basic-chemistry", "silver-processing")
end
rm.ReplaceProportional("chemical-plant", "pipe", "basic-chemical-plant", 1/5)
rm.ReplaceProportional("oil-refinery", "pipe", "basic-chemical-plant", 1/5)

tf.removePrereq("sulfur-processing", "oil-processing")
--rocketry no longer needs oil but flammables depending on oil makes flavor-sense
if mods["Krastorio2"] then
  tf.addPrereq("sulfur-processing", "logistic-science-pack")
  tf.addPrereq("sulfur-processing", "kr-fluids-chemistry")
else
  tf.addPrereq("sulfur-processing", "electric-chemical-plant")
  if parts.bz.chlorine then
    tf.removePrereq("chlorine-processing", "fluid-handling")
    tf.addPrereq("chlorine-processing", "electric-chemical-plant")
  end
end

if parts.coke_tol then
  if mods["Krastorio2"] then
    rm.AddProductRaw("coke", {type="item", name="toluene", amount=1, independent_probability=0.6})
    rm.AddProductRaw("phenol", {type="item", name="toluene", amount=1, independent_probability=0.6})
  else
    rm.AddProductRaw("coke", {type="item", name="toluene", amount=1, independent_probability=0.1})
    rm.AddProductRaw("phenol", {type="item", name="toluene", amount=1, independent_probability=0.2})
  end
  if data.raw.recipe["solid-fuel-from-coal"] then
    rm.AddProductRaw("solid-fuel-from-coal", {type="item", name="toluene", amount=1, independent_probability=0.2})
    rm.AddProductRaw("woodcoke", {type="item", name="toluene", amount=1, independent_probability=0.2})
  else
    rm.AddProductRaw("woodcoke", {type="item", name="toluene", amount=1, independent_probability=0.1})
  end
end

if parts.coke_tol or parts.oil_tol then
  rm.AddProductRaw("phenol-from-oil", {type="item", name="toluene", amount=1, independent_probability=0.2})
end

local boom_factor = 1
if rm.CheckIngredient("explosives", "zirconium-plate") then
  boom_factor = 2
end
tf.addPrereq("explosives", "toluene-production")
if rm.CheckIngredient("explosives", "formaldehyde") then
  rm.ReplaceProportional("explosives", "sulfur", "tnt", 1)
  rm.ReplaceProportional("explosives", "coal", "gunpowder", 1)
  if parts.waste then
    rm.AddProductRaw("explosives", {type="fluid", name="chemical-waste", amount=20*boom_factor})
  end
  tf.addRecipeUnlock("explosives", "tnt")
else
  data.raw.item["explosives"].localised_name = {"item-name.tnt"}
  rm.RemoveIngredient("explosives", "water", 99999)
  rm.RemoveIngredient("explosives", "sulfur", 99999)
  rm.AddIngredient("explosives", "sulfuric-acid", 10*boom_factor)
  rm.AddIngredient("explosives", mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", 10*boom_factor)
  rm.ReplaceProportional("explosives", "coal", "toluene", 1)
  if parts.waste then
    rm.AddProductRaw("explosives", {type="fluid", name="chemical-waste", amount=30*boom_factor})
  end
end

--"rubber cement is not cement! you idiot!"
--you know what else isn't cement? wet bricks
tf.addPrereq("concrete", "toluene-production")
rm.ReplaceIngredient("concrete", "iron-ore", "toluene", 1)
rm.RemoveIngredient("concrete", "iron-stick", 99999)

tf.addPrereq(mods["Krastorio2"] and "kr-fuel" or "flammables", "toluene-production")
tf.removeRecipeUnlock("oil-processing", "solid-fuel-from-petroleum-gas")
tf.addRecipeUnlock("flammables", "solid-fuel-from-petroleum-gas") --this should just be vanilla tbh. why does the flammables tech exist.

rm.multiply("solid-fuel-from-petroleum-gas", 6, true, true, true)
rm.RemoveIngredient("solid-fuel-from-petroleum-gas", "petroleum-gas", 20)
rm.AddIngredient("solid-fuel-from-petroleum-gas", "toluene", 1)

rm.multiply("solid-fuel-from-light-oil", 6, true, true, true)
rm.RemoveIngredient("solid-fuel-from-light-oil", "light-oil", 10)
rm.AddIngredient("solid-fuel-from-light-oil", "toluene", 1)

rm.multiply("solid-fuel-from-heavy-oil", 6, true, true, true)
rm.RemoveIngredient("solid-fuel-from-heavy-oil", "heavy-oil", 20)
rm.AddIngredient("solid-fuel-from-heavy-oil", "toluene", 1)

rm.ReplaceIngredient("grenade", "coal", "gunpowder", 10)

rm.AddProductRaw("basic-oil-processing", {type="item", name="sulfur", amount=1, independent_probability=0.5})
rm.AddProductRaw("advanced-oil-processing", {type="item", name="sulfur", amount=1, independent_probability=0.5})
if mods["aai-industry"] then
  rm.AddProductRaw("oil-processing-heavy", {type="item", name="sulfur", amount=1, independent_probability=0.5})
end

if parts.oil_tol then
  rm.AddProductRaw("basic-oil-processing", {type="item", name="toluene", amount=1, independent_probability=0.15})
  rm.AddProductRaw("advanced-oil-processing", {type="item", name="toluene", amount=1, independent_probability=0.15})
  if mods["aai-industry"] then
    rm.AddProductRaw("oil-processing-heavy", {type="item", name="toluene", amount=1, independent_probability=0.15})
  end
  rm.AddProductRaw("heavy-oil-cracking", {type="item", name="toluene", amount=1, independent_probability=0.1})
  rm.AddProductRaw("light-oil-cracking", {type="item", name="toluene", amount=1, independent_probability=0.1})
end

if not rm.CheckIngredient("assembling-machine-2", "gearbox") then
  rm.RemoveIngredient("assembling-machine-2", "iron-gear-wheel", 99999)
  rm.RemoveIngredient("assembling-machine-2", "bakelite", 99999)
  rm.AddIngredient("assembling-machine-2", "drive-belt", 3)
end

if not rm.CheckIngredient("assembling-machine-3", "electric-engine-unit") then
  rm.AddIngredient("assembling-machine-3", "drive-belt", 5)
end

if data.raw.item["machining-tool"] then
  rm.ReplaceIngredient("machining-tool", "tungsten-carbide", "drive-belt", 1)
  --tool costs either 2 TC or 1 steel so only the tungsten tool has room to cheapen.
  --bz makes steel less of an iron bottleneck so i could theoretically have it dynamically react but ehh
  --bz also makes steel an annoying hassle
end

tf.addRecipeUnlock("sulfur-processing", mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid")

tf.addPrereq("electric-energy-distribution-1", "rubber")
rm.AddIngredient("medium-electric-pole", "rubber", 1)
rm.AddIngredient("big-electric-pole", "rubber", 2)

tf.addPrereq("engine", "rubber")
if mods["aai-industry"] then
  rm.ReplaceProportional("engine-unit", "iron-gear-wheel", "drive-belt", 1/2)
else
  rm.ReplaceIngredient("engine-unit", "iron-gear-wheel", "drive-belt", 1)
end

if mods["ThemTharHills-Updated"] then
  tf.addPrereq("high-voltage-equipment", "rubber")
  rm.ReplaceProportional("advanced-cable", "plastic-bar", "rubber", 1)
  tf.removeRecipeUnlock("gold-processing", "nitric-acid-early")
  tf.removeRecipeUnlock("gold-processing", mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid")
else
  rm.AddIngredient("substation", "rubber", 10)
end

if not mods["Krastorio2"] then
  tf.removeRecipeUnlock("oil-processing", "chemical-plant")
  tf.removeRecipeUnlock(mods["aai-industry"] and "basic-fluid-handling" or "fluid-handling", "chemical-plant") --bzchlorine
  tf.addPrereq("oil-processing", "electric-chemical-plant")
end

--nickel means valves in chemical plants and such
local gasket_item = "rubber"
local gasket_ratio = 2
if mods["BrassTacks-Updated"] then
  gasket_item = "airtight-seal"
  gasket_ratio = 1
else if parts.bz.carbon then
  gasket_item = "gasket"
  gasket_ratio = 1
  tf.addRecipeUnlock("rubber", "gasket")
end end

if not mods["BrassTacks-Updated"] then
  --airtight seal item does not exist, add gaskets or rubber as relevant
  rm.ReplaceIngredient("pump", "graphite", gasket_item, 2)
  rm.RemoveIngredient("flamethrower-ammo", "steel-plate", 1)
  rm.AddIngredient("flamethrower-ammo", gasket_item, gasket_ratio)
  if not mods["LunarLandings"] then
    rm.AddIngredient("rocket-fuel", gasket_item, gasket_ratio)
  end
end

if mods["IfNickel-Updated"] then
  tf.addPrereq("valves", "rubber")
  if not mods["BrassTacks-Updated"] then
    if parts.bz.carbon then
      rm.ReplaceProportional("invar-valve", "graphite", gasket_item, gasket_ratio/2)
    else
      rm.ReplaceProportional("invar-valve", "copper-plate", gasket_item, gasket_ratio/2)
    end
  end
else
  tf.addPrereq("engine", "rubber")

  --in this situation invar valves have not replaced gears in chem plants. airtight-seals are a bit more expensive than gears, gaskets and rubber less so.
  --even in the latter cases gears are added to the process via burner chem plants so I can retain my reputation as Annoying Person Who Makes Machines Too Expensive
  rm.ReplaceIngredient("chemical-plant", "iron-gear-wheel", gasket_item, gasket_ratio * 5)
  rm.ReplaceIngredient("oil-refinery", "iron-gear-wheel", gasket_item, gasket_ratio * 10)

  rm.AddIngredient("fluid-wagon", gasket_item, gasket_ratio*3)
  rm.AddIngredient("steam-turbine", gasket_item, gasket_ratio*10)
  rm.AddIngredient("heat-exchanger", gasket_item, gasket_ratio*10)
end

tf.removePrereq("chemical-science-pack", "sulfur-processing")
tf.addPrereq("chemical-science-pack", "explosives")

if mods["MoreScience"] then
  tf.addPrereq("purification-research", "basic-chemistry")
  tf.removeRecipeUnlock("purification-research", "chemical-plant")
  rm.SetCategory("purified-water", "basic-chemistry")
  rm.SetCategory("automation-science-fluid", "basic-chemistry")
  rm.SetCategory("logistic-science-fluid", "basic-chemistry")
  rm.RemoveIngredient("logistic-science-fluid", "purified-water", 99999)
  rm.SetCategory("military-science-fluid", "basic-chemistry")
  rm.RemoveIngredient("military-science-fluid", "purified-water", 99999)
  tf.removePrereq("sulfur-processing", "sulfur")

  if mods["Krastorio2"] then
    tf.addPrereq("electric-power-science-pack", "kr-fluids-chemistry")
    tf.addPrereq("advanced-automation-science-pack", "kr-fluids-chemistry")
  else
    tf.addPrereq("electric-power-science-pack", "electric-chemical-plant")
    tf.addPrereq("advanced-automation-science-pack", "electric-chemical-plant")
  end

  tf.addSciencePack("chemical-waste-disposal", "advanced-automation-science-pack")
  tf.addSciencePack("byproduct-disposal", "advanced-automation-science-pack")
end

if mods["Krastorio2"] then
  rm.ReplaceIngredient("kr-fertilizer", "kr-biomass", "potassium-nitrate", 1)
  rm.ReplaceProportional("kr-biter-research-data", "coke", "gunpowder", 2)
else
  if mods["MoreScience"] then
    rm.ReplaceProportional("chemical-science-fluid", "sulfur", "explosives", 2)
  else
    rm.ReplaceProportional("chemical-science-pack", "sulfur", "explosives", 2)
  end
end

tf.addPrereq("logistics-2", "rubber")
rm.AddIngredient("fast-transport-belt", "rubber", 1)
rm.AddIngredient("fast-splitter", "rubber", 2)
rm.AddIngredient("car", "rubber", 10)

rm.AddIngredient("express-transport-belt", "drive-belt", 1)
rm.AddIngredient("express-splitter", "drive-belt", 2)

if not mods["Krastorio2"] then
  rm.AddIngredient("fast-underground-belt", "rubber", 8)
  rm.AddIngredient("express-underground-belt", "drive-belt", 8)
end

if not mods["Krastorio2"] and not mods["ThemTharHills-Updated"] then
  rm.ReplaceIngredient("rocket-fuel", "light-oil", "nitric-acid", 10)
end

if mods["BrassTacks-Updated"] and not mods["IfNickel-Updated"] then
  tf.removeRecipeUnlock(mods["aai-industry"] and "basic-fluid-handling" or "fluid-handling", "airtight-seal")
  tf.addRecipeUnlock("rubber", "airtight-seal")
  tf.addPrereq("fluid-handling", "rubber")
end

if mods["LunarLandings"] then
  rm.AddIngredient("ll-lunar-foundation", "toluene", 1)
  rm.AddIngredient("ll-astrocrystal-processing", "toluene", 1)

  --if not mods["ThemTharHills-Updated"] then
    --rm.AddIngredient("ll-rich-moon-rock-processing", "nitric-acid", 25, 25)
  --end

  if parts.green then
    tf.addRecipeUnlock("ll-luna-automation", "brimstuff-oxygen")
  end

  if parts.waste then
    rm.AddProductRaw("ll-red-mud-recovery", {type="fluid", name="chemical-waste", amount=25})
    --rm.AddProductRaw("ll-rich-moon-rock-processing", {type="fluid", name=parts.acidwaste, amount=25, fluidbox_index=1})

    tf.addRecipeUnlock("ll-steam-condenser", "waste-treatment-water-recovery")
    tf.addRecipeUnlock("ll-quantum-resource-processing", "astral-waste-treatment")

    if mods["ThemTharHills-Updated"] then
      rm.RemoveProduct("astral-waste-treatment", "petroleum-gas", 25)
      rm.AddProductRaw("astral-waste-treatment", {type="fluid", name="depleted-acid", amount=50})
    end

    data.raw["assembling-machine"]["ll-low-grav-assembling-machine"].fluid_boxes[4].production_type = "output"
    data.raw["assembling-machine"]["ll-low-grav-assembling-machine"].fluid_boxes[4].pipe_connections[1].flow_direction = "output"
  end
end

require("compat.aai")
require("compat.kras")
require("compat.bz")
require("compat.renai")
require("compat.freight")
require("compat.bio")

if not mods["Krastorio2"] then
  data.raw.item["nitric-acid-barrel"].ib_badge = "NA"
  data.raw.recipe["nitric-acid-barrel"].ib_badge = "NA"
  data.raw.recipe["nitric-acid-barrel"].ib_corner = "left-bottom"
  data.raw.recipe["empty-nitric-acid-barrel"].ib_badge = "NA"
  data.raw.recipe["empty-nitric-acid-barrel"].ib_corner = "left-bottom"
end
if parts.green then
  data.raw.item["fertilizer-slurry-barrel"].ib_badge = "FS"
  data.raw.recipe["fertilizer-slurry-barrel"].ib_badge = "FS"
  data.raw.recipe["fertilizer-slurry-barrel"].ib_corner = "left-bottom"
  data.raw.recipe["empty-fertilizer-slurry-barrel"].ib_badge = "FS"
  data.raw.recipe["empty-fertilizer-slurry-barrel"].ib_corner = "left-bottom"
end
if parts.waste then
  data.raw.item["chemical-waste-barrel"].ib_badge = "CW"
  data.raw.recipe["chemical-waste-barrel"].ib_badge = "CW"
  data.raw.recipe["chemical-waste-barrel"].ib_corner = "left-bottom"
  data.raw.recipe["empty-chemical-waste-barrel"].ib_badge = "CW"
  data.raw.recipe["empty-chemical-waste-barrel"].ib_corner = "left-bottom"
  if mods["ThemTharHills-Updated"] then
    data.raw.item["depleted-acid-barrel"].ib_badge = "DA"
    data.raw.recipe["depleted-acid-barrel"].ib_badge = "DA"
    data.raw.recipe["depleted-acid-barrel"].ib_corner = "left-bottom"
    data.raw.recipe["empty-depleted-acid-barrel"].ib_badge = "DA"
    data.raw.recipe["empty-depleted-acid-barrel"].ib_corner = "left-bottom"
  end
end
