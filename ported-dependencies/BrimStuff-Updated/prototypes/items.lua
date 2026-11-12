local parts = require("variable-parts")

local stacksize_override = nil
if mods["Krastorio2"] then
  --stacksize_override = tonumber(settings.startup["kr-stack-size"].value)
end

data:extend({
  {
    type = "item",
    name = "rubber",
    icon = "__BrimStuff-Updated__/graphics/icons/rubber.png",
    icon_size = 64,
    subgroup = parts.green and "brimstuff-botany" or "raw-material",
    order = "gc",
    stack_size = stacksize_override or 100
  },
  {
    type = "item",
    name = "potassium-nitrate",
    icon = "__BrimStuff-Updated__/graphics/icons/potassium-nitrate.png",
    icon_size = 64,
    subgroup = "raw-material",
    order = "ga",
    stack_size = stacksize_override or 100,
    ib_badge = "KN"
  },
  {
    type = "item",
    name = "gunpowder",
    icon = "__BrimStuff-Updated__/graphics/icons/gunpowder.png",
    icon_size = 64,
    subgroup = mods["space-exploration"] and "chemical" or "raw-material",
    order = "gb",
    stack_size = stacksize_override or 100
  },
  {
    type = "item",
    name = "toluene",
    icon = "__BrimStuff-Updated__/graphics/icons/toluene.png",
    icon_size = 64,
    subgroup = "raw-material",
    order = "gc",
    stack_size = stacksize_override or 100,
    fuel_categories = { "chemical" },
    fuel_value = "1MJ"
  },
  {
    type = "item",
    name = "drive-belt",
    icon = "__BrimStuff-Updated__/graphics/icons/drive-belt.png",
    icon_size = 64,
    subgroup = "intermediate-product",
    order = "gc",
    stack_size = 100
  },
  {
    type = "item-subgroup",
    name = "advanced-chemicals", --by which i mean 'not oil fractions'
    group = "intermediate-products",
    order = "ab"
  }
})

if parts.waste then
  data:extend({
    {
      type = "fluid",
      name = "chemical-waste",
      icon = "__BrimStuff-Updated__/graphics/icons/chemical-waste.png",
      icon_size = 64,
      subgroup = "fluid",
      order = "h",
      default_temperature = 25,
      max_temperature = 100,
      base_color = {r=0.5, g=0, b=0.8, a=1},
      flow_color = {r=1, g=0, b=1, a=1},
      auto_barrel = true,
    },
    {
      type = "item-subgroup",
      name = "waste-treatment",
      group = "intermediate-products",
      order = "ad"
    }
  })
  if mods["ThemTharHills-Updated"] then
    data:extend({
      {
        type = "fluid",
        name = "depleted-acid",
        icon = "__BrimStuff-Updated__/graphics/icons/depleted-acid.png",
        icon_size = 64,
        subgroup = "fluid",
        order = "i",
        default_temperature = 25,
        max_temperature = 100,
        base_color = {r=0, g=0.6, b=0.8, a=1},
        flow_color = {r=0, g=1, b=1, a=1},
        auto_barrel = true,
      }
    })
  end
  if mods["space-exploration"] then
    data:extend{
      {
        type = "item",
        name = "pollution-nodule",
        icon = "__BrimStuff-Updated__/graphics/icons/pollution-nodule.png",
        icon_size = 64,
        subgroup = "waste-treatment",
        order = "k",
        stack_size = stacksize_override or 200
      }
    }
  end
end

if not mods["Krastorio2"] then
  data:extend({
  {
    type = "fluid",
    name = "nitric-acid",
    icon = "__BrimStuff-Updated__/graphics/icons/nitric-acid.png",
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

if parts.bz.gas then
  data:extend({
    {
      type = "item",
      name = "tnt",
      icon = "__BrimStuff-Updated__/graphics/icons/tnt.png",
      icon_size = 64,
      subgroup = mods["space-exploration"] and "chemical" or "raw-material",
      order = "ii",
      stack_size = 100
    }
  })
end

if parts.bz.carbon and not mods["BrassTacks-Updated"] then
  data:extend({
    {
      type = "item",
      name = "gasket",
      icon = "__BrimStuff-Updated__/graphics/icons/gasket.png",
      icon_size = 64,
      order = "d",
      subgroup = "intermediate-product",
      stack_size = 100
    }
  })
end
