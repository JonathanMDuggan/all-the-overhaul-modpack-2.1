local util = require("util")

local lasermill_pipes = table.deepcopy(require("__base__.prototypes.entity.assembler-pictures").assembler2pipepictures)
lasermill_pipes.south =
{
  filename = "__LasingAround-Updated__/graphics/entity/pipe_connector_hr.png",
  priority = "extra-high",
  width = 88,
  height = 61,
  shift = util.by_pixel(0, -31.25),
  scale = 0.5
}

local lasermill = {
  type = "assembling-machine",
  name = "laser-mill",
  icon = "__LasingAround-Updated__/graphics/icons/laser-mill.png",
  icon_size = 64, icon_mipmaps = 4,
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  minable = {mining_time = 0.25, result = "laser-mill"},
  max_health = 450,
  collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  crafting_categories = {"laser-assembling", "laser-milling", "laser-milling-exclusive"},
  crafting_speed = 2,
  energy_source =
  {
    type = "electric",
    usage_priority = "secondary-input",
    emissions_per_minute = {pollution = 1}
  },
  energy_usage = "850kW",
  module_slots = 4,
  effect_receiver = { base_effect = { productivity = 0.2 } },
  allowed_effects = {"consumption", "speed", "productivity", "pollution"},
  fluid_boxes = {
    {
      production_type = "input",
      pipe_picture = lasermill_pipes,
      pipe_covers = pipecoverspictures(),
      pipe_connections = {{ flow_direction="input", direction = defines.direction.north, position = {0, -1} }},
      secondary_draw_orders = { north = -1, east = -1, west = -1 },
      volume = 1000,
    },
    {
      production_type = "output",
      pipe_picture = lasermill_pipes,
      pipe_covers = pipecoverspictures(),
      pipe_connections = {{ flow_direction="output", direction = defines.direction.south, position = {0, 1} }},
      secondary_draw_orders = { north = -1, east = -1, west = -1 },
      volume = 1000,
    },
    {
      production_type = "input",
      pipe_picture = lasermill_pipes,
      pipe_covers = pipecoverspictures(),
      volume = 1000,
      pipe_connections = {
        { flow_direction = "input", direction = defines.direction.west, position = { -1, 0 }},
        { flow_direction = "input", direction = defines.direction.east, position = { 1, 0 }}
      },
      secondary_draw_orders = { north = -1, east = -1, west = -1 }
    }
  },
  fluid_boxes_off_when_no_fluid_recipe = true,
  corpse = "laser-mill-remnants",
  dying_explosion = "assembling-machine-3-explosion",
  damaged_trigger_effect = data.raw["assembling-machine"]["assembling-machine-3"].damaged_trigger_effect,
  graphics_set = {
    working_visualisations = {{
      animation = {
        layers = {
          {
            filename = "__LasingAround-Updated__/graphics/entity/table_hot.png",
            priority = "high",
            width = 96,
            height = 88,
            frame_count = 15,
            line_length = 15,
            shift = util.by_pixel(0, -28),
            animation_speed = 0.175,
          },
          {
            filename = "__LasingAround-Updated__/graphics/entity/beams.png",
            priority = "high",
            draw_as_glow = true,
            width = 96,
            height = 120,
            frame_count = 15,
            line_length = 15,
            shift = util.by_pixel(0, -12),
          },
          {
            filename = "__LasingAround-Updated__/graphics/entity/box.png",
            priority = "high",
            width = 96,
            height = 120,
            frame_count = 15,
            line_length = 15,
            shift = util.by_pixel(0, -12),
          },
          {
            filename = "__LasingAround-Updated__/graphics/entity/glow.png",
            priority = "high",
            width = 120,
            height = 120,
            frame_count = 15,
            line_length = 15,
            draw_as_light = true,
            shift = util.by_pixel(0, -12),
          }
        }
      }}
    },
    animation = {
      layers = {
        {
          filename = "__LasingAround-Updated__/graphics/entity/shadow_hr.png",
          priority = "high",
          width = 320,
          height = 192,
          frame_count = 1,
          line_length = 1,
          scale = 0.5,
          repeat_count = 15,
          shift = util.by_pixel(32, 0),
          animation_speed = 0.175,
          draw_as_shadow = true,
        },
        {
          filename = "__LasingAround-Updated__/graphics/entity/table_hr.png",
          priority = "high",
          width = 192,
          height = 240,
          frame_count = 15,
          line_length = 15,
          scale = 0.5,
          shift = util.by_pixel(0, -12),
          animation_speed = 0.175,
        },
        {
          filename = "__LasingAround-Updated__/graphics/entity/box_hr.png",
          priority = "high",
          width = 192,
          height = 240,
          frame_count = 15,
          line_length = 15,
          scale = 0.5,
          shift = util.by_pixel(0, -12),
          animation_speed = 0.175,
        }
      }
    },
  },
  working_sound = {
      sound =
      {
        {
          filename = "__LasingAround-Updated__/sound/lasermill.ogg",
          volume = 0.85
        }
      },
      audible_distance_modifier = 1,
      fade_in_ticks = 4,
      fade_out_ticks = 4
  },
  open_sound = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"].open_sound),
  close_sound = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"].close_sound),
  impact_category = data.raw["assembling-machine"]["assembling-machine-3"].impact_category
}

data:extend({
  lasermill,
  {
    type = "item",
    name = "laser-mill",
    icon = "__LasingAround-Updated__/graphics/icons/laser-mill.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "production-machine",
    place_result = "laser-mill",
    order = "c[laser-mill]",
    stack_size = 10
  },
  {
    type = "corpse",
    name = "laser-mill-remnants",
    icon = "__LasingAround-Updated__/graphics/icons/laser-mill.png",
    icon_size = 64,
    flags = {"placeable-neutral", "not-on-map"},
    subgroup = "production-machine-remnants",
    order = "c[laser-mill]",
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    tile_width = 3,
    tile_height = 3,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15,
    animation = {
      direction_count = 1,
      filename = "__LasingAround-Updated__/graphics/entity/laser_mill_remnant.png",
      priority = "high",
      width = 96,
      height = 96,
      frame_count = 1,
      line_length = 1
    }
  }
})
