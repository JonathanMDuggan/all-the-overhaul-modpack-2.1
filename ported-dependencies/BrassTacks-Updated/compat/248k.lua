local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")
local cu = require("category-utils")

local advfitting = "bolted-flange"
if parts.bz.carbon or mods["BrimStuff-Updated"] then
  advfitting = "airtight-seal"
end

if mods["248k-Redux"] then
  -- electric era
  if parts.experimental then
    rm.ReplaceIngredient("gearbox", "galvanized-steel-plate", "el_ALK", mods["Krastorio2"] and 4 or 2)
    rm.RemoveIngredient("fast-transport-belt", "el_ALK", 1)
    rm.RemoveIngredient("fast-splitter", "el_ALK", 3)
    rm.RemoveIngredient("fast-underground-belt", "el_ALK", 8)
    rm.RemoveIngredient("kr-fast-loader", "el_ALK", 4)

    rm.AddIngredient("el_burner_kerosene", "flywheel", 5)

    rm.RemoveIngredient("el_arc_furnace", "steel-plate", 20)
    rm.AddIngredient("el_arc_furnace", "hardened-hull", 10)

    rm.RemoveIngredient("el_caster", "steel-plate", 20)
    rm.AddIngredient("el_caster", "hardened-hull", 10)

    rm.ReplaceIngredient("el_purifier", "iron-gear-wheel", "articulated-mechanism", 20)

    rm.ReplaceProportional("el_diesel_train", "iron-gear-wheel", "gearbox", 0.2)
  end

  rm.RemoveIngredient("el_burner_kerosene", "pipe", 10)
  rm.AddIngredient("el_burner_kerosene", "engine-unit", 5)

  rm.AddIngredient("el_tank", "bolted-flange", 8)

  --fission era
  if parts.experimental then
    rm.ReplaceIngredient("fi_crafter", "iron-gear-wheel", "complex-joint", 10)
    rm.AddIngredient("fi_castor", "hardened-hull", 20)
    rm.AddIngredient("fu_miner", "hardened-hull", 20)
    rm.AddIngredient("fi_crusher", "hardened-hull", 10)

    rm.ReplaceProportional("fi_solid_reactor", "steel-plate", "hardened-hull", 0.5)
  else
    rm.ReplaceIngredient("fi_crafter", "iron-gear-wheel", "bearing", 10)
  end

  rm.ReplaceIngredient("fi_crusher", "iron-gear-wheel", "bearing", 10)
  rm.ReplaceIngredient("fi_fiberer", "iron-gear-wheel", "bearing", 10)
  rm.ReplaceIngredient("fi_compound_machine", "iron-gear-wheel", "bearing", 10)

  rm.AddIngredient("fi_empty_solution", advfitting, 1)

  if mods["aai-industry"] or mods["ThemTharHills-Updated"] then
    rm.ReplaceProportional("fi_crusher", "engine-unit", "electric-engine-unit", 0.67)
    rm.ReplaceProportional("fi_fiberer", "engine-unit", "electric-engine-unit", 0.67)
    rm.ReplaceProportional("fi_compound_machine", "engine-unit", "electric-engine-unit", 0.67)
    tf.removePrereq("electric-engine", "fi_caster_tech")
    tf.addPrereq("fi_crusher_tech", "electric-engine")
  else
    tf.addPrereq("fi_crusher_tech", "lubricant")
  end

  if parts.drill then
    rm.ReplaceIngredient("fu_miner_fuel", "tungsten-carbide", "industrial-drill-head", 1)
    rm.AddIngredient("fu_miner_fuel", "fi_GFK", 3)
    data.raw.item["fu_miner_fuel"].fuel_value = "320MJ"
  end

  --fusion era
  --there are several expensive and high tech construction materials by this point. hardened hulls are sort of obsolete
  --also most new machines at this stage are mega energy tech and don't have mechanisms
  if parts.experimental then
    rm.AddIngredient("fu_robo_logistic", "complex-joint", 1)
    rm.AddIngredient("fu_robo_construction", "complex-joint", 1)

    if parts.gyroscope then
      rm.AddIngredient("gr_magnet_train_pre", parts.gyroscope, 10)
      rm.AddIngredient("gr_magnet_wagon_pre", parts.gyroscope, 1)
      rm.AddIngredient("gr_magnet_tanker_pre", parts.gyroscope, 1)
    end

    rm.AddIngredient("fu_turbine", "advanced-gearbox", 10)
  end

  if mods["Krastorio2"] then
    rm.RemoveIngredient("gr_wheel", "fu_iron", 99999)
    data.raw.recipe["gr_wheel"].categories = { "chemistry" }
    rm.AddIngredient("gr_wheel", "fu_copper", 250)
    rm.AddIngredient("gr_wheel", "248k-zinc-atom", 250)
  else
    data.raw.recipe["gr_wheel"].categories = { "fi_refining" }
    rm.RemoveIngredient("gr_wheel", "fu_iron", 250)
    rm.AddIngredient("gr_wheel", "fu_copper", 125)
    rm.AddIngredient("gr_wheel", "248k-zinc-atom", 125)
  end

end
