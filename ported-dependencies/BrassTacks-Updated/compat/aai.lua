local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")
local cu = require("category-utils")

local advfitting = "bolted-flange"
if parts.bz.carbon or mods["BrimStuff-Updated"] then
  advfitting = "airtight-seal"
end

if mods["aai-containers"] then
  rm.AddIngredient("aai-strongbox-passive-provider", "iron-gear-wheel", 2)
  if parts.experimental then
    rm.AddIngredient("aai-strongbox", "articulated-mechanism", 5)
    rm.AddIngredient("aai-storehouse", "articulated-mechanism", 10)
    rm.AddIngredient("aai-warehouse", "articulated-mechanism", 20)
    rm.AddIngredient("aai-warehouse-passive-provider", "complex-joint", 5)
    tf.addPrereq("aai-warehouse-storage", "mechanical-engineering-2")
    if rm.CheckIngredient("aai-strongbox", "kr-steel-beam") then
      rm.ReplaceIngredient("aai-strongbox", "kr-steel-beam", "galvanized-steel-plate", 5)
      rm.ReplaceIngredient("aai-storehouse", "kr-steel-beam", "galvanized-steel-plate", 25)
      rm.ReplaceIngredient("aai-warehouse", "kr-steel-beam", "galvanized-steel-plate", 50)
    else
      rm.ReplaceIngredient("aai-strongbox", "steel-plate", "galvanized-steel-plate", 25)
      rm.ReplaceIngredient("aai-storehouse", "steel-plate", "galvanized-steel-plate", 50)
      rm.ReplaceIngredient("aai-warehouse", "steel-plate", "galvanized-steel-plate", 100)
    end
  else
    rm.AddIngredient("aai-storehouse-passive-provider", "iron-gear-wheel", 5)
    rm.AddIngredient("aai-warehouse-passive-provider", "iron-gear-wheel", 10)
  end
end

if mods["textplates"] and not mods["galdocs-manufacturing"] then
  if parts.experimental then
    rm.ReplaceIngredient("textplate-small-steel", "steel-plate", "galvanized-steel-plate", 1)
    rm.ReplaceIngredient("textplate-large-steel", "steel-plate", "galvanized-steel-plate", 4)
  end
  if not (data.raw.item["gold-plate"] or data.raw.item["ei_gold-plate"] or data.raw.item["fi_gold"]) then
    if data.raw.recipe["textplate-small-gold"] then
      rm.ReplaceIngredient("textplate-small-gold", "sulfur", "brass-plate", 1)
      rm.ReplaceIngredient("textplate-large-gold", "sulfur", "brass-plate", 4)
      data.raw.recipe["textplate-small-gold"].enabled = true
      data.raw.recipe["textplate-large-gold"].enabled = true
      data.raw.technology["textplates-gold"] = nil
    end
  end
end

if mods["aai-signal-transmission"] then
  if parts.experimental then
    tf.addPrereq("aai-signal-transmission", "skyseeker-armature")

    rm.AddIngredient("aai-signal-sender", "skyseeker-armature", 5)
    rm.RemoveIngredient("aai-signal-sender", "electric-engine-unit", 10)
    rm.AddIngredient("aai-signal-receiver", "skyseeker-armature", 5)
    rm.RemoveIngredient("aai-signal-receiver", "electric-engine-unit", 10)
  end
end

if mods["aai-industry"] then
  if parts.experimental then
    if parts.nickelExperiment then
      rm.RemoveIngredient("area-mining-drill", "steel-plate", 20)
    else
      rm.ReplaceIngredient("area-mining-drill", "steel-plate", "galvanized-steel-plate", 20)
    end
    rm.AddIngredient("area-mining-drill", "advanced-gearbox", 2)
    if parts.drill then
      rm.RemoveIngredient("area-mining-drill", "tungsten-carbide", 99999)
      rm.RemoveIngredient("area-mining-drill", "diamond", 99999)
      rm.RemoveIngredient("area-mining-drill", "electric-engine-unit", 4)
      rm.AddIngredient("area-mining-drill", "industrial-drill-head", 8)
    else
      rm.AddIngredient("area-mining-drill", "complex-joint", 10)
    end

    rm.RemoveIngredient("industrial-furnace", "steel-plate", 16)
    if mods["IfNickel-Updated"] then
      rm.AddIngredient("industrial-furnace", "hardened-hull", 8)
    else
      rm.AddIngredient("industrial-furnace", "hardened-hull", 12)
    end
  end
