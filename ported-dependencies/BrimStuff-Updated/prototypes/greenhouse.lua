local util = require("util")
local parts = require("variable-parts")
local tf = require("techfuncs")

if not settings.startup["brimstuff-greenhouse"].value then
  return
end

local gh = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-1"])

gh.name = "brimstuff-greenhouse"
gh.order = "ca"
gh.icon = "__BrimStuff-Updated__/graphics/icons/brimstuff-greenhouse.png"
gh.icon_size = 64
gh.icon_mipmaps = 4
gh.remnants = "lab_remnants"
gh.next_upgrade = nil
gh.fluid_boxes = {
  {
    production_type = "input",
    pipe_picture = table.deepcopy(require("__base__.prototypes.entity.assembler-pictures").assembler2pipepictures),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = -1,
    pipe_connections = {{ flow_direction="input", direction = defines.direction.north, position = {0, -1.2} }},
    secondary_draw_orders = { north = -1 },
    volume = 1000,
  },
  {
    production_type = "output",
    pipe_picture = table.deepcopy(require("__base__.prototypes.entity.assembler-pictures").assembler2pipepictures),
    pipe_covers = pipecoverspictures(),
    base_area = 1,
    base_level = 1,
    pipe_connections = {{ flow_direction="output", direction = defines.direction.south, position = {0, 1.2} }},
    secondary_draw_orders = { north = -1 },
    volume = 1000,
  }
}
if not mods["LunarLandings"] then
  gh.fixed_recipe="brimstuff-wood-growth"
end

gh.minable.result="brimstuff-greenhouse"
gh.crafting_categories={"brimstuff-botany"}
gh.animation = {
      layers =
      {
        {
          filename = "__BrimStuff-Updated__/graphics/entity/greenhouse.png",
          width = 98,
          height = 87,
          frame_count = 33,
          line_length = 11,
          animation_speed = 1 / 3,
          shift = util.by_pixel(0, 1.5),
          hr_version =
          {
            filename = "__BrimStuff-Updated__/graphics/entity/hr-greenhouse.png",
            width = 194,
            height = 174,
            frame_count = 33,
            line_length = 11,
            animation_speed = 1 / 3,
            shift = util.by_pixel(0, 1.5),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/lab/lab-integration.png",
          width = 122,
          height = 81,
          frame_count = 1,
          line_length = 1,
          repeat_count = 33,
          animation_speed = 1 / 3,
          shift = util.by_pixel(0, 15.5),
          hr_version =
          {
            filename = "__base__/graphics/entity/lab/hr-lab-integration.png",
            width = 242,
            height = 162,
            frame_count = 1,
            line_length = 1,
            repeat_count = 33,
            animation_speed = 1 / 3,
            shift = util.by_pixel(0, 15.5),
            scale = 0.5
          }
        },
        {
          filename = "__BrimStuff-Updated__/graphics/entity/greenhouse-light.png",
          blend_mode = "additive",
          draw_as_light = true,
          width = 106,
          height = 100,
          frame_count = 33,
          line_length = 11,
          animation_speed = 1 / 3,
          shift = util.by_pixel(-1, 1),
          hr_version =
          {
            filename = "__BrimStuff-Updated__/graphics/entity/hr-greenhouse-light.png",
            blend_mode = "additive",
            draw_as_light = true,
            width = 216,
            height = 194,
            frame_count = 33,
            line_length = 11,
            animation_speed = 1 / 3,
            shift = util.by_pixel(0, 0),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/lab/lab-shadow.png",
          width = 122,
          height = 68,
          frame_count = 1,
          line_length = 1,
          repeat_count = 33,
          animation_speed = 1 / 3,
          shift = util.by_pixel(13, 11),
          draw_as_shadow = true,
          hr_version =
          {
            filename = "__base__/graphics/entity/lab/hr-lab-shadow.png",
            width = 242,
            height = 136,
            frame_count = 1,
            line_length = 1,
            repeat_count = 33,
            animation_speed = 1 / 3,
            shift = util.by_pixel(13, 11),
            scale = 0.5,
            draw_as_shadow = true
          }
        }
      }
    }

gh.working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/particles/tree-leaves-1.ogg",
          volume = 0.7
        },
        {
          filename = "__base__/sound/particles/tree-leaves-2.ogg",
          volume = 0.7
        },
        {
          filename = "__base__/sound/particles/tree-leaves-3.ogg",
          volume = 0.7
        },
        {
          filename = "__base__/sound/particles/tree-leaves-4.ogg",
          volume = 0.7
        }
      },
      audible_distance_modifier = 0.7,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    }

