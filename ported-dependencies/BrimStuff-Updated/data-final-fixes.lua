local rm = require("recipe-modify")
local cu = require("category-utils")
local tf = require("techfuncs")
local parts = require("variable-parts")


local allowed_recipes = {
  mods["Krastorio2"] and "kr-nitric-acid" or nil,
  "nitric-acid-early",
  "gunpowder",
  "potassium-nitrate",
  "fertilizer-slurry",
  "tnt",
  "toluene-wood",
  "toluene-coal",

  "rubber",
  "drive-belt",
  "gasket",
  "synthetic-rubber",
  "plastic-with-toluene",

  "advanced-waste-treatment",
  "depleted-acid-treatment",
  "brimstuff-wood-growth",

  "cryo-waste-compression", --more water reclaimed for waterless planets and the nodules are valuable for pyroflux
  "pyro-waste-treatment",
  "pyro-nodule-melting", --normal pyroflux recipe also accepts productivity

  "waste-treatment-water-recovery",
  "astral-waste-treatment",
  "brimstuff-oxygen"
}

--wait until plastic-with-toluene is defined to add recipes to prodmods.

tf.removeRecipeUnlock("kr-fluid-excess-handling", "kr-burn-chemical-waste")
tf.removeRecipeUnlock("kr-fluid-excess-handling", "kr-burn-depleted-acid")

table.insert(data.raw["assembling-machine"]["chemical-plant"]["crafting_categories"], "basic-chemistry")

if parts.waste then
  data.raw["assembling-machine"]["chemical-plant"].energy_source.emissions_per_minute = {pollution = 3}
  data.raw["assembling-machine"]["basic-chemical-plant"].energy_source.emissions_per_minute = {pollution = 4}
end

if mods["space-exploration"] then
  table.insert(data.raw["assembling-machine"]["se-space-biochemical-laboratory"]["crafting_categories"], "basic-chemistry")
end

if mods["Krastorio2"] then
  rm.ReplaceIngredient("chemical-science-pack", "kr-glass", "explosives", 10)
  table.insert(data.raw["assembling-machine"]["kr-advanced-chemical-plant"]["crafting_categories"], "basic-chemistry")
end

if data.raw.recipe.salt then
  -- 2.1 port: remove with table.remove (iterating backwards) so the list keeps no holes;
  -- a list with a hole is rejected by the game as soon as another mod appends to it
  for k = #data.raw["assembling-machine"]["assembling-machine-1"]["crafting_categories"], 1, -1 do
    local v = data.raw["assembling-machine"]["assembling-machine-1"]["crafting_categories"][k]
    if v == "crafting-with-fluid" then
      table.remove(data.raw["assembling-machine"]["assembling-machine-1"]["crafting_categories"], k)
    end
  end
  if data.raw["assembling-machine"]["burner-assembling-machine"] then
    -- 2.1 port: remove with table.remove (iterating backwards) so the list keeps no holes;
    -- a list with a hole is rejected by the game as soon as another mod appends to it
    for k = #data.raw["assembling-machine"]["burner-assembling-machine"]["crafting_categories"], 1, -1 do
      local v = data.raw["assembling-machine"]["burner-assembling-machine"]["crafting_categories"][k]
      if v == "crafting-with-fluid" then
        table.remove(data.raw["assembling-machine"]["burner-assembling-machine"]["crafting_categories"], k)
      end
    end
  end
  rm.SetCategory("salt", "basic-chemistry")
  tf.removeRecipeUnlock("automation", "salt")
  tf.addRecipeUnlock("basic-chemistry", "salt")
end

rm.SetCategory("formaldehyde", "basic-chemistry")
rm.SetCategory("bakelite", "basic-chemistry")

if data.raw["item-subgroup"]["chemistry"] then
  cu.moveItem("basic-chemical-plant", "chemistry", "dz")
end

--TTH + K2 already adds saltpeter byproducts
if not (mods["ThemTharHills-Updated"] and mods["Krastorio2"]) then
  if mods["Krastorio2"] then
    rm.AddProductRaw("kr-sand", {type="item", name="potassium-nitrate", amount=1, independent_probability=0.15})
  end
  if mods["aai-industry"] then
    rm.AddProductRaw("sand", {type="item", name="potassium-nitrate", amount=1, independent_probability=0.05})
  end
end

if parts.waste then
  --This is not enough of a downside to make p-gas fuel worthwhile, but nothing would be
  --This has to be in DFF because for some reason space exploration removes the main_product if done in DU
  rm.AddProductRaw("solid-fuel-from-heavy-oil", {type="fluid", name="chemical-waste", amount=60})
  rm.AddProductRaw("solid-fuel-from-light-oil", {type="fluid", name="chemical-waste", amount=30})
  --normally bzgold catalyzed petrostuff is just the vanilla version and the non-catalyzed is worse
end

if data.raw.item["ptpd-catalyst"] then
  if parts.waste then
    rm.ReplaceIngredient("catalyzed-solid-fuel-from-petroleum-gas", "petroleum-gas", "chemical-waste", 15)
    rm.RemoveIngredient("catalyzed-solid-fuel-from-petroleum-gas", "petroleum-gas", 5)
  else
    rm.RemoveIngredient("catalyzed-solid-fuel-from-petroleum-gas", "petroleum-gas", 20)
  end
  rm.RemoveIngredient("catalyzed-solid-fuel-from-light-oil", "light-oil", 10)
  rm.RemoveIngredient("catalyzed-solid-fuel-from-heavy-oil", "heavy-oil", 20)
end

--I am breaking all my own rules by defining a new recipe here.
--In my defense I want to catch all the recipe changes.
local plastic2 = table.deepcopy(data.raw.recipe["plastic-bar"])
plastic2.name = "plastic-with-toluene"
plastic2.icons = {
  {
    icon = "__base__/graphics/icons/plastic-bar.png",
    icon_mipmaps = 4,
    icon_size = 64
  },
  {
    icon = "__BrimStuff-Updated__/graphics/icons/toluene.png",
    icon_size = 64,
    scale = 0.25,
    shift = {-8, -8}
  }
}
data:extend({plastic2})
rm.multiply("plastic-with-toluene", 2, true, true, true)
if rm.CheckIngredient("plastic-with-toluene", "phenol") then
  rm.ReplaceIngredient("plastic-with-toluene", "phenol", "toluene", 1)
  --I should make a non-stupid way to add to existing products other than removing a negative amount
  --phenol is arguably more annoying to produce than toluene, so replacing one unit of it is the main benefit.
  --still, this is many ingredients into a high-throughput recipe, so you should be rewarded for a good design.
  rm.RemoveProduct("plastic-with-toluene", "plastic-bar", mods["Krastorio2"] and -6 or -3)
  rm.RemoveProduct("plastic-with-toluene", "chemical-waste", -10)
else
  if mods["Krastorio2"] then
    rm.ReplaceIngredient("plastic-with-toluene", "coal", "toluene", 2)
    rm.RemoveIngredient("plastic-with-toluene", "carbon-black", 2)
    rm.RemoveProduct("plastic-with-toluene", "plastic-bar", -2)
  else
    rm.ReplaceIngredient("plastic-with-toluene", "coal", "toluene", 1)
    rm.RemoveIngredient("plastic-with-toluene", "carbon-black", 1)
    rm.RemoveProduct("plastic-with-toluene", "plastic-bar", -1)
  end
  rm.RemoveProduct("plastic-with-toluene", "chemical-waste", -10)
end


for k, v in pairs(allowed_recipes) do
  if data.raw.recipe[v] then
    data.raw.recipe[v].allow_productivity = true
  end
end

if mods["Krastorio2"] and parts.waste and settings.startup["brimstuff-krastorio-filter-hell"].value then
  rm.RemoveProduct("dirty-water-filtration-1", "water", 99999)
  rm.AddProductRaw("dirty-water-filtration-1", {type="fluid", name="chemical-waste", amount=20})
  rm.RemoveProduct("dirty-water-filtration-2", "water", 99999)
  rm.AddProductRaw("dirty-water-filtration-2", {type="fluid", name="chemical-waste", amount=20})
  rm.RemoveProduct("dirty-water-filtration-3", "water", 99999)
  rm.AddProductRaw("dirty-water-filtration-3", {type="fluid", name="chemical-waste", amount=20})
  rm.RemoveProduct("dirty-water-filtration-graphite", "water", 99999)
  rm.AddProductRaw("dirty-water-filtration-graphite", {type="fluid", name="chemical-waste", amount=20})
  rm.RemoveProduct("dirty-water-filtration-titanium", "water", 99999)
  rm.AddProductRaw("dirty-water-filtration-titanium", {type="fluid", name="chemical-waste", amount=20})
  rm.RemoveProduct("dirty-water-filtration-lead", "water", 99999)
  rm.AddProductRaw("dirty-water-filtration-lead", {type="fluid", name="chemical-waste", amount=20})
  rm.RemoveProduct("dirty-water-filtration-tungsten", "water", 99999)
  rm.AddProductRaw("dirty-water-filtration-tungsten", {type="fluid", name="chemical-waste", amount=20})
  rm.RemoveProduct("dirty-water-filtration-zircon", "water", 99999)
  rm.AddProductRaw("dirty-water-filtration-zircon", {type="fluid", name="chemical-waste", amount=20})
  rm.RemoveProduct("dirty-water-filtration-aluminum", "water", 99999)
  rm.AddProductRaw("dirty-water-filtration-aluminum", {type="fluid", name="chemical-waste", amount=20})
  rm.RemoveProduct("dirty-water-filtration-tin", "water", 99999)
  rm.AddProductRaw("dirty-water-filtration-tin", {type="fluid", name="chemical-waste", amount=20})
  rm.RemoveProduct("dirty-water-filtration-zinc", "water", 99999)
  rm.AddProductRaw("dirty-water-filtration-zinc", {type="fluid", name="chemical-waste", amount=20})
  rm.RemoveProduct("dirty-water-filtration-nickel", "water", 99999)
  rm.AddProductRaw("dirty-water-filtration-nickel", {type="fluid", name="chemical-waste", amount=20})
  rm.RemoveProduct("dirty-water-filtration-gold", "water", 99999)
  rm.AddProductRaw("dirty-water-filtration-gold", {type="fluid", name="chemical-waste", amount=20})
  rm.RemoveProduct("dirty-water-filtration-silver", "water", 99999)
  rm.AddProductRaw("dirty-water-filtration-silver", {type="fluid", name="chemical-waste", amount=20})
  rm.RemoveProduct("se-dirty-water-filtration-holmium", "water", 99999)
  rm.AddProductRaw("se-dirty-water-filtration-holmium", {type="fluid", name="chemical-waste", amount=50})
  rm.RemoveProduct("se-dirty-water-filtration-iridium", "water", 99999)
  rm.AddProductRaw("se-dirty-water-filtration-iridium", {type="fluid", name="chemical-waste", amount=50})
  rm.RemoveProduct("coal-filtration", "water", 99999)
  rm.AddProductRaw("coal-filtration", {type="fluid", name="chemical-waste", amount=40})
end

for k, v in pairs(data.raw["map-gen-presets"]["default"]) do
  if type(v) == "table" and v.basic_settings and v.basic_settings.autoplace_controls and v.basic_settings.autoplace_controls["copper-ore"] then
    v.basic_settings.autoplace_controls["sulfur-ore"] = table.deepcopy(v.basic_settings.autoplace_controls["copper-ore"])
  end
end

local ammo_recipes = {
  {"firearm-magazine", 1},
  {"firearm-magazine-iron-lead", 1},
  {"firearm-magazine-copper-lead", 1},
  {"firearm-magazine-iron-only", 1},
  {"pistol-magazine-bismuth", 1},
  {"kr-rifle-magazine", 2},
  {"rifle-magazine-iron-lead", 2},
  {"rifle-magazine-copper-lead", 2},
  {"rifle-magazine-iron", 2},
  {"rifle-magazine-bismuth", 2},
  {"kr-anti-materiel-rifle-magazine", 3} --[sic]
}

for k, v in pairs(ammo_recipes) do
  local recipename = v[1]
  local gunpowdercost = v[2]
  if data.raw.recipe[recipename] then
    if rm.CheckIngredient(recipename, "coal") then
      rm.ReplaceProportional(recipename, "coal", "gunpowder", 1)
    else
      if rm.CheckIngredient(recipename, "lead-plate") then
        rm.RemoveIngredient(recipename, "lead-plate", 1)
        rm.AddIngredient(recipename, "gunpowder", gunpowdercost)
      else if rm.CheckIngredient(recipename, "copper-plate") then
        rm.RemoveIngredient(recipename, "copper-plate", 1)
        rm.AddIngredient(recipename, "gunpowder", gunpowdercost)
      end end
      if rm.CheckIngredient(recipename, "iron-plate") then
        rm.RemoveIngredient(recipename, "iron-plate", 1)
        rm.AddIngredient(recipename, "gunpowder", gunpowdercost)
      end
    end
  end
end

rm.AddIngredient("firearm-magazine-bismuth", "gunpowder", 1)
rm.AddIngredient("shotgun-shell-bismuth", "gunpowder", 1)

--some bz mods mess with shotgun shells in DFF so this is here instead of DU

if rm.CheckIngredient("shotgun-shell", "stone") then
  rm.RemoveIngredient("shotgun-shell", "stone", 2)
else if rm.CheckIngredient("shotgun-shell", "salt") then
  rm.RemoveIngredient("shotgun-shell", "salt", 2)
else
  rm.RemoveIngredient("shotgun-shell", "iron-plate", 1)
  rm.RemoveIngredient("shotgun-shell", "lead-plate", 1)
end end
rm.RemoveIngredient("shotgun-shell", "coal", 2)
rm.AddIngredient("shotgun-shell", "gunpowder", 2)

require("deadlock")
require("compat.final")
