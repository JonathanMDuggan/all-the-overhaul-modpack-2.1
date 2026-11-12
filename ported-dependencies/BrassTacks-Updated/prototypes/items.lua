local parts = require("variable-parts")

local stacksize_override = nil
if mods["Krastorio2"] then
  --stacksize_override = tonumber(settings.startup["kr-stack-size"].value)
else
  data:extend({
    {
      type = "item",
      name = "brass-precursor",
      icon = parts.qualityIconPath("brasstacks", "icons/brass-precursor.png"),
      icon_size = 64,
      subgroup = "raw-resource",
      order = "eb",
      ic_create_container = false,
      stack_size = stacksize_override or 50,
      ib_badge = "BR",
      ib_invert = true
    }
  })
end

if not mods["galdocs-manufacturing"] then
  data:extend({
    {
      type = "item",
      name = "zinc-plate",
      icon = parts.qualityIconPath("brasstacks", "icons/zinc-plate.png"),
      icon_size = 64,
      subgroup = "raw-material",
      --copper = c
      order = "ca",
      ib_badge = "Zn",
      stack_size = stacksize_override or 100
    },
    {
      type = "item",
      name = "brass-plate",
      icon = parts.qualityIconPath("brasstacks", "icons/brass-plate.png"),
      icon_size = 64,
      subgroup = "raw-material",
      order = "cb",
      ib_badge = "BR",
      ib_invert = true,
      stack_size = stacksize_override or 100
    }
  })
  if not mods["exotic-industries"] then
    data:extend({
      {
        type = "item",
        name = "zinc-ore",
        icon = "__BrassTacks-Updated__/graphics/icons/zinc-ore.png",
        icon_size = 64, icon_mipmaps = 4,
        pictures =
            {
              { size = 64, filename = "__BrassTacks-Updated__/graphics/icons/zinc-ore.png",   scale = 0.5, mipmap_count = 4 },
              { size = 64, filename = "__BrassTacks-Updated__/graphics/icons/zinc-ore-1.png", scale = 0.5, mipmap_count = 4 },
              { size = 64, filename = "__BrassTacks-Updated__/graphics/icons/zinc-ore-2.png", scale = 0.5, mipmap_count = 4 },
              { size = 64, filename = "__BrassTacks-Updated__/graphics/icons/zinc-ore-3.png", scale = 0.5, mipmap_count = 4 }
            },
        subgroup = "raw-resource",
        --copper = e
        order = "ea",
        ib_badge = "Zn",
        stack_size = stacksize_override or 50
      }
    })
  end
end

data:extend({
  {
    type = "item",
    name = "bolted-flange",
    icon = parts.qualityIconPath("brasstacks", "icons/bolted-flange.png"),
    icon_size = 64,
    subgroup = "intermediate-product",
    --gear = c
    order = "cc",
    stack_size = 100
  },
  {
    type = "item",
    name = "brass-balls",
    icon = parts.qualityIconPath("brasstacks", "icons/brass-balls.png"),
    icon_size = 64,
    subgroup = "intermediate-product",
    --engine = i
    order = "ia",
    stack_size = 200
  },
  {
    type = "item",
    name = "bearing",
    icon = parts.qualityIconPath("brasstacks", "icons/bearing.png"),
    icon_size = 64,
    subgroup = "intermediate-product",
    order = "ib",
    stack_size = 100
  },
  {
    type = "item-subgroup",
    name = "frame-components",
    group = "intermediate-products",
    order = "fu"
  },
  {
    type = "item-subgroup",
    name = "gear-components",
    group = "intermediate-products",
    order = "fv"
  },
  {
    type = "item-subgroup",
    name = "rotary-components",
    group = "intermediate-products",
    order = "fw"
  },
  {
    type = "item-subgroup",
    name = "articulated-components",
    group = "intermediate-products",
    order = "fy"
  },
  {
    type = "item-subgroup",
    name = "plumbing-components",
    group = "intermediate-products",
    order = "fz"
  }
})

