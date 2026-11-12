local parts = require("variable-parts")

local stacksize_override = nil
if mods["Krastorio2"] then
  --stacksize_override = tonumber(settings.startup["kr-stack-size"].value)
end

if not mods["galdocs-manufacturing"] then
  data:extend({
    {
      type = "item",
      name = "nickel-ore",
      icon = "__IfNickel-Updated__/graphics/icons/nickel-ore.png",
      icon_size = 64, icon_mipmaps = 4,
      pictures =
          {
            { size = 64, filename = "__IfNickel-Updated__/graphics/icons/nickel-ore.png",   scale = 0.5, mipmap_count = 4 },
            { size = 64, filename = "__IfNickel-Updated__/graphics/icons/nickel-ore-1.png", scale = 0.5, mipmap_count = 4 },
            { size = 64, filename = "__IfNickel-Updated__/graphics/icons/nickel-ore-2.png", scale = 0.5, mipmap_count = 4 },
            { size = 64, filename = "__IfNickel-Updated__/graphics/icons/nickel-ore-3.png", scale = 0.5, mipmap_count = 4 }
          },
      subgroup = "raw-resource",
      --copper = e
      order = "f",
      stack_size = stacksize_override or 50
    },
    {
      type = "item",
      name = "nickel-plate",
      icon = "__IfNickel-Updated__/graphics/icons/nickel-plate.png",
      icon_size = 64,
      subgroup = "raw-material",
      --copper = c
      order = "cb",
      stack_size = stacksize_override or 100
    },
    {
      type = "item",
      name = "invar-plate",
      icon = "__IfNickel-Updated__/graphics/icons/invar-plate.png",
      icon_size = 64,
      subgroup = "raw-material",
      --steel=d
      order = "db",
      stack_size = stacksize_override or 100
    }
  })
end

