local tf = require("techfuncs")
local parts = require("variable-parts")

if not mods["galdocs-manufacturing"] then
  data:extend({
    {
      type = "technology",
      name = "invar-processing",
      icon = "__IfNickel-Updated__/graphics/tech/invar-processing.png",
      icon_size = 256, icon_mipmaps = 4,
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = "invar-plate"
        }
      },
      prerequisites = tf.compilePrereqs{not (mods["Krastorio2"] or mods["MoreScience"]) and "logistic-science-pack" or nil},
      unit =
      {
        count = (mods["Krastorio2"] or mods["MoreScience"]) and 50 or 100,
        ingredients =
        {
          {"automation-science-pack", 1},
          not (mods["Krastorio2"] or mods["MoreScience"]) and {"logistic-science-pack", 1} or nil
        },
        time = (mods["Krastorio2"] or mods["MoreScience"]) and 15 or 30
      },
      order = "b"
    }
  })

  if parts.foundryEnabled then
    tf.addPrereq("invar-processing", "foundry")
  end
end

data:extend({
  {
    type = "technology",
    name = "valves",
    icon = "__IfNickel-Updated__/graphics/tech/valves.png",
    icon_size = 256, icon_mipmaps = 4,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "invar-valve"
      },
      parts.experimental and {
        type = "unlock-recipe",
        recipe = "flow-controller"
      } or nil
    },
    prerequisites = tf.compilePrereqs{parts.invartech, parts.experimental and "electronics" or nil},
    unit =
    {
      count = 50,
      ingredients =
      tf.compilePrereqs{
        {"automation-science-pack", 1},
        not (mods["Krastorio2"] or mods["MoreScience"]) and {"logistic-science-pack", 1} or nil
      },
      time = (mods["Krastorio2"] or mods["MoreScience"]) and 15 or 30
    },
    order = "b"
  }
})

if parts.experimental then
  data:extend({
    {
      type = "technology",
      name = "injection-molding",
      icon = "__IfNickel-Updated__/graphics/tech/injection-molding.png",
      icon_size = 256,
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = "cooling-fan"
        }
      },
      prerequisites = {"chemical-science-pack"},
      unit =
      {
        count = 100,
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1}
        },
        time = 30
      },
      order = "b"
    },
    {
      type = "technology",
      name = "gimbaled-thruster",
      icon = "__IfNickel-Updated__/graphics/tech/gimbaled-thruster.png",
      icon_size = 256,
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = "gimbaled-thruster"
        }
      },
      prerequisites = tf.compilePrereqs{(not (mods["space-exploration"] or mods["LunarLandings"])) and "utility-science-pack" or nil, "rocket-fuel"},
      unit =
      {
        count = 150,
        ingredients =
        tf.compilePrereqs{
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          (not (mods["space-exploration"] or mods["LunarLandings"])) and {"utility-science-pack", 1} or nil
        },
        time = 30
      },
      order = "b"
    }
  })
  if not parts.brassExperiment then
    data:extend({
      {
        type = "technology",
        name = "mechanical-engineering",
        icon = "__IfNickel-Updated__/graphics/tech/mechanical-engineering.png",
        icon_size = 256,
        effects =
        {
          {
            type = "unlock-recipe",
            recipe = "motorized-articulator"
          }
        },
        prerequisites = {"logistic-science-pack"},
        unit =
        {
          count = 100,
          ingredients =
          {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
          },
          time = 30
        },
        order = "e"
      }
    })
  end
  if mods["space-exploration"] then
    data:extend({
      {
        type = "technology",
        name = "machine-homeostasis",
        icons = {
          {
            icon = "__IfNickel-Updated__/graphics/tech/advanced-flow-controller.png",
            icon_size = 256
          },
          {
            icon = "__space-exploration-graphics__/graphics/icons/vitamelange-bloom.png",
            icon_size = 64,
            scale = 1,
            shift = {-64, -64}
          },
         },
        effects =
        {
          {
            type = "unlock-recipe",
            recipe = "flow-controller-biological"
          },
          {
            type = "unlock-recipe",
            recipe = "advanced-flow-controller-biological"
          }
        },
        prerequisites = {"se-biological-science-pack-1"},
        unit =
        {
          count = 100,
          ingredients =
          {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "se-biological-science-pack-1", 1 },
          },
          time = 30
        },
        order = "e"
      },
      {
        type = "technology",
        name = "advanced-flow-controller",
        icon = "__IfNickel-Updated__/graphics/tech/advanced-flow-controller.png",
        icon_size = 256,
        effects =
        {
          {
            type = "unlock-recipe",
            recipe = "advanced-flow-controller"
          }
        },
        prerequisites = {"chemical-science-pack"},
        unit =
        {
          count = 100,
          ingredients =
          {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
          },
          time = 30
        },
        order = "e"
      },
      {
        type = "technology",
        name = "nickel-electromagnet",
        icon = "__IfNickel-Updated__/graphics/tech/nickel-electromagnet.png",
        icon_size = 256,
        effects =
        {
          {
            type = "unlock-recipe",
            recipe = "nickel-electromagnet"
          }
        },
        prerequisites = {"chemical-science-pack"},
        unit =
        {
          count = 75,
          ingredients =
          {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
          },
          time = 30
        },
        order = "e"
      }
    })
  end
