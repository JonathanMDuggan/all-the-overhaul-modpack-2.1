local parts = require("variable-parts")
local tf = require("techfuncs")

local ic_in_scanner = mods["ThemTharHills-Updated"] and not mods["space-exploration"]

data:extend({
  {
    type = "technology",
    name = "helium-extraction",
    icons = {
      {
        icon = "__LasingAround-Updated__/graphics/technology/helium-extraction.png",
        icon_size = 256
      }
     },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "advanced-oil-filtration"
      },
      parts.bz.gas and {
        type = "unlock-recipe",
        recipe = "advanced-gas-processing"
      }
    },
    prerequisites = {"chemical-science-pack"},
    unit = {
      count = 75,
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 }
      },
      time = 30,
    }
  },
  {
    type = "technology",
    name = "helium-laser",
    icons = {
      {
        icon = "__LasingAround-Updated__/graphics/technology/helium-laser.png",
        icon_size = 256
      }
     },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "helium-laser"
      }
    },
    prerequisites = tf.compilePrereqs{"laser", (not mods["LunarLandings"]) and "helium-extraction" or nil},
    unit = {
      count = 150,
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 }
      },
      time = 30,
    }
  },
  {
    type = "technology",
    name = "carbon-dioxide-laser",
    icons = {
      {
        icon = "__LasingAround-Updated__/graphics/technology/carbon-dioxide-laser.png",
        icon_size = 256
      }
     },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "carbon-dioxide-laser"
      }
    },
    prerequisites = {"laser"},
    unit = {
      count = 150,
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 }
      },
      time = 30,
    }
  },
  {
    type = "technology",
    name = "scanner",
    icons = {
      {
        icon = "__LasingAround-Updated__/graphics/technology/scanner.png",
        icon_size = 256
      }
     },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "scanner"
      }
    },
    prerequisites = tf.compilePrereqs{"helium-laser", ic_in_scanner and "processing-unit" or nil},
    unit = {
      count = 100,
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 }
      },
      time = 30,
    }
  },
  {
    type = "technology",
    name = "spectroscopy",
    icons = {
      {
        icon = "__LasingAround-Updated__/graphics/technology/spectroscopy.png",
        icon_size = 256
      }
     },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "spectroscope"
      }
    },
    prerequisites = {"helium-laser"},
    unit = {
      count = 50,
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 }
      },
      time = 30,
    }
  },
  {
    type = "technology",
    name = "laser-mill",
    icons = {
      {
        icon = "__LasingAround-Updated__/graphics/technology/laser-mill.png",
        icon_size = 256
      }
     },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "laser-mill"
      }
    },
    prerequisites = tf.compilePrereqs{"carbon-dioxide-laser", (not mods["LunarLandings"]) and "helium-extraction" or nil},
    unit = {
      count = 500,
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 }
      },
      time = 30,
    }
  },
  {
    type = "technology",
    name = "spectroscopic-helium-extraction",
    icons = {
      {
        icon = "__LasingAround-Updated__/graphics/technology/helium-extraction.png",
        icon_size = 256
      },
      {
        icon = "__LasingAround-Updated__/graphics/technology/spectroscopy.png",
        icon_size = 256,
        scale = 0.25,
        shift = {-64, 64}
      }
     },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "spectroscopic-oil-filtration"
      },
      parts.bz.gas and {
        type = "unlock-recipe",
        recipe = "spectroscopic-gas-processing"
      } or nil
    },
    prerequisites = {"spectroscopy", "production-science-pack"},
    unit = {
      count = 250,
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "production-science-pack", 1 }
      },
      time = 60,
    }
  }
})


if data.raw.item["tracker"] then
  data:extend({
    {
      type = "technology",
      name = "tracking-systems",
      icons = {
        {
          icon = "__LasingAround-Updated__/graphics/technology/tracking-systems.png",
          icon_size = 256
        }
       },
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = "tracker"
        }
      },
      prerequisites = tf.compilePrereqs{"helium-laser", 
        (mods["space-exploration"] or mods["LunarLandings"]) and (data.raw.technology["graphene"] and "graphene" or (data.raw.recipe["gyroscope"] and "gyroscope" or "gyro")) or "utility-science-pack"},
      unit = {
        count = 150,
        ingredients = tf.compilePrereqs{
          { "automation-science-pack", 1 },
          { "logistic-science-pack", 1 },
          { "chemical-science-pack", 1 },
          not (mods["space-exploration"] or mods["LunarLandings"]) and { "utility-science-pack", 1 } or nil
        },
        time = 30,
      }
    }
  })
  if mods["LunarLandings"] then
    -- data:extend({
    --   {
    --         type = "technology",
    --         name = "advanced-rocket-navigation",
    --         icons = {
    --           {
    --             icon = "__LasingAround-Updated__/graphics/icons/rocket-control-unit.png",
    --             icon_size = 256
    --           },
    --           {
    --             icon = "__LasingAround-Updated__/graphics/icons/tracker.png",
    --             icon_size = 64,
    --             shift = {-64, -64},
    --             scale = 2
    --           }
    --          },
    --         effects =
    --         {
    --           {
    --             type = "unlock-recipe",
    --             recipe = "advanced-rocket-control-unit"
    --           }
    --         },
    --         prerequisites = {"ll-quantum-science-pack"},
    --         unit = {
    --           count = 200,
    --           ingredients = {
    --             { "automation-science-pack", 1 },
    --             { "logistic-science-pack", 1 },
    --             { "chemical-science-pack", 1 },
    --             { "production-science-pack", 1 },
    --             { "utility-science-pack", 1 },
    --             { "ll-space-science-pack", 1 },
    --             { "ll-quantum-science-pack", 1 }
    --           },
    --           time = 60,
    --         }
    --   }
    -- })
  end
