local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")
local cu = require("category-utils")

if mods["aai-industry"] then
  if not parts.brassExperiment then
    rm.ReplaceIngredient("industrial-furnace", "steel-plate", "invar-plate", 8)
  end
  if parts.experimental then
    rm.AddIngredient("area-mining-drill", "motorized-articulator", 10)
  end
end

if mods["big-mining-drill"] then
  if parts.experimental then
    rm.AddIngredient("big-mining-drill", "motorized-articulator", 10)
  end
end

if mods["aai-containers"] then
  rm.AddIngredient("aai-strongbox-passive-provider", parts.motor, 2)
  --rm.AddIngredient("aai-strongbox-active-provider", parts.motor, 2, 2)
  --rm.AddIngredient("aai-strongbox-storage", parts.motor, 2, 2)
  --rm.AddIngredient("aai-strongbox-requester", parts.motor, 2, 2)
  --rm.AddIngredient("aai-strongbox-buffer", parts.motor, 2, 2)

  if parts.experimental then
    rm.AddIngredient("aai-storehouse-passive-provider", "motorized-articulator", 2)
    --rm.AddIngredient("aai-storehouse-active-provider", "motorized-articulator", 2)
    --rm.AddIngredient("aai-storehouse-storage", "motorized-articulator", 2)
    --rm.AddIngredient("aai-storehouse-requester", "motorized-articulator", 2)
    --rm.AddIngredient("aai-storehouse-buffer", "motorized-articulator", 2)
  else
    rm.AddIngredient("aai-storehouse-passive-provider", parts.motor, 5)
    --rm.AddIngredient("aai-storehouse-active-provider", parts.motor, 5, 5)
    --rm.AddIngredient("aai-storehouse-storage", parts.motor, 5, 5)
    --rm.AddIngredient("aai-storehouse-requester", parts.motor, 5, 5)
    --rm.AddIngredient("aai-storehouse-buffer", parts.motor, 5, 5)
  end

  if parts.experimental then
    rm.AddIngredient("aai-warehouse-passive-provider", "motorized-articulator", 5)
    --rm.AddIngredient("aai-warehouse-active-provider", "motorized-articulator", 5)
    --rm.AddIngredient("aai-warehouse-storage", "motorized-articulator", 5)
    --rm.AddIngredient("aai-warehouse-requester", "motorized-articulator", 5)
    --rm.AddIngredient("aai-warehouse-buffer", "motorized-articulator", 5)
  else
    rm.AddIngredient("aai-warehouse-passive-provider", parts.motor, 10)
    --rm.AddIngredient("aai-warehouse-active-provider", parts.motor, 10, 10)
    --rm.AddIngredient("aai-warehouse-storage", parts.motor, 10, 10)
    --rm.AddIngredient("aai-warehouse-requester", parts.motor, 10, 10)
    --rm.AddIngredient("aai-warehouse-buffer", parts.motor, 10, 10)
  end
end

if mods["aai-signal-transmission"] then
  if parts.experimental then
    if parts.brassExperiment then
      --unnecessary. big motor and gyro already need plenty nickel.

      --rm.AddIngredient("skyseeker-armature", "motorized-articulator", 1)
      --rm.RemoveIngredient("skyseeker-armature", "iron-gear-wheel", 2)
      --rm.RemoveIngredient("skyseeker-armature", "kr-steel-gear-wheel", 1)
    else
      rm.AddIngredient("aai-signal-sender", "motorized-articulator", 5)
      rm.AddIngredient("aai-signal-receiver", "motorized-articulator", 5)
    end
  end
end

if mods["jetpack"] then
  rm.AddIngredient("jetpack-2", "invar-valve", 20)
  if parts.experimental then
    rm.AddIngredient("jetpack-3", "gimbaled-thruster", 30)
    tf.addPrereq("jetpack-3", "gimbaled-thruster")
  else
    rm.AddIngredient("jetpack-3", "invar-valve", 30)
  end
end

