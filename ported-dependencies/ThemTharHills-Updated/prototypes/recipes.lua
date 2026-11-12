local parts = require("variable-parts")
local rm = require("recipe-modify")
local tf = require("techfuncs")

for k, v in pairs(data.raw["technology"]) do
  tf.removeRecipeUnlock(v.name, "iron-stick")
end
data.raw.recipe["iron-stick"].enabled = true
data:extend({
  {
    type = "recipe",
    name = "gold-powder",
    categories = { "chemistry" },
    enabled = false,
    energy_required = 1,
    ingredients = {{type="item", name="gold-ore", amount=1}, {type="fluid", name=parts.aquaregia and "aqua-regia" or (mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid"), amount=10}},
    results = {{type="item", name="gold-powder",amount=2}},
    crafting_machine_tint = {
        primary = {0.75, 0.7, 0, 1},
        secondary = {1, 0.95, 0, 1},
        tertiary = {0.5, 0.5, 1, 1},
        quaternary = {1, 1, 1, 1}
    }
  },
  {
    type = "recipe",
    name = "trace-gold-from-copper",
    icons = {
      {
        icon = "__ThemTharHills-Updated__/graphics/icons/gold-powder.png",
        icon_size = 64
      },
      {
        icon = "__base__/graphics/icons/copper-ore.png",
        icon_size = 64,
        icon_mipmaps = 4,
        scale = 0.25,
        shift = {-8, -8}
      }
    },
    categories = { "chemistry" },
    enabled = false,
    energy_required = 3,
    localised_name = {"recipe-name.trace-gold-from-copper"},
    ingredients = {{type="item", name="copper-ore", amount=3}, {type="fluid", name=parts.aquaregia and "aqua-regia" or (mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid"), amount=30}},
    results = {{type="item", name="gold-powder", amount=1}, mods["IfNickel-Updated"] and {type="item", name="nickel-ore", amount=1, independent_probability=0.25} or nil},
    main_product = "gold-powder",
    crafting_machine_tint = {
        primary = {0.75, 0.4, 0, 1},
        secondary = {1, 0.65, 0, 1},
        tertiary = {0.5, 0.5, 1, 1},
        quaternary = {1, 1, 1, 1}
    },
    allow_decomposition = false,
    ib_badge = "Au",
    ib_corner = "right-top"
  },
  {
    type = "recipe",
    name = "gold-plate",
    categories = { "smelting" },
    enabled = false,
    energy_required = 3.2,
    ingredients = {{type="item", name="gold-powder", amount=3}},
    results = {{type="item", name=parts.gold, amount=1}},
  },
  {
    type = "recipe",
    name = "gold-wire",
    categories = { "crafting" },
    enabled = false,
    energy_required = 0.5,
    ingredients = {{type="item", name=parts.gold, amount=1}},
    results = {{type="item", name=parts.wire, amount=2}},
    lasermill = {helium=1, productivity=true, type="gubbins", multiply=2}
  },
  {
    type = "recipe",
    name = "transceiver",
    categories = { "crafting" },
    enabled = false,
    energy_required = 2,
    ingredients = tf.compilePrereqs{{type="item", name="electronic-circuit", amount=3}, {type="item", name=parts.wire, amount=5}, 
      parts.preferred({"kr-quartz", "silica", "iron-stick"}, {1, 1, 1}), parts.preferred({"pcb-solder", "solder"}, {1, 1})},
    results = {{type="item", name="transceiver", amount=1}},
  },
  {
    type = "recipe",
    name = "advanced-cable",
    categories = { "advanced-crafting" },
    enabled = false,
    energy_required = 3,
    ingredients = {parts.preferred({"silver-wire", "tinned-cable", "copper-cable"}, {3, 1, 1}), {type="item", name=parts.wire, amount=6}, {type="item", name="plastic-bar", amount=3}},
    results = {{type="item", name="advanced-cable", amount=1}},
  },
  {
    type = "recipe",
    name = "hv-power-regulator",
    categories = { "crafting" },
    enabled = false,
    energy_required = 6,
    ingredients = tf.compilePrereqs{{type="item", name="advanced-circuit", amount=5}, {type="item", name="advanced-cable", amount=2}, {type="item", name="battery", amount=2}, 
      parts.preferred({"cooling-fan", "aluminum-plate", "galvanized-steel-plate", "steel-plate"}, {1, 5, 1, 1}), parts.optionalIngredient("el_energy_crystal", 1), parts.optionalIngredient("acsr-cable", 1)},
    results = {{type="item", name="hv-power-regulator", amount=1}},
  },
  {
    type = "recipe",
    name = "integrated-circuit",
    categories = { "advanced-crafting" },
    enabled = false,
    energy_required = 1,
    ingredients = tf.compilePrereqs{{type="item", name="plastic-bar", amount=1}, {type="item", name=parts.gold, amount=2}, parts.preferred({"ll-silicon", "silicon-wafer", mods["Krastorio2"] and "kr-silicon" or "silicon", "copper-plate"}, {2, 1, 2, 2})},
    results = {{type="item", name="integrated-circuit",amount=2}},
  }
}
)

if parts.aquaregia then
  data:extend({
    {
      type = "recipe",
      name = "aqua-regia",
      categories = { "chemistry" },
      enabled = false,
      energy_required = 1,
      subgroup = "fluid-recipes",
      order = "y04a", --this is where it belongs with se. otherwise it will be moved later.
      ingredients = tf.compilePrereqs{data.raw["fluid"]["hydrogen-chloride"] and {type="fluid", name="hydrogen-chloride", amount=100} or nil,
      data.raw["fluid"]["kr-hydrogen-chloride"] and {type="fluid", name="kr-hydrogen-chloride", amount=100} or nil,
        {type="fluid", name=mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", amount=mods["Krastorio2"] and 100 or 160}},
      results = {{type="fluid", name="aqua-regia", amount=200}},
      emissions_multiplier = 0.25,
      crafting_machine_tint = {
        primary = {0.75, 0.75, 1, 1},
        secondary = {0.75, 1, 0.75, 1},
        tertiary = {1, 0.2, 0, 0.3},
        quaternary = {1, 1, 1, 0.6}
      }
    }
  })
end

if parts.bz.gold and data.raw.item["silver-plate"] and rm.CheckIngredient("integrated-circuit", "copper-plate") then
  data:extend({
    {
      type = "recipe",
      name = "integrated-circuit-silver",
      icons = {
        {
          icon = "__ThemTharHills-Updated__/graphics/icons/integrated-circuit.png",
          icon_size = 64
        },
        {
          icon = "__bzgold" .. (mods["bzgold2"] and "2" or "") .. "__/graphics/icons/silver-plate.png",
          icon_size = 128,
          scale = 0.125,
          shift = {8, -8}
        }
      },
      categories = { "advanced-crafting" },
      enabled = false,
      energy_required = 1,
      ingredients = {{type="item", name="plastic-bar", amount=1}, {type="item", name=parts.gold, amount=2}, {type="item", name="silver-plate", amount=2}},
      results = {{type="item", name="integrated-circuit",amount=2}},
    }
  })
  data.raw.recipe["integrated-circuit"].icons = {
    {
      icon = "__ThemTharHills-Updated__/graphics/icons/integrated-circuit.png",
      icon_size = 64
    },
    {
      icon = "__base__/graphics/icons/copper-plate.png",
      icon_size = 64,
      scale = 0.25,
      shift = {8, -8}
    }
  }
end

if mods["Krastorio2"] then
  data:extend({
    {
      type = "recipe",
      name = "ammonia-from-potassium-nitrate",
      icons = {
        {
          icon = "__Krastorio2Assets__/icons/fluids/ammonia.png",
          icon_size = 64,
          icon_mipmaps = 4,
        },
        {
          icon = "__ThemTharHills-Updated__/graphics/icons/potassium-nitrate.png",
          icon_size = 64,
          shift = {-8, -8},
          scale = 0.25
        }
      },
      categories = { "chemistry" },
      subgroup = "fluid-recipes",
      order = "y03[ammonia]alt",
      enabled = false,
      energy_required = 2,
      ingredients = {{type="fluid", name="water", amount=20}, {type="item", name="potassium-nitrate", amount=1}},
      results = {{type="fluid", name="kr-ammonia", amount=20}},
      crafting_machine_tint = {
        primary = {0.5, 0.5, 1, 1},
        secondary = {1, 1, 1, 1},
        tertiary = {0.5, 0.5, 1, 1},
        quaternary = {0.8, 0.8, 0.8, 1}
      }
    }
  })
  
  local matterutil = require("__Krastorio2__/prototypes/libraries/matter")
  data:extend(
    {
      {
        type = "technology",
        name = "kr-matter-gold-processing",
        icons = {
          {
            icon = "__Krastorio2Assets__/technologies/backgrounds/matter.png",
            icon_size = 256,
          },
          {
            icon = "__ThemTharHills-Updated__/graphics/icons/gold-ore.png",
            icon_size = 64,
            scale = 1
          }
        },
        effects = {},
        prerequisites = { "kr-matter-processing" },
        order = "g-e-e",
        unit = {
          count = 350,
          ingredients = {
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "kr-matter-tech-card", 1 },
          },
          time = 45
        }
      },
      {
        type = "recipe",
        name = "nitric-acid-early",
        icons = {
          {
            icon = "__Krastorio2Assets__/icons/fluids/nitric-acid.png",
            icon_size = 64,
            icon_mipmaps = 4,
          },
          {
            icon = "__ThemTharHills-Updated__/graphics/icons/potassium-nitrate.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          }
        },
        categories = { "chemistry" },
        subgroup = "fluid-recipes",
        order = "y04[nitric-acid]alt",
        enabled = false,
        energy_required = 3,
        ingredients = {{type="item", name="potassium-nitrate", amount=1}, {type="fluid", name="water", amount=30}},
        results = {{type="fluid", name=mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", amount=5}},
        crafting_machine_tint = {
          primary = {0.75, 0.75, 1, 1},
          secondary = {1, 1, 1, 1},
          tertiary = {0.5, 0.5, 1, 1},
          quaternary = {1, 1, 1, 1}
        }
      },
      {
        type = "recipe",
        name = "gold-wire-s-c",
        categories = { "smelting" },
        enabled = false,
        energy_required = 1,
        ingredients = {{type="item", name="gold-powder", amount=3}},
        results = {{type="item", name=parts.wire, amount=2}},
      }
    }
  )
  matterutil.make_recipes({
    material = {type = "item", name = "gold-ore", amount=10},
    matter_count = 5,
    energy_required = 1,
    needs_stabilizer = false,
    unlocked_by = "kr-matter-gold-processing"
  })
  matterutil.make_deconversion_recipe({
    material = {type="item", name=parts.gold, amount=10},
    matter_count = mods["space-exploration"] and 11.25 or 15,
    energy_required = 3,
    only_deconversion = true,
    needs_stabilizer = true,
    unlocked_by = "kr-matter-gold-processing"
  })
else
  data:extend({
    {
      type = "recipe",
      name = "nitric-acid",
      categories = { "chemistry" },
      enabled = false,
      energy_required = 1,
      subgroup = "fluid-recipes",
      order = "y04", --this is where it belongs with se. otherwise it will be moved later.
      ingredients = tf.compilePrereqs{{type="item", name="copper-plate", amount=1}, {type="fluid", name="water", amount=100}, {type="fluid", name="sulfuric-acid", amount=10}, parts.optionalIngredient("potassium-nitrate", 1)},
      results = {{type="fluid", name="nitric-acid", amount=100}},
      crafting_machine_tint = {
        primary = {0.5, 0.75, 1, 1},
        secondary = {1, 1, 1, 1},
        tertiary = {0.25, 0.5, 1, 1},
        quaternary = {1, 1, 1, 1}
      }
    }
  })
end

if mods["space-exploration"] then
  se_delivery_cannon_recipes["gold-ore"] = {name= "gold-ore"}
  se_delivery_cannon_recipes[parts.gold] = {name= parts.gold}
  se_delivery_cannon_recipes["gold-ingot"] = {name= "gold-ingot"}
  if mods["Krastorio2"] then
    se_delivery_cannon_recipes["potassium-nitrate"] = {name= "potassium-nitrate"}
  else
    se_delivery_cannon_recipes["nitric-acid-barrel"] = {name= "nitric-acid-barrel"}
  end

  data:extend(
    {
      {
        type = "recipe",
        icon = "__ThemTharHills-Updated__/graphics/icons/molten-gold.png",
        icon_size = 64,
        subgroup = "gold",
        name = "molten-gold",
        categories = { "smelting" },
        energy_required = 60,
        ingredients = {{type="item", name="gold-powder", amount=72}, {type="fluid", name="se-pyroflux", amount=10}},
        results = {{type="fluid", name="molten-gold", amount=900}},
        enabled = false
      },
      {
        type = "recipe",
        name = "gold-ingot",
        categories = { "casting" },
        energy_required = 25,
        ingredients = {{type="fluid", name="molten-gold", amount=250}},
        results = {{type="item", name="gold-ingot", amount=1}},
        main_product = "gold-ingot", --required for bismuth to not break
        enabled = false
      },
      {
        type = "recipe",
        name = "gold-ingot-to-plate",
        icons = {
          { icon = "__ThemTharHills-Updated__/graphics/icons/gold-plate.png", icon_size = 64 },
          { icon = "__ThemTharHills-Updated__/graphics/icons/gold-ingot.png", icon_size = 64, scale=0.25, shift= {-8, -8}},
        },
        categories = { "crafting" },
        energy_required = 5,
        ingredients = {{type="item", name="gold-ingot", amount=1}},
        results = {{type="item", name=parts.gold, amount=10}},
        allow_decomposition = false,
        enabled = false
      }
    }
  )
end

if mods["FreightForwarding"] then
  data:extend({
    {
      type = "recipe",
      name = "noble-nodule-dredging",
      categories = { "ff-dredging" },
      energy_required = 50,
      ingredients = {},
      results = {{type="item", name="noble-nodule", amount_min=75, amount_max=150}},
      enabled = false
    },
    {
      type = "recipe",
      name = "noble-nodule-washing",
      categories = { "chemistry" },
      energy_required = 15,
      allow_decomposition = false,
      ingredients = {{type="item", name="noble-nodule", amount=18}, {type="fluid", name=mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", amount=15}},
      results = {{type="item", name="gold-ore", amount_min=40, amount_max=50}, {type="item", name=data.raw.item["silver-ore"] and "silver-ore" or "copper-ore", amount_min=0, amount_max=8}, 
        {type="item", name="stone", amount_min=0, amount_max=4}, {type="item", name="noble-nodule", amount_min=0, amount_max=6}},
      main_product = "gold-ore",
      enabled = false,
      crafting_machine_tint = {
        primary = {r = 0.9, g = 0.8, b = 0, a = 1.0},
        secondary = {r = 1.0, g = 1.0, b = 1.0, a = 1.0},
        tertiary = {r = 1.0, g = 1.0, b = 0.8, a = 1.0},
        quaternary = {r = 0.75, g = 0.75, b = 0.0, a = 0.5}
      }
    }
  })
end

if mods["LunarLandings"] then
  if not mods["BrassTacks-Updated"] then
    data:extend({
      {
        type = "recipe",
        name = "cheese-ore-processing",
        categories = { "ll-electric-smelting" },
        subgroup = "ll-raw-material-moon",
        order = "a[moon-rock]-c",
        icon = "__ThemTharHills-Updated__/graphics/icons/cheese-ore.png",
        icon_size = 64,
        energy_required = 10,
        ingredients = { {type="item", name="cheese-ore", amount=20} },
        results = {{type="item", name="gold-ore", amount=10}, {type="item", name="ll-moon-rock", amount=3}, {type="fluid", name="light-oil", amount=10, fluidbox_index = 1}},
        enabled = false
      }
    })
  end
  data:extend({
    {
      type = "recipe",
      name = "entangled-transceiver",
      categories = { "ll-quantum-resonating" },
      localised_name = { "recipe-name.entangled-transceiver" },
      icons = {
        {
          icon = "__ThemTharHills-Updated__/graphics/icons/transceiver.png",
          icon_size = 64
        },
        {
          icon = "__LunarLandings__/graphics/icons/polariton/polariton.png",
          icon_size = 64,
          scale = 0.25,
          shift = {-8, -8}
        }
      },
      energy_required = 15,
      allow_decomposition = false,
      ingredients = {{type="item", name="integrated-circuit", amount=30}, {type="item", name="ll-down-polariton", amount=1}, {type="item", name="ll-right-polariton", amount=1}},
      results = {{type="item", name="transceiver", amount=30}, {type="item", name="ll-up-polariton", amount=2}},
      main_product = "transceiver",
      enabled = false
    }
  })
end
