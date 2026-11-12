local parts = require("variable-parts")
local rm = require("recipe-modify")
local tf = require("techfuncs")

local early_acid = data.raw.fluid[mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid"] and (mods["ThemTharHills-Updated"] or mods["BrimStuff-Updated"])
local ic_in_scanner = mods["ThemTharHills-Updated"] and not mods["space-exploration"]

local gubbins_allowed = settings.startup["lasingaround-allow-gubbins-in-mill"].value
local circuits_allowed = settings.startup["lasingaround-allow-circuits-in-mill"].value
local entities_allowed = settings.startup["lasingaround-allow-entities-in-mill"].value


local helium_yield = 10
if settings.startup["lasingaround-allow-gubbins-in-mill"].value then
  helium_yield = helium_yield + 2
end
if settings.startup["lasingaround-allow-circuits-in-mill"].value then
  helium_yield = helium_yield + (parts.bz.gold and 2 or 3)
end
if settings.startup["lasingaround-allow-gubbins-in-mill"].value then
  helium_yield = helium_yield + 1
end

if mods["LunarLandings"] then
  helium_yield = helium_yield / 2
end

data:extend({
  {
    type = "recipe-category",
    name = "laser-assembling"
  },
  {
    type = "recipe-category",
    name = "laser-milling"
  },
  {
    type = "recipe-category",
    name = "laser-milling-exclusive"
  },
  {
    type = "recipe",
    name = "oil-filtration",
    subgroup = "helium",
    order = "a",
    categories = { "chemistry" },
    enabled = false,
    energy_required = 1,
    ingredients = {{type="fluid", name="crude-oil", amount=50, fluidbox_index=1}},
    results = {{type="fluid", name="filtered-oil", amount=50, fluidbox_index=1}},
    crafting_machine_tint = {
        primary = {0.1, 0.1, 0.1, 1},
        secondary = {0.9, 0.9, 0.9, 1},
        tertiary = {1, 1, 1, 0.5},
        quaternary = {1, 1, 1, 1}
    }
  },
  {
    type = "recipe",
    name = "advanced-oil-filtration",
    localised_description = {"recipe-description.helium-productivity-rules"},
    icon = "__LasingAround-Updated__/graphics/icons/advanced-oil-filtration.png",
    icon_size = 64,
    subgroup = "helium",
    order = "b",
    categories = { "chemistry" },
    enabled = false,
    energy_required = 1,
    ingredients = {{type="fluid", name="crude-oil", amount=50}, {type="fluid", name="steam", amount=5}},
    results = {{type="fluid", name="filtered-oil", amount=50, ignored_by_productivity=50, ignored_by_stats=50}, {type="fluid", name="helium", amount=helium_yield}},
    crafting_machine_tint = {
        primary = {0.1, 0.1, 0.1, 1},
        secondary = {0.75, 1, 0.9, 1},
        tertiary = {1, 1, 1, 0.5},
        quaternary = {0.75, 1, 0.9, 1}
    }
  },
  {
    type = "recipe",
    name = "spectroscopic-oil-filtration",
    localised_description = {"recipe-description.helium-productivity-rules"},
    icons = {
      {
        icon = "__LasingAround-Updated__/graphics/icons/advanced-oil-filtration.png",
        icon_size = 64,
      },
      {
        icon = "__LasingAround-Updated__/graphics/icons/spectroscope.png",
        icon_size = 64,
        scale=0.25,
        shift={-8, 8}
      }
    },
    subgroup = "helium",
    order = "c",
    categories = { "oil-processing" },
    enabled = false,
    energy_required = 2,
    ingredients = {{type="fluid", name="crude-oil", amount=100}, {type="fluid", name="steam", amount=20}, {type="item", name="spectroscope", amount=1}},
    results = {{type="fluid", name="filtered-oil", amount=100, ignored_by_productivity=100, ignored_by_stats=100}, {type="fluid", name="helium", amount=helium_yield * 3}, {type="item", name="spectroscope", amount=1, independent_probability=0.99, ignored_by_productivity=1, ignored_by_stats=1}, {type="fluid", name="crude-oil", amount=5, ignored_by_productivity=5, ignored_by_stats=5}},
    allow_decomposition = false
  },
  (parts.bz.gold and not (mods["space-exploration"] or mods["ThemTharHills-Updated"])) and {
    type = "recipe",
    name = "empty-amplifier-tube",
    categories = { "advanced-crafting" },
    enabled = false,
    energy_required = 50,
    ingredients = tf.compilePrereqs{{type="item", name="gold-ingot", amount=1}, parts.preferred({"ll-silica", "bismuth-glass", mods["Krastorio2"] and "kr-glass" or "glass", "kr-quartz", "silica", "tin-plate", "iron-plate"}, {40, 20, 20, 10, 50, 20, 10}), 
      parts.preferred({"silver-plate", "copper-plate"}, {10, 10}), parts.optionalIngredient("tungsten-plate", 10)},
    results = {{type="item", name="empty-amplifier-tube",amount=10}},
    lasermill = {
      helium = 30,
      productivity = true
    }
  } or {
    type = "recipe",
    name = "empty-amplifier-tube",
    icon_size = 64,
    categories = { "advanced-crafting" },
    enabled = false,
    energy_required = 5,
    ingredients = tf.compilePrereqs{parts.preferred({"gold-plate", "fi_gold", "silver-wire", "tinned-cable", "copper-cable"}, {1, 1, 2, 2, 2}), 
      parts.preferred({"ll-silica", "bismuth-glass", mods["Krastorio2"] and "kr-glass" or "glass", "kr-quartz", "silica", "tin-plate", "iron-plate"}, {4, 2, 2, 1, 5, 2, 1}), parts.preferred({"silver-plate", "copper-plate"}, {1, 1}), 
        parts.optionalIngredient("tungsten-plate", 1)},
    results = {{type="item", name="empty-amplifier-tube", amount=1}},
    lasermill = {
      helium = 3,
      productivity = true
    }
  },
  {
    type = "recipe",
    name = "helium-laser",
    icon_size = 64,
    categories = { "crafting-with-fluid" },
    enabled = false,
    energy_required = 2,
    ingredients = tf.compilePrereqs{{type="fluid", name="helium", amount=25}, {type="item", name="empty-amplifier-tube", amount=1}, {type="item", name="electronic-circuit", amount=1}, {type="item", name="battery", amount=1}, 
      parts.preferred({"optical-fiber", "kr-quartz"}, {1, 1})},
    results = {{type="item", name="helium-laser", amount=1}}
  },
  {
    type = "recipe",
    name = "carbon-dioxide-laser",
    icon_size = 64,
    categories = { "crafting-with-fluid" },
    enabled = false,
    energy_required = 2,
    ingredients = tf.compilePrereqs{{type="fluid", name="petroleum-gas", amount=100}, {type="item", name="empty-amplifier-tube", amount=1}, {type="item", name="advanced-circuit", amount=1}, {type="item", name="battery", amount=10}, 
      parts.preferred({"ti-sapphire", "diamond", "el_energy_crystal"}, {1, 1, 1}), parts.optionalIngredient("advanced-cable", 1)},
    results = {{type="item", name="carbon-dioxide-laser", amount=1}}
  },
  {
    type = "recipe",
    name = "scanner",
    icon_size = 64,
    categories = { "crafting" },
    enabled = false,
    energy_required = 3,
    ingredients = tf.compilePrereqs{{type="item", name="helium-laser", amount=1}, ic_in_scanner and {type="item", name="integrated-circuit", amount=5} or {type="item", name="electronic-circuit", amount=1}, 
      {type="item", name="advanced-circuit", amount=ic_in_scanner and 1 or 3}, parts.preferred({mods["Krastorio2"] and "kr-glass" or "glass", "optical-fiber"}, {2, 3})},
    results = {{type="item", name="scanner", amount=1}}
  },
  {
    type = "recipe",
    name = "spectroscope",
    icon_size = 64,
    categories = { "crafting" },
    enabled = false,
    energy_required = 3,
    ingredients = tf.compilePrereqs{{type="item", name="helium-laser", amount=1}, parts.preferred({"ll-silicon", "silver-plate", "copper-plate"}, {2, 3, 3}), 
      parts.preferred({"silicon-wafer", "electronic-circuit"}, {1, 1}), parts.preferred({mods["Krastorio2"] and "kr-glass" or "glass", "ll-silica", "bismuth-glass"}, {1, 2, 1})},
    results = {{type="item", name="spectroscope", amount=1}}
  },
  {
    type = "recipe",
    name = "laser-mill",
    categories = { "crafting" },
    energy_required = 1,
    results = {{type="item", name="laser-mill", amount=1}},
    enabled = false,
    ingredients = tf.compilePrereqs{{type="item", name="assembling-machine-2", amount=1}, {type="item", name="carbon-dioxide-laser", amount=2}, parts.preferred({"complex-joint", "steel-gear-wheel", "bearing", "iron-gear-wheel"}, 
      {2, 4, 4, 10}), parts.preferred({"hv-power-regulator", "advanced-circuit"}, {5, 25}), parts.preferred({"se-heat-shielding", "tungsten-plate"}, {1, 10}), 
      parts.optionalIngredient("cooling-fan", 10), parts.preferred({"bismuth-glass", mods["Krastorio2"] and "kr-glass" or "glass"}, {10, 10})}
  }
})

if parts.bz.gas then
  data:extend({
    {
      type = "recipe",
      name = "advanced-gas-processing",
      localised_description = {"recipe-description.helium-productivity-rules"},
      icon = "__LasingAround-Updated__/graphics/icons/advanced-gas-processing.png",
      icon_size = 64,
      subgroup = "helium",
      order = "d",
      categories = { "chemistry" },
      enabled = false,
      energy_required = 5,
      ingredients = {{type="fluid", name="gas", amount=50}, {type="fluid", name="steam", amount=5}},
      results = {{type="fluid", name="formaldehyde", amount=45, ignored_by_productivity=45, ignored_by_stats=45}, {type="fluid", name="helium", amount=helium_yield}},
      crafting_machine_tint = {
          primary = {1, 0.85, 0.1, 1},
          secondary = {0.75, 1, 0.9, 1},
          tertiary = {1, 1, 1, 0.5},
          quaternary = {0.75, 1, 0.9, 1}
      }
    },
    {
      type = "recipe",
      name = "spectroscopic-gas-processing",
      localised_description = {"recipe-description.helium-productivity-rules"},
      icons = {
        {
          icon = "__LasingAround-Updated__/graphics/icons/advanced-gas-processing.png",
          icon_size = 64,
        },
        {
          icon = "__LasingAround-Updated__/graphics/icons/spectroscope.png",
          icon_size = 64,
          scale=0.25,
          shift={-8, 8}
        }
      },
      subgroup = "helium",
      order = "e",
      categories = { "oil-processing" },
      enabled = false,
      energy_required = 10,
      ingredients = {{type="fluid", name="gas", amount=100}, {type="fluid", name="steam", amount=20}, {type="item", name="spectroscope", amount=1}},
      results = {{type="fluid", name="formaldehyde", amount=90, ignored_by_productivity=90, ignored_by_stats=90}, {type="fluid", name="helium", amount=helium_yield * 3}, {type="item", name="spectroscope", amount=1, independent_probability=0.99, ignored_by_productivity=1, ignored_by_stats=1}, {type="fluid", name="gas", amount=5, ignored_by_productivity=5, ignored_by_stats=5}},
      allow_decomposition = false
    },
  })

  if mods["Krastorio2"] then
    data:extend({
      {
          type = "recipe",
          name = "advanced-gas-reforming",
          localised_description = {"recipe-description.helium-productivity-rules"},
          icons = {
            {
              icon = "__Krastorio2Assets__/icons/fluids/hydrogen.png",
              icon_mipmaps = 4,
              icon_size = 64,
            },
            {
              icon = "__bzgas" .. (mods["bzgas2"] and "2" or "") .. "__/graphics/icons/gas.png",
              icon_size = 128,
              scale=0.125,
              shift={-8, -8}
            },
            {
              icon = "__LasingAround-Updated__/graphics/icons/helium.png",
              icon_size = 64,
              scale=0.25,
              shift={8, 8}
            }
          },
          subgroup = "helium",
          order = "f",
          categories = { "chemistry" },
          enabled = false,
          energy_required = 6,
          ingredients = {{type="fluid", name="gas", amount=50}, {type="fluid", name="steam", amount=10}},
          results = {{type="fluid", name="kr-hydrogen", amount=200, ignored_by_productivity=200, ignored_by_stats=200}, {type="fluid", name="helium", amount=helium_yield}},
          crafting_machine_tint = {
              primary = {1, 0.85, 0.1, 1},
              secondary = {0.75, 1, 0.9, 1},
              tertiary = {1, 1, 1, 0.5},
              quaternary = {0.75, 1, 0.9, 1}
          }
        },
        {
          type = "recipe",
          name = "spectroscopic-gas-reforming",
          localised_description = {"recipe-description.helium-productivity-rules"},
          icons = {
            {
              icon = "__Krastorio2Assets__/icons/fluids/hydrogen.png",
              icon_mipmaps = 4,
              icon_size = 64,
            },
            {
              icon = "__bzgas" .. (mods["bzgas2"] and "2" or "") .. "__/graphics/icons/gas.png",
              icon_size = 128,
              scale=0.125,
              shift={-8, -8}
            },
            {
              icon = "__LasingAround-Updated__/graphics/icons/helium.png",
              icon_size = 64,
              scale=0.25,
              shift={8, 8}
            },
            {
              icon = "__LasingAround-Updated__/graphics/icons/spectroscope.png",
              icon_size = 64,
              scale=0.25,
              shift={-8, 8}
            }
          },
          subgroup = "helium",
          order = "g",
          categories = { "oil-processing" },
          enabled = false,
          energy_required = 12,
          ingredients = {{type="fluid", name="gas", amount=100}, {type="fluid", name="steam", amount=40}, {type="item", name="spectroscope", amount=1}},
          results = {{type="fluid", name="kr-hydrogen", amount=400, ignored_by_productivity=400, ignored_by_stats=400}, {type="fluid", name="helium", amount=helium_yield * 3}, {type="item", name="spectroscope", amount=1, independent_probability=0.99, catalyst_amount=1}, {type="fluid", name="gas", amount=5, catalyst_amount=5}},
          allow_decomposition = false
        }
    })
  end

  if mods["space-exploration"] then
    data:extend({
      {
          type = "recipe",
          name = "advanced-methane-distillation",
          localised_description = {"recipe-description.helium-productivity-rules"},
          icons = {
            {
              icon = "__space-exploration-graphics__/graphics/icons/fluid/methane-gas.png",
              icon_mipmaps = 4,
              icon_size = 64,
            },
            {
              icon = "__bzgas" .. (mods["bzgas2"] and "2" or "") .. "__/graphics/icons/gas.png",
              icon_size = 128,
              scale=0.125,
              shift={-8, -8}
            },
            {
              icon = "__LasingAround-Updated__/graphics/icons/helium.png",
              icon_size = 64,
              scale=0.25,
              shift={8, 8}
            }
          },
          subgroup = "helium",
          order = "h",
          categories = { "chemistry" },
          enabled = false,
          energy_required = 2,
          ingredients = {{type="fluid", name="gas", amount=50}, {type="fluid", name="steam", amount=5}},
          results = {{type="fluid", name="se-methane-gas", amount=50, ignored_by_productivity=50, ignored_by_stats=50}, {type="fluid", name="helium", amount=helium_yield}},
          crafting_machine_tint = {
              primary = {1, 0.85, 0.1, 1},
              secondary = {0.75, 1, 0.9, 1},
              tertiary = {1, 1, 1, 0.5},
              quaternary = {0.75, 1, 0.9, 1}
          }
        },
        {
          type = "recipe",
          name = "spectroscopic-methane-distillation",
          localised_description = {"recipe-description.helium-productivity-rules"},
          icons = {
            {
              icon = "__space-exploration-graphics__/graphics/icons/fluid/methane-gas.png",
              icon_mipmaps = 4,
              icon_size = 64,
            },
            {
              icon = "__bzgas" .. (mods["bzgas2"] and "2" or "") .. "__/graphics/icons/gas.png",
              icon_size = 128,
              scale=0.125,
              shift={-8, -8}
            },
            {
              icon = "__LasingAround-Updated__/graphics/icons/helium.png",
              icon_size = 64,
              scale=0.25,
              shift={8, 8}
            },
            {
              icon = "__LasingAround-Updated__/graphics/icons/spectroscope.png",
              icon_size = 64,
              scale=0.25,
              shift={-8, 8}
            }
          },
          subgroup = "helium",
          order = "i",
          categories = { "oil-processing" },
          enabled = false,
          energy_required = 4,
          ingredients = {{type="fluid", name="gas", amount=100}, {type="fluid", name="steam", amount=20}, {type="item", name="spectroscope", amount=1}},
          results = {{type="fluid", name="se-methane-gas", amount=100, ignored_by_stats=100}, {type="fluid", name="helium", amount=helium_yield * 3}, 
            {type="item", name="spectroscope", amount=1, independent_probability=0.99, ignored_by_productivity=1, ignored_by_stats=1}, {type="fluid", name="gas", amount=5, ignored_by_productivity=5, ignored_by_stats=5}},
          allow_decomposition = false
        }
    })
  end
end

if data.raw.item["tracker"] then
  data:extend({
    {
      type = "recipe",
      name = "tracker",
      categories = { "crafting" },
      enabled = false,
      energy_required = 10,
      ingredients = {{type="item", name="transceiver", amount=1}, {type="item", name="helium-laser", amount=1}, parts.preferred({"gyro", "gyroscope"}, {1, 1}), 
        mods["space-exploration"] and parts.preferred({"graphene", "battery"}, {1, 1}) or {type="item", name="battery", amount=1}},
      results = {{type="item", name="tracker", amount=1}}
    }
  })
end

if data.raw.item["micron-tolerance-components"] then
  data:extend({
    {
      type = "recipe",
      name = "micron-tolerance-components",
      categories = { "meowing" },
      enabled = false,
      energy_required = 4,
      ingredients = {{type="item", name="invar-plate", amount=1}},
      results = {{type="item", name="micron-tolerance-components",amount=4}},
      lasermill = {
        helium = 2,
        convert = true,
        se_variant = "space-laser",
        se_tooltip_entity = "se-space-laser-laboratory",
        unlock = "se-space-laser-laboratory",
        icon_offset = {8, -8}
      }
    }
  })
  if mods["space-exploration"] then
    data:extend({
      {
        type = "recipe",
        name = "spectroscope-micron-tolerance",
        icons = {
          {
            icon = "__LasingAround-Updated__/graphics/icons/spectroscope.png",
            icon_size = 64
          },
          {
            icon = "__LasingAround-Updated__/graphics/icons/micron-tolerance-components.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          }
        },
        categories = { "crafting" },
        enabled = false,
        energy_required = 3,
        ingredients = tf.compilePrereqs{{type="item", name="helium-laser", amount=1}, parts.preferred({"silver-plate", "copper-plate"}, {1, 1}), 
          parts.preferred({"silicon-wafer", "electronic-circuit"}, {1, 1}), parts.preferred({mods["Krastorio2"] and "kr-glass" or "glass", "bismuth-glass"}, {1, 1}), {type="item", name="micron-tolerance-components", amount=1}},
        results = {{type="item", name="spectroscope", amount=1}}
      },
      {
        type = "recipe",
        name = "laboratory-gear",
        categories = { "crafting" },
        enabled = false,
        energy_required = 10,
        ingredients = tf.compilePrereqs{{type="item", name="micron-tolerance-components", amount=5}, {type="item", name=mods["Krastorio2"] and "kr-glass" or "glass", amount=10}, 
          {type="item", name="spectroscope", amount=1}, {type="item", name="scanner", amount=1}, 
          parts.preferred({"gyroscope", "gyro"}, {1, 1}), parts.optionalIngredient(mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", 25)},
        results = {{type="item", name="laboratory-gear",amount=5}}
      }
    })
  else
    if mods["LunarLandings"] then
      data:extend({
        {
          type = "recipe",
          name = "spectroscope-micron-tolerance",
          icons = {
            {
              icon = "__LasingAround-Updated__/graphics/icons/spectroscope.png",
              icon_size = 64
            },
            {
              icon = "__LasingAround-Updated__/graphics/icons/micron-tolerance-components.png",
              icon_size = 64,
              scale = 0.25,
              shift = {-8, -8}
            }
          },
          categories = { "crafting" },
          enabled = false,
          energy_required = 3,
          ingredients = tf.compilePrereqs{{type="item", name="helium-laser", amount=1}, {type="item", name="ll-silicon", amount=2}, parts.preferred({"silicon-wafer", "electronic-circuit"}, {1, 1}), 
            {type="item", name="ll-silica", amount=2}, {type="item", name="micron-tolerance-components", amount=2}},
          results = {{type="item", name="spectroscope", amount=1}}
        }
      })
      rm.AddIngredient("spectroscope", "electronic-circuit", 2)
    else
      rm.AddIngredient("spectroscope", "micron-tolerance-components", 1)
      rm.RemoveIngredient("spectroscope", "copper-plate", 2)
      rm.RemoveIngredient("spectroscope", "silver-plate", 2)
    end
  end
end

if mods["space-exploration"] then
  se_delivery_cannon_recipes["helium-barrel"] = {name="helium-barrel"}
end

if not mods["Krastorio2"] then
  data:extend({
    {
      type = "recipe",
      name = "helium-venting",
      icon = "__LasingAround-Updated__/graphics/icons/helium-venting.png",
      icon_size = 64,
      subgroup = "helium",
      order = "z",
      categories = { "chemistry" },
      enabled = false,
      energy_required = 0.5,
      ingredients = {{type="fluid", name="helium", amount=100}},
      emissions_multiplier = 0.01,
      results = {},
      allow_decomposition = false,
      crafting_machine_tint = {
          primary = {0, 0, 0, 0},
          secondary = {0, 0, 0, 0},
          tertiary = {0.75, 1, 0.9, 0.33},
          quaternary = {0.75, 1, 0.9, 1}
      }
    }
  })
end

if mods["LunarLandings"] then
  data:extend({
    {
      type = "recipe",
      name = "polariton-laser",
      categories = { "advanced-circuit-crafting" },
      localised_name = { "recipe-name.polariton-laser" },
      icons = {
        {
          icon = "__LasingAround-Updated__/graphics/icons/helium-laser.png",
          icon_size = 64
        },
        {
          icon = "__LunarLandings__/graphics/icons/polariton/polariton.png",
          icon_size = 64,
          scale = 0.25,
          shift = {-8, -8}
        }
      },
      energy_required = 60,
      allow_decomposition = false,
      ingredients = {{type="item", name="battery", amount=20}, {type="item", name="empty-amplifier-tube", amount=20}, {type="fluid", name="ll-astroflux", amount=50}, 
        {type="item", name="ll-superposed-polariton", amount=1, ignored_by_stats=1}, {type="item", name="ll-up-polariton", amount=1, ignored_by_stats=1}},
      results = {{type="item", name="helium-laser", amount=20}, {type="item", name="ll-up-polariton", amount=1, independent_probability=0.2, ignored_by_productivity=1, ignored_by_stats=1}, 
        {type="item", name="ll-down-polariton", amount=1, independent_probability=0.4, ignored_by_productivity=1, ignored_by_stats=1}, {type="item", name="ll-left-polariton", amount=1, independent_probability=0.6, ignored_by_productivity=1, ignored_by_stats=1},
          {type="item", name="ll-right-polariton", amount=1, independent_probability=0.8, ignored_by_productivity=1, ignored_by_stats=1}},
      main_product = "helium-laser",
      enabled = false
    }
  })
  if data.raw.item["tracker"] then
    -- Need to make a better version of this for 2.0
    -- data:extend({
    --   {
    --     type = "recipe",
    --     name = "advanced-rocket-control-unit",
    --     category = "advanced-circuit-crafting",
    --     icons = {
    --       {
    --         icon = "__base__/graphics/icons/rocket-control-unit.png",
    --         icon_size = 64
    --       },
    --       {
    --         icon = "__LasingAround-Updated__/graphics/icons/tracker.png",
    --         icon_size = 64,
    --         scale = 0.25,
    --         shift = {-8, -8}
    --       }
    --     },
    --     energy_required = 800,
    --     allow_decomposition = false,
    --     ingredients = {{type="item", name="ll-quantum-processor", amount=1}, {type="item", name="tracker", amount=20}, {type="item", name="ll-data-card", amount=1}},
    --     results = {{type="item", name="rocket-control-unit", amount=20}, {type="item", name="ll-junk-data-card", amount=1, ignored_by_productivity=1, ignored_by_stats=1}},
    --     main_product = "rocket-control-unit",
    --     enabled = false
    --   }
    -- })
  end
end
