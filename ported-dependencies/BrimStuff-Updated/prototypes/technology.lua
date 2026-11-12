local parts = require("variable-parts")
local tf = require("techfuncs")

data:extend({
  {
      type = "technology",
      name = "rubber",
      icons = {
        {
          icon = "__BrimStuff-Updated__/graphics/technology/rubber.png",
          icon_size = 256
        }
       },
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = "rubber"
        },
        {
          type = "unlock-recipe",
          recipe = "drive-belt"
        }
      },
      prerequisites = {"basic-chemistry"},
      unit = {
        count = 50,
        ingredients = {
          { "automation-science-pack", 1 }
        },
        time = 30,
      }
  },
  {
      type = "technology",
      name = "toluene-production",
      icons = {
        {
          icon = "__BrimStuff-Updated__/graphics/technology/toluene-production.png",
          icon_size = 256
        }
       },
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = "toluene-coal"
        },
        {
          type = "unlock-recipe",
          recipe = "toluene-wood"
        }
      },
      prerequisites = {mods["Krastorio2"] and "kr-fluids-chemistry" or "electric-chemical-plant"},
      unit = {
        count = 75,
        ingredients = {
          { "automation-science-pack", 1 },
          { "logistic-science-pack", 1 }
        },
        time = 30,
      }
  },
  {
      type = "technology",
      name = "advanced-polymer-synthesis",
      icons = {
        {
          icon = "__base__/graphics/technology/plastics.png",
          icon_size = 256
        },
        {
          icon = "__BrimStuff-Updated__/graphics/technology/toluene-production.png",
          icon_size = 256,
          scale = 0.5,
          shift = {-64, -64}
        }
       },
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = "plastic-with-toluene"
        },
        {
          type = "unlock-recipe",
          recipe = "synthetic-rubber"
        }
      },
      prerequisites = {"production-science-pack"},
      unit = {
        count = 100,
        ingredients = {
          { "automation-science-pack", 1 },
          { "logistic-science-pack", 1 },
          { "chemical-science-pack", 1 },
          { "production-science-pack", 1 }
        },
        time = 45,
      }
  }
})

if not mods["Krastorio2"] then
  data:extend({
    {
        type = "technology",
        name = "electric-chemical-plant",
        icons = {
          {
            icon = "__BrimStuff-Updated__/graphics/technology/electric-chemical-plant.png",
            icon_size = 256
          }
         },
        effects =
        {
          {
            type = "unlock-recipe",
            recipe = "chemical-plant"
          }
        },
        prerequisites = tf.compilePrereqs{mods["IfNickel-Updated"] and "valves" or "rubber", data.raw.item["hardened-hull"] and "hardened-hull" or "steel-processing", not data.raw.item["hardened-hull"] and "logistic-science-pack" or nil, parts.bz.tungsten and "tungsten-processing" or nil},
        unit = {
          count = 50,
          ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
          },
          time = 30,
        }
    }
  })
end

if parts.waste then
  data:extend({
    {
        type = "technology",
        name = "chemical-waste-disposal",
        icons = {
          {
            icon = "__BrimStuff-Updated__/graphics/technology/chemical-waste-disposal.png",
            icon_size = 256
          }
         },
        effects =
        tf.compilePrereqs{
          {
            type = "unlock-recipe",
            recipe = "advanced-waste-treatment"
          },
          mods["ThemTharHills-Updated"] and {
            type = "unlock-recipe",
            recipe = "depleted-acid-treatment"
          } or nil
        },
        prerequisites = {"sulfur-processing"},
        unit = {
          count = 100,
          ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
          },
          time = 30,
        }
    },
    (not mods["Krastorio2"]) and { -- crusher can void solids
        type = "technology",
        name = "byproduct-disposal",
        icons = {
          {
            icon = "__BrimStuff-Updated__/graphics/technology/byproduct-disposal.png",
            icon_size = 256
          }
         },
        effects =
        tf.compilePrereqs{
          {
            type = "unlock-recipe",
            recipe = "sulfur-disposal"
          },
          {
            type = "unlock-recipe",
            recipe = "potassium-nitrate-disposal"
          },
          {
            type = "unlock-recipe",
            recipe = "toluene-disposal"
          },
          data.raw.item["carbon-black"] and {
            type = "unlock-recipe",
            recipe = "carbon-black-disposal"
          } or nil
        },
        prerequisites = {"chemical-science-pack", "chemical-waste-disposal"},
        unit = {
          count = 50,
          ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
          },
          time = 30,
        }
    } or nil
  })
