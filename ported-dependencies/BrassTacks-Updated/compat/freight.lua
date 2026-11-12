local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")

if mods["underwater-pipes"] and parts.experimental then
  rm.RemoveIngredient("underwater-pipe", "steel-plate", 999)
  rm.AddIngredient("underwater-pipe", "hardened-hull", 3)
end

if mods["IntermodalContainers"] then
  if parts.experimental then
    rm.AddIngredient("ic-container", "articulated-mechanism", 1)
    rm.AddIngredient("ic-containerization-machine-2", "gearbox", 2)
    rm.AddIngredient("ic-containerization-machine-3", "advanced-gearbox", 2)
    rm.AddIngredient("ic-containerization-machine-3", "complex-joint", 10)
  else
    rm.AddIngredient("ic-containerization-machine-3", "bearing", 10)
  end
end

if mods["cargo-ships"] and parts.experimental then
  rm.ReplaceProportional("boat", "steel-plate", "galvanized-steel-plate", 1)
  rm.ReplaceProportional("port", "steel-plate", "galvanized-steel-plate", 1)

  rm.ReplaceProportional("cargo_ship", "steel-plate", "hardened-hull", 0.5)
  rm.ReplaceProportional("oil_tanker", "steel-plate", "hardened-hull", 0.5)

  rm.AddIngredient("cargo_ship", "flywheel", 5)
  rm.AddIngredient("oil_tanker", "flywheel", 5)

  if not parts.nickelExperiment then
    rm.AddIngredient("bridge_base", "articulated-mechanism", 30)
  end
end

if mods["Mini_Trains"] and parts.experimental then
  rm.AddIngredient("mini-locomotive", "flywheel", 1)
end

if mods["FreightForwarding"] then
  rm.ReplaceProportional("cargo-wagon", "iron-gear-wheel", "bearing", 1)
  rm.ReplaceProportional("fluid-wagon", "iron-gear-wheel", "bearing", 1)

  tf.addRecipeUnlock("ff-dredging", "brazen-nodule-dredging")
  tf.addRecipeUnlock("ff-dredging", "brazen-nodule-washing")
end

if mods["ch-concentrated-solar"] then
  if parts.experimental then
    rm.ReplaceIngredient("chcs-heliostat-mirror", "steel-plate", "complex-joint", 1)
    rm.ReplaceProportional("chcs-heliostat-mirror", "steel-plate", "galvanized-steel-plate", 1)
    rm.ReplaceProportional("chcs-solar-power-tower", "steel-plate", "hardened-hull", 0.5)
    rm.ReplaceProportional("chcs-solar-laser-tower", "steel-plate", "hardened-hull", 0.5)
    rm.AddIngredient("chcs-solar-laser-tower", "complex-joint", 5)
    if parts.gyroscope then
      rm.AddIngredient("chcs-solar-laser-tower", parts.gyroscope, 1)
    end
  else
    rm.AddIngredient("chcs-solar-laser-tower", "bearing", 5)
  end
end
