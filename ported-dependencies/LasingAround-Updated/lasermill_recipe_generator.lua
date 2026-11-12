local rm = require("recipe-modify")
local tf = require("techfuncs")
local deepcopy = require("util").table.deepcopy
local flib_locale = require("__flib__.locale")

if mods["Krastorio2"] and data.raw.recipe["iron-gear-wheel"] then
  --I don't know why Krastorio is only sometimes bulkifying this recipe.
  if data.raw.recipe["iron-gear-wheel"].energy_required == 2 then
    -- recipe has been bulkified to cost of 4 plates
    data.raw.recipe["iron-gear-wheel"].lasermill.helium = 2
  else
    -- recipe remains at K2 default cost of 1 plate
    data.raw.recipe["iron-gear-wheel"].lasermill.multiply = 2
  end
end

local new_recipes = {}
local new_recipes_helium = {}
local new_recipes_multipliers = {}
local new_recipes_tech_unlocks = {}
local new_recipes_productivity = {
  "empty-amplifier-tube",
  "helium-laser",
  "carbon-dioxide-laser",
  "advanced-oil-filtration",
  "advanced-gas-processing",
  "spectroscopic-oil-filtration",
  "spectroscopic-gas-processing",
  "micron-tolerance-components",
  "invar-valve-micron-tolerance",
  "gyroscope-micron-tolerance",
  "rocket-control-unit-micron-tolerance",
  "laboratory-gear",

  "advanced-gas-reforming",
  "advanced-gas-distillation",
  "spectroscopic-gas-reforming",
  "spectroscopic-gas-distillation",

  "gimbaled-thruster-micron-tolerance",
  "advanced-rocket-control-unit",
  "polariton-laser"
}
--may as well do this here. little sense in doing two productivity passes.

local gubbins_allowed = settings.startup["lasingaround-allow-gubbins-in-mill"].value
local circuits_allowed = settings.startup["lasingaround-allow-circuits-in-mill"].value
local entities_allowed = settings.startup["lasingaround-allow-entities-in-mill"].value
local hide_duplicates = settings.startup["lasingaround-hide-duplicate-recipes"].value

local function get_main_product(recipe)
  if recipe.main_product then
    return recipe.main_product
  end
  if recipe.results and #recipe.results == 1 then
    local product = recipe.results[1]
    return product["name"]
  end
  if recipe.result then
    return recipe.result
  end
  return "???"
end

local function get_prototype(name)
  local possibilities = {"item", "fluid", "ammo", "capsule", "gun", "item-with-entity-data", "item-with-label", "module", "rail-planner", "spidertron-remote", "tool", "armor", "repair-tool"}
  for k, v in pairs(possibilities) do
    local prototype = data.raw[v][name]
    if prototype then return prototype end
  end
  log("tried to get prototype for nonexistent item/fluid: " .. name)
  return false
end

local function get_icon(name)
  local p = get_prototype(name)
  if p then
    if p.icons then return p.icons end
    if p.icon then
      return {
        {
          icon = p.icon,
          icon_size = p.icon_size,
          icon_mipmaps = p.icon_mipmaps
        }
      }
    end
    log("missing or malformed icon for item/fluid: " .. name)
    return {
      {
        icon = "__core__/graphics/icons/alerts/destroyed-icon.png",
        icon_size = 64
      }
    }
  else
    return {
      {
        icon = "__core__/graphics/icons/alerts/destroyed-icon.png",
        icon_size = 64
      }
    }
  end
end

local function make_laser_recipe_icon(recipe, position, is_space)
  local starting_icon = {}
  if recipe.icons then
    starting_icon = deepcopy(recipe.icons)
    if not position then
      if mods["icon-badges"] and recipe.ib_badge and (recipe.ib_corner == "left-top" or not recipe.ib_corner) then
        position = {8, -8}
      else
        position = {-8, -8}
      end
    end
  else if recipe.icon then
    starting_icon = {
      {
        icon = recipe.icon,
        icon_size = recipe.icon_size,
        icon_mipmaps = recipe.icon_mipmaps
      }
    }
    if not position then
      if mods["icon-badges"] and recipe.ib_badge and (recipe.ib_corner == "left-top" or not recipe.ib_corner) then
        position = {8, -8}
      else
        position = {-8, -8}
      end
    end
  else
    local product = get_main_product(recipe)
    starting_icon = deepcopy(get_icon(product))
    if not position then
      local product_prototype = get_prototype(product)
      if product_prototype and mods["icon-badges"] and product_prototype.ib_badge then
        position = {8, -8}
      else
        position = {-8, -8}
      end
    end
  end end
  table.insert(starting_icon, {
    icon = is_space and "__space-exploration-graphics__/graphics/icons/astronomic/planet-orbit.png" or "__LasingAround-Updated__/graphics/icons/laser-modifier.png",
    icon_size = 64,
    scale = 0.25,
    shift = deepcopy(position)
  })
  return starting_icon
end

local function remove_extraneous_fluids(recipe)
  if recipe.ingredients then
    local incomplete = true
    while incomplete do
      incomplete = false
      for k, ing in pairs(recipe.ingredients) do
        if ing.type == "fluid" and ing.name ~= "helium" then
          table.remove(recipe.ingredients, k)
          incomplete = true
          break
        end
      end
    end
  end
  if recipe.normal then
    remove_extraneous_fluids(recipe.normal)
  end
  if recipe.expensive then
    remove_extraneous_fluids(recipe.expensive)
  end