end

if mods["big-mining-drill"] then
  if parts.experimental then
    if parts.nickelExperiment then
      rm.RemoveIngredient("big-mining-drill", "steel-plate", 20)
    else
      rm.ReplaceIngredient("big-mining-drill", "steel-plate", "galvanized-steel-plate", 20)
    end
    rm.AddIngredient("big-mining-drill", "advanced-gearbox", 2)
    if parts.drill then
      rm.RemoveIngredient("big-mining-drill", "tungsten-carbide", 99999)
      rm.RemoveIngredient("big-mining-drill", "diamond", 99999)
      rm.RemoveIngredient("big-mining-drill", "electric-engine-unit", 4)
      rm.AddIngredient("big-mining-drill", "industrial-drill-head", 8)
    else
      rm.AddIngredient("big-mining-drill", "complex-joint", 10)
    end
  end
end

if mods["jetpack"] and parts.experimental then
  if parts.gyroscope then
    rm.RemoveIngredient("jetpack-2", parts.gyroscope, 99)
    rm.ReplaceIngredient("jetpack-2", "advanced-circuit", parts.gyroscope, 20)
    tf.addPrereq("jetpack-2", parts.gyroscope)
  end

  if not parts.nickelExperiment then
    rm.RemoveIngredient("jetpack-3", "complex-joint", 99)
    rm.AddIngredient("jetpack-3", "complex-joint", 30)
    tf.addPrereq("jetpack-3", "mechanical-engineering-2")
  end
end

