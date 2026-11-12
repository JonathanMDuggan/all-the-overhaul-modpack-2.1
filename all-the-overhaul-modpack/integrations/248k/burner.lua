data.raw.furnace["fu_burner"].energy_source.emissions_per_minute = { pollution = 100 };

function make_burner_recipe(item)
    -- fix for ElectricTrains crash
    if string.find(item, "dummy") then
        return
    end
    local recipe = {
        name = "fu_burn_" .. item .. "_recipe",
        type = 'recipe',
        categories = { 'fu_burner_category' },
        icon = '__248k-Redux-graphics__/ressources/elements/fu_oxygen.png',
        icon_size = 64,
        enabled = true,
        hidden = true,
        ingredients = {
            { type = "item", name = item, amount = 1 },
        },
        results = {},
        energy_required = 0.1,
        always_show_made_in = true,
        subgroup = 'fu_item_subgroup_f',
    }
    if data.raw.item[item].icon then
        recipe["icon"] = data.raw.item[item].icon
        recipe["icon_size"] = data.raw.item[item].icon_size
    end
    data:extend({ recipe })
end

-- Quirk kept from Factorio 2.0: science packs were "tool" prototypes and therefore not part of data.raw.item, so no
-- burn recipe was created for them. They are plain items since 2.1 and are skipped explicitly to keep it that way.
local sciencePacks = atom.util.item.getSciencePacks()

for i, _ in pairs(data.raw.item) do
    if not (data.raw.item[i].name == "fi_waste") and not sciencePacks[i] then
        if (data.raw.item["fu_burn_" .. i .. "_recipe"] == nil) then
            make_burner_recipe(data.raw.item[i].name)
        end
    end
end