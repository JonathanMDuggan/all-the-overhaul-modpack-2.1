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
    name = "gunpowder",
    categories = { "basic-chemistry" },
    energy_required = 2,
    ingredients = {{type="item", name="sulfur", amount=2}, {type="item", name="coal", amount=2}, {type="item", name="potassium-nitrate", amount=1}, {type="fluid", name="water", amount=60}},
    results = tf.compilePrereqs{{type="item", name="gunpowder", amount=3}, parts.waste and {type="fluid", name="chemical-waste", amount=60} or nil},
    main_product = "gunpowder",
    enabled = false,
    crafting_machine_tint = {
      primary = {0.5, 0.5, 0.5, 1},
      secondary = {1, 1, 0, 1},
      tertiary = {0, 0, 0, 1},
      quaternary = {1, 1, 0, 1}
    } or nil
  },
  {
    type = "recipe",
    name = "rubber",
    categories = { "basic-chemistry" },
    energy_required = 1,
    ingredients = {{type="item", name="wood", amount=3}, {type="item", name="sulfur", amount=1}, {type="fluid", name="water", amount=50}},
    results = tf.compilePrereqs{{type="item", name="rubber", amount=2}, parts.waste and {type="fluid", name="chemical-waste", amount=20} or nil},
    main_product = "rubber",
    enabled = false,
    crafting_machine_tint = {
      primary = {1, 0.55, 0.55, 1},
      secondary = {0.8, 0.4, 0.1, 1},
      tertiary = {0, 0, 0, 0.5},
      quaternary = {1, 1, 1, 1}
    }
  },
  {
    type = "recipe",
    name = "toluene-coal",
    categories = { "chemistry" },
    energy_required = 1,
    ingredients = {{type="item", name="coal", amount=1}, {type="fluid", name="steam", amount=5}},
    results = tf.compilePrereqs{{type="item", name="toluene", amount=1}, parts.waste and {type="fluid", name="chemical-waste", amount=5} or nil},
    main_product = "toluene",
    icons = {
      {
        icon = "__BrimStuff-Updated__/graphics/icons/toluene.png",
        icon_size = 64,
        icon_mipmaps = 4,
      },
      {
        icon = "__base__/graphics/icons/coal.png",
        icon_size = 64,
        scale = 0.25,
        icon_mipmaps = 4,
        shift = {-8, -8}
      }
    },
    enabled = false,
    crafting_machine_tint = {
      primary = {0.15, 0.15, 0.15, 1},
      secondary = {1, 1, 1, 1},
      tertiary = {1, 1, 0.7, 1},
      quaternary = {1, 1, 1, 1}
    } or nil
  },
  {
    type = "recipe",
    name = "toluene-wood",
    categories = { "chemistry" },
    energy_required = 2,
    ingredients = {{type="item", name="wood", amount=5}, {type="fluid", name="steam", amount=10}},
    results = tf.compilePrereqs{{type="item", name="toluene", amount=1}, parts.waste and {type="fluid", name="chemical-waste", amount=15} or nil},
    main_product = "toluene",
    icons = {
      {
        icon = "__BrimStuff-Updated__/graphics/icons/toluene.png",
        icon_size = 64,
        icon_mipmaps = 4,
      },
      {
        icon = "__base__/graphics/icons/wood.png",
        icon_size = 64,
        scale = 0.25,
        icon_mipmaps = 4,
        shift = {-8, -8}
      }
    },
    enabled = false,
    crafting_machine_tint = {
      primary = {0.75, 0.375, 0, 1},
      secondary = {1, 1, 1, 1},
      tertiary = {1, 1, 0.7, 1},
      quaternary = {1, 1, 1, 1}
    } or nil
  },
  {
    type = "recipe",
    name = "potassium-nitrate",
    categories = { "basic-chemistry" },
    energy_required = 1,
    ingredients = {{type="item", name="stone", amount=1}, {type="fluid", name="water", amount=30}},
    results = tf.compilePrereqs{{type="item", name="potassium-nitrate", amount=1}, parts.waste and {type="fluid", name="chemical-waste", amount=10} or nil},
    main_product = "potassium-nitrate",
    allow_decomposition = false,
    enabled = false,
    crafting_machine_tint = {
      primary = {0.9, 0.6, 0.3, 1},
      secondary = {1, 1, 0.5, 1},
      tertiary = {0.25, 0.25, 0.25, 0.25},
      quaternary = {1, 1, 1, 1}
    }
  },
  {
    type = "recipe",
    name = "drive-belt",
    categories = { "crafting" },
    energy_required = 2,
    ingredients = {{type="item", name="rubber", amount=3}, {type="item", name="iron-gear-wheel", amount=2}, parts.preferred({"bronze-plate", "iron-stick"}, {1, 1})},
    results = {{type="item", name="drive-belt", amount=1}},
    enabled = false,
  },
  {
    type = "recipe",
    name = "synthetic-rubber",
    categories = { "chemistry" },
    energy_required = 1,
    ingredients = {{type="fluid", name="petroleum-gas", amount=20}, {type="item", name="sulfur", amount=1}, {type="item", name="toluene", amount=1}},
    results = tf.compilePrereqs{{type="item", name="rubber", amount=3}, parts.waste and {type="fluid", name="chemical-waste", amount=35} or nil},
    main_product = "rubber",
    enabled = false,
    localised_name = {"recipe-name.synthetic-rubber"},
    icons = {
      {
        icon = "__BrimStuff-Updated__/graphics/icons/rubber.png",
        icon_size = 64
      },
      {
        icon = "__BrimStuff-Updated__/graphics/icons/toluene.png",
        icon_size = 64,
        scale = 0.25,
        shift = {-8, -8}
      }
    },
    crafting_machine_tint = {
      primary = {1, 0.55, 0.55, 1},
      secondary = {1, 1, 1, 1},
      tertiary = {0, 0, 0, 0.5},
      quaternary = {1, 1, 1, 1}
    }
  },
  {
    type = "recipe",
    name = "nitric-acid-early",
    icons = {
      {
        icon = mods["Krastorio2"] and "__Krastorio2Assets__/icons/fluids/nitric-acid.png" or "__BrimStuff-Updated__/graphics/icons/nitric-acid.png",
        icon_size = 64,
        icon_mipmaps = 4,
      },
      {
        icon = "__BrimStuff-Updated__/graphics/icons/potassium-nitrate.png",
        icon_size = 64,
        scale = 0.25,
        shift = {-8, -8}
      }
    },
    subgroup = "fluid-recipes",
    order = "y04[nitric-acid]alt", --this is where it belongs with k2 and/or se. otherwise it will be moved later.
    categories = { "basic-chemistry" },
    enabled = false,
    energy_required = 1,
    allow_decomposition = false,
    ingredients = {{type="item", name="potassium-nitrate", amount=1}, {type="fluid", name="water", amount=30}},
    results = {{type="fluid", name=mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", amount=5}},
    crafting_machine_tint = {
      primary = {0.75, 0.75, 1, 1},
      secondary = {1, 1, 1, 1},
      tertiary = {0.5, 0.5, 1, 1},
      quaternary = {1, 1, 1, 1}
    }
  }
})