if mods["space-exploration"] then

  rm.AddProductRaw("se-scrap-hard-recycling", {type="item", name="zinc-ore", amount=1, independent_probability=0.05})

  if parts.experimental then
    tf.addPrereq("se-meteor-defence", "skyseeker-armature")

    tf.addRecipeUnlock("se-heat-shielding-iridium", "hardened-hull-iridium")

    rm.AddIngredient("se-space-assembling-machine", "advanced-gearbox", 2)
    rm.ReplaceIngredient("se-space-assembling-machine", "cermet", "complex-joint", 5)

    rm.ReplaceIngredient("se-space-pipe", "steel-plate", "hardened-hull", 1)

    rm.ReplaceIngredient("se-canister", "steel-plate", "galvanized-steel-plate", 4)

    rm.ReplaceIngredient("se-rocket-launch-pad", "steel-plate", "hardened-hull", 500)
    rm.AddIngredient("se-rocket-launch-pad", "complex-joint", 100)

    rm.AddIngredient("se-pulveriser", "articulated-mechanism", 10)

    rm.AddIngredient("se-recycling-facility", "complex-joint", 5)
    rm.ReplaceIngredient("se-space-mechanical-laboratory", "cermet", "complex-joint", 40)
    rm.ReplaceIngredient("se-space-mechanical-laboratory", "steel-plate", "hardened-hull", 100)
    rm.ReplaceIngredient("se-recycling-facility", "steel-plate", "galvanized-steel-plate", 20)

    rm.AddIngredient("se-space-telescope", "skyseeker-armature", 5)
    rm.AddIngredient("se-space-telescope-gammaray", "skyseeker-armature", 25)
    rm.AddIngredient("se-space-telescope-radio", "skyseeker-armature", 25)
    rm.AddIngredient("se-space-telescope-microwave", "skyseeker-armature", 25)
    rm.AddIngredient("se-space-telescope-xray", "skyseeker-armature", 25)

    rm.AddIngredient("se-delivery-cannon-capsule", "hardened-hull", 1)
    rm.AddIngredient("se-delivery-cannon-capsule-iridium", "hardened-hull", 1)
    rm.AddIngredient("se-meteor-defence", "skyseeker-armature", 10)
    rm.ReplaceIngredient("se-delivery-cannon-weapon", "electric-engine-unit", "skyseeker-armature", 50)
    rm.ReplaceIngredient("se-delivery-cannon", "electric-engine-unit", "skyseeker-armature", 10)
    rm.RemoveIngredient("se-delivery-cannon", "gyro", 99)

    rm.AddIngredient("se-heavy-assembly", "complex-joint", 4)

    rm.ReplaceIngredient("se-core-miner-drill", "steel-plate", "galvanized-steel-plate", 50)
    rm.ReplaceIngredient("se-core-miner-drill", "steel-plate", "hardened-hull", 50)

    rm.AddIngredient("se-spaceship-clamp", "complex-joint", 5)
    rm.AddIngredient("se-spaceship-gate", "complex-joint", 6)
    rm.ReplaceIngredient("se-spaceship-rocket-engine", "steel-plate", "hardened-hull", 20)
    rm.ReplaceIngredient("se-spaceship-rocket-booster-tank", "steel-plate", "hardened-hull", 10)

    rm.ReplaceIngredient("se-space-thermodynamics-laboratory", "steel-plate", "hardened-hull", 100)
    rm.ReplaceIngredient("se-space-radiation-laboratory", "steel-plate", "hardened-hull", 100)

    rm.ReplaceIngredient("se-space-transport-belt", "electric-motor", "gearbox", 2)
    rm.AddIngredient("se-space-splitter", "complex-joint", 1)
    rm.AddIngredient("se-space-splitter", "gearbox", 2)

    cu.moveItem("galvanized-steel-plate", "iron", "z")

    rm.RemoveIngredient("se-electric-boiler", "steel-plate", 10)
    if parts.nickel then
      rm.AddIngredient("se-electric-boiler", "hardened-hull", 5)
    else
      rm.AddIngredient("se-electric-boiler", "hardened-hull", 8)
    end

    if parts.gyroscope then
      rm.RemoveIngredient("se-space-gravimetrics-laboratory", parts.gyroscope, 8)
      rm.AddIngredient("se-space-gravimetrics-laboratory", parts.gyroscope, 50)

      rm.RemoveIngredient("se-space-mechanical-laboratory", parts.gyroscope, 99)
      rm.AddIngredient("se-space-mechanical-laboratory", parts.gyroscope, 10)

      rm.RemoveIngredient("se-thruster-suit-2", parts.gyroscope, 99)
      rm.AddIngredient("se-thruster-suit-2", parts.gyroscope, 10)

      rm.RemoveIngredient("se-spaceship-console", parts.gyroscope, 99)
      rm.AddIngredient("se-spaceship-console", parts.gyroscope, 10)
    end

    if settings.startup["brasstacks-se-maintenance"].value then
      local function add_catalyst(recipe, ingredient, amount, losschance, scrap, scrap_amount)
        rm.AddIngredient(recipe, ingredient, amount)
        rm.AddProductRaw(recipe, {type="item", name=ingredient, amount=amount, independent_probability=1.0 - losschance, ignored_by_productivity=amount, ignored_by_stats=amount})
        if scrap then
          rm.AddProductRaw(recipe, {type="item", name=scrap, amount=scrap_amount, independent_probability=losschance})
        end
      end

      if parts.gyroscope then
        rm.AddIngredient("se-arcosphere-fracture", parts.gyroscope, 25)
        rm.AddProductRaw("se-arcosphere-fracture", {type="item", name="se-scrap", amount=250, independent_probability=1})
        rm.AddIngredient("se-arcosphere-fracture-alt", parts.gyroscope, 25)
        rm.AddProductRaw("se-arcosphere-fracture-alt", {type="item", name="se-scrap", amount=250, independent_probability=1})

        add_catalyst("se-arcosphere-fold-in", parts.gyroscope, 1, 0.1, "se-scrap", 10)
        add_catalyst("se-arcosphere-fold-out", parts.gyroscope, 1, 0.1, "se-scrap", 10)
        add_catalyst("se-arcosphere-fold-a", parts.gyroscope, 1, 0.1, "se-scrap", 10)
        add_catalyst("se-arcosphere-fold-b", parts.gyroscope, 1, 0.1, "se-scrap", 10)
        add_catalyst("se-arcosphere-fold-c", parts.gyroscope, 1, 0.1, "se-scrap", 10)
        add_catalyst("se-arcosphere-fold-d", parts.gyroscope, 1, 0.1, "se-scrap", 10)
        add_catalyst("se-arcosphere-fold-e", parts.gyroscope, 1, 0.1, "se-scrap", 10)
        add_catalyst("se-arcosphere-fold-f", parts.gyroscope, 1, 0.1, "se-scrap", 10)
        add_catalyst("se-arcosphere-fold-g", parts.gyroscope, 1, 0.1, "se-scrap", 10)
        add_catalyst("se-arcosphere-fold-h", parts.gyroscope, 1, 0.1, "se-scrap", 10)
      end

      --add_catalyst("se-delivery-cannon-capsule", "skyseeker-armature", 1, 0.005, "se-scrap", 30)
      --add_catalyst("se-delivery-cannon-capsule-iridium", "skyseeker-armature", 1, 0.005, "se-scrap", 30)
      --data.raw.recipe["se-delivery-cannon-capsule"].main_product = "se-delivery-cannon-capsule"
      --data.raw.recipe["se-delivery-cannon-capsule-iridium"].main_product = "se-delivery-cannon-capsule"

      add_catalyst("se-observation-frame-visible", "skyseeker-armature", 1, 0.01, "se-scrap", 30)
      data.raw.recipe["se-observation-frame-visible"].main_product = "se-observation-frame-visible"
      add_catalyst("se-observation-frame-infrared", "skyseeker-armature", 1, 0.01, "se-scrap", 30)
      data.raw.recipe["se-observation-frame-infrared"].main_product = "se-observation-frame-infrared"
      add_catalyst("se-observation-frame-uv", "skyseeker-armature", 1, 0.01, "se-scrap", 30)
      data.raw.recipe["se-observation-frame-uv"].main_product = "se-observation-frame-uv"

      add_catalyst("se-observation-frame-microwave", "skyseeker-armature", 1, 0.02, "se-scrap", 30)
      data.raw.recipe["se-observation-frame-microwave"].main_product = "se-observation-frame-microwave"
      add_catalyst("se-observation-frame-xray", "skyseeker-armature", 1, 0.02, "se-scrap", 30)
      data.raw.recipe["se-observation-frame-xray"].main_product = "se-observation-frame-xray"

      add_catalyst("se-observation-frame-radio", "skyseeker-armature", 1, 0.05, "se-scrap", 30)
      data.raw.recipe["se-observation-frame-radio"].main_product = "se-observation-frame-radio"
      add_catalyst("se-observation-frame-gammaray", "skyseeker-armature", 1, 0.05, "se-scrap", 30)
      data.raw.recipe["se-observation-frame-gammaray"].main_product = "se-observation-frame-gammaray"

      add_catalyst("se-iridium-ore-crushed", "articulated-mechanism", 1, 0.05, "se-scrap", 1)
    end
  else
    rm.AddIngredient("se-pulveriser", "iron-gear-wheel", 10)
    rm.AddIngredient("se-space-assembling-machine", "bearing", 5)

    rm.AddIngredient("se-space-telescope", "bearing", 5)
    rm.AddIngredient("se-space-telescope-gammaray", "bearing", 25)
    rm.AddIngredient("se-space-telescope-radio", "bearing", 25)
    rm.AddIngredient("se-space-telescope-microwave", "bearing", 25)
    rm.AddIngredient("se-space-telescope-xray", "bearing", 25)

    rm.AddIngredient("se-recycling-facility", "bearing", 5)
    rm.AddIngredient("se-mechanical-laboratory", "bearing", 40)

    rm.AddIngredient("se-spaceship-clamp", "bearing", 5)
    rm.AddIngredient("se-spaceship-gate", "bearing", 6)

    rm.AddIngredient("se-space-transport-belt", "iron-gear-wheel", 5)
    rm.AddIngredient("se-space-splitter", "iron-gear-wheel", 10)
  end

  if not mods["IfNickel-Updated"] then
    rm.ReplaceIngredient("se-canister", "steel-plate", advfitting, 1)
  end
  rm.RemoveIngredient("se-canister", "graphite", 5)
  rm.AddIngredient("se-space-pipe", advfitting, 1)
  rm.AddIngredient("se-nutrient-vat", advfitting, 1)
  if advfitting == "airtight-seal" and parts.bz.gold then
    rm.RemoveIngredient("se-space-pipe", "silver-brazing-alloy", 99999)
  end

  data:extend({
    {
      type = "recipe",
      name = "landfill-zinc-ore",
      icons = {
        {
          icon = "__base__/graphics/icons/landfill.png",
          icon_size = 64, icon_mipmaps = 4
        },
        {
          icon = "__BrassTacks-Updated__/graphics/icons/zinc-ore.png",
          icon_size = 64, icon_mipmaps = 4, scale = 0.25
        }
      },
      categories = { "hard-recycling" },
      energy_required = 1,
      ingredients = {{type="item", name="zinc-ore", amount=50}},
      results = {{type="item", name="landfill", amount=1}},
      order = "z-b-zinc-ore",
      enabled = false
    }
  })
  tf.addRecipeUnlock("se-recycling-facility", "landfill-zinc-ore")

  cu.moveItem("enriched-zinc", "zinc", "a-a")
  cu.moveRecipe("enriched-zinc", "zinc", "a-1")
  cu.moveRecipe("dirty-water-filtration-zinc", "zinc", "a-2")
  cu.moveItem("se-core-fragment-zinc-ore", "zinc", "a-a-a-29")
  cu.moveRecipe("se-core-fragment-zinc-ore", "zinc", "a-a-a-29")
  cu.moveItem("zinc-ore", "zinc", "a-b")
  cu.moveRecipe("molten-zinc", "zinc", "a-a-b")
  cu.moveItem("zinc-ingot", "zinc", "a-b")
  cu.moveItem("zinc-plate", "zinc", "a-c")
  cu.moveRecipe("enriched-zinc-plate", "zinc", "a-c-b")
  cu.moveRecipe("zinc-ingot-to-plate", "zinc", "a-c-c")
  cu.moveItem("brass-precursor", "zinc", "a-d")
  cu.moveItem("brass-plate", "zinc", "a-e")
  cu.moveRecipe("brass-plate-foundry", "zinc", "a-e-b")
  cu.moveItem("brass-ingot", "zinc", "a-e-d")
  cu.moveRecipe("brass-ingot-to-plate", "zinc", "a-e-f")
  tf.addRecipeUnlock("se-pyroflux-smelting", "molten-zinc")
  tf.addRecipeUnlock("se-pyroflux-smelting", "zinc-ingot")
  tf.addRecipeUnlock("se-pyroflux-smelting", "zinc-ingot-to-plate")
  tf.addRecipeUnlock("se-pyroflux-smelting", "brass-ingot")
  tf.addRecipeUnlock("se-pyroflux-smelting", "brass-ingot-to-plate")
end

if mods["se-space-trains"] then
  if parts.experimental then
    if parts.gyroscope then
        rm.RemoveIngredient("space-locomotive", parts.gyroscope, 99999)
        rm.AddIngredient("space-locomotive", parts.gyroscope, 10)
        rm.AddIngredient("space-cargo-wagon", parts.gyroscope, 1)
        rm.AddIngredient("space-fluid-wagon", parts.gyroscope, 1)
    end
    rm.ReplaceProportional("space-locomotive", "kr-steel-gear-wheel", "advanced-gearbox", 0.1)
    rm.ReplaceProportional("space-locomotive", "iron-gear-wheel", "advanced-gearbox", 0.1)
  end
end