end

if data.raw.item["micron-tolerance-components"] then
  data:extend({
    {
      type = "technology",
      name = "micron-tolerance-manufacturing",
      icons = {
        {
          icon = "__LasingAround-Updated__/graphics/technology/micron-tolerance-manufacturing.png",
          icon_size = 256
        }
       },
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = "micron-tolerance-components"
        },
        {
          type = "unlock-recipe",
          recipe = "invar-valve-micron-tolerance"
        }
      },
      prerequisites = {"laser-mill"},
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
  if mods["space-exploration"] then
    data:extend({
      {
        type = "technology",
        name = "micron-tolerance-instruments",
        icons = {
          {
            icon = "__LasingAround-Updated__/graphics/technology/micron-tolerance-instruments.png",
            icon_size = 256
          }
         },
        effects =
        {
          {
            type = "unlock-recipe",
            recipe = "laboratory-gear"
          },
          {
            type = "unlock-recipe",
            recipe = "spectroscope-micron-tolerance"
          }
        },
        prerequisites = {"space-science-pack"},
        unit = {
          count = 100,
          ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "se-rocket-science-pack", 1 },
            { "space-science-pack", 1 }
          },
          time = 45,
        }
      }
    })
  else
    if mods["LunarLandings"] then
      data:extend({
        {
          type = "technology",
          name = "micron-tolerance-instruments",
          icons = {
            {
              icon = "__LasingAround-Updated__/graphics/technology/micron-tolerance-instruments.png",
              icon_size = 256
            }
           },
          effects =
          {
            {
              type = "unlock-recipe",
              recipe = "spectroscope-micron-tolerance"
            }
          },
          prerequisites = {"ll-space-science-pack", "micron-tolerance-manufacturing"},
          unit = {
            count = 150,
            ingredients = {
              { "automation-science-pack", 1 },
              { "logistic-science-pack", 1 },
              { "chemical-science-pack", 1 },
              { "production-science-pack", 1 },
              { "ll-space-science-pack", 1 }
            },
            time = 45,
          }
        }
      })
    else
      tf.addPrereq("spectroscopy", "micron-tolerance-manufacturing")
    end
  end
  if mods["LunarLandings"] and (parts.nickelExperiment or parts.brassExperiment) then
      data:extend({
        {
          type = "technology",
          name = "micron-tolerance-space-machines",
          icons = {
            {
              icon = "__base__/graphics/icons/rocket-part.png",
              icon_size = 64,
              icon_mipmaps = 4
            },
            {
              icon = "__LasingAround-Updated__/graphics/icons/micron-tolerance-components.png",
              icon_size = 64,
              scale = 0.5,
              shift = {-16, -16}
            }
           },
          effects =
          {
          },
          prerequisites = {"ll-space-science-pack", "micron-tolerance-manufacturing"},
          unit = {
            count = 100,
            ingredients = {
              { "automation-science-pack", 1 },
              { "logistic-science-pack", 1 },
              { "chemical-science-pack", 1 },
              { "production-science-pack", 1 },
              { "ll-space-science-pack", 1 }
            },
            time = 30,
          }
        }
      })
  end
end

if mods["LunarLandings"] then
  data:extend({
    {
          type = "technology",
          name = "polariton-laser",
          icons = {
            {
              icon = "__LasingAround-Updated__/graphics/technology/helium-laser.png",
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
              recipe = "polariton-laser"
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

if mods["BrassTacks-Updated"] then
  if parts.brassExperiment then
    tf.addPrereq("laser-mill", "mechanical-engineering-2")
  else if not mods["Krastorio2"] then
    tf.addPrereq("laser-mill", "lubricant")
  end end
end

if not mods["Krastorio2"] then
  tf.addRecipeUnlock("helium-extraction", "helium-venting")
end

if parts.bz.gas then
  if mods["space-exploration"] then
    tf.addRecipeUnlock("se-space-biochemical-laboratory", "advanced-methane-distillation")
    tf.addRecipeUnlock("spectroscopic-helium-extraction", "spectroscopic-methane-distillation")
  end
  if mods["Krastorio2"] then
    tf.addRecipeUnlock("kr-advanced-chemistry", "advanced-gas-reforming")
    tf.addRecipeUnlock("spectroscopic-helium-extraction", "spectroscopic-gas-reforming")
  end
end