end

--[[
lasermill = {
  helium = 5,
  type = "welding",
  convert = false,
  productivity = false,
  unlock = "laser-mill",
  icon_offset={-8, -8},
  remove_fluids=false,
  se_variant=false,
  multiply=1
}
]]--

for name, recipe in pairs(data.raw.recipe) do
  if recipe.lasermill then
    local lasdata = recipe.lasermill
    if not((lasdata.type == "entity" and not entities_allowed) or (lasdata.type == "circuit" and not circuits_allowed) or (lasdata.type == "gubbins" and not gubbins_allowed)) then
      if lasdata.convert then
        if lasdata.remove_fluids then
          remove_extraneous_fluids(recipe)
        end
        new_recipes_helium[name] = lasdata.helium or 1
        recipe.categories = { "laser-milling-exclusive" }
        if lasdata.multiply then
          new_recipes_multipliers[recipe.name] = lasdata.multiply
        end
      end
      if (not lasdata.convert) or (mods["space-exploration"] and lasdata.se_variant and lasdata.convert) then
        local recipe_copy = deepcopy(recipe)
        if lasdata.remove_fluids then
          remove_extraneous_fluids(recipe_copy)
        end
        if lasdata.convert then
          recipe_copy.name = name .. "-in-orbit"
          recipe_copy.categories = { lasdata.se_variant }
        else
          recipe_copy.name = name .. "-in-laser-mill"
          recipe_copy.localised_name = {"?", {recipe_copy.name}, {"", {"entity-name.laser-mill"}, " > ", flib_locale.of(recipe, recipe.name)}}
          recipe_copy.categories = { "laser-milling" }
          new_recipes_helium[recipe_copy.name] = lasdata.helium or 1
          if lasdata.multiply then
            new_recipes_multipliers[recipe_copy.name] = lasdata.multiply
          end
        end

        if lasdata.icon_offset ~= false then
          recipe_copy.icons = make_laser_recipe_icon(recipe, lasdata.icon_offset, lasdata.convert)
          recipe_copy.icon = nil
          recipe_copy.icon_mipmaps = nil
        end

        if lasdata.convert then
          if recipe.localised_description then
            recipe.localised_description = {"", recipe.localised_description, "\n\n", {"recipe-description.also-made-without-helium", lasdata.se_tooltip_entity, {"entity-name." .. lasdata.se_tooltip_entity}}}
          else
            recipe.localised_description = {"?", {"", {"recipe-description." .. recipe.name}, "\n\n", {"recipe-description.also-made-without-helium", lasdata.se_tooltip_entity, {"entity-name." .. lasdata.se_tooltip_entity}}}, {"recipe-description.also-made-without-helium", lasdata.se_tooltip_entity, {"entity-name." .. lasdata.se_tooltip_entity}}}
            recipe_copy.localised_description = {"?", {"recipe-description." .. recipe_copy.name}, {"recipe-description." .. recipe.name}, ""}
          end
        else
          if recipe.localised_description then
            recipe.localised_description = {"", recipe.localised_description, "\n\n", {"recipe-description.also-made-with-helium", "laser-mill", {"entity-name.laser mill"}}}
          else
            recipe.localised_description = {"?", {"", {"recipe-description." .. recipe.name}, "\n\n", {"recipe-description.also-made-with-helium", "laser-mill", {"entity-name.laser-mill"}}}, {"recipe-description.also-made-with-helium", "laser-mill", {"entity-name.laser-mill"}}}
            recipe_copy.localised_description = {"?", {"recipe-description." .. recipe_copy.name}, {"recipe-description." .. recipe.name}, ""}
          end
        end

        if hide_duplicates then
          recipe_copy.hide_from_player_crafting = true
        end

        recipe_copy.always_show_made_in = true

        --allow more convenience for specifying this
        if lasdata.unlock == true then
          recipe_copy.enabled = true
        else
          recipe_copy.enabled = false
          if lasdata.unlock ~= false then
            if lasdata.unlock == nil then lasdata.unlock = {"laser-mill"} end
            if type(lasdata.unlock) == "string" then lasdata.unlock = {lasdata.unlock} end
            new_recipes_tech_unlocks[recipe_copy.name] = lasdata.unlock
          end
        end
        --techfuncs unlock-adding function requires the recipe to first exist in data.raw, but we are iterating over data.raw as we speak so we cannot add it here

        recipe_copy.allow_productivity = lasdata.productivity

        log("generating laser mill recipe: " .. recipe_copy.name)

        table.insert(new_recipes, recipe_copy)
      end
    end
  end
end


if #new_recipes > 0 then
  data:extend(new_recipes)
end

for name, techs in pairs(new_recipes_tech_unlocks) do
  for _, technology in pairs(techs) do
    tf.addRecipeUnlock(technology, name)
  end
end

for name, multiplier in pairs(new_recipes_multipliers) do
  rm.multiply(name, multiplier, true, true, true)
end

for name, helium in pairs(new_recipes_helium) do
  rm.AddIngredient(name, "helium", helium)
end
