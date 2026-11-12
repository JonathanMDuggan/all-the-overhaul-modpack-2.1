local parts = require("variable-parts")
local tf = require("techfuncs")

data:extend({
  {
        type = "technology",
        name = "gold-processing",
        icons = {
          {
            icon = "__ThemTharHills-Updated__/graphics/tech/gold-processing.png",
            icon_size = 256
          }
         },
        effects =
        {
          {
            type = "unlock-recipe",
            recipe = mods["Krastorio2"] and "nitric-acid-early" or "nitric-acid"
          },
          {
            type = "unlock-recipe",
            recipe = "gold-powder"
          },
          {
            type = "unlock-recipe",
            recipe = "gold-plate"
          },
          {
            type = "unlock-recipe",
            recipe = "trace-gold-from-copper"
          }
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
    {
          type = "technology",
          name = "gold-electronics",
          icons = {
            {
              icon = "__ThemTharHills-Updated__/graphics/tech/gold-electronics.png",
              icon_size = 256
            }
           },
          effects =
          {
            {
              type = "unlock-recipe",
              recipe = "gold-wire"
            },
            {
              type = "unlock-recipe",
              recipe = "transceiver"
            }
          },
          prerequisites = {"gold-processing"},
          unit = {
            count = 100,
            ingredients = {
              { "automation-science-pack", 1 },
              { "logistic-science-pack", 1 }
            },
            time = 30,
          }
    },
    {
          type = "technology",
          name = "high-voltage-equipment",
          icons = {
            {
              icon = "__ThemTharHills-Updated__/graphics/tech/high-voltage-equipment.png",
              icon_size = 256
            }
           },
          effects =
          {
            {
              type = "unlock-recipe",
              recipe = "advanced-cable"
            },
            {
              type = "unlock-recipe",
              recipe = "hv-power-regulator"
            }
          },
          prerequisites = {data.raw.technology["injection-molding"] and "injection-molding" or "chemical-science-pack", "battery"},
          unit = {
            count = 150,
            ingredients = {
              { "automation-science-pack", 1 },
              { "logistic-science-pack", 1 },
              { "chemical-science-pack", 1 }
            },
            time = 30,
          }
    }
})

if mods["LunarLandings"] then
  if not mods["BrassTacks-Updated"] then
    data:extend({
      {
            type = "technology",
            name = "lunar-cheese-exploitation",
            icons = {
              {
                icon = "__ThemTharHills-Updated__/graphics/tech/lunar-cheese-exploitation.png",
                icon_size = 64,
                icon_mipmaps = 4
              }
             },
            effects =
            {
              {
                type = "unlock-recipe",
                recipe = "cheese-ore-processing"
              }
            },
            prerequisites = {"production-science-pack"},
            unit = {
              count = 300,
              ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 }
              },
              time = 30,
            }
      }
    })
  end
  data:extend({
    {
          type = "technology",
          name = "entangled-communications",
          icons = {
            {
              icon = "__ThemTharHills-Updated__/graphics/tech/gold-electronics.png",
              icon_size = 256
            },
            {
              icon = "__LunarLandings__/graphics/icons/polariton/polariton.png",
              icon_size = 64,
              shift = {-64, -64},
              scale = 2
            }
           },
          effects =
          {
            {
              type = "unlock-recipe",
              recipe = "entangled-transceiver"
            }
          },
          prerequisites = {"ll-quantum-resonation"},
          unit = {
            count = 100,
            ingredients = {
              { "automation-science-pack", 1 },
              { "logistic-science-pack", 1 },
              { "chemical-science-pack", 1 },
              { "production-science-pack", 1 },
              { "utility-science-pack", 1 },
              { "ll-space-science-pack", 1 }
            },
            time = 60,
          }
    }
  })
end

if parts.aquaregia then
  tf.addRecipeUnlock("gold-processing", "aqua-regia")
end