end

if parts.bz.gas then
  if parts.waste then
    tf.addRecipeUnlock("basic-chemistry", "basic-waste-treatment")
  end
  tf.addRecipeUnlock("basic-chemistry", "potassium-nitrate")
  tf.addRecipeUnlock("basic-chemistry", "gunpowder")
  tf.addRecipeUnlock("basic-chemistry", "nitric-acid-early")
else
  data:extend({
    {
          type = "technology",
          name = "basic-chemistry",
          icons = {
            {
              icon = "__BrimStuff-Updated__/graphics/technology/basic-chemistry.png",
              icon_size = 256
            }
           },
          effects =
          tf.compilePrereqs{
            {
              type = "unlock-recipe",
              recipe = "basic-chemical-plant"
            },
            parts.waste and {
              type = "unlock-recipe",
              recipe = "basic-waste-treatment"
            } or nil,
            {
              type = "unlock-recipe",
              recipe = "potassium-nitrate"
            },
            {
              type = "unlock-recipe",
              recipe = "gunpowder"
            },
            {
              type = "unlock-recipe",
              recipe = "nitric-acid-early"
            }
          },
          prerequisites = {"automation", mods["aai-industry"] and "basic-fluid-handling" or nil},
          unit = {
            count = 20,
            ingredients = {
              { "automation-science-pack", 1 }
            },
            time = 10,
          }
      }
  })
end

if parts.waste and mods["space-exploration"] then
  data:extend({
    {
          type = "technology",
          name = "pyro-waste-processing",
          icons = {
            {
              icon = "__space-exploration-graphics__/graphics/technology/vulcanite-processing.png",
              icon_size = 128
            },
            {
              icon = "__BrimStuff-Updated__/graphics/icons/chemical-waste.png",
              icon_size = 64,
              scale = 1,
              shift = {-32, 32}
            }
           },
          effects =
          {
            {
              type = "unlock-recipe",
              recipe = "pyro-waste-treatment"
            },
            {
              type = "unlock-recipe",
              recipe = "pyro-nodule-melting"
            }
          },
          prerequisites = {"production-science-pack"},
          unit = {
            count = 75,
            ingredients = {
              { "automation-science-pack", 1 },
              { "logistic-science-pack", 1 },
              { "chemical-science-pack", 1 },
              { "se-rocket-science-pack", 1 },
              { "space-science-pack", 1 },
              { "production-science-pack", 1 }
            },
            time = 30,
          }
    },
    {
          type = "technology",
          name = "cryo-waste-processing",
          icons = {
            {
              icon = "__space-exploration-graphics__/graphics/technology/cryonite-processing.png",
              icon_size = 128
            },
            {
              icon = "__BrimStuff-Updated__/graphics/icons/chemical-waste.png",
              icon_size = 64,
              scale = 1,
              shift = {-32, 32}
            }
           },
          effects =
          {
            {
              type = "unlock-recipe",
              recipe = "cryo-waste-compression"
            },
            {
              type = "unlock-recipe",
              recipe = "cryo-waste-expansion"
            },
            {
              type = "unlock-recipe",
              recipe = "nodule-scrapping"
            }
          },
          prerequisites = {"utility-science-pack"},
          unit = {
            count = 75,
            ingredients = {
              { "automation-science-pack", 1 },
              { "logistic-science-pack", 1 },
              { "chemical-science-pack", 1 },
              { "se-rocket-science-pack", 1 },
              { "space-science-pack", 1 },
              { "utility-science-pack", 1 }
            },
            time = 30,
          }
    }
  })
end
