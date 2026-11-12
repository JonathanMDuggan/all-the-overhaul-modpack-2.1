--- Stand-in for `__jalm__/stdlib/data/recipe` (the Recipe class of the Factorio Standard Library).
---
--- ATOM used jalm ("Just Another Library Mod", a Factorio 2.0 update of Factorio-Stdlib, MIT) for four Recipe methods.
--- jalm is deprecated and has no Factorio 2.1 release, so those four methods live here now. They keep the behaviour of
--- stdlib's `stdlib/data/recipe.lua` / `stdlib/data/data.lua` (https://github.com/Afforess/Factorio-Stdlib):
---
---   Recipe(name):add_ingredient({ item_name, amount })
---   Recipe(name):replace_ingredient(old_name, { item_name, amount })
---   Recipe(name):change_category(category_name)
---   Recipe(name):set_enabled(enabled)
---
--- Behaviour kept on purpose (do not "fix" without checking every caller in integrations/5dim and friends):
---   * A recipe that does not exist is logged and every method on it is a no-op.
---   * The `{ name, amount }` shorthand only accepts items (any item prototype type), never fluids. An unknown item is
---     logged and nothing is added or replaced.
---   * add_ingredient appends without looking for an existing ingredient of the same name.
---   * replace_ingredient replaces the first matching ingredient with a fresh `{ type, name, amount }` table and does
---     nothing when the old ingredient is not part of the recipe.
---   * change_category only applies when the recipe category exists.
---
--- Factorio 2.1 difference: RecipePrototype::category was replaced by RecipePrototype::categories, so change_category
--- writes `categories = { category_name }`.
---
--- New ATOM code should use atom.util.Recipe (util/recipe.lua) instead of this module.

local Recipe = {}
Recipe.__index = Recipe

local function logMissing(what, name)
    log("ATOM legacy Recipe: " .. what .. " '" .. tostring(name) .. "' does not exist.")
end

--- Whether any item prototype (item, tool, module, ammo, ...) with this name exists. Fluids don't count.
--- @param name string
--- @return boolean
local function isItem(name)
    for itemType, _ in pairs(defines.prototypes.item) do
        local prototypes = data.raw[itemType]
        if prototypes and prototypes[name] then
            return true
        end
    end
    return false
end

--- Turns the `{ name, amount }` shorthand into an IngredientPrototype.
--- @param ingredient table `{ name, amount }`
--- @return table|nil The ingredient, or nil if the item doesn't exist
local function format(ingredient)
    if type(ingredient) ~= "table" or type(ingredient[1]) ~= "string" then
        error("ATOM legacy Recipe: only the { name, amount } ingredient shorthand is supported", 3)
    end
    local name = ingredient[1]
    if not isItem(name) then
        logMissing("item", name)
        return nil
    end
    return { type = "item", name = name, amount = ingredient[2] or 1 }
end

--- @return boolean Whether the wrapped recipe exists
function Recipe:is_valid()
    return self.prototype ~= nil
end

--- Adds an ingredient to the recipe.
--- @param ingredient table `{ name, amount }`
--- @return table self
function Recipe:add_ingredient(ingredient)
    if self:is_valid() then
        local new = format(ingredient)
        if new then
            self.prototype.ingredients = self.prototype.ingredients or {}
            table.insert(self.prototype.ingredients, new)
        end
    end
    return self
end

--- Replaces one ingredient with another.
--- @param old string The name of the ingredient to replace
--- @param ingredient table `{ name, amount }`
--- @return table self
function Recipe:replace_ingredient(old, ingredient)
    assert(old, "Missing recipe to replace")
    if self:is_valid() then
        local new = format(ingredient)
        if new then
            for i, existing in pairs(self.prototype.ingredients or {}) do
                if existing[1] == old or existing.name == old then
                    self.prototype.ingredients[i] = new
                    break
                end
            end
        end
    end
    return self
end

--- Changes the recipe category. Does nothing if the category doesn't exist.
--- @param categoryName string The new crafting category
--- @return table self
function Recipe:change_category(categoryName)
    if self:is_valid() then
        if data.raw["recipe-category"][categoryName] then
            self.prototype.categories = { categoryName }
        else
            logMissing("recipe-category", categoryName)
        end
    end
    return self
end

--- Enables or disables the recipe at the start of the game.
--- @param enabled boolean
--- @return table self
function Recipe:set_enabled(enabled)
    if self:is_valid() then
        self.prototype.enabled = enabled
    end
    return self
end

--- @param name string The name of the recipe
--- @return table The wrapped recipe. All methods are no-ops if the recipe doesn't exist.
return setmetatable({}, {
    __call = function(_, name)
        local prototype = data.raw.recipe[name]
        if not prototype then
            logMissing("recipe", name)
        end
        return setmetatable({ prototype = prototype }, Recipe)
    end
})
