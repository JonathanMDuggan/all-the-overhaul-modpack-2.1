local resource_autoplace = require("resource-autoplace")

if mods["galdocs-manufacturing"] then return end


data.raw.planet.nauvis.map_gen_settings.autoplace_controls["nickel-ore"] = {}
data.raw.planet.nauvis.map_gen_settings.autoplace_settings.entity.settings["nickel-ore"] = {}
resource_autoplace.initialize_patch_set("nickel-ore", true)

data:extend({
  {
    type = "autoplace-control",
    category = "resource",
    name = "nickel-ore",
    localised_name = {"", (mods["LunarLandings"] and "[virtual-signal=ll-nauvis] " or "") .. "[entity=nickel-ore] ", {"entity-name.nickel-ore"}},
    richness = true,
    order = "b-db"
  },
  {
    type = "resource",
    name = "nickel-ore",
    icon = "__IfNickel-Updated__/graphics/icons/nickel-ore.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral"},
    order="a-b-y",
    map_color = {0.1, 0.1, 0.8},
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_particle = "nickel-ore-particle",
      mining_time = 1,
      result = "nickel-ore"
    },
    walking_sound = data.raw.resource["iron-ore"].walking_sound,
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "nickel-ore",
      order = "a-b-e",
      base_density = mods["aai-industry"] and 6 or 5,
      has_starting_area_placement = true,
      regular_rq_factor_multiplier = 0.7,
      starting_rq_factor_multiplier = 1.1,
      base_spots_per_km2 = 7,
      candidate_spot_count = 22,
      richness_post_multiplier = 2
    },
    stage_counts = {30000, 19000, 11000, 5800, 2600, 800, 300, 160},
    stages =
    {
      sheet =
      {
        filename = "__IfNickel-Updated__/graphics/ore/hr-nickel-ore.png",
        priority = "extra-high",
        size = 128,
        frame_count = 8,
        variation_count = 8,
        scale = 0.5
      }
    },
    mining_visualisation_tint = {r=0.1, g=0.1, b=0.8}
  }
})
