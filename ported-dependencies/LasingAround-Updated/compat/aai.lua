local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")

local function lasermill_recipe(recipe, lasdata)
  if data.raw.recipe[recipe] and not data.raw.recipe[recipe].lasermill then
    data.raw.recipe[recipe].lasermill = lasdata
  end
end

if mods["aai-containers"] and data.raw.item["tracker"] then
  tf.addPrereq("aai-strongbox-storage", "tracking-systems")
  rm.ReplaceProportional("aai-strongbox-passive-provider", "electronic-circuit", "tracker", 1/2)
  rm.ReplaceProportional("aai-storehouse-passive-provider", "electronic-circuit", "tracker", 1/2)
  rm.ReplaceProportional("aai-warehouse-passive-provider", "electronic-circuit", "tracker", 1/2)
  rm.RemoveIngredient("aai-strongbox-passive-provider", "advanced-circuit", 99999)
  rm.RemoveIngredient("aai-storehouse-passive-provider", "advanced-circuit", 99999)
  rm.RemoveIngredient("aai-warehouse-passive-provider", "advanced-circuit", 99999)
end

if data.raw.item["skyseeker-armature"] then
  if data.raw.item["micron-tolerance-components"] and not mods["LunarLandings"] then
    rm.ReplaceProportional("skyseeker-armature", "iron-gear-wheel", "micron-tolerance-components", 2)
    rm.ReplaceProportional("skyseeker-armature", "steel-gear-wheel", "micron-tolerance-components", 4)
  end
  if data.raw.item["tracker"] then
    rm.ReplaceProportional("skyseeker-armature", "gyro", "tracker", 1)
    rm.ReplaceProportional("skyseeker-armature", "gyroscope", "tracker", 1)
  end
else if mods["aai-signal-transmission"] and data.raw.item["micron-tolerance-components"] then
  rm.AddIngredient("aai-signal-sender", "micron-tolerance-components", 50)
  rm.AddIngredient("aai-signal-receiver", "micron-tolerance-components", 50)
end end

