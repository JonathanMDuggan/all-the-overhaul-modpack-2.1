local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")
local cu = require("category-utils")

if mods["248k-Redux"] then
  --electronic era
  if parts.experimental then
    rm.ReplaceIngredient("fu_burner", "electronic-circuit", "flow-controller", 5)
    rm.ReplaceIngredient("el_grower", "iron-gear-wheel", "invar-valve", 10)
    rm.RemoveIngredient("el_grower", "electronic-circuit", 10)
  else
    rm.AddIngredient("fu_burner", "invar-valve", 5)
    rm.ReplaceIngredient("el_grower", "iron-gear-wheel", "invar-valve", 10)
  end

  rm.ReplaceIngredient("el_burner", "electronic-circuit", parts.motor, 10)
  rm.RemoveIngredient("el_burner_kerosene", "pipe", 10)
  rm.AddIngredient("el_burner_kerosene", "invar-valve", 5)
  if not mods["BrassTacks-Updated"] then
    rm.ReplaceProportional("el_burner_kerosene", "pipe", "engine-unit", 0.5)
  end
  rm.RemoveIngredient("fu_burner", "pipe", 10)

  rm.ReplaceIngredient("el_arc_furnace", "steel-plate", "invar-plate", 5)
  rm.ReplaceIngredient("el_caster", "steel-plate", "invar-plate", 5)
  rm.ReplaceIngredient("el_caster", "electronic-circuit", parts.motor, 10)

  rm.ReplaceIngredient("el_pressurizer", "electronic-circuit", parts.motor, 10)
  rm.ReplaceIngredient("el_pressurizer", "iron-gear-wheel", "invar-valve", 10)

  if parts.brassExperiment then
    rm.ReplaceIngredient("el_purifier", "electronic-circuit", parts.motor, 5)
  else
    rm.ReplaceIngredient("el_purifier", "iron-gear-wheel", parts.motor, 10)
  end

  rm.ReplaceIngredient("el_water_generator", "electronic-circuit", parts.motor, 20)

  --fission era
  if not mods["space-exploration"] then
    --who allowed a mixture of hyphens and underscores. killing and biting
    rm.AddIngredient("fi_low-density-structure", "invar-plate", 2)
  end
  if not parts.brassExperiment then
    rm.ReplaceIngredient("fi_solid_reactor", "steel-plate", "invar-plate", 100)
  end

  if parts.experimental then
    rm.RemoveIngredient("fi_crafter", "iron-gear-wheel", 10)
    rm.AddIngredient("fi_crafter", "machining-tool", 2)
    if mods["space-exploration"] then
      rm.AddIngredient("fi_refinery", "advanced-flow-controller", 10)
    else
      rm.AddIngredient("fi_refinery", "flow-controller", 20)
    end
  else
    rm.AddIngredient("fi_refinery", "invar-valve", 20)
  end

  if (mods["aai-industry"] or mods["ThemTharHills-Updated"]) and not mods["BrassTacks-Updated"] then
    rm.ReplaceProportional("fi_crusher", "engine-unit", "electric-engine-unit", 0.67)
    rm.ReplaceProportional("fi_fiberer", "engine-unit", "electric-engine-unit", 0.67)
    rm.ReplaceProportional("fi_compound_machine", "engine-unit", "electric-engine-unit", 0.67)
    tf.removePrereq("electric-engine", "fi_caster_tech")
    tf.addPrereq("fi_crusher_tech", "electric-engine")
  end

  --fusion era
  if data.raw.item["nickel-electromagnet"] then
    rm.AddIngredient("fu_activator", "nickel-electromagnet", 10)
    rm.AddIngredient("fu_magnet", "nickel-electromagnet", 50)
    rm.AddIngredient("fu_plasma", "nickel-electromagnet", 50)
    rm.AddIngredient("fu_materials_magnet", "nickel-electromagnet", 1)
    rm.AddProductRaw("fu_materials_magnet", {type="item", name="nickel-electromagnet", amount=1, independent_probability=0.75, ignored_by_productivity=1, ignored_by_stats=1})
    if data.raw["assembling-machine"]["fu_magnet"] then
      data.raw["assembling-machine"]["fu_magnet"].ingredient_count = nil
    end
  end

  if parts.experimental then
    if mods["space-exploration"] then
      if parts.bz.titanium then
        rm.AddIngredient("fu_turbine", "self-regulating-valve", 20)
        rm.AddIngredient("fu_boiler", "self-regulating-valve", 20)
        rm.AddIngredient("fu_exchanger", "self-regulating-valve", 20)
      else
        rm.AddIngredient("fu_turbine", "advanced-flow-controller", 1)
        rm.AddIngredient("fu_boiler", "advanced-flow-controller", 1)
        rm.AddIngredient("fu_exchanger", "advanced-flow-controller", 1)
      end
    else
      rm.AddIngredient("fu_turbine", "invar-valve", 20)
      rm.AddIngredient("fu_boiler", "flow-controller", 20)
      rm.AddIngredient("fu_exchanger", "flow-controller", 20)
    end
    rm.AddIngredient("fu_space_probe_probe", "gimbaled-thruster", 25)
    rm.AddIngredient("fu_space_probe_deep_probe", "gimbaled-thruster", 50)

    rm.AddIngredient("gr_crafter", "advanced-machining-tool", 10)
  else
    rm.AddIngredient("fu_turbine", "invar-valve", 20)
    rm.AddIngredient("fu_boiler", "invar-valve", 20)
    rm.AddIngredient("fu_exchanger", "invar-valve", 20)
  end
end
