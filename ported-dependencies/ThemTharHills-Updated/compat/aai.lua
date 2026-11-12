local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")
local cu = require("category-utils")

if mods["aai-containers"] and not data.raw.item["tracker"] then
  rm.ReplaceProportional("aai-strongbox-passive-provider", "electronic-circuit", "transceiver", 1/4)
  rm.ReplaceProportional("aai-storehouse-passive-provider", "electronic-circuit", "transceiver", 1/5)
  rm.ReplaceProportional("aai-warehouse-passive-provider", "electronic-circuit", "transceiver", 1/5)
end

if mods["aai-signal-transmission"] then
  rm.AddIngredient("aai-signal-sender", "transceiver", 10)
  rm.AddIngredient("aai-signal-receiver", "transceiver", 10)
end

if mods["aai-industry"] then
  rm.AddIngredient("area-mining-drill", "hv-power-regulator", 1)
end

if mods["space-exploration"] then

  rm.AddProductRaw("se-scrap-hard-recycling", {type="item", name="gold-ore", amount=1, independent_probability=0.01})

  if data.raw.item["nickel-electromagnet"] then
    rm.ReplaceProportional("nickel-electromagnet", "copper-cable", "advanced-cable", 1/4)
    tf.removePrereq("nickel-electromagnet", "chemical-science-pack")
    tf.addPrereq("nickel-electromagnet", "high-voltage-equipment")
  else
    rm.AddIngredient("se-space-particle-accelerator", "advanced-cable", 40)
    rm.AddIngredient("se-space-particle-collider", "advanced-cable", 100)
    rm.AddIngredient("se-space-plasma-generator", "advanced-cable", 40)
    rm.AddIngredient("se-space-electromagnetics-laboratory", "advanced-cable", 40)

    rm.RemoveIngredient("se-space-pipe", "copper-cable", 2)
    rm.AddIngredient("se-space-pipe", "advanced-cable", 1) -- plasma containment
    rm.AddIngredient("se-space-transport-belt", "advanced-cable", 1)
    rm.AddIngredient("se-space-rail", "advanced-cable", 10) -- batch of 100
    rm.ReplaceIngredient("se-energy-beam-defence", "copper-plate", "advanced-cable", 200)
  end

  if settings.startup["themtharhills-se-maintenance"].value and ((not mods["IfNickel-Updated"]) or (mods["IfNickel-Updated"] and not (data.raw.item["nickel-electromagnet"] and settings.startup["ifnickel-se-maintenance"].value))) then
    local function add_catalyst(recipe, ingredient, amount, losschance, scrap, scrap_amount)
      rm.AddIngredient(recipe, ingredient, amount)
      rm.AddProductRaw(recipe, {type="item", name=ingredient, amount=amount, independent_probability=1.0 - losschance, ignored_by_productivity=amount, ignored_by_stats=amount})
      if scrap then
        rm.AddProductRaw(recipe, {type="item", name=scrap, amount=scrap_amount, independent_probability=losschance})
      end
    end
    -- Research. 25% magnet fail chance
    add_catalyst("se-electromagnetic-field-data", "advanced-cable", 1, 0.25, "se-scrap", 2)
    add_catalyst("se-bioelectrics-data", "advanced-cable", 1, 0.25, "se-scrap", 2)
    add_catalyst("se-forcefield-data", "advanced-cable", 1, 0.25, "se-scrap", 2)
    add_catalyst("se-neural-anomaly-data", "advanced-cable", 1, 0.25, "se-scrap", 2)
    add_catalyst("se-naquium-energy-data", "advanced-cable", 1, 0.25, "se-scrap", 2)
    add_catalyst("se-boson-data", "advanced-cable", 1, 0.25, "se-scrap", 2)
    add_catalyst("se-singularity-data", "advanced-cable", 1, 0.25, "se-scrap", 2)
    add_catalyst("se-entanglement-data", "advanced-cable", 1, 0.25, "se-scrap", 2)
    add_catalyst("se-lepton-data", "advanced-cable", 1, 0.25, "se-scrap", 2)
    add_catalyst("se-magnetic-monopole-data", "advanced-cable", 1, 0.25, "se-scrap", 2)
    add_catalyst("se-micro-black-hole-data", "advanced-cable", 1, 0.25, "se-scrap", 2)
    add_catalyst("se-quark-data", "advanced-cable", 1, 0.25, "se-scrap", 2)
    add_catalyst("se-subatomic-data", "advanced-cable", 1, 0.25, "se-scrap", 2)
    add_catalyst("se-fusion-test-data", "advanced-cable", 1, 0.25, "se-scrap", 2)
    add_catalyst("se-particle-beam-shielding-data", "advanced-cable", 1, 0.25, "se-scrap", 2)
    add_catalyst("se-annihilation-data", "advanced-cable", 1, 0.25, "se-scrap", 2)

    -- Routine production. 5% magnet fail chance
    add_catalyst("se-plasma-stream", "advanced-cable", 1, 0.05, "se-scrap", 2)
    add_catalyst("se-ion-stream", "advanced-cable", 1, 0.05, "se-scrap", 2)
    add_catalyst("se-proton-stream", "advanced-cable", 1, 0.05, "se-scrap", 2)
    add_catalyst("se-particle-stream", "advanced-cable", 1, 0.05, "se-scrap", 2)
    data.raw.recipe["se-plasma-stream"].allow_decomposition = false
    data.raw.recipe["se-ion-stream"].allow_decomposition = false
    data.raw.recipe["se-proton-stream"].allow_decomposition = false
    data.raw.recipe["se-particle-stream"].allow_decomposition = false
  end

  if data.raw.item["skyseeker-armature"] then
    tf.removePrereq("skyseeker-armature", "se-rocket-science-pack")
    tf.addPrereq("skyseeker-armature", "processing-unit")
    rm.AddIngredient("skyseeker-armature", "integrated-circuit", parts.bz.gold and 1 or 2)
  end

  rm.ReplaceProportional("se-empty-data", "copper-plate", "integrated-circuit", 1/2)
  rm.ReplaceProportional("se-machine-learning-data", "electronic-circuit", "integrated-circuit", 1/2)

  if data.raw.item["advanced-flow-controller"] then
    rm.ReplaceProportional("advanced-flow-controller-biological", "advanced-circuit", "integrated-circuit", 1)
  end

  rm.AddIngredient("se-rocket-launch-pad", "hv-power-regulator", 50)

  rm.AddIngredient("se-electric-boiler", "advanced-cable", 10)
  rm.AddIngredient("se-electric-boiler", "hv-power-regulator", 1)
  rm.RemoveIngredient("se-electric-boiler", "copper-plate", 200)

  rm.AddIngredient("se-space-assembling-machine", "hv-power-regulator", 1)

  rm.ReplaceProportional("se-space-radiator", "copper-cable", "advanced-cable", 1/4)

  if not mods["Krastorio2"] then
    rm.AddIngredient("se-space-solar-panel", parts.gold, 8)
    rm.ReplaceProportional("se-cryonite-ion-exchange-beads", "sulfuric-acid", "nitric-acid", 1)
  end

  rm.ReplaceIngredient("se-holmium-powder", "copper-cable", parts.wire, 1)

  rm.AddIngredient("se-dynamic-emitter", "transceiver", 1)
  rm.ReplaceProportional("se-conductivity-data", "copper-plate", "advanced-cable", 1/4)

  rm.ReplaceIngredient("se-observation-frame-blank", "light-oil", mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", 10)
  rm.ReplaceIngredient("se-observation-frame-blank-beryllium", "light-oil", mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", 10)

  rm.AddIngredient("se-belt-probe", "transceiver", 100)
  rm.AddIngredient("se-star-probe", "transceiver", 100)
  rm.AddIngredient("se-void-probe", "transceiver", 100)
  rm.AddIngredient("se-arcosphere-collector", "transceiver", 250)

  rm.ReplaceProportional("se-supercharger", "battery", "hv-power-regulator", 1/2)

  rm.AddIngredient("se-space-thermodynamics-laboratory", "advanced-cable", 50)

  data:extend({
    {
      type = "recipe",
      name = "landfill-gold-ore",
      icons = {
        {
          icon = "__base__/graphics/icons/landfill.png",
          icon_size = 64, icon_mipmaps = 4
        },
        {
          icon = "__ThemTharHills-Updated__/graphics/icons/gold-ore.png",
          icon_size = 64, icon_mipmaps = 4, scale = 0.25
        }
      },
      categories = { "hard-recycling" },
      energy_required = 1,
      ingredients = {{type="item", name="gold-ore", amount=50}},
      results = {{type="item", name="landfill", amount=1}},
      order = "z-b-gold-ore",
      enabled = false
    }
  })
  tf.addRecipeUnlock("se-recycling-facility", "landfill-gold-ore")

  cu.moveItem("gold-ore", "gold", "a-b")
  cu.moveRecipe("molten-gold", "gold", "a-a-b")
  cu.moveItem("se-core-fragment-gold-ore", "gold", "a-a-a-28")
  cu.moveRecipe("se-core-fragment-gold-ore", "gold", "a-a-a-28")
  cu.moveItem("gold-ingot", "gold", "a-b")
  cu.moveItem("gold-powder", "gold", "a-b-a")
  cu.moveItem(parts.gold, "gold", "a-c")
  cu.moveRecipe("gold-ingot-to-plate", "gold", "a-c-c")
  cu.moveItem("potassium-nitrate", "stone", "z")

  tf.addRecipeUnlock("se-pyroflux-smelting", "molten-gold")
  tf.addRecipeUnlock("se-pyroflux-smelting", "gold-ingot")
  tf.addRecipeUnlock("se-pyroflux-smelting", "gold-ingot-to-plate")
end
