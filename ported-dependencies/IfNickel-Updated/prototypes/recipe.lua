local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")

local yield = 1
local cost = 1

if mods["Krastorio2"] then
  yield = 5
  cost = 10
  if mods["space-exploration"] then
    yield = 15
    cost = 20
  end
end

data:extend({
  {
    type = "recipe",
    name = "invar-valve",
    categories = { "advanced-crafting" },
    enabled = false,
    energy_required = 3,
    ingredients = tf.compilePrereqs{{type="item", name="invar-plate", amount=1}, {type="item", name="pipe", amount=2}, parts.preferred({"airtight-seal", "brass-plate", "copper-plate"}, {1, 2, 2})},
    results = {{type="item", name="invar-valve", amount=1}},
  }

})

for k, v in pairs(data.raw["technology"]) do
  tf.removeRecipeUnlock(v.name, "iron-stick")
end
data.raw.recipe["iron-stick"].enabled = true
if not mods["aai-industry"] then
  if parts.bz.aluminum then
    data:extend({
      {
        type = "recipe",
        name = "motor",
        categories = { "crafting" },
        energy_required = 1,
        ingredients = {{type="item", name="nickel-plate", amount=4}, {type="item", name="iron-stick", amount=2}, {type="item", name="aluminum-cable", amount=1}},
        results = {{type="item", name="motor",amount=2}},
      }
    })
  else
    data:extend({
      {
        type = "recipe",
        name = "motor",
        categories = { "crafting" },
        energy_required = 0.5,
        ingredients = {{type="item", name="nickel-plate", amount=2}, {type="item", name="iron-stick", amount=1}, {type="item", name="copper-cable", amount=2}},
        results = {{type="item", name="motor", amount=1}},
      }
    })
  end
end

if not mods["galdocs-manufacturing"] then
  data:extend({
    {
      type = "recipe",
      name = "nickel-plate",
      categories = { "smelting" },
      energy_required = 3.2 * yield,
      ingredients = {{type="item", name="nickel-ore", amount=cost}},
      results = {{type="item", name="nickel-plate", amount=yield}},
    }
  })
  if parts.foundryEnabled or mods["Krastorio2"] then
    data:extend({
      {
        type = "recipe",
        name = "invar-plate",
        categories = { parts.foundryEnabled and "founding" or "smelting" },
        enabled = false,
        energy_required = 6.4,
        ingredients = {{type="item", name="iron-plate", amount=2}, {type="item", name="nickel-plate", amount=2}},
        results = {{type="item", name="invar-plate", amount=1}},
      }
    })
  else
    data:extend({
      {
        type = "recipe",
        name = "invar-precursor",
        categories = { "crafting" },
        enabled = false,
        energy_required = 0.5,
        ingredients = {{type="item", name="iron-plate", amount=2}, {type="item", name="nickel-plate", amount=2}},
        results = {{type="item", name="invar-precursor", amount=1}},
      },
      {
        type = "recipe",
        name = "invar-plate",
        categories = { "smelting" },
        energy_required = 6.4,
        enabled = false,
        ingredients = {{type="item", name="invar-precursor", amount=1}},
        results = {{type="item", name="invar-plate", amount=1}},
      }
    })
    tf.addRecipeUnlock("invar-processing", "invar-precursor")
  end
end