if mods["space-exploration"] then
  --leak testing. a realistic use of helium!
  rm.AddIngredient("se-space-pipe", "helium", 1)
  rm.SetCategory("se-space-pipe", "crafting-with-fluid")
  rm.AddIngredient("se-canister", "helium", 4)
  rm.SetCategory("se-canister", "crafting-with-fluid")
  if parts.nickelExperiment then
    rm.AddIngredient("advanced-flow-controller", "helium", 1)
    rm.SetCategory("advanced-flow-controller", "crafting-with-fluid")
    rm.AddIngredient("advanced-flow-controller-biological", "helium", 3)
    rm.SetCategory("advanced-flow-controller-biological", "crafting-with-fluid")
    rm.AddIngredient("self-regulating-valve", "helium", 1)
    rm.SetCategory("self-regulating-valve", "crafting-with-fluid")
    tf.addPrereq("advanced-flow-controller", "helium-extraction")
    rm.AddIngredient("self-regulating-valve", "micron-tolerance-components", 1)
  end

  if data.raw.item["micron-tolerance-components"] then
    tf.addPrereq("se-space-manufactory", "micron-tolerance-instruments")
    rm.RemoveIngredient("se-material-testing-pack", "stone", 99999)
    rm.RemoveIngredient("se-material-testing-pack", "silica", 99999)
    rm.multiply("se-material-testing-pack", 3, true, true, true)
    rm.AddIngredient("se-material-testing-pack", "laboratory-gear", 1)
    if #data.raw.recipe["se-material-testing-pack"].ingredients > 6 then
      if data.raw.item["nitinol-plate"] then
        rm.RemoveIngredient("se-material-testing-pack", "copper-plate", 99999)
      else
        rm.RemoveIngredient("se-material-testing-pack", "nickel-plate", 99999)
      end
    end

    if not data.raw.item["skyseeker-armature"] then
      rm.AddIngredient("se-space-telescope", "micron-tolerance-components", 50)
      rm.AddIngredient("se-space-telescope-gammaray", "micron-tolerance-components", 250)
      rm.AddIngredient("se-space-telescope-radio", "micron-tolerance-components", 250)
      rm.AddIngredient("se-space-telescope-microwave", "micron-tolerance-components", 250)
      rm.AddIngredient("se-space-telescope-xray", "micron-tolerance-components", 250)

      rm.AddIngredient("se-meteor-defence", "micron-tolerance-components", 100)
      rm.AddIngredient("se-delivery-cannon-weapon", "micron-tolerance-components", 500)
      rm.AddIngredient("se-delivery-cannon", "micron-tolerance-components", 100)
    end

    rm.AddIngredient("se-space-mirror", "micron-tolerance-components", 1)
    rm.AddIngredient("se-space-mirror-alternate", "micron-tolerance-components", 1)

    rm.multiply("se-observation-frame-blank", 2, true, true, true)
    rm.multiply("se-observation-frame-blank-beryllium", 2, true, true, true)
    rm.ReplaceIngredient("se-observation-frame-blank", "steel-plate", "laboratory-gear", 1)
    rm.ReplaceIngredient("se-observation-frame-blank-beryllium", "se-beryllium-plate", "laboratory-gear", 1)

    --also function as basic production structures, so make them less onerous
    rm.AddIngredient("se-space-biochemical-laboratory", "laboratory-gear", 20)
    rm.AddIngredient("se-space-thermodynamics-laboratory", "laboratory-gear", 20)
    rm.AddIngredient("se-space-growth-facility", "laboratory-gear", 20)

    rm.AddIngredient("se-space-genetics-laboratory", "laboratory-gear", 80)
    rm.AddIngredient("se-space-mechanical-laboratory", "laboratory-gear", 80)
    rm.AddIngredient("se-space-astrometrics-laboratory", "laboratory-gear", 50)
    rm.AddIngredient("se-space-electromagnetics-laboratory", "laboratory-gear", 80)
    rm.AddIngredient("se-space-laser-laboratory", "laboratory-gear", 80)
    rm.AddIngredient("se-space-gravimetrics-laboratory", "laboratory-gear", 80)
    rm.AddIngredient("se-space-particle-collider", "laboratory-gear", 80)
    rm.AddIngredient("se-space-particle-accelerator", "laboratory-gear", 80)

    rm.AddIngredient("se-genetic-data", "laboratory-gear", 1)
    rm.AddProductRaw("se-genetic-data", {type="item", name="laboratory-gear", independent_probability=0.99, amount=1})
  end

  tf.addPrereq("se-space-belt", "scanner")
  rm.ReplaceProportional("se-space-splitter", "advanced-circuit", "scanner", 0.2)

  rm.ReplaceIngredient("se-space-laser-laboratory", "ti-sapphire", "carbon-dioxide-laser", 10)
  rm.RemoveIngredient("se-space-laser-laboratory", "diamond", 99999)

  if rm.CheckIngredient("se-plasma-stream", "lithium") then
    rm.ReplaceIngredient("se-plasma-stream", "lithium", "helium", 1)
  else
    rm.ReplaceIngredient("se-plasma-stream", "stone", "helium", 2)
  end

  rm.multiply("se-gammaray-detector", 4, true, true, true)
  rm.AddIngredient("se-gammaray-detector", "spectroscope", 1)

  rm.AddIngredient("se-space-telescope", "spectroscope", 10)
  rm.AddIngredient("se-space-telescope-microwave", "spectroscope", 30)
  rm.AddIngredient("se-space-telescope-xray", "spectroscope", 30)
  rm.AddIngredient("se-space-telescope-gammaray", "spectroscope", 50)
  rm.AddIngredient("se-space-telescope-radio", "spectroscope", 50)

  rm.AddIngredient("se-dynamic-emitter", "carbon-dioxide-laser", 1)

  rm.AddIngredient("se-zero-point-energy-data", "carbon-dioxide-laser", 1)
  rm.AddProductRaw("se-zero-point-energy-data", {name="carbon-dioxide-laser", type="item", amount=1, independent_probability=0.75})
  rm.AddProductRaw("se-zero-point-energy-data", {name="se-scrap", type="item", amount=10, independent_probability=0.25})

  rm.AddIngredient("se-polarisation-data", "helium-laser", 1)
  rm.AddProductRaw("se-polarisation-data", {name="helium-laser", type="item", amount=1, independent_probability=0.75})
  rm.AddProductRaw("se-polarisation-data", {name="se-scrap", type="item", amount=3, independent_probability=0.25})

  rm.AddIngredient("se-quantum-phenomenon-data", "helium-laser", 1)
  rm.AddProductRaw("se-quantum-phenomenon-data", {name="helium-laser", type="item", amount=1, independent_probability=0.75})
  rm.AddProductRaw("se-quantum-phenomenon-data", {name="se-scrap", type="item", amount=3, independent_probability=0.25})

  --beryllium
  lasermill_recipe("se-aeroframe-scaffold", {convert=true, helium=8, se_variant="space-crafting", se_tooltip_entity="se-space-assembling-machine", unlock="se-aeroframe-scaffold", icon_offset = {data.raw.item["nanotubes"] and 8 or -8, -8}})
  lasermill_recipe("se-aeroframe-bulkhead", {convert=true, helium=16, se_variant="space-crafting", se_tooltip_entity="se-space-assembling-machine", unlock="se-aeroframe-bulkhead"})
  lasermill_recipe("se-low-density-structure-beryllium", {convert=true, helium=10, se_variant="space-crafting", se_tooltip_entity="se-space-assembling-machine", unlock="se-low-density-structure-beryllium", icon_offset = {data.raw.item["nanotubes"] and 8 or -8, -8}})

  --iridium
  lasermill_recipe("se-heavy-girder", {convert=true, helium=4, se_variant="space-crafting", se_tooltip_entity="se-space-assembling-machine", unlock="se-heavy-girder"})
  lasermill_recipe("se-heavy-composite", {convert=true, helium=25, se_variant="space-crafting", se_tooltip_entity="se-space-assembling-machine", unlock="se-heavy-composite"})

  --heatshield
  tf.addPrereq("laser-mill", "se-heat-shielding")
  lasermill_recipe("se-heat-shielding-iridium", {helium=3, unlock="se-heat-shielding-iridium", icon_offset = {8, -8}})
end
