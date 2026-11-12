local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")

if mods["248k-Redux"] then
  rm.ReplaceProportional("el_kerosene", "crude-oil", "filtered-oil", 1)
  rm.ReplaceProportional("el_kerosene_basic", "crude-oil", "filtered-oil", 1)

  tf.addPrereq("fi_refinery_tech", "spectroscopy")
  rm.AddIngredient("fi_refinery", "spectroscope", 10)

  tf.addPrereq("fi_ki_tech", "helium-laser")
  rm.AddIngredient("fi_ki_beacon", "helium-laser", 5)
  rm.ReplaceIngredient("fi_ki_core", "electronic-circuit", "helium-laser", 100)
  rm.AddIngredient("fu_ki_beacon", "helium-laser", 15)
  rm.ReplaceIngredient("fu_ki_core", "electronic-circuit", "helium-laser", 250)

  rm.AddIngredient("fu_laser", "spectroscope", 20)
  rm.AddIngredient("fu_laser_card", "carbon-dioxide-laser", 1)
  rm.AddProductRaw("fu_laser_card", {type="item", name="carbon-dioxide-laser", amount=1, independent_probability=0.75, ignored_by_productivity=1, ignored_by_stats=1})

  if data.raw["assembling-machine"]["fu_laser"] then
    data.raw["assembling-machine"]["fu_laser"].ingredient_count = nil
  end

  rm.AddIngredient("fu_plasma", "carbon-dioxide-laser", 10)

  rm.AddIngredient("fu_stelar_reactor", "carbon-dioxide-laser", 100)
  rm.AddIngredient("fu_tokamak_reactor", "carbon-dioxide-laser", 100)

  rm.AddIngredient("fu_fusor", "scanner", 50)
  rm.AddIngredient("gr_lab", "scanner", 50)

  if data.raw.item["micron-tolerance-components"] then
    rm.AddIngredient("fu_tech_sign", "micron-tolerance-components", 1)
  end

  if not data.raw.item["advanced-machining-tool"] then
    rm.AddIngredient("gr_crafter", "scanner", 10)
  end

  if data.raw.item["tracker"] then
    rm.AddIngredient("fu_robo_logistic", "tracker", 5)
    rm.AddIngredient("fu_robo_construction", "tracker", 5)
  end
end