if parts.experimental then
  data:extend({
    {
      type = "recipe",
      name = "motorized-articulator",
      categories = { "crafting" },
      energy_required = 2,
      enabled = false,
      ingredients = tf.compilePrereqs{parts.preferred({"electric-motor", "motor"}, {2, 2}), {type="item", name="electronic-circuit", amount=1}, parts.preferred({"articulated-mechanism", "kr-inserter-parts", "iron-gear-wheel"},
        {2, 1, 2}), parts.optionalIngredient("bronze-plate", 2)},
      results = {{type="item", name="motorized-articulator", amount=1}},
    },
    {
      type = "recipe",
      name = "cooling-fan",
      categories = { "advanced-crafting" },
      energy_required = 2,
      enabled = false,
      ingredients = {parts.preferred({"electric-motor", "motor"}, {1, 1}), {type="item", name="plastic-bar", amount=4}},
      results = {{type="item", name="cooling-fan", amount=1}},
    },
    {
      type = "recipe",
      name = "gimbaled-thruster",
      categories = { "crafting" },
      energy_required = 30,
      enabled = false,
      ingredients = tf.compilePrereqs{{type="item", name="motorized-articulator", amount=1}, {type="item", name="invar-valve", amount=1}, parts.preferred({"rocket-engine-nozzle", "se-heat-shielding", "invar-plate"}, {2, 1, 2}), 
        parts.preferred({"complex-joint", "bearing", "iron-gear-wheel"}, {1, 2, 4})},
      results = {{type="item", name="gimbaled-thruster", amount=1}},
    },
    {
      type = "recipe",
      name = "flow-controller",
      categories = { "crafting" },
      energy_required = 2,
      enabled = false,
      ingredients = tf.compilePrereqs{parts.preferred({"electric-motor", "motor"}, {1, 1}), {type="item", name="invar-valve", amount=1}, {type="item", name="electronic-circuit", amount=1}, 
        parts.preferred({"tinned-cable", mods["Krastorio2"] and "kr-glass" or "glass"}, {2, 1})},
      results = {{type="item", name="flow-controller", amount=1}},
    }
  })

  if mods["LunarLandings"] then
    data:extend({
      {
        type = "recipe",
        name = "pack-gimbaled-thruster",
        categories = { "crafting" },
        energy_required = 2,
        enabled = false,
        icon = "__IfNickel-Updated__/graphics/icons/gimbaled-thruster-packed.png",
        icon_size = 64,
        subgroup = "ll-packed-rocket-ingredients",
        localised_name = {"recipe-name.pack-gimbaled-thruster"},
        order = "za",
        ingredients = {{type="item", name="gimbaled-thruster", amount=5}},
        results = {{type="item", name="gimbaled-thruster-packed", amount=1}}
      },
      {
        type = "recipe",
        name = "unpack-gimbaled-thruster",
        categories = { "crafting" },
        energy_required = 2,
        enabled = false,
        icon = "__IfNickel-Updated__/graphics/icons/gimbaled-thruster-packed.png",
        icon_size = 64,
        subgroup = "ll-packed-rocket-ingredients",
        localised_name = {"recipe-name.unpack-gimbaled-thruster"},
        order = "zb",
        ingredients = {{type="item", name="gimbaled-thruster-packed", amount=1}},
        results = {{type="item", name="gimbaled-thruster", amount=5}}
      }
    })
  end

  if not mods["galdocs-manufacturing"] then
    data:extend({
      {
        type = "recipe",
        name = "machining-tool",
        categories = { "crafting" },
        energy_required = 2,
        enabled = false,
        ingredients = tf.compilePrereqs{parts.preferred({"electric-motor", "motor"}, {1, 1}), {type="item", name="motorized-articulator", amount=1}, parts.preferred({"tungsten-carbide", "steel-plate"}, {2, 1})},
        results = {{type="item", name="machining-tool", amount=1}},
      },
      {
        type = "recipe",
        name = "advanced-machining-tool",
        categories = { "crafting" },
        energy_required = 4,
        enabled = false,
        ingredients = tf.compilePrereqs{{type="item", name="machining-tool", amount=1}, parts.optionalIngredient("diamond", 1), parts.preferred({"complex-joint", "bearing", "iron-gear-wheel"}, {1, 2, 4}), {type="item", name="speed-module", amount=1}},
        results = {{type="item", name="advanced-machining-tool", amount=1}},
      }
    })
  end

  if mods["space-exploration"] then
    data:extend({
      {
        type = "recipe",
        name = "nickel-electromagnet",
        categories = { "crafting" },
        energy_required = 2,
        enabled = false,
        ingredients = {{type="item", name="electronic-circuit", amount=1}, {type="item", name="nickel-plate", amount=4}, {type="item", name="copper-cable", amount=4}},
        results = {{type="item", name="nickel-electromagnet",amount=4}}
      },
      {
        type = "recipe",
        name = "advanced-flow-controller",
        categories = { "crafting" },
        energy_required = 8,
        enabled = false,
        allow_decomposition = false,
        ingredients = tf.compilePrereqs{{type="item", name="flow-controller", amount=2}, {type="item", name="invar-valve", amount=2}, {type="item", name="advanced-circuit", amount=1}, parts.preferred({"kr-steel-pipe", "pipe"}, {4, 10})},
        results = {{type="item", name="advanced-flow-controller", amount=1}},
      },
      {
        type = "recipe",
        name = "flow-controller-biological",
        categories = { "advanced-crafting" },
        icons = {
          {
            icon = "__IfNickel-Updated__/graphics/icons/flow-controller.png",
            icon_size = 64
          },
          {
            icon = "__space-exploration-graphics__/graphics/icons/vitamelange-bloom.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          },
         },
        energy_required = 9,
        enabled = false,
        allow_decomposition = false,
        ingredients = tf.compilePrereqs{{type="item", name="electric-motor", amount=1}, {type="item", name="invar-valve", amount=3}, {type="item", name="electronic-circuit", amount=1}, {type="item", name="se-vitamelange-bloom", amount=2},
          parts.preferred({"tinned-cable", mods["Krastorio2"] and "kr-glass" or "glass"}, {3, 3})},
        results = {{type="item", name="flow-controller", amount=3}},
        main_product = "flow-controller"
      },
      {
        type = "recipe",
        name = "advanced-flow-controller-biological",
        categories = { "advanced-crafting" },
        icons = {
          {
            icon = "__IfNickel-Updated__/graphics/icons/advanced-flow-controller.png",
            icon_size = 64
          },
          {
            icon = "__space-exploration-graphics__/graphics/icons/vitamelange-bloom.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          },
         },
        energy_required = 30,
        enabled = false,
        ingredients = tf.compilePrereqs{{type="item", name="flow-controller", amount=6}, parts.preferred({"self-regulating-valve", "invar-valve"}, {2, 2}), {type="item", name="advanced-circuit", amount=1}, 
          parts.preferred({"kr-steel-pipe", "pipe"}, {12, 30}), {type="item", name="se-vitamelange-bloom", amount=5}},
        results = {{type="item", name="advanced-flow-controller", amount=3}},
        main_product = "advanced-flow-controller"
      }
    })
  end
end

if mods["Krastorio2"] then
  local matterutil = require("__Krastorio2__/prototypes/libraries/matter")
  data:extend(
    {
      {
        type = "recipe",
        name = "enriched-nickel",
        categories = { "chemistry" },
        energy_required = 3,
        ingredients = {{type="item", name="nickel-ore", amount=9}, {type="fluid", name="sulfuric-acid", amount=3}, {type="fluid", name="water", amount=25, ignored_by_stats = 25}},
        results = {{type="item", name="enriched-nickel", amount=mods["space-exploration"] and 9 or 6}, {type="fluid", name="kr-dirty-water", amount=25, ignored_by_productivity=25, ignored_by_stats=25}},
        main_product = "enriched-nickel",
        enabled = false,
        crafting_machine_tint = {
          primary = {r = 0.0, g = 0.0, b = 1, a = 1.0},
    			secondary = {r = 0.8, g = 0.8, b = 1.0, a = 1.0},
    			tertiary = {r = 0.0, g = 0.0, b = 1.0, a = 1.0},
    			quaternary = {r = 0.7, g = 0.7, b = 1.0, a = 0.5}
        }
      },
      {
        type = "recipe",
        name = "enriched-nickel-plate",
        icons = {
          { icon = "__IfNickel-Updated__/graphics/icons/nickel-plate.png", icon_size = 64 },
          { icon = "__IfNickel-Updated__/graphics/icons/enriched-nickel.png", icon_size = 64, scale=0.25, shift= {-8, -8}},
        },
        categories = { "smelting" },
        energy_required = 16,
        ingredients = {{type="item", name="enriched-nickel", amount=5}},
        results = {{type="item", name="nickel-plate",amount=5}},
        enabled = false
      },
      {
    		type = "recipe",
    		name = "dirty-water-filtration-nickel",
        subgroup = "raw-material",
    		order = "w013[dirty-water-filtration-zinc]",
    		categories = { "kr-fluid-filtration" },
    		icons =
    		{
    			{
    				icon = data.raw.fluid["kr-dirty-water"].icon,
    				icon_size = data.raw.fluid["kr-dirty-water"].icon_size
    			},
    			{
    				icon = "__IfNickel-Updated__/graphics/icons/nickel-ore.png",
    				icon_size =	64,
    				scale = 0.2,
    				shift = {0, 4}
    			}
    		},
    		energy_required = 2,
    		ingredients = { {type = "fluid", name = "kr-dirty-water", amount = 100, ignored_by_stats = 100} },
    		results =	{ {type = "fluid", name = "water", amount = 90, ignored_by_productivity=90, ignored_by_stats = 90}, {type = "item",  name = "stone", independent_probability = 0.3, amount = 1}, {type = "item",  name = "nickel-ore", independent_probability = 0.1, amount = 1},
    		},
    		crafting_machine_tint =
    		{
    			primary = {r = 0.0, g = 0.0, b = 0.9, a = 0.9},
          secondary = {r = 0.66, g = 0.66, b = 1, a = 0.6}
    		},
        enabled = false
    	}
    }
  )
  matterutil.make_recipes({
    material = {type = "item", name = "nickel-ore", amount=10},
    matter_count = 5,
    energy_required = 1,
    needs_stabilizer = false,
    unlocked_by = "kr-matter-nickel-processing"
  })
  matterutil.make_deconversion_recipe({
    material = {type = "item", name = "nickel-plate", amount=10},
    matter_count = mods["space-exploration"] and 7.5 or 10,
    energy_required = 3,
    needs_stabilizer = true,
    unlocked_by = "kr-matter-nickel-processing"
  })
  local material_name = "nickel-ore"
  if mods["space-exploration"] then
    rm.AddIngredient("kr-matter-to-" .. material_name, "se-kr-charged-basic-stabilizer", 1)
    rm.AddProductRaw("kr-matter-to-" .. material_name, { type = "item", name = "se-kr-charged-basic-stabilizer", amount = 1, independent_probability = 0.199 })
    rm.AddProductRaw("kr-matter-to-" .. material_name, { type = "item", name = "se-kr-basic-stabilizer", amount = 1, independent_probability = 0.8 })
  end
end

if mods["space-exploration"] then
  se_delivery_cannon_recipes["nickel-ore"] = {name= "nickel-ore"}
  se_delivery_cannon_recipes["nickel-plate"] = {name= "nickel-plate"}
  se_delivery_cannon_recipes["nickel-ingot"] = {name= "nickel-ingot"}
  se_delivery_cannon_recipes["invar-plate"] = {name= "invar-plate"}
  se_delivery_cannon_recipes["invar-ingot"] = {name= "invar-ingot"}
  if mods["Krastorio2"] then
    se_delivery_cannon_recipes["enriched-nickel"] = {name= "enriched-nickel"}
  end
  if parts.nitinol then
    se_delivery_cannon_recipes["nitinol-plate"] = {name= "nitinol-plate"}
  end

  data:extend(
    {
      {
        type = "recipe",
        icon = "__IfNickel-Updated__/graphics/icons/molten-nickel.png",
        icon_size = 64,
        subgroup = "nickel",
        name = "molten-nickel",
        categories = { "smelting" },
        energy_required = 60,
        ingredients = {{type="item", name=mods["Krastorio2"] and "enriched-nickel" or "nickel-ore", amount=24}, {type="fluid", name="se-pyroflux", amount=10}},
        results = {{type="fluid", name="molten-nickel", amount= mods["Krastorio2"] and 750 or 900}},
        enabled = false
      },
      {
        type = "recipe",
        name = "nickel-ingot",
        categories = { "casting" },
        energy_required = 25,
        ingredients = {{type="fluid", name="molten-nickel", amount=250}},
        results = {{type="item", name="nickel-ingot",amount=1}},
        enabled = false
      },
      {
        type = "recipe",
        name = "nickel-ingot-to-plate",
        icons = {
          { icon = "__IfNickel-Updated__/graphics/icons/nickel-plate.png", icon_size = 64 },
          { icon = "__IfNickel-Updated__/graphics/icons/nickel-ingot.png", icon_size = 64, scale=0.25, shift= {-8, -8}},
        },
        categories = { "crafting" },
        energy_required = 5,
        ingredients = {{type="item", name="nickel-ingot", amount=1}},
        results = {{type="item", name="nickel-plate",amount=10}},
        allow_decomposition = false,
        enabled = false
      },
      {
        type = "recipe",
        name = "invar-ingot",
        categories = { "casting" },
        energy_required = 50,
        ingredients = {{type="fluid", name="se-molten-iron", amount=500}, {type="item", name="nickel-ingot", amount=2}},
        results = {{type="item", name="invar-ingot",amount=1}},
        enabled = false
      },
      {
        type = "recipe",
        name = "invar-ingot-to-plate",
        icons = {
          { icon = "__IfNickel-Updated__/graphics/icons/invar-plate.png", icon_size = 64 },
          { icon = "__IfNickel-Updated__/graphics/icons/invar-ingot.png", icon_size = 64, scale=0.25, shift= {-8, -8}},
        },
        categories = { "crafting" },
        energy_required = 5,
        ingredients = {{type="item", name="invar-ingot", amount=1}},
        results = {{type="item", name="invar-plate",amount=10}},
        allow_decomposition = false,
        enabled = false
      }
    }
  )
end

if parts.nitinol then
  if parts.foundryEnabled or mods["Krastorio2"] then
    data:extend({
      {
        type = "recipe",
        name = "nitinol-plate",
        categories = { parts.foundryEnabled and "founding" or "smelting" },
        energy_required = 16,
        ingredients = {{type="item", name="nickel-plate", amount=3}, {type="item", name="titanium-plate", amount=1}},
        results = {{type="item", name="nitinol-plate", amount=2}},
        enabled = false,
      }
    })
  else
    data:extend({
      {
        type = "recipe",
        name = "nitinol-precursor",
        categories = { "crafting" },
        energy_required = 0.5,
        ingredients = {{type="item", name="nickel-plate", amount=3}, {type="item", name="titanium-plate", amount=1}},
        results = {{type="item", name="nitinol-precursor", amount=2}},
        enabled = false,
      },
      {
        type = "recipe",
        name = "nitinol-plate",
        categories = { "smelting" },
        energy_required = 8,
        ingredients = {{type="item", name="nitinol-precursor", amount=1}},
        results = {{type="item", name="nitinol-plate", amount=1}},
        enabled = false,
      },
    })
  end
  data:extend({
    {
      type = "recipe",
      name = "nitinol-plate-space",
      categories = { "space-thermodynamics" },
      icons = {
        {
          icon = "__IfNickel-Updated__/graphics/icons/nitinol-plate.png",
          icon_size = 64
        },
        {
          icon = "__space-exploration-graphics__/graphics/icons/astronomic/planet-orbit.png",
          icon_size = 64,
          scale = 0.25,
          shift = {-8, -8}
        }
      },
      energy_required = 32,
      ingredients = {{type="item", name="nickel-plate", amount=3}, {type="item", name="titanium-plate", amount=1}},
      results = {{type="item", name="nitinol-plate", amount=4}},
      enabled = false,
    },
    {
      type = "recipe",
      name = "self-regulating-valve",
      categories = { "advanced-crafting" },
      energy_required = 8,
      ingredients = tf.compilePrereqs{{type="item", name="nitinol-plate", amount=1}, {type="item", name="invar-valve", amount=1}, parts.preferred({"titanium-palladium-flange", "titanium-plate"}, {2, 2})},
      results = {{type="item", name="self-regulating-valve", amount=2}},
      enabled = false,
    },
    {
      type = "recipe",
      name = "nitinol-mesh",
      categories = { "advanced-crafting" },
      energy_required = 8,
      ingredients = tf.compilePrereqs{{type="item", name="nitinol-plate", amount=3}, parts.preferred({"aluminum-2219", "iron-stick"}, {2, 4}), parts.preferred({"carbon-fiber", "plastic-bar"}, {2, 2})},
      results = {{type="item", name="nitinol-mesh", amount=2}},
      enabled = false,
      lasermill = {
        convert = true,
        helium = 3,
        se_variant = "space-crafting",
        unlock = "se-space-assembling",
        se_tooltip_entity = "se-space-assembling-machine",
        icon_offset = {8, -8}
      }
    },
    {
      type = "recipe",
      name = "nitinol-mesh-beryllium",
      categories = { "advanced-crafting" },
      icons = {
        {
          icon = "__IfNickel-Updated__/graphics/icons/nitinol-mesh.png",
          icon_size = 64
        },
        {
          icon = "__space-exploration-graphics__/graphics/icons/beryllium-plate.png",
          icon_size = 64,
          scale = 0.25,
          shift = {-8, -8}
        }
      },
      energy_required = 24,
      ingredients = tf.compilePrereqs{{type="item", name="nitinol-plate", amount=6}, {type="item", name="se-beryllium-plate", amount=1}, parts.preferred({"carbon-fiber", "plastic-bar"}, {4, 4})},
      results = {{type="item", name="nitinol-mesh", amount=6}},
      enabled = false,
      lasermill = {
        convert = true,
        helium = 9,
        se_variant = "space-crafting",
        unlock = "nitinol-mesh-beryllium",
        se_tooltip_entity = "se-space-assembling-machine",
        icon_offset = {8, -8}
      }
    }
  })
  if mods["LasingAround-Updated"] then
    data:extend({
      {
        type = "recipe",
        name = "nitinol-plate-helium",
        categories = { "smelting" },
        icons = {
          {
            icon = "__IfNickel-Updated__/graphics/icons/nitinol-plate.png",
            icon_size = 64
          },
          {
            icon = "__LasingAround-Updated__/graphics/icons/helium.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          }
        },
        energy_required = 32,
        ingredients = {{type="item", name="nickel-plate", amount=3}, {type="item", name="titanium-plate", amount=1}, {type="fluid", name="helium", amount=6}},
        results = {{type="item", name="nitinol-plate", amount=4}},
        enabled = false,
      }
    })
  end
end

if mods["FreightForwarding"] then
  data:extend({
    {
      type = "recipe",
      name = "meteoric-nodule-dredging",
      categories = { "ff-dredging" },
      energy_required = 50,
      ingredients = {},
      results = {{type="item", name="meteoric-nodule", amount_min=100, amount_max=200}},
      enabled = false
    },
    {
      type = "recipe",
      name = "meteoric-nodule-washing",
      categories = { "chemistry" },
      energy_required = 15,
      allow_decomposition = false,
      ingredients = {{type="item", name="meteoric-nodule", amount=18}, {type="fluid", name="sulfuric-acid", amount=15}},
      results = {{type="item", name="nickel-ore", amount_min=40, amount_max=50}, {type="item", name="iron-ore", amount_min=0, amount_max=8}, {type="item", name="stone", amount_min=0, amount_max=4}, 
        {type="item", name="meteoric-nodule", amount_min=0, amount_max=6}},
      main_product = "nickel-ore",
      enabled = false,
      crafting_machine_tint = {
        primary = {r = 0.0, g = 0.0, b = 1, a = 1.0},
        secondary = {r = 0.8, g = 0.8, b = 1.0, a = 1.0},
        tertiary = {r = 0.0, g = 0.0, b = 1.0, a = 1.0},
        quaternary = {r = 0.7, g = 0.7, b = 1.0, a = 0.5}
      }
    }
  })
end

if mods["248k-Redux"] then
  data:extend({
    {
      type = "recipe",
      name = "248k-nickel-atom-hot",
      categories = { "fu_star_engine_core_crafting_category" },
      energy_required = 1,
      ingredients = {{type="fluid", name="fu_protium_heated", amount=30000}},
      results = {{type="fluid", name="248k-nickel-atom-hot", amount=1000}},
      subgroup = "fu_star_engine_subgroup_b",
      enabled=false
    },
    {
      type = "recipe",
      name = "248k-nickel-atom",
      categories = { "fu_star_engine_cooler_crafting_category" },
      energy_required = 1,
      ingredients = {{type="fluid", name="248k-nickel-atom-hot", amount=500}},
      results = {{type="fluid", name="248k-nickel-atom", amount=500}},
      subgroup = "fu_star_engine_subgroup_c",
      enabled=false
    },
    {
      type = "recipe",
      name = "nickel-from-atoms",
      categories = { "crafting-with-fluid" },
      energy_required = 6,
      ingredients = {{type="fluid", name="248k-nickel-atom", amount=500}},
      results = {{type="item", name="nickel-plate",amount=500}},
      subgroup = "fu_star_engine_subgroup_d",
      enabled=false
    },
    {
      type = "recipe",
      name = "invar-from-atoms",
      categories = { "chemistry" },
      energy_required = 6,
      ingredients = {{type="fluid", name="248k-nickel-atom", amount=250}, {type="fluid", name="fu_iron", amount=250}},
      results = {{type="item", name="invar-plate",amount=500}},
      subgroup = "fu_star_engine_subgroup_d",
      enabled=false
    }
  })
end
