local Recipe_old = require("__all-the-overhaul-modpack__/util/legacy-recipe")

-- "electronics" is the recipe category of the electronics assembling machines (mini assemblers). It is not a vanilla
-- category but comes from a dependency. Many mods dropped such shared categories for Factorio 2.1 in favour of
-- RecipePrototype::categories, so it is created here if no other mod provides it anymore.
atom.util.recipe.ensureCategory("electronics")

-- Categories that are gone in the 2.1 versions of the dependencies are skipped instead of breaking the load
local existingCategories = atom.util.recipe.existingCategories

data.raw["assembling-machine"]["mini-assembler-1"].crafting_categories = existingCategories({ "electronics" })
data.raw["assembling-machine"]["mini-assembler-2"].crafting_categories = existingCategories({ "electronics", "electronics-machine" })
data.raw["assembling-machine"]["mini-assembler-3"].crafting_categories = existingCategories({ "electronics", "electronics-machine", "crafting-or-electromagnetics" })
data.raw["assembling-machine"]["mini-assembler-4"].crafting_categories = table.deepcopy(data.raw["assembling-machine"]["mini-assembler-3"].crafting_categories)
data.raw["assembling-machine"]["mini-assembler-5"].crafting_categories = table.deepcopy(data.raw["assembling-machine"]["mini-assembler-4"].crafting_categories)
data.raw["assembling-machine"]["mini-assembler-6"].crafting_categories = table.deepcopy(data.raw["assembling-machine"]["mini-assembler-5"].crafting_categories)
data.raw["assembling-machine"]["mini-assembler-7"].crafting_categories = table.deepcopy(data.raw["assembling-machine"]["mini-assembler-6"].crafting_categories)
data.raw["assembling-machine"]["mini-assembler-8"].crafting_categories = table.deepcopy(data.raw["assembling-machine"]["mini-assembler-7"].crafting_categories)
data.raw["assembling-machine"]["mini-assembler-9"].crafting_categories = table.deepcopy(data.raw["assembling-machine"]["mini-assembler-8"].crafting_categories)
data.raw["assembling-machine"]["mini-assembler-10"].crafting_categories = table.deepcopy(data.raw["assembling-machine"]["mini-assembler-9"].crafting_categories)

-- Set crafting categories for selected recipes
-- Up to Factorio 2.0 a recipe had exactly one category and "electronics" could also be crafted by hand and in regular
-- assemblers. Since 2.1 a recipe lists every category it belongs to, so "crafting" is listed next to "electronics"
-- to keep these recipes available outside of the electronics assembling machines.
local function setElectronicsCategory(recipeName)
    local recipe = atom.util.Recipe(recipeName)
    if recipe then
        recipe.setCategories({ "crafting", "electronics" })
    end
end
setElectronicsCategory("aluminum-cable")
setElectronicsCategory("basic-electronic-components")
setElectronicsCategory("basic-electronic-components-silver")
setElectronicsCategory("kr-automation-core")
setElectronicsCategory("kr-blank-tech-card")
setElectronicsCategory("blank-tech-card-silver")
Recipe_old("kr-electronic-components"):change_category("electronics-machine")
Recipe_old("advanced-electronic-components"):change_category("electronics-machine")
Recipe_old("gold-wire"):change_category("electronics-machine")
Recipe_old("integrated-circuit"):change_category("electronics-machine")
Recipe_old("tantalum-capacitor"):change_category("electronics-machine")
Recipe_old("temperature-sensor"):change_category("electronics-machine")
Recipe_old("mlcc"):change_category("electronics-machine")
Recipe_old("nickel-electromagnet"):change_category("electronics-machine")
Recipe_old("optical-fiber"):change_category("electronics-machine")
Recipe_old("silver-wire"):change_category("electronics-machine")
Recipe_old("tinned-cable"):change_category("electronics-machine")
Recipe_old("advanced-cable"):change_category("electronics-machine")
Recipe_old("advanced-processing-unit"):change_category("electronics-machine")
