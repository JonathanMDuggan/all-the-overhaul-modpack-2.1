local resource_autoplace = require("resource-autoplace")

if mods["galdocs-manufacturing"] then
  return
end

data.raw.planet.nauvis.map_gen_settings.autoplace_controls["zinc-ore"] = {}
data.raw.planet.nauvis.map_gen_settings.autoplace_settings.entity.settings["zinc-ore"] = {}
resource_autoplace.initialize_patch_set("zinc-ore", true)

data:extend({
  {
    type = "autoplace-control",
    category = "resource",
    name = "zinc-ore",
    localised_name = {"", (mods["LunarLandings"] and "[virtual-signal=ll-nauvis] " or "") .. "[entity=zinc-ore] ", {"entity-name.zinc-ore"}},
    richness = true,
    order = "b-da"
  },
  {
    type = "resource",
    name = "zinc-ore",
    icon = "__BrassTacks-Updated__/graphics/icons/zinc-ore.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral"},
    order="a-b-x",
    map_color = {0.9, 0.9, 0.9},
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_particle = "zinc-particle",
      mining_time = 1,
      result = "zinc-ore"
    },
    walking_sound = data.raw.resource["iron-ore"].walking_sound,
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "zinc-ore",
      order = "a-b-e",
      base_density = 4,
      has_starting_area_placement = true,
      regular_rq_factor_multiplier = 1.1,
      starting_rq_factor_multiplier = 1.1,
      candidate_spot_count = 22
    },
    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages =
    {
      sheet =
      {
        filename = "__BrassTacks-Updated__/graphics/ore/hr-zinc-ore.png",
        priority = "extra-high",
        size = 128,
        frame_count = 8,
        variation_count = 8,
        scale = 0.5
      }
    },
    mining_visualisation_tint = {r=0.7, g=0.7, b=0.75}
  }
})

if mods["LunarLandings"] then
  data:extend({
    {
      type = "resource",
      name = "cheese-ore",
      icon = "__BrassTacks-Updated__/graphics/icons/cheese-ore.png",
      icon_size = 64,
      icon_mipmaps = 4,
      flags = {"placeable-neutral"},
      order="a-b-x",
      tree_removal_probability = 0.8,
      tree_removal_max_distance = 32 * 32,
      minable =
      {
        mining_particle = "zinc-particle",
        mining_time = 1,
        result = "cheese-ore"
      },
      walking_sound = data.raw.resource["iron-ore"].walking_sound,
      collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
      selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
      autoplace = resource_autoplace.resource_autoplace_settings
      {
        name = "cheese-ore",
        order = "a-b-e",
        base_density = 4,
        has_starting_area_placement = false,
        regular_rq_factor_multiplier = 1.0,
        starting_rq_factor_multiplier = 1.1,
        candidate_spot_count = 22
      },
      stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
      stages =
      {
        sheet =
        {
          filename = "__BrassTacks-Updated__/graphics/ore/hr-cheese-ore.png",
          priority = "extra-high",
          size = 128,
          frame_count = 8,
          variation_count = 8,
          scale = 0.5
        }
      },
      map_color = {1, 0.8, 0},
      mining_visualisation_tint = {1, 0.9, 0}
    },
    {
      type = "autoplace-control",
      category = "resource",
      name = "cheese-ore",
      localised_name = {"", "[virtual-signal=ll-luna] [entity=cheese-ore] ", {"entity-name.cheese-ore"}},
      richness = true,
      order = "d-ca"
    }
  })
  data.raw.resource["cheese-ore"].autoplace.default_enabled = false
  data.raw.resource["cheese-ore"].autoplace.tile_restriction = {"ll-luna-plain"}
end
