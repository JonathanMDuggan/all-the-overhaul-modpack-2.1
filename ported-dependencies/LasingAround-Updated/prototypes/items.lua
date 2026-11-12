local parts = require("variable-parts")

local stacksize_override = nil
if mods["Krastorio2"] then
  --stacksize_override = tonumber(settings.startup["kr-stack-size"].value)
end

data:extend({
  {
      type = "item-subgroup",
      name = "effector-components",
      group = "intermediate-products",
      order = mods["space-exploration"] and "a-d-c" or "f-zd",
  },
  {
      type = "item-subgroup",
      name = "helium",
      group = mods["space-exploration"] and  "resources" or "intermediate-products",
      order = "a-ab",
  },
  {
    type = "fluid",
    name = "helium",
    icon = "__LasingAround-Updated__/graphics/icons/helium.png",
    icon_size = 64,
    subgroup = "fluid",
    order = "a[fluid]-f",
    default_temperature = 25,
    max_temperature = 25,
    base_color = {r=0.75, g=1, b=0.9, a=1},
    flow_color = {r=1, g=1, b=1, a=1},
    auto_barrel = true
  },
  {
    type = "fluid",
    name = "filtered-oil",
    icon = "__base__/graphics/icons/fluid/crude-oil.png",
    icon_size = 64,
    subgroup = "fluid",
    order = "a[fluid]-bc",
    default_temperature = 25,
    max_temperature = 25,
    base_color = data.raw.fluid["crude-oil"].base_color,
    flow_color = data.raw.fluid["crude-oil"].flow_color,
    auto_barrel = true
  },
  {
    type = "item",
    name = "empty-amplifier-tube",
    icon = "__LasingAround-Updated__/graphics/icons/empty-amplifier-tube.png",
    icon_size = 64,
    subgroup = "effector-components",
    order = "a",
    stack_size = 100
  },
  {
    type = "item",
    name = "helium-laser",
    icon = "__LasingAround-Updated__/graphics/icons/helium-laser.png",
    icon_size = 64,
    pictures = {
      layers = {
        {
          size = 64,
          filename = "__LasingAround-Updated__/graphics/icons/helium-laser.png",
          scale = 0.25
        },
        {
          filename = "__LasingAround-Updated__/graphics/icons/helium-laser-glow.png",
          size = 64,
          scale = 0.25,
          draw_as_light = true
        }
      }
    },
    subgroup = "effector-components",
    order = "b",
    stack_size = 50
  },
  {
    type = "item",
    name = "carbon-dioxide-laser",
    icon = "__LasingAround-Updated__/graphics/icons/carbon-dioxide-laser.png",
    icon_size = 64,
    pictures = {
      layers = {
        {
          size = 64,
          filename = "__LasingAround-Updated__/graphics/icons/carbon-dioxide-laser.png",
          scale = 0.25
        },
        {
          filename = "__LasingAround-Updated__/graphics/icons/carbon-dioxide-laser-glow.png",
          size = 128,
          scale = 0.25,
          draw_as_light = true
        }
      }
    },
    subgroup = "effector-components",
    order = "c",
    stack_size = 50
  },
  {
    type = "item",
    name = "scanner",
    icon = "__LasingAround-Updated__/graphics/icons/scanner.png",
    icon_size = 64,
    subgroup = "effector-components",
    order = "d",
    stack_size = 50
  },
  {
    type = "item",
    name = "spectroscope",
    icon = "__LasingAround-Updated__/graphics/icons/spectroscope.png",
    icon_size = 64,
    subgroup = "effector-components",
    order = "e",
    stack_size = 50
  }
})

if mods["IfNickel-Updated"] and (mods["space-exploration"] or parts.nickelExperiment) then
  data:extend({
    {
      type = "item",
      name = "micron-tolerance-components",
      icon = "__LasingAround-Updated__/graphics/icons/micron-tolerance-components.png",
      icon_size = 64,
      pictures =
      {
        { size = 64, filename = "__LasingAround-Updated__/graphics/icons/micron-tolerance-components-1.png", scale = 0.25},
        { size = 64, filename = "__LasingAround-Updated__/graphics/icons/micron-tolerance-components-2.png", scale = 0.25},
        { size = 64, filename = "__LasingAround-Updated__/graphics/icons/micron-tolerance-components-3.png", scale = 0.25},
        { size = 64, filename = "__LasingAround-Updated__/graphics/icons/micron-tolerance-components-4.png", scale = 0.25}
      },
      subgroup = "intermediate-product",
      order = "zote the mighty",
      stack_size = stacksize_override or 100
    }
  })
  if mods["space-exploration"] then
    data:extend({
      {
        type = "item",
        name = "laboratory-gear",
        icon = "__LasingAround-Updated__/graphics/icons/laboratory-gear.png",
        icon_size = 64,
        subgroup = "advanced-assembling",
        order = "y",
        stack_size = 50
      }
    })
  end
end

if mods["ThemTharHills-Updated"] and (data.raw.item["gyroscope"] or data.raw.item["gyro"]) then
  data:extend({
    {
     type = "item",
     name = "tracker",
     icon = "__LasingAround-Updated__/graphics/icons/tracker.png",
     icon_size = 64,
     pictures = {
       layers = {
         {
           size = 64,
           filename = "__LasingAround-Updated__/graphics/icons/tracker.png",
           scale = 0.5
         },
         {
           filename = "__LasingAround-Updated__/graphics/icons/tracker-glow.png",
           size = 64,
           scale = 0.5,
           draw_as_light = true
         }
       }
     },
     subgroup = "effector-components",
     order = "f",
     stack_size = 50
    }
  })
end

--It's not generally kosher to do this before data-updates but we need to get there before barrel recipes get generated.
data.raw.fluid["crude-oil"].icon = "__LasingAround-Updated__/graphics/icons/crude-oil.png"
data.raw.fluid["crude-oil"].flow_color = {r=0.5, g=0.35, b=0.2}
data.raw.fluid["crude-oil"].base_color = {r=0.25, g=0.15, b=0.0}