data:extend({
  {
    type = "item",
    name = "invar-valve",
    icon = "__IfNickel-Updated__/graphics/icons/invar-valve.png",
    icon_size = 64,
    subgroup = "intermediate-product",
    order = "cf",
    stack_size = 50
  },
  {
    type = "item-subgroup",
    name = "engine-components",
    group = "intermediate-products",
    order = "fx"
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

if not mods["aai-industry"] then
  data:extend({
    {
      type = "item",
      name = "motor",
      icon = "__IfNickel-Updated__/graphics/icons/motor.png",
      icon_size = 64,
      subgroup = "intermediate-product",
      localised_name = {"item-name.motor-nickel"}, --different locale key to avoid overriding "single cylinder engine" text
      --gear = c
      order = "cb",
      stack_size = 100
    }
  })
end

if not (parts.foundryEnabled or mods["galdocs-manufacturing"]) then
  data:extend({
    {
      type = "item",
      name = "invar-precursor",
      icon = "__IfNickel-Updated__/graphics/icons/invar-precursor.png",
      icon_size = 64,
      subgroup = "raw-resource",
      order = "fa",
      ic_create_container = false,
      stack_size = stacksize_override or 50
    }
  })
end

if parts.experimental then
  data:extend({
    {
      type = "item",
      name = "motorized-articulator",
      icon = "__IfNickel-Updated__/graphics/icons/motorized-articulator.png",
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "gb",
      stack_size = 50
    },
    {
      type = "item",
      name = "flow-controller",
      icon = "__IfNickel-Updated__/graphics/icons/flow-controller.png",
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "cg",
      stack_size = 50
    },
    {
      type = "item",
      name = "cooling-fan",
      icon = "__IfNickel-Updated__/graphics/icons/cooling-fan.png",
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "ch",
      stack_size = 50
    },
    {
      type = "item",
      name = "gimbaled-thruster",
      icon = "__IfNickel-Updated__/graphics/icons/gimbaled-thruster.png",
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "na",
      stack_size = mods["LunarLandings"] and 20 or 10
    }
  })

  if mods["LunarLandings"] then
    data:extend({
      {
        type = "item",
        name = "gimbaled-thruster-packed",
        icon = "__IfNickel-Updated__/graphics/icons/gimbaled-thruster-packed.png",
        icon_size = 64,
        subgroup = "ll-packed-rocket-ingredients",
        order = "z",
        stack_size = 4
      }
    })
  end

  if not mods["galdocs-manufacturing"] then
    data:extend({
      {
        type = "item",
        name = "machining-tool",
        icon = "__IfNickel-Updated__/graphics/icons/machining-tool.png",
        icon_size = 64,
        subgroup = "intermediate-product",
        order = "nb",
        stack_size = 50
      },
      {
        type = "item",
        name = "advanced-machining-tool",
        icon = "__IfNickel-Updated__/graphics/icons/advanced-machining-tool.png",
        icon_size = 64,
        subgroup = "intermediate-product",
        order = "nc",
        stack_size = 50
      }
    })
  end
end

if mods["Krastorio2"] then
  data:extend({
    {
      type = "item",
      name = "enriched-nickel",
      icon = "__IfNickel-Updated__/graphics/icons/enriched-nickel.png",
      icon_size = 64,
      subgroup = "raw-material",
      order = "f3",
      stack_size = stacksize_override or 100
    }
  })
end

if mods["space-exploration"] then
  data:extend({
    {
        type = "item-subgroup",
        name = "nickel",
        group = "resources",
        order = "a-h-z-a2",
    },
    {
      type = "item",
      name = "nickel-ingot",
      icon = "__IfNickel-Updated__/graphics/icons/nickel-ingot.png",
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "???",
      stack_size = 50
    },
    {
      type = "item",
      name = "invar-ingot",
      icon = "__IfNickel-Updated__/graphics/icons/invar-ingot.png",
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "???",
      stack_size = 50
    },
    {
      type = "fluid",
      name = "molten-nickel",
      icon = "__IfNickel-Updated__/graphics/icons/molten-nickel.png",
      icon_size = 64,
      subgroup = "fluid",
      order = "a[molten]-b3",
      default_temperature = 1455,
      max_temperature = 1455,
      base_color = {r=0.1, g=0.1, b=0.9, a=1},
      flow_color = {r=0.4, g=0.4, b=1, a=1},
      auto_barrel = false
    }
  })

  if parts.experimental then
    data:extend({
      {
        type = "item",
        name = "advanced-flow-controller",
        icon = "__IfNickel-Updated__/graphics/icons/advanced-flow-controller.png",
        icon_size = 64,
        subgroup = "intermediate-product",
        order = "cga",
        stack_size = 50
      },
      {
        type = "item",
        name = "nickel-electromagnet",
        icon = "__IfNickel-Updated__/graphics/icons/nickel-electromagnet.png",
        icon_size = 64,
        subgroup = "electronic",
        order = "b-02-b",
        stack_size = 100
      }
    })
  end
end

if parts.nitinol then
  data:extend({
    {
      type = "item",
      name = "nitinol-plate",
      icon = "__IfNickel-Updated__/graphics/icons/nitinol-plate.png",
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "???",
      stack_size = stacksize_override or 100
    },
    {
      type = "item",
      name = "nitinol-mesh",
      icon = "__IfNickel-Updated__/graphics/icons/nitinol-mesh.png",
      icon_size = 64,
      subgroup = "advanced-assembling",
      order = "g",
      stack_size = 50
    },
    {
      type = "item",
      name = "self-regulating-valve",
      icon = "__IfNickel-Updated__/graphics/icons/self-regulating-valve.png",
      icon_size = 64,
      subgroup = "advanced-assembling",
      order = "h",
      stack_size = 50
    }
  })
  if not (parts.foundryEnabled or mods["Krastorio2"]) then
    data:extend({
      {
        type = "item",
        name = "nitinol-precursor",
        icon = "__IfNickel-Updated__/graphics/icons/nitinol-precursor.png",
        icon_size = 64,
        subgroup = "intermediate-product",
        order = "???",
        stack_size = 50
      }
    })
  end
end

if mods["FreightForwarding"] then
  data:extend({
    {
      type = "item",
      name = "meteoric-nodule",
      icon = "__IfNickel-Updated__/graphics/icons/meteoric-nodule.png",
      icon_size = 64,
      subgroup = "raw-resource",
      order = "w[nodule]-e[meteoric]",
      stack_size = 1,
      ic_create_container = false
    }
  })
end

if mods["248k-Redux"] then
  data:extend({
    {
      type = "fluid",
      name = "248k-nickel-atom",
      icon = "__IfNickel-Updated__/graphics/icons/248k-nickel-atom.png",
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
      name = "248k-nickel-atom-hot",
      icons = {
          {
            icon = "__IfNickel-Updated__/graphics/icons/248k-nickel-atom.png",
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