end

if mods["Krastorio2"] then
  data:extend({
    {
      type = "technology",
      name = "kr-matter-nickel-processing",
      icons = {
        {
          icon = "__Krastorio2Assets__/technologies/backgrounds/matter.png",
          icon_size = 256,
        },
        {
          icon = "__IfNickel-Updated__/graphics/icons/nickel-ore.png",
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
    }
  })
end

if parts.nitinol then
  data:extend({
    {
      type = "technology",
      name = "nitinol-processing",
      icons = {
        {
          icon = "__IfNickel-Updated__/graphics/tech/nitinol-processing.png",
          icon_size = 256
        }
      },
      effects = {
        {
          type = "unlock-recipe",
          recipe = "nitinol-plate"
        },
        {
          type = "unlock-recipe",
          recipe = "nitinol-mesh"
        },
        {
          type = "unlock-recipe",
          recipe = "self-regulating-valve"
        },
        (not (parts.foundryEnabled or mods["Krastorio2"])) and {
          type = "unlock-recipe",
          recipe = "nitinol-precursor"
        } or nil,
      },
      prerequisites = { "se-rocket-science-pack" },
      unit = {
        count = 250,
        ingredients = {
          { "automation-science-pack", 1 },
          { "logistic-science-pack", 1 },
          { "chemical-science-pack", 1 },
          { "se-rocket-science-pack", 1 },
        },
        time = 30
      }
    },
    {
      type = "technology",
      name = "space-nitinol-processing",
      icons = {
        {
          icon = "__IfNickel-Updated__/graphics/tech/nitinol-processing.png",
          icon_size = 256
        },
        {
          icon = "__space-exploration-graphics__/graphics/technology/thermodynamics-laboratory.png",
          icon_size = 128,
          scale = 0.66,
          shift = {-64, -64}
        }
      },
      localised_description = mods["LasingAround-Updated"] and {"technology-description.space-nitinol-processing-helium"} or {"technology-description.space-nitinol-processing"},
      effects = {
        {
          type = "unlock-recipe",
          recipe = "nitinol-plate-space"
        },
        mods["LasingAround-Updated"] and {
          type = "unlock-recipe",
          recipe = "nitinol-plate-helium"
        } or nil
      },
      prerequisites = { "se-space-thermodynamics-laboratory" },
      unit = {
        count = 250,
        ingredients = {
          { "automation-science-pack", 1 },
          { "logistic-science-pack", 1 },
          { "chemical-science-pack", 1 },
          { "space-science-pack", 1 },
        },
        time = 60
      }
    },
    {
      type = "technology",
      name = "nitinol-mesh-beryllium",
      icons = {
        {
          icon = "__IfNickel-Updated__/graphics/tech/nitinol-processing.png",
          icon_size = 256
        },
        {
          icon = "__space-exploration-graphics__/graphics/technology/beryllium-processing.png",
          icon_size = 128,
          scale = 0.66,
          shift = {-64, -64}
        }
      },
      effects = {
        {
          type = "unlock-recipe",
          recipe = "nitinol-mesh-beryllium"
        }
      },
      prerequisites = { "se-aeroframe-pole" },
      unit = {
        count = 100,
        ingredients = {
          { "automation-science-pack", 1 },
          { "logistic-science-pack", 1 },
          { "chemical-science-pack", 1 },
          { "utility-science-pack", 1 },
          { "se-astronomic-science-pack-1", 1 },
        },
        time = 60
      }
    }
  })
end

if mods["248k-Redux"] then
  data:extend({
    {
      type = "technology",
      name = "nickel-fusion-processing",
      icon = "__IfNickel-Updated__/graphics/icons/stacking/nickel-plate-stacked.png",
      icon_size = 64,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "248k-nickel-atom-hot"
        },
        {
          type = "unlock-recipe",
          recipe = "248k-nickel-atom"
        },
        {
          type = "unlock-recipe",
          recipe = "nickel-from-atoms"
        },
        {
          type = "unlock-recipe",
          recipe = "invar-from-atoms"
        }
      },
      prerequisites = { "fu_star_engine_iron_tech" },
      order = "g",
      unit = {
        count = 1000,
        ingredients = {
          { "automation-science-pack", 1 },
          { "logistic-science-pack", 1 },
          { "chemical-science-pack", 1 },
          { "utility-science-pack", 1 },
          { "production-science-pack", 1 },
          { "space-science-pack", 1 }
        },
        time = 45
      }
    }
  })
end