if parts.bz.carbon or mods["BrimStuff-Updated"] then
  data:extend({
    {
      type = "item",
      name = "airtight-seal",
      icon = parts.qualityIconPath("brasstacks", "icons/airtight-seal.png"),
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "cd",
      stack_size = 100
    }
  })
end

if settings.startup["brasstacks-experimental-intermediates"].value then
  data:extend({
    {
      type = "item",
      name = "articulated-mechanism",
      icon = parts.qualityIconPath("brasstacks", "icons/articulated-mechanism.png"),
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "cb",
      stack_size = 100
    },
    {
      type = "item",
      name = "flywheel",
      icon = parts.qualityIconPath("brasstacks", "icons/flywheel.png"),
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "ce",
      stack_size = 50
    },
    {
      type = "item",
      name = "hardened-hull",
      icon = parts.qualityIconPath("brasstacks", "icons/hardened-hull.png"),
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "ga",
      stack_size = 50
    },
    {
      type = "item",
      name = "complex-joint",
      icon = parts.qualityIconPath("brasstacks", "icons/complex-joint.png"),
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "gc",
      stack_size = 50
    },
    {
      type = "item",
      name = "gearbox",
      icon = parts.qualityIconPath("brasstacks", "icons/gearbox.png"),
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "gd",
      stack_size = 50
    },
    {
      type = "item",
      name = "advanced-gearbox",
      icon = parts.qualityIconPath("brasstacks", "icons/advanced-gearbox.png"),
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "ge",
      stack_size = 50
    }
  })

  if not mods["galdocs-manufacturing"] then
    data:extend({
      {
        type = "item",
        name = "galvanized-steel-plate",
        icon = parts.qualityIconPath("brasstacks", "icons/galvanized-steel-plate.png"),
        icon_size = 64,
        subgroup = "raw-material",
        order = "da",
        stack_size = stacksize_override or 100,
        ib_badge = "GV",
        ib_invert = true
      }
    })
  end

  if mods["Krastorio2"] then
    data:extend({
      {
        type = "item",
        name = "elite-gearbox",
        icon = parts.qualityIconPath("brasstacks", "icons/elite-gearbox.png"),
        icon_size = 64,
        pictures =
        {
          layers =
          {
            {
              size = 64,
              filename = parts.qualityIconPath("brasstacks", "icons/elite-gearbox.png"),
              scale = 0.25
            },
            {
              filename = parts.qualityIconPath("brasstacks", "icons/elite-gearbox-glow.png"),
              size = 64,
              scale = 0.25,
              flags = {"light"},
              draw_as_light = true
            }
          }
        },
        subgroup = "intermediate-product",
        order = "gf",
        stack_size = 50
      }
    })
  end

  if parts.gyroscope then
      data:extend({
        {
          type = "item",
          name = parts.gyroscope,
          localised_name = {"item-name.gyroscope"},
          icon = parts.qualityIconPath("brasstacks", "icons/gyroscope.png"),
          icon_size = 64,
          subgroup = "intermediate-product",
          order = "gca",
          stack_size = 50
        }
    })
  end

  if mods["aai-signal-transmission"] or mods["LunarLandings"] then
    data:extend({
      {
        type = "item",
        name = "skyseeker-armature",
        icon = parts.qualityIconPath("brasstacks", "icons/skyseeker-armature.png"),
        icon_size = 64,
        subgroup = "intermediate-product",
        order = "gcb",
        stack_size = 10
      }
  })
end
end

if mods["Krastorio2"] then
  data:extend({
    {
      type = "item",
      name = "enriched-zinc",
      icon = parts.qualityIconPath("brasstacks", "icons/enriched-zinc.png"),
      icon_size = 64,
      subgroup = "raw-material",
      order = "ea3",
      stack_size = stacksize_override or 100
    }
  })
end