if mods["space-exploration"] then
  rm.AddProductRaw("se-scrap-hard-recycling", {type="item", name="nickel-ore", amount=1, independent_probability=0.05})

  if parts.experimental then

    if rm.CheckIngredient("electric-engine-unit", "bronze-plate") or rm.CheckIngredient("electric-engine-unit", "bearing") then
      --limit ingredients to 4, we need a lot of these
      rm.ReplaceIngredient("electric-engine-unit", "electronic-circuit", "nickel-electromagnet", 4)
    else
      rm.ReplaceIngredient("electric-engine-unit", "electronic-circuit", "nickel-electromagnet", 2)
    end
    tf.addPrereq("electric-engine", "nickel-electromagnet")

    rm.AddIngredient("se-space-platform-scaffold", "nickel-electromagnet", 1)
    rm.AddIngredient("se-magnetic-canister", "nickel-electromagnet", 1)
    rm.AddIngredient("se-space-particle-accelerator", "nickel-electromagnet", 100)
    rm.AddIngredient("se-space-particle-collider", "nickel-electromagnet", 250)
    rm.AddIngredient("se-space-plasma-generator", "nickel-electromagnet", 100)
    rm.AddIngredient("se-space-electromagnetics-laboratory", "nickel-electromagnet", 100)

    rm.RemoveIngredient("se-space-pipe", "copper-cable", 2)
    rm.AddIngredient("se-space-pipe", "nickel-electromagnet", 1) -- plasma containment
    rm.AddIngredient("se-space-transport-belt", "nickel-electromagnet", 1)
    rm.AddIngredient("se-space-rail", "nickel-electromagnet", 200) -- batch of 100
    rm.AddIngredient("se-spaceship-clamp", "nickel-electromagnet", 20)
    rm.ReplaceIngredient("se-energy-beam-defence", "copper-plate", "nickel-electromagnet", 200)

    if parts.nitinol then
      rm.ReplaceProportional("se-space-transport-belt", "titanium-plate", "nitinol-mesh", 0.5) --flexible belt surfacing
      rm.AddIngredient("se-delivery-cannon-chest", "nitinol-mesh", 5)

      --tf.addPrereq("se-delivery-cannon", "nitinol-processing")

      rm.ReplaceIngredient("se-adaptive-armour-equipment-2", "titanium-plate", "nitinol-plate", 30) --shape memory. eh close enough
      rm.ReplaceIngredient("se-adaptive-armour-equipment-3", "titanium-plate", "nitinol-plate", 40)

      --tf.addPrereq("se-adaptive-armour-2", "nitinol-processing")

      rm.ReplaceIngredient("se-aeroframe-pole", "iron-stick", "nitinol-plate", 1) --it's just the Vaguely Associated With Beryllium resource
      --rm.ReplaceIngredient("se-aeroframe-bulkhead", "titanium-plate", "nitinol-plate", 2)
      rm.ReplaceIngredient("se-lattice-pressure-vessel", "titanium-plate", "nitinol-mesh", 2)

      if parts.brassExperiment then
        rm.RemoveIngredient("complex-joint-iridium", "articulated-mechanism", 16)
        rm.AddIngredient("complex-joint-iridium", "nitinol-plate", 4) --good springs
      end

      rm.AddIngredient("se-low-density-structure-beryllium", "nitinol-mesh", 1)
      rm.RemoveIngredient("se-low-density-structure-beryllium", "carbon-fiber", 99999)
      rm.RemoveIngredient("se-low-density-structure-beryllium", "plastic-bar", 99999)
      rm.RemoveIngredient("se-low-density-structure-beryllium", "steel-plate", 1)
      rm.RemoveIngredient("se-low-density-structure-beryllium", "aluminum-2219", 1)

      rm.AddIngredient("efficiency-module-6", "nitinol-plate", 20)
      rm.AddIngredient("speed-module-6", "nitinol-mesh", 25)
      rm.AddIngredient("productivity-module-6", "self-regulating-valve", 30)

      rm.AddIngredient("se-space-radiator", "nitinol-plate", 10)
      rm.AddIngredient("se-space-radiator-2", "self-regulating-valve", 10)

      rm.AddIngredient("se-space-thermodynamics-laboratory", "nitinol-plate", 20)
      rm.AddIngredient("se-space-mechanical-laboratory", "nitinol-mesh", 20)

      rm.AddIngredient("se-big-heat-exchanger", "self-regulating-valve", 50)
      rm.RemoveIngredient("se-big-heat-exchanger", "titanium-plate", 99999)
      rm.RemoveIngredient("se-big-heat-exchanger", "titanium-palladium-flange", 99999)

      rm.AddIngredient("se-big-turbine", "self-regulating-valve", 50)
      rm.RemoveIngredient("se-big-turbine", "titanium-plate", 99999)
      rm.RemoveIngredient("se-big-turbine", "titanium-palladium-flange", 99999)

      --tf.addPrereq("nuclear-power", "nitinol-processing")

      rm.AddIngredient("heat-exchanger", "self-regulating-valve", 10)
      rm.RemoveIngredient("heat-exchanger", "titanium-plate", 99999)
      rm.RemoveIngredient("heat-exchanger", "titanium-palladium-flange", 99999)
      rm.AddIngredient("steam-turbine", "self-regulating-valve", 10)
      rm.RemoveIngredient("steam-turbine", "pipe", 10)
      rm.RemoveIngredient("steam-turbine", "titanium-plate", 99999)
      rm.RemoveIngredient("steam-turbine", "titanium-palladium-flange", 99999)

      rm.AddIngredient("se-condenser-turbine", "self-regulating-valve", 10)
      rm.RemoveIngredient("se-condenser-turbine", "titanium-plate", 99999)
      rm.RemoveIngredient("se-condenser-turbine", "titanium-palladium-flange", 99999)

      rm.ReplaceProportional("se-cargo-rocket-cargo-pod", "steel-plate", "nitinol-mesh", 0.5)
      if (mods["Krastorio2"] or mods["ThemTharHills-Updated"]) or not data.raw.item["titanium-palladium-flange"] then
        --K2 allows palladium from rare metal ore, TTH allows some pall/plat ore on nauvis from byproducts.
        rm.ReplaceProportional("se-cargo-rocket-fuel-tank", "pipe", "self-regulating-valve", 0.5)
      end

      --tf.addPrereq("se-cargo-rocket-silo", "nitinol-processing")

      rm.AddIngredient("se-space-elevator-cable", "nitinol-plate", 1)
      rm.AddIngredient("se-space-elevator-cable-nano", "nitinol-plate", 1)
      rm.RemoveIngredient("se-space-elevator-cable", "coal", 2)

      rm.ReplaceIngredient("se-tensile-strength-data", "steel-plate", "nitinol-plate", 1)

      if mods["Krastorio2"] then
        rm.AddIngredient("kr-fusion-reactor", "self-regulating-valve", 100)
        rm.ReplaceIngredient("kr-advanced-transport-belt", "titanium-plate", "nitinol-mesh", 1)
        rm.AddIngredient("kr-advanced-splitter", "nitinol-mesh", 2)

        rm.ReplaceIngredient("kr-advanced-steam-turbine", "titanium-palladium-flange", "self-regulating-valve", 10)
      end
    end

    local function add_catalyst(recipe, ingredient, amount, losschance, scrap, scrap_amount)
      rm.AddIngredient(recipe, ingredient, amount)
      rm.AddProductRaw(recipe, {type="item", name=ingredient, amount=amount, independent_probability=1.0 - losschance, ignored_by_productivity=amount, ignored_by_stats=amount})
      if scrap then
        rm.AddProductRaw(recipe, {type="item", name=scrap, amount=scrap_amount, independent_probability=losschance})
      end
    end

    if settings.startup["ifnickel-se-maintenance"].value then
      -- Research. 25% magnet fail chance
      add_catalyst("se-electromagnetic-field-data", "nickel-electromagnet", 1, 0.25, "se-scrap", 1)
      add_catalyst("se-bioelectrics-data", "nickel-electromagnet", 1, 0.25, "se-scrap", 1)
      add_catalyst("se-forcefield-data", "nickel-electromagnet", 1, 0.25, "se-scrap", 1)
      add_catalyst("se-neural-anomaly-data", "nickel-electromagnet", 1, 0.25, "se-scrap", 1)
      add_catalyst("se-naquium-energy-data", "nickel-electromagnet", 1, 0.25, "se-scrap", 1)
      add_catalyst("se-boson-data", "nickel-electromagnet", 1, 0.25, "se-scrap", 1)
      add_catalyst("se-singularity-data", "nickel-electromagnet", 1, 0.25, "se-scrap", 1)
      add_catalyst("se-entanglement-data", "nickel-electromagnet", 1, 0.25, "se-scrap", 1)
      add_catalyst("se-lepton-data", "nickel-electromagnet", 1, 0.25, "se-scrap", 1)
      add_catalyst("se-magnetic-monopole-data", "nickel-electromagnet", 1, 0.25, "se-scrap", 1)
      add_catalyst("se-micro-black-hole-data", "nickel-electromagnet", 1, 0.25, "se-scrap", 1)
      add_catalyst("se-quark-data", "nickel-electromagnet", 1, 0.25, "se-scrap", 1)
      add_catalyst("se-subatomic-data", "nickel-electromagnet", 1, 0.25, "se-scrap", 1)
      add_catalyst("se-fusion-test-data", "nickel-electromagnet", 1, 0.25, "se-scrap", 1)
      add_catalyst("se-particle-beam-shielding-data", "nickel-electromagnet", 1, 0.25, "se-scrap", 1)
      add_catalyst("se-annihilation-data", "nickel-electromagnet", 1, 0.25, "se-scrap", 1)

      -- Routine production. 5% magnet fail chance
      add_catalyst("se-plasma-stream", "nickel-electromagnet", 1, 0.05, "se-scrap", 1)
      add_catalyst("se-ion-stream", "nickel-electromagnet", 1, 0.05, "se-scrap", 1)
      add_catalyst("se-proton-stream", "nickel-electromagnet", 1, 0.05, "se-scrap", 1)
      add_catalyst("se-particle-stream", "nickel-electromagnet", 1, 0.05, "se-scrap", 1)
      data.raw.recipe["se-plasma-stream"].allow_decomposition = false
      data.raw.recipe["se-ion-stream"].allow_decomposition = false
      data.raw.recipe["se-proton-stream"].allow_decomposition = false
      data.raw.recipe["se-particle-stream"].allow_decomposition = false
    end

    rm.AddIngredient("se-cargo-rocket-section", "gimbaled-thruster", 1)
    rm.AddIngredient("se-cargo-rocket-section-beryllium", "gimbaled-thruster", 1)
    rm.RemoveIngredient("se-cargo-rocket-section", "rocket-engine-nozzle", 5)
    rm.RemoveIngredient("se-cargo-rocket-section-beryllium", "rocket-engine-nozzle", 5)

    cu.moveItem("gimbaled-thruster", "rocket-part", "o")

    --if rm.CheckIngredient("se-rocket-science-pack", "rocket-engine-nozzle") then
      --rm.RemoveIngredient("se-rocket-science-pack", "rocket-engine-nozzle", 8)
      --rm.AddIngredient("se-rocket-science-pack", "gimbaled-thruster", 4)
    --end

    rm.AddIngredient("se-belt-probe", "gimbaled-thruster", 10)
    rm.AddIngredient("se-star-probe", "gimbaled-thruster", 10)
    rm.AddIngredient("se-void-probe", "gimbaled-thruster", 10)
    rm.AddIngredient("se-arcosphere-collector", "gimbaled-thruster", 10)

    rm.RemoveIngredient("se-void-probe", "rocket-engine-nozzle", 1)

    rm.AddIngredient("se-space-assembling-machine", "advanced-machining-tool", 4)
    rm.RemoveIngredient("se-space-assembling-machine", "tungsten-carbide", 99)
    rm.RemoveIngredient("se-space-assembling-machine", "diamond", 99)

    rm.ReplaceIngredient("se-cargo-rocket-cargo-pod", "fast-inserter", "motorized-articulator", 2)

    rm.AddIngredient("se-fuel-refinery", "flow-controller", 10)

    rm.RemoveIngredient("se-rocket-launch-pad", "pipe", 100)
    rm.AddIngredient("se-rocket-launch-pad", "advanced-flow-controller", 20)

    tf.addPrereq("se-lifesupport-facility", "advanced-flow-controller")
    tf.addPrereq("se-space-decontamination-facility", "advanced-flow-controller")
    rm.AddIngredient("se-lifesupport-facility", "advanced-flow-controller", 5)
    rm.AddIngredient("se-space-growth-facility", "advanced-flow-controller", 20)
    rm.AddIngredient("se-space-decontamination-facility", "advanced-flow-controller", 20)
    rm.AddIngredient("se-space-genetics-laboratory", "advanced-flow-controller", 20)
    rm.AddIngredient("se-space-biochemical-laboratory", "advanced-flow-controller", 20)

    rm.AddIngredient("se-space-hypercooler", "advanced-flow-controller", 5)
    rm.AddIngredient("se-condenser-turbine", "advanced-flow-controller", 5)

    if settings.startup["ifnickel-se-maintenance"].value then
      add_catalyst("se-radiating-space-coolant-slow", "flow-controller", 1, 0.06, "se-scrap", 10)
      add_catalyst("se-space-coolant-warm", "flow-controller", 1, 0.005, "se-scrap", 10)
      add_catalyst("se-radiating-space-coolant-fast", "flow-controller", 1, 0.0005, "se-scrap", 10)
      data.raw.recipe["se-radiating-space-coolant-slow"].allow_decomposition = false
      data.raw.recipe["se-space-coolant-warm"].allow_decomposition = false
      data.raw.recipe["se-radiating-space-coolant-fast"].allow_decomposition = false

      add_catalyst("se-space-coolant-cold", "advanced-flow-controller", 1, 0.005, "se-scrap", 30)
      add_catalyst("se-space-coolant-supercooled", "advanced-flow-controller", 1, 0.005, "se-scrap", 30)
      add_catalyst("se-space-coolant-cold-cryonite", "advanced-flow-controller", 1, 0.005, "se-scrap", 30)
      add_catalyst("se-space-coolant-supercooled-cryonite", "advanced-flow-controller", 1, 0.005, "se-scrap", 30)
      data.raw.recipe["se-space-coolant-cold"].allow_decomposition = false
      data.raw.recipe["se-space-coolant-supercooled"].allow_decomposition = false
      data.raw.recipe["se-space-coolant-cold-cryonite"].allow_decomposition = false
      data.raw.recipe["se-space-coolant-supercooled-cryonite"].allow_decomposition = false
    end

    rm.AddIngredient("se-recycling-facility", "motorized-articulator", 5)
    rm.AddIngredient("se-mechanical-laboratory", "motorized-articulator", 10)

    rm.AddIngredient("se-electric-boiler", "flow-controller", 1)

    if not parts.brassExperiment then
      rm.AddIngredient("se-spaceship-gate", "motorized-articulator", 6)
      rm.ReplaceIngredient("se-rocket-launch-pad", "steel-plate", "invar-plate", 200)
    end
    rm.ReplaceIngredient("se-spaceship-rocket-booster-tank", "se-space-pipe", "gimbaled-thruster", 4)

    rm.AddIngredient("se-space-capsule", "gimbaled-thruster", 20)

    rm.AddIngredient("se-lattice-pressure-vessel", "advanced-flow-controller", 1)
    if rm.CheckIngredient("se-bioscrubber", "platinum-ingot") or rm.CheckIngredient("se-bioscrubber", "palladium-ingot") then
      --made in batch of 10
      rm.AddIngredient("se-bioscrubber", "flow-controller", 10)
    else
      rm.AddIngredient("se-bioscrubber", "flow-controller", 1)
    end

    rm.AddIngredient("se-pressure-containment-data", "advanced-flow-controller", 1)

    rm.ReplaceIngredient("se-holmium-solenoid", "iron-stick", "nickel-electromagnet", 1)
  else
    rm.AddIngredient("se-fuel-refinery", "invar-valve", 10)
    rm.AddIngredient("se-lifesupport-facility", "invar-valve", 20)
    rm.AddIngredient("se-space-growth-facility", "invar-valve", 50)
    rm.AddIngredient("se-space-decontamination-facility", "invar-valve", 50)
    rm.AddIngredient("se-space-genetics-laboratory", "invar-valve", 50)
    rm.AddIngredient("se-space-biochemical-laboratory", "invar-valve", 50)

    rm.RemoveIngredient("se-rocket-launch-pad", "pipe", 100)
    rm.AddIngredient("se-rocket-launch-pad", "invar-valve", 50)

    rm.AddIngredient("se-electric-boiler", "invar-valve", 1)

    rm.ReplaceIngredient("se-spaceship-rocket-booster-tank", "se-space-pipe", "invar-valve", 8)

    rm.AddIngredient("se-space-radiator", "invar-valve", 5)
    rm.AddIngredient("se-space-hypercooler", "invar-valve", 10)
    rm.AddIngredient("se-condenser-turbine", "invar-valve", 10)

    rm.AddIngredient("se-lattice-pressure-vessel", "invar-valve", 2)
    if rm.CheckIngredient("se-bioscrubber", "platinum-ingot") or rm.CheckIngredient("se-bioscrubber", "palladium-ingot") then
      --made in batch of 10
      rm.AddIngredient("se-bioscrubber", "invar-valve", 10)
    else
      rm.AddIngredient("se-bioscrubber", "invar-valve", 1)
    end

    rm.AddIngredient("se-pressure-containment-data", "invar-valve", 2)

    rm.ReplaceIngredient("se-holmium-solenoid", "iron-stick", "nickel-plate", 1)
  end

  rm.ReplaceIngredient("se-canister", "steel-plate", "invar-valve", 1)

  rm.ReplaceIngredient("se-spaceship-rocket-engine", "se-space-pipe", "invar-valve", 40)

  if settings.startup["ifnickel-steel-valve"].value then
    rm.RemoveIngredient("se-bioscrubber", "steel-plate", 1)
  end

  if parts.nitinol then
    rm.AddIngredient("se-material-testing-pack", "nitinol-plate", 1)
  else
    rm.AddIngredient("se-material-testing-pack", "nickel-plate", 1)
  end
  rm.ReplaceIngredient("se-heat-shielding", "steel-plate", "invar-plate", 2)

  data:extend({
    {
      type = "recipe",
      name = "landfill-nickel-ore",
      icons = {
        {
          icon = "__base__/graphics/icons/landfill.png",
          icon_size = 64, icon_mipmaps = 4
        },
        {
          icon = "__IfNickel-Updated__/graphics/icons/nickel-ore.png",
          icon_size = 64, icon_mipmaps = 4, scale = 0.25
        }
      },
      categories = { "hard-recycling" },
      energy_required = 1,
      ingredients = {{type="item", name="nickel-ore", amount=50}},
      results = {{type="item", name="landfill", amount=1}},
      order = "z-b-nickel-ore",
      enabled = false
    }
  })
  tf.addRecipeUnlock("se-recycling-facility", "landfill-nickel-ore")

  cu.moveItem("enriched-nickel", "nickel", "a-a")
  cu.moveRecipe("enriched-nickel", "nickel", "a-1")
  cu.moveRecipe("dirty-water-filtration-nickel", "nickel", "a-2")
  cu.moveItem("nickel-ore", "nickel", "a-b")
  cu.moveItem("se-core-fragment-nickel-ore", "nickel", "a-a-a-31")
  cu.moveRecipe("se-core-fragment-nickel-ore", "nickel", "a-a-a-31")
  cu.moveRecipe("molten-nickel", "nickel", "a-a-b")
  cu.moveItem("nickel-ingot", "nickel", "a-b")
  cu.moveItem("nickel-plate", "nickel", "a-c")
  cu.moveRecipe("enriched-nickel-plate", "nickel", "a-c-b")
  cu.moveRecipe("nickel-ingot-to-plate", "nickel", "a-c-c")
  cu.moveItem("invar-precursor", "nickel", "a-d")
  cu.moveItem("invar-plate", "nickel", "a-e-a")
  cu.moveItem("invar-ingot", "nickel", "a-e-b")
  cu.moveRecipe("invar-ingot-to-plate", "nickel", "a-e-c")
  tf.addRecipeUnlock("se-pyroflux-smelting", "molten-nickel")
  tf.addRecipeUnlock("se-pyroflux-smelting", "nickel-ingot")
  tf.addRecipeUnlock("se-pyroflux-smelting", "nickel-ingot-to-plate")
  tf.addRecipeUnlock("se-pyroflux-smelting", "invar-ingot")
  tf.addRecipeUnlock("se-pyroflux-smelting", "invar-ingot-to-plate")

  if parts.nitinol then
    cu.moveItem("nitinol-precursor", "nickel", "a-f")
    cu.moveItem("nitinol-plate", "nickel", "a-g")
    cu.moveRecipe("nitinol-plate", "nickel", "a-g-a")
    cu.moveRecipe("nitinol-plate-space", "nickel", "a-g-b")
  end
end

if mods["se-space-trains"] then
  if data.raw.item["nickel-electromagnet"] then
    rm.AddIngredient("space-locomotive", "nickel-electromagnet", 20)
    rm.AddIngredient("space-cargo-wagon", "nickel-electromagnet", 20)
    rm.AddIngredient("space-fluid-wagon", "nickel-electromagnet", 20)
  else
    rm.AddIngredient("space-locomotive", "nickel-plate", 20)
    rm.AddIngredient("space-cargo-wagon", "nickel-plate", 20)
    rm.AddIngredient("space-fluid-wagon", "nickel-plate", 20)
  end
end
