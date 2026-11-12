local parts = require("variable-parts")

local stacksize_override = nil
if mods["Krastorio2"] then
  --stacksize_override = tonumber(settings.startup["kr-stack-size"].value)
end

data:extend({
  {
    type = "item",
    name = "gold-ore",
    icon = "__ThemTharHills-Updated__/graphics/icons/gold-ore.png",
    icon_size = 64, icon_mipmaps = 4,
    pictures =
        {
          { size = 64, filename = "__ThemTharHills-Updated__/graphics/icons/gold-ore.png",   scale = 0.5, mipmap_count = 4 },
          { size = 64, filename = "__ThemTharHills-Updated__/graphics/icons/gold-ore-1.png", scale = 0.5, mipmap_count = 4 },
          { size = 64, filename = "__ThemTharHills-Updated__/graphics/icons/gold-ore-2.png", scale = 0.5, mipmap_count = 4 },
          { size = 64, filename = "__ThemTharHills-Updated__/graphics/icons/gold-ore-3.png", scale = 0.5, mipmap_count = 4 }
        },
    subgroup = "raw-resource",
    order = "j",
    stack_size = stacksize_override or 50,
    ib_badge = "Au"
  },
  {
    type = "item",
    name = "gold-powder",
    icon = "__ThemTharHills-Updated__/graphics/icons/gold-powder.png",
    icon_size = 64,
    subgroup = "raw-resource",
    order = "ja",
    stack_size = stacksize_override or 200,
    ib_badge = "Au"
  },
  {
    type = "item",
    name = parts.gold,
    icon = "__ThemTharHills-Updated__/graphics/icons/gold-plate.png",
    icon_size = 64,
    subgroup = "raw-material",
    order = "h",
    stack_size = stacksize_override or 100,
    ib_badge = "Au"
  },
  {
    type = "item",
    name = parts.wire,
    icon = "__ThemTharHills-Updated__/graphics/icons/gold-wire.png",
    icon_size = 64,
    subgroup = "cable",
    order = "f",
    stack_size = 200,
    ib_badge = "Au"
  },
  {
    type = "item",
    name = "transceiver",
    icon = "__ThemTharHills-Updated__/graphics/icons/transceiver.png",
    icon_size = 64,
    subgroup = "intermediate-product",
    order = "gb",
    stack_size = 100
  },
  {
    type = "item",
    name = "advanced-cable",
    icon = "__ThemTharHills-Updated__/graphics/icons/advanced-cable.png",
    icon_size = 64,
    subgroup = "intermediate-product",
    order = "z",
    stack_size = 100
  },
  {
    type = "item",
    name = "hv-power-regulator",
    icon = "__ThemTharHills-Updated__/graphics/icons/hv-power-regulator.png",
    icon_size = 64,
    subgroup = "intermediate-product",
    order = "gcb",
    stack_size = 50
  },
  {
    type = "item",
    name = "integrated-circuit",
    icon = "__ThemTharHills-Updated__/graphics/icons/integrated-circuit.png",
    icon_size = 64,
    subgroup = "generic-circuits",
    order = "z",
    stack_size = 100
  },
  {
    type = "item-subgroup",
    name = "advanced-chemicals", --by which i mean 'not oil fractions'
    group = "intermediate-products",
    order = "ab"
  },
  {
    type = "item-subgroup",
    name = "cable",
    group = "intermediate-products",
    order = mods["space-exploration"] and "a-am" or "f-z"
  },
  {
    type = "item-subgroup",
    name = "fiddly-electrical-gubbins",
    group = "intermediate-products",
    order = "f-za"
  },
  {
    type = "item-subgroup",
    name = "generic-circuits",
    group = "intermediate-products",
    order = "f-zb"
  },
  {
    type = "item-subgroup",
    name = "specialized-electronics",
    group = "intermediate-products",
    order = "f-zc"
  }
})

if mods["Krastorio2"] then
  data:extend({
  {
    type = "item",
    name = "potassium-nitrate",
    icon = "__ThemTharHills-Updated__/graphics/icons/potassium-nitrate.png",
    icon_size = 64,
    subgroup = "raw-material",
    order = "ga",
    stack_size = stacksize_override or 100
  }
  })
else
  data:extend({
  {
    type = "fluid",
    name = "nitric-acid",
    icon = "__ThemTharHills-Updated__/graphics/icons/nitric-acid.png",
    icon_size = 64,
    subgroup = "fluid",
    order = "g",
    default_temperature = 25,
    max_temperature = 25,
    base_color = {r=0.75, g=0.75, b=1, a=1},
    flow_color = {r=1, g=1, b=1, a=1},
    auto_barrel = true
  }
  })
end

if parts.aquaregia then
  data:extend({
  {
    type = "fluid",
    name = "aqua-regia",
    icon = "__ThemTharHills-Updated__/graphics/icons/aqua-regia.png",
    icon_size = 64,
    subgroup = "fluid",
    order = "ga",
    default_temperature = 25,
    max_temperature = 25,
    base_color = {r=1, g=0.2, b=0, a=1},
    flow_color = {r=1, g=1, b=1, a=1},
    auto_barrel = true
  }
  })
end

if mods["space-exploration"] then
  data:extend({
    {
        type = "item-subgroup",
        name = "gold",
        group = "resources",
        order = "a-h-z-a",
    },
    {
      type = "item",
      name = "gold-ingot",
      icon = "__ThemTharHills-Updated__/graphics/icons/gold-ingot.png",
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "???",
      stack_size = 50
    },
    {
      type = "fluid",
      name = "molten-gold",
      icon = "__ThemTharHills-Updated__/graphics/icons/molten-gold.png",
      icon_size = 64,
      subgroup = "fluid",
      order = "a[molten]-b2",
      default_temperature = 1064,
      max_temperature = 1064,
      base_color = {r=1, g=0.8, b=0, a=1},
      flow_color = {r=1, g=1, b=0, a=1},
      auto_barrel = false
    }
  })
end

if mods["FreightForwarding"] then
  data:extend({
    {
      type = "item",
      name = "noble-nodule",
      icon = "__ThemTharHills-Updated__/graphics/icons/noble-nodule.png",
      icon_size = 64,
      subgroup = "raw-resource",
      order = "w[nodule]-f[noble]",
      stack_size = 1,
      ic_create_container = false,
      ib_badge = "Au"
    }
  })
end

if mods["LunarLandings"] and not mods["BrassTacks-Updated"] then
  data:extend({
    {
      type = "item",
      name = "cheese-ore",
      icon = "__ThemTharHills-Updated__/graphics/icons/cheese-ore.png",
      icon_size = 64, icon_mipmaps = 4,
      pictures =
          {
            { size = 64, filename = "__ThemTharHills-Updated__/graphics/icons/cheese-ore.png",   scale = 0.25, mipmap_count = 4 },
            { size = 64, filename = "__ThemTharHills-Updated__/graphics/icons/cheese-ore-1.png", scale = 0.25, mipmap_count = 4 },
            { size = 64, filename = "__ThemTharHills-Updated__/graphics/icons/cheese-ore-2.png", scale = 0.25, mipmap_count = 4 },
            { size = 64, filename = "__ThemTharHills-Updated__/graphics/icons/cheese-ore-3.png", scale = 0.25, mipmap_count = 4 }
          },
      subgroup = "raw-resource",
      order = "h2",
      stack_size = stacksize_override or 50,
      ib_badge = "Ch"
    }
  })
end
