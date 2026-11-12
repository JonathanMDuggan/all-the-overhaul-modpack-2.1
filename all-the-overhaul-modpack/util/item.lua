atom.util.item = {
    --- Removes an item by name together with all its dependencies
    --- @param name string The name of the item
    removeByName = function(name)
        local isFluid = data.raw.fluid[name] ~= nil
        atom.util.recipe.removeByItem(name)

        --- Remove filters from fluid_boxes
        --- See https://lua-api.factorio.com/latest/types/FluidBox.html#filter
        if (isFluid) then
            local function removeFilter(category)
                if not data.raw[category] then return end
                for _, entity in pairs(data.raw[category]) do
                    if (entity.fluid_boxes) then
                        for _, fluidBox in pairs(entity.fluid_boxes) do
                            if (type(fluidBox) == "table" and fluidBox.filter == name) then
                                fluidBox.filter = nil
                            end
                        end
                    end
                end
            end
            for type in pairs(defines.prototypes['entity']) do
                removeFilter(type)
            end
        end

        data.raw.item[name] = nil
        data.raw.fluid[name] = nil
        data.raw.capsule[name] = nil
    end,

    --- Removes the source item by renaming all instances to the target name.
    --- Used to merge two identical items with different names.
    --- @param sourceName string The item you want to replace with the target
    --- @param targetName string The item you want to keep
    migrate = function(sourceName, targetName)
        local isFluid = data.raw.fluid[targetName] ~= nil
        atom.util.recipe.replaceIngredient(sourceName, targetName)
        atom.util.recipe.replaceResult(sourceName, targetName)

        --- Change filters in fluid_boxes
        --- See https://lua-api.factorio.com/latest/types/FluidBox.html#filter
        if (isFluid) then
            local function changeFilter(category)
                if not data.raw[category] then return end
                for _, entity in pairs(data.raw[category]) do
                    if (entity.fluid_boxes) then
                        for _, fluidBox in pairs(entity.fluid_boxes) do
                            if (type(fluidBox) == "table" and fluidBox.filter == sourceName) then
                                fluidBox.filter = targetName
                            end
                        end
                    end
                end
            end
            for type in pairs(defines.prototypes['entity']) do
                changeFilter(type)
            end
        end

        data.raw.item[sourceName] = nil
        data.raw.fluid[sourceName] = nil
        data.raw.capsule[sourceName] = nil
    end,

    --- Returns the names of all science packs: every item that is accepted by a lab or needed by a technology.
    --- Up to Factorio 2.0 these had to be "tool" prototypes and were therefore never part of data.raw.item.
    --- Since 2.1 science packs are plain items (vanilla and most mods converted theirs). Code that walks data.raw.item
    --- uses this set to keep treating science packs the way it did before.
    --- @return table<string, boolean> A set of item names
    getSciencePacks = function()
        local result = {}
        for _, lab in pairs(data.raw.lab) do
            for _, input in pairs(lab.inputs or {}) do
                result[input] = true
            end
        end
        for _, technology in pairs(data.raw.technology) do
            if technology.unit and technology.unit.ingredients then
                for _, ingredient in pairs(technology.unit.ingredients) do
                    local name = ingredient[1] or ingredient.name
                    if name then
                        result[name] = true
                    end
                end
            end
        end
        return result
    end
}
