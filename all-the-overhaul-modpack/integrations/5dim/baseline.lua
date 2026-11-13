--- Keeps the 5dim modules the way they were when ATOM was balanced (their Factorio 2.0 releases).
---
--- For Factorio 2.1 the 5dim mods were reworked: a cost calculator re-prices every recipe and technology, machine and
--- turret stats follow new formulas, and 5dim_battlefield gained a lot of content (artillery turrets and shells, slow
--- turrets, land mines, grenades, capsules, combat robots, sniper rifle, ...). ATOM's integration edits are written
--- relative to the 2.0 values ("replace steel with X", "add Y"), so they need the 2.0 values underneath.
---
--- baseline-data.lua lists every value that differs between the 2.0 and the 2.1 releases, taken from prototype
--- snapshots of both (base game + 5dim_core, _automation, _nuclear, _resources, _battlefield only).
--- baseline-new-content.lua lists the prototypes that did not exist in 2.0. Both files are generated.
---
--- A value is only reset while it still is exactly what 5dim 2.1 set. Anything another mod (or ATOM) changed in the
--- meantime is left alone. That makes it safe to run this at the start of every data stage.
---
--- Known limits: values are compared after 5dim's own three stages with only the base game present; ingredient lists
--- are merged per ingredient, so a recipe another mod already rewrote is only partly restored.

local entries = require("__all-the-overhaul-modpack__/integrations/5dim/baseline-data")
local newContent = require("__all-the-overhaul-modpack__/integrations/5dim/baseline-new-content")

local function keyOf(element)
    if type(element) ~= "table" then
        return nil
    end
    return element.name or element.type or element[1]
end

local function find(list, key)
    for i, element in pairs(list) do
        if tostring(keyOf(element)) == key then
            return i
        end
    end
    return nil
end

--- Whether `current` still has the value 5dim 2.1 gave it. Keys the snapshot didn't record (graphics, sounds) are ignored.
local function same(current, expected)
    if type(current) == "number" and type(expected) == "number" then
        return math.abs(current - expected) <= 1e-9 * math.max(1, math.abs(current), math.abs(expected))
    end
    if type(current) ~= type(expected) then
        return false
    end
    if type(expected) == "table" then
        if #expected > 0 and #expected ~= #current then
            return false
        end
        for k, v in pairs(expected) do
            if not same(current[k], v) then
                return false
            end
        end
        return true
    end
    return current == expected
end

local function step(current, part)
    if type(current) ~= "table" then
        return nil, nil
    end
    if type(part) == "table" then
        local index = find(current, part[2])
        return index and current[index], index
    end
    return current[part], part
end

local function applyEntry(entry)
    local prototype = data.raw[entry[1]] and data.raw[entry[1]][entry[2]]
    if not prototype then
        return false
    end
    local path, operation, old, new = entry[3], entry[4], entry[5], entry[6]
    local parent = prototype
    local last = operation == "set" or operation == "unset"
    for i = 1, #path - (last and 1 or 0) do
        parent = step(parent, path[i])
        if parent == nil then
            return false
        end
    end
    if type(parent) ~= "table" then
        return false
    end
    if operation == "set" or operation == "unset" then
        local current, key = step(parent, path[#path])
        if key == nil or current == nil or not same(current, new) then
            return false
        end
        if type(old) == "table" and type(current) == "table" and #old == 0 and next(old) ~= nil then
            for k, v in pairs(old) do
                current[k] = table.deepcopy(v)
            end
        else
            parent[key] = table.deepcopy(old)
        end
        return true
    elseif operation == "add" then
        if find(parent, tostring(keyOf(old))) then
            return false
        end
        table.insert(parent, table.deepcopy(old))
        return true
    elseif operation == "remove" then
        local index = find(parent, tostring(keyOf(new)))
        if not index or not same(parent[index], new) then
            return false
        end
        table.remove(parent, index)
        return true
    end
    return false
end

local function hideNewContent()
    local hiddenTechnologies, hiddenRecipes, hiddenEntities = {}, {}, {}
    for _, name in pairs(newContent.technology or {}) do
        local technology = data.raw.technology[name]
        if technology then
            technology.hidden = true
            technology.enabled = false
            hiddenTechnologies[name] = true
        end
    end
    for _, name in pairs(newContent.recipe or {}) do
        local recipe = data.raw.recipe[name]
        if recipe then
            recipe.hidden = true
            recipe.enabled = false
            hiddenRecipes[name] = true
        end
    end
    for _, itemType in pairs({ "item", "capsule", "ammo", "gun" }) do
        for _, name in pairs(newContent[itemType] or {}) do
            local item = data.raw[itemType] and data.raw[itemType][name]
            if item then
                item.hidden = true
                if item.place_result then
                    hiddenEntities[item.place_result] = true
                end
            end
        end
    end
    -- An entity may not upgrade to something whose item is hidden
    for entityType in pairs(defines.prototypes.entity) do
        for _, entity in pairs(data.raw[entityType] or {}) do
            if entity.next_upgrade and hiddenEntities[entity.next_upgrade] then
                entity.next_upgrade = nil
            end
        end
    end
    for name, technology in pairs(data.raw.technology) do
        if not hiddenTechnologies[name] then
            for i = #(technology.prerequisites or {}), 1, -1 do
                if hiddenTechnologies[technology.prerequisites[i]] then
                    table.remove(technology.prerequisites, i)
                end
            end
            for i = #(technology.effects or {}), 1, -1 do
                local effect = technology.effects[i]
                if effect.type == "unlock-recipe" and hiddenRecipes[effect.recipe] then
                    table.remove(technology.effects, i)
                end
            end
        end
    end
end

--- @param stage string "data", "updates" or "final-fixes"
return function(stage)
    local applied = 0
    for _, entry in ipairs(entries) do
        -- Something that is missing after the data stage was removed or replaced on purpose by another mod or by ATOM
        -- (as it was with the 2.0 releases), so missing entries are only added back in the data stage.
        if (entry[4] ~= "add" or stage == "data") and applyEntry(entry) then
            applied = applied + 1
        end
    end
    hideNewContent()
    log("ATOM 5dim 2.0 baseline (" .. stage .. "): reset " .. applied .. " of " .. #entries .. " values")
end