if parts.drill then
  data:extend({
    {
      type = "item",
      name = "industrial-drill-head",
      icon = parts.qualityIconPath("brasstacks", "icons/industrial-drill-head.png"),
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "ea3",
      stack_size = 50
    }
  })
end

if mods["space-exploration"] then
  data:extend({
    {
        type = "item-subgroup",
        name = "zinc",
        group = "resources",
        order = "a-h-z-a",
    },
    {
      type = "item",
      name = "zinc-ingot",
      icon = parts.qualityIconPath("brasstacks", "icons/zinc-ingot.png"),
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "???",
      stack_size = 50
    },
    {
      type = "item",
      name = "brass-ingot",
      icon = parts.qualityIconPath("brasstacks", "icons/brass-ingot.png"),
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "???",
      stack_size = 50
    },
    {
      type = "fluid",
      name = "molten-zinc",
      icon = parts.qualityIconPath("brasstacks", "icons/molten-zinc.png"),
      icon_size = 64,
      subgroup = "fluid",
      order = "a[molten]-b2",
      default_temperature = 419,
      max_temperature = 419,
      base_color = {r=0.8, g=0.8, b=0.8, a=1},
      flow_color = {r=1, g=1, b=1, a=1},
      auto_barrel = false
    }
  })
end

if mods["FreightForwarding"] then
  data:extend({
    {
      type = "item",
      name = "brazen-nodule",
      icon = parts.qualityIconPath("brasstacks", "icons/brazen-nodule.png"),
      icon_size = 64,
      subgroup = "raw-resource",
      order = "w[nodule]-d[brazen]",
      stack_size = 1,
      ic_create_container = false
    }
  })
end

if mods["248k-Redux"] then
  data:extend({
    {
      type = "fluid",
      name = "248k-zinc-atom",
      icon = "__BrassTacks-Updated__/graphics/icons/248k-zinc-atom.png",
      icon_size = 64,
      subgroup = "fu_item_subgroup_f",
      order = "a-a",
      default_temperature = 1000,
      max_temperature = 1000,
      base_color = {r=0.0, g=0.3, b=0.4, a=1},
      flow_color = {r=0, g=0.3, b=0.4, a=1}
    },
    {
      type = "fluid",
      name = "248k-zinc-atom-hot",
      icons = {
          {
            icon = "__BrassTacks-Updated__/graphics/icons/248k-zinc-atom.png",
            icon_size = 64,
          },
          {
            icon = "__core__/graphics/arrows/heat-exchange-indication.png",
            icon_size = 48, icon_mipmaps = 4,
            scale = 0.5,
            shift = {-6, -6}
          }
      },
      subgroup = "fu_item_subgroup_f",
      order = "a-a",
      default_temperature = 1000,
      max_temperature = 1000,
      base_color = {r=0.0, g=0.3, b=0.4, a=1},
      flow_color = {r=0, g=0.3, b=0.4, a=1}
    }
  })
end

if mods["LunarLandings"] then
  data:extend({
    {
      type = "item",
      name = "cheese-ore",
      icon = "__BrassTacks-Updated__/graphics/icons/cheese-ore.png",
      icon_size = 64, icon_mipmaps = 4,
      pictures =
          {
            { size = 64, filename = "__BrassTacks-Updated__/graphics/icons/cheese-ore.png",   scale = 0.25, mipmap_count = 4 },
            { size = 64, filename = "__BrassTacks-Updated__/graphics/icons/cheese-ore-1.png", scale = 0.25, mipmap_count = 4 },
            { size = 64, filename = "__BrassTacks-Updated__/graphics/icons/cheese-ore-2.png", scale = 0.25, mipmap_count = 4 },
            { size = 64, filename = "__BrassTacks-Updated__/graphics/icons/cheese-ore-3.png", scale = 0.25, mipmap_count = 4 }
          },
      subgroup = "raw-resource",
      order = "h2",
      stack_size = stacksize_override or 50,
      ib_badge = "Ch"
    }
  })
end