gh.crafting_speed = 1
gh.module_specification = { module_slots = 1 }
gh.allowed_effects = {"consumption", "speed", "productivity", "pollution"}
gh.energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = {pollution = -2}
    }
gh.energy_usage = "30kW"

data:extend({
  {
    type = "recipe-category",
    name = "brimstuff-botany"
  },
  gh,
  {
    type = "fluid",
    name = "fertilizer-slurry",
    icon = "__BrimStuff-Updated__/graphics/icons/fertilizer-slurry.png",
    icon_size = 64,
    subgroup = "fluid",
    order = "q",
    default_temperature = 25,
    max_temperature = 25,
    base_color = {r=0, g=0.6, b=0.2, a=1},
    flow_color = {r=0, g=1, b=0, a=1},
    auto_barrel = true
  },
  {
    type = "item",
    name = "brimstuff-greenhouse",
    icon = "__BrimStuff-Updated__/graphics/icons/brimstuff-greenhouse.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "production-machine",
    place_result = "brimstuff-greenhouse",
    order = "cz",
    stack_size = 50
  },
  {
    type = "recipe",
    name = "brimstuff-greenhouse",
    categories = { "crafting" },
    subgroup = "production-machine",
    energy_required = 1,
    results = {{type="item", name="brimstuff-greenhouse", amount=1}},
    enabled = false,
    ingredients = tf.compilePrereqs{{type="item", name="iron-stick", amount=16}, {type="item", name="pipe", amount=5}, {type="item", name="stone-brick", amount=5}, 
      parts.optionalIngredient(mods["Krastorio2"] and "kr-glass" or "glass", 10), parts.optionalIngredient("silver-brazing-alloy", 5)}
  },
  {
    type = "item-subgroup",
    name = "brimstuff-botany",
    group = "intermediate-products",
    order = "ac"
  },
  {
    type = "recipe",
    name = "brimstuff-wood-growth",
    categories = { "brimstuff-botany" },
    subgroup = "brimstuff-botany",
    order = "a",
    energy_required = 2,
    results = {{type="item", name="wood", amount=1}},
    enabled = false,
    ingredients = {{type="fluid", name="fertilizer-slurry", amount=5}},
  },
  {
    type = "recipe",
    name = "fertilizer-slurry",
    subgroup = "brimstuff-botany",
    order = "b",
    categories = { "basic-chemistry" },
    energy_required = 1,
    results = {{type="fluid", name="fertilizer-slurry", amount=100}},
    enabled = false,
    ingredients = {{type="fluid", name=mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", amount=25}, {type="item", name="wood", amount=1}, {type="item", name="potassium-nitrate", amount=1}},
    crafting_machine_tint = {
      primary = {0, 0.6, 0.2, 1},
      secondary = {0, 1, 0, 1},
      tertiary = {0, 0.6, 0.2, 1},
      quaternary = {0, 1, 0, 1}
    }
  },
  {
      type = "technology",
      name = "brimstuff-greenhouse",
      icons = {
        {
          icon = "__BrimStuff-Updated__/graphics/icons/brimstuff-greenhouse.png",
          icon_size = 64,
          icon_mipmaps = 4
        }
       },
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = "brimstuff-greenhouse"
        },
        {
          type = "unlock-recipe",
          recipe = "fertilizer-slurry"
        },
        {
          type = "unlock-recipe",
          recipe = "brimstuff-wood-growth"
        }
      },
      prerequisites = {"basic-chemistry"},
      unit = {
        count = 30,
        ingredients = {
          { "automation-science-pack", 1 }
        },
        time = 15,
      }
  }
})

if mods["LunarLandings"] then
  data:extend({
    {
      type = "recipe",
      name = "brimstuff-oxygen",
      categories = { "brimstuff-botany" },
      subgroup = "brimstuff-botany",
      order = "ab",
      energy_required = 2,
      results = {{type="fluid", name="ll-oxygen", amount=30}},
      enabled = false,
      ingredients = {{type="fluid", name="fertilizer-slurry", amount=5}},
    },
  })
end