if parts.bz.carbon and not mods["BrassTacks-Updated"] then
  data:extend({
    {
      type = "recipe",
      name = "gasket",
      categories = { "advanced-crafting" },
      energy_required = 0.5,
      ingredients = {{type="item", name="rubber", amount=1}, {type="item", name="graphite", amount=1}},
      results = {{type="item", name="gasket", amount=1}},
      enabled = false
    }
  })
end

if parts.waste then
  data:extend({
    {
      type = "recipe",
      name = "basic-waste-treatment",
      icons = {
        {
          icon = "__BrimStuff-Updated__/graphics/icons/chemical-waste.png",
          icon_size = 64,
        }
      },
      categories = { "basic-chemistry" },
      subgroup = "waste-treatment",
      order = "a",
      main_product = "",
      enabled = false,
      energy_required = 1,
      allow_decomposition = false,
      ingredients = {{type="fluid", name="chemical-waste", amount=240}},
      results = {{type="fluid", name="steam", amount=20, temperature=165}},
      emissions_multiplier = 5,
      crafting_machine_tint = {
        primary = {0.5, 0, 1, 1},
        secondary = {1, 0, 1, 1},
        tertiary = {0.5, 0, 1, 1},
        quaternary = {0.8, 0.8, 0.8, 0.8}
      }
    },
    {
      type = "recipe",
      name = "advanced-waste-treatment",
      icons = {
        {
          icon = "__BrimStuff-Updated__/graphics/icons/chemical-waste.png",
          icon_size = 64,
          icon_mipmaps = 4,
        },
        {
          icon = "__base__/graphics/icons/fluid/sulfuric-acid.png",
          icon_size = 64,
          scale = 0.25,
          icon_mipmaps = 4,
          shift = {-8, -8}
        }
      },
      categories = { "chemistry" },
      subgroup = "waste-treatment",
      order = "b",
      main_product = "",
      enabled = false,
      energy_required = 2,
      allow_decomposition = false,
      ingredients = {{type="fluid", name="chemical-waste", amount=600}, {type="fluid", name="sulfuric-acid", amount=5}},
      results = {{type="fluid", name="steam", amount=5, temperature=165}, {type="item", name="coal", amount=1}, {type="item", name="stone", amount=1}},
      emissions_multiplier = 2.5,
      crafting_machine_tint = {
        primary = {0.5, 0, 1, 1},
        secondary = {1, 0, 1, 1},
        tertiary = {0.5, 0, 1, 1},
        quaternary = {1, 0, 1, 1}
      }
    }
  })
  if not mods["Krastorio2"] then
    data:extend({
      {
        type = "recipe",
        name = "potassium-nitrate-disposal",
        icons = {
          {
            icon = "__BrimStuff-Updated__/graphics/icons/chemical-waste.png",
            icon_size = 64
          },
          {
            icon = "__BrimStuff-Updated__/graphics/icons/potassium-nitrate.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          }
        },
        subgroup = "waste-treatment",
        order = "d",
        main_product = "",
        categories = { "chemistry" },
        enabled = false,
        energy_required = 1,
        allow_decomposition = false,
        ingredients = {{type="fluid", name="water", amount=50}, {type="item", name="potassium-nitrate", amount=10}},
        results = {{type="fluid", name="chemical-waste", amount=50}},
        emissions_multiplier = 1.5,
        crafting_machine_tint = {
          primary = {0.5, 0, 1, 1},
          secondary = {0.9, 0.9, 0.9, 1},
          tertiary = {0.5, 0, 1, 1},
          quaternary = {0.9, 0.9, 0.9, 1}
        }
      },
      {
        type = "recipe",
        name = "sulfur-disposal",
        icons = {
          {
            icon = "__BrimStuff-Updated__/graphics/icons/chemical-waste.png",
            icon_size = 64
          },
          {
            icon = "__base__/graphics/icons/sulfur.png",
            icon_size = 64,
            icon_mipmaps = 4,
            scale = 0.25,
            shift = {-8, -8}
          }
        },
        subgroup = "waste-treatment",
        order = "e",
        categories = { "chemistry" },
        main_product = "",
        enabled = false,
        energy_required = 1,
        allow_decomposition = false,
        ingredients = {{type="fluid", name="sulfuric-acid", amount=50}, {type="fluid", name="water", amount=50}, {type="item", name="sulfur", amount=10}},
        results = {{type="fluid", name="sulfuric-acid", amount=55}, {type="fluid", name="chemical-waste", amount=50}},
        emissions_multiplier = 1.5,
        crafting_machine_tint = {
          primary = {0.5, 0, 1, 1},
          secondary = {1, 1, 0, 1},
          tertiary = {0.5, 0, 1, 1},
          quaternary = {1, 1, 0, 1}
        }
      },
      {
        type = "recipe",
        name = "toluene-disposal",
        icons = {
          {
            icon = "__BrimStuff-Updated__/graphics/icons/chemical-waste.png",
            icon_size = 64
          },
          {
            icon = "__BrimStuff-Updated__/graphics/icons/toluene.png",
            icon_size = 64,
            icon_mipmaps = 4,
            scale = 0.25,
            shift = {-8, -8}
          }
        },
        subgroup = "waste-treatment",
        order = "fa",
        categories = { "chemistry" },
        main_product = "",
        enabled = false,
        energy_required = 1,
        allow_decomposition = false,
        ingredients = {{type="fluid", name="water", amount=50}, {type="item", name="toluene", amount=10}},
        results = {{type="fluid", name="chemical-waste", amount=75}},
        emissions_multiplier = 1.5,
        crafting_machine_tint = {
          primary = {0.5, 0, 1, 1},
          secondary = {1, 1, 0.5, 1},
          tertiary = {0.5, 0, 1, 1},
          quaternary = {1, 1, 0.5, 1}
        }
      }
    })
    if data.raw.item["carbon-black"] then
      data:extend({
        {
          type = "recipe",
          name = "carbon-black-disposal",
          icons = {
            {
              icon = "__BrimStuff-Updated__/graphics/icons/chemical-waste.png",
              icon_size = 64
            },
            {
              icon = "__bzcarbon" .. (mods["bzcarbon2"] and "2" or "") .. "__/graphics/icons/carbon-black.png",
              icon_size = 64,
              icon_mipmaps = 4,
              scale = 0.25,
              shift = {-8, -8}
            }
          },
          subgroup = "waste-treatment",
          order = "f",
          categories = { "chemistry" },
          main_product = "",
          enabled = false,
          energy_required = 1,
          allow_decomposition = false,
          ingredients = {{type="fluid", name="water", amount=50}, {type="item", name="carbon-black", amount=10}},
          results = {{type="fluid", name="chemical-waste", amount=50}},
          emissions_multiplier = 1.5,
          crafting_machine_tint = {
            primary = {0.5, 0, 1, 1},
            secondary = {0.1, 0, 0.2, 1},
            tertiary = {0.5, 0, 1, 1},
            quaternary = {0.1, 0, 0.2, 1}
          }
        }
      })
    end
  end

  if mods["LunarLandings"] then
    data:extend({
      {
        type = "recipe",
        name = "waste-treatment-water-recovery",
        icons = {
          {
            icon = "__BrimStuff-Updated__/graphics/icons/chemical-waste.png",
            icon_size = 64,
            icon_mipmaps = 4,
          },
          {
            icon = "__LunarLandings__/graphics/silica.png",
            icon_size = 64,
            scale = 0.25,
            icon_mipmaps = 4,
            shift = {-8, -8}
          }
        },
        categories = { "chemistry" },
        subgroup = "waste-treatment",
        order = "ba",
        main_product = "",
        enabled = false,
        energy_required = 2,
        allow_decomposition = false,
        ingredients = {{type="fluid", name="chemical-waste", amount=600}, {type="fluid", name="sulfuric-acid", amount=2}, {type="item", name="ll-silica", amount=1}, {type="item", name="stone", amount=1}},
        results = {{type="fluid", name="water", amount=300}, {type="item", name="coal", amount=1}},
        emissions_multiplier = 2.5,
        crafting_machine_tint = {
          primary = {0, 0.5, 0.5, 1},
          secondary = {0, 0.8, 0.8, 1},
          tertiary = {0.5, 0, 1, 1},
          quaternary = {1, 0, 1, 1}
        },
      },
      {
        type = "recipe",
        name = "astral-waste-treatment",
        icons = {
          {
            icon = "__BrimStuff-Updated__/graphics/icons/chemical-waste.png",
            icon_size = 64,
            icon_mipmaps = 4,
          },
          {
            icon = "__LunarLandings__/graphics/fluid/astroflux.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          }
        },
        categories = { "chemistry" },
        subgroup = "waste-treatment",
        order = "bb",
        main_product = "",
        enabled = false,
        energy_required = 2,
        allow_decomposition = false,
        ingredients = {{type="fluid", name="chemical-waste", amount=600}, {type="fluid", name="ll-astroflux", amount=10}, {type="item", name="coal", amount=1}},
        results = {{type="fluid", name="petroleum-gas", amount=75}},
        crafting_machine_tint = {
          primary = {0.5, 0, 1, 1},
          secondary = {1, 0, 1, 1},
          tertiary = {0.75, 0.5, 1, 1},
          quaternary = {0.9, 0.8, 1, 1}
        }
      }
    })
  end
end

if not mods["Krastorio2"] then
  data:extend({
    {
      type = "recipe",
      name = "nitric-acid",
      categories = { "chemistry" },
      enabled = false,
      energy_required = 1,
      subgroup = "fluid-recipes",
      order = "y04", --this is where it belongs with se. otherwise it will be moved later.
      ingredients = {{type="item", name="copper-plate", amount=1}, {type="item", name="potassium-nitrate", amount=1}, {type="fluid", name="water", amount=100}, {type="fluid", name="sulfuric-acid", amount=10}},
      results = tf.compilePrereqs{{type="fluid", name=mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", amount=100}, parts.waste and {type="fluid", name="chemical-waste", amount=25} or nil},
      main_product = mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid",
      crafting_machine_tint = {
        primary = {0.5, 0.75, 1, 1},
        secondary = {1, 1, 1, 1},
        tertiary = {0.25, 0.5, 1, 1},
        quaternary = {1, 1, 1, 1}
      }
    }
  })
end

if parts.bz.gas then
  data:extend({
    {
      type = "recipe",
      name = "tnt",
      categories = { "chemistry" },
      enabled = false,
      energy_required = 1,
      ingredients = {{type="fluid", name="sulfuric-acid", amount=10}, {type="fluid", name=mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", amount=10}, {type="item", name="toluene", amount=1}},
      results = tf.compilePrereqs{{type="item", name="tnt", amount=2}, parts.waste and {type="fluid", name="chemical-waste", amount=25} or nil},
      main_product = "tnt",
      crafting_machine_tint = {
        primary = {1, 0.5, 0, 1},
        secondary = {1, 1, 0, 1},
        tertiary = {0.75, 0.75, 0.25, 1},
        quaternary = {0.8, 0.4, 0.4, 1}
      }
    }
  })
end

if mods["Krastorio2"] and not mods["ThemTharHills-Updated"] then
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
          icon = "__BrimStuff-Updated__/graphics/icons/potassium-nitrate.png",
          icon_size = 64,
          shift = {-8, -8},
          scale = 0.25
        }
      },
      categories = { "chemistry" },
      subgroup = "fluid-recipes",
      order = "y03[ammonia]alt",
      allow_decomposition = false,
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
end

if parts.waste and mods["ThemTharHills-Updated"] then
  data:extend({
    {
      type = "recipe",
      name = "depleted-acid-treatment",
      icons = {
        {
          icon = "__BrimStuff-Updated__/graphics/icons/depleted-acid.png",
          icon_size = 64,
          icon_mipmaps = 4,
        }
      },
      categories = { mods["Krastorio2"] and "kr-fluid-filtration" or "chemistry" },
      subgroup = "waste-treatment",
      order = "c",
      allow_decomposition = false,
      enabled = false,
      energy_required = 5,
      ingredients = tf.compilePrereqs{{type="fluid", name="depleted-acid", amount=150}, not mods["Krastorio2"] and {type="fluid", name="water", amount=50} or nil},
      results = {{type="fluid", name="chemical-waste", amount=mods["Krastorio2"] and 149 or 199}, {type="item", name="gold-powder", amount=1}},
      emissions_multiplier = 1.5,
      crafting_machine_tint = {
        primary = {0, 0.6, 0.8, 1},
        secondary = {0, 1, 1, 1},
        tertiary = {0.5, 1, 1, 1},
        quaternary = {0.4, 0.4, 0.8, 1}
      }
    }
  })
end

if parts.waste and mods["space-exploration"] then
  data:extend({
    {
      type = "recipe",
      name = "cryo-waste-compression",
      icons = {
        {
          icon = "__BrimStuff-Updated__/graphics/icons/chemical-waste.png",
          icon_size = 64
        },
        {
          icon = "__space-exploration-graphics__/graphics/icons/cryonite-rod.png",
          icon_size = 64,
          scale = 0.25,
          shift = {-8, -8}
        }
      },
      categories = { mods["Krastorio2"] and "kr-fluid-filtration" or "chemistry" },
      subgroup = "waste-treatment",
      order = "k",
      enabled = false,
      energy_required = 5,
      --cryoslush + water = ~1000 transportable water per rod. sending rods means ~10x water per cannon payload from reclamation.
      --this is useful for waterless planets doing something that makes waste. nodules can be exported pretty cheaply due to high stack size.
      ingredients = {{type="item", name="se-cryonite-rod", amount=1}, {type="fluid", name="chemical-waste", amount=1500}},
      results = {{type="fluid", name="water", amount=1000}, {type="item", name="pollution-nodule", amount=1}},
      allow_decomposition = false,
      crafting_machine_tint = {
        primary = {0.5, 0, 1, 1},
        secondary = {0, 1, 1, 1},
        tertiary = {0, 0.5, 1, 1},
        quaternary = {0, 1, 1, 1}      }
    },
    {
      type = "recipe",
      name = "cryo-waste-expansion",
      icons = {
        {
          icon = "__BrimStuff-Updated__/graphics/icons/chemical-waste.png",
          icon_size = 64,
          icon_mipmaps = 4,
        },
        {
          icon = "__BrimStuff-Updated__/graphics/icons/pollution-nodule.png",
          icon_size = 64,
          scale = 0.25,
          shift = {-8, -8}
        }
      },
      categories = { "chemistry" },
      subgroup = "waste-treatment",
      order = "l",
      enabled = false,
      energy_required = 10,
      ingredients = {{type="item", name="pollution-nodule", amount=1}, {type="fluid", name="water", amount=1500}},
      results = {{type="fluid", name="chemical-waste", amount=1000}, {type="fluid", name="se-cryonite-slush", amount=1}},
      allow_decomposition = false,
      crafting_machine_tint = {
        primary = {0.5, 0, 1, 1},
        secondary = {0, 1, 1, 1},
        tertiary = {0, 0.5, 1, 1},
        quaternary = {0, 1, 1, 1}      }
    },
    {
      type = "recipe",
      name = "nodule-scrapping",
      icons = {
        {
          icon = "__space-exploration-graphics__/graphics/blank.png",
          icon_size = 64
        },
        {
          icon = "__space-exploration-graphics__/graphics/icons/scrap.png",
          icon_size = 64,
          scale = 0.33,
          shift = {-8, 8}
        },
        {
          icon = "__BrimStuff-Updated__/graphics/icons/pollution-nodule.png",
          icon_size = 64,
          scale = 0.33,
          shift = {8, -8}
        },
        {
          icon = "__space-exploration-graphics__/graphics/icons/transition-arrow.png",
          icon_size = 64
        }
      },
      categories = { "hard-recycling" },
      subgroup = "recycling",
      order = "zz",
      enabled = false,
      energy_required = 1,
      main_product = "",
      allow_decomposition = false,
      ingredients = {{type="item", name="pollution-nodule", amount=1}},
      results = {{type="item", name="se-scrap", amount=1}}
    },
    {
      type = "recipe",
      name = "pyro-waste-treatment",
      icons = {
        {
          icon = "__BrimStuff-Updated__/graphics/icons/chemical-waste.png",
          icon_size = 64
        },
        {
          icon = "__space-exploration-graphics__/graphics/icons/fluid/pyroflux.png",
          icon_size = 64,
          icon_mipmaps = 4,
          scale = 0.25,
          shift = {-8, -8}
        }
      },
      categories = { "chemistry" },
      subgroup = "waste-treatment",
      order = "m",
      enabled = false,
      energy_required = 2,
      allow_decomposition = false,
      ingredients = {{type="fluid", name="se-pyroflux", amount=1}, {type="fluid", name="chemical-waste", amount=600}},
      results = {{type="fluid", name="steam", amount=10, temperature=500}, {type="item", name="stone", amount=2}, {type="item", name="coal", amount=2}},
      emissions_multiplier = 1.75,
      crafting_machine_tint = {
        primary = {0.5, 0, 1, 1},
        secondary = {0, 1, 1, 1},
        tertiary = {0.8, 0, 0, 1},
        quaternary = {1, 0.3, 0.3, 1}
      }
    },
    {
      type = "recipe",
      name = "pyro-nodule-melting",
      icons = {
        {
          icon = "__space-exploration-graphics__/graphics/icons/fluid/pyroflux.png",
          icon_size = 64,
          icon_mipmaps = 4
        },
        {
          icon = "__BrimStuff-Updated__/graphics/icons/pollution-nodule.png",
          icon_size = 64,
          scale = 0.25,
          shift = {-8, -8}
        }
      },
      categories = { "chemistry" },
      subgroup = "waste-treatment",
      order = "n",
      enabled = false,
      energy_required = 5,
      allow_decomposition = false,
      ingredients = {{type="item", name="se-vulcanite-block", amount=2}, {type="item", name="pollution-nodule", amount=1}},
      results = {{type="fluid", name="se-pyroflux", amount=25}},
      main_product = "",
      crafting_machine_tint = {
        primary = {0.8, 0, 0, 1},
        secondary = {1, 0.3, 0.3, 1},
        tertiary = {0.5, 0, 1, 1},
        quaternary = {0, 1, 1, 1}      }
    }
  })
end

if mods["space-exploration"] then
  se_delivery_cannon_recipes["potassium-nitrate"] = {name="potassium-nitrate"}
  se_delivery_cannon_recipes["rubber"] = {name="rubber"}
  if not mods["Krastorio2"] then se_delivery_cannon_recipes["nitric-acid-barrel"] = {name="nitric-acid-barrel"} end
  if data.raw.item["tnt"] then
    se_delivery_cannon_recipes["tnt"] = {name="tnt"}
  end
  if parts.waste then
    se_delivery_cannon_recipes["pollution-nodule"] = {name="pollution-nodule"}
  end
end
