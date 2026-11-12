-- Unnecessary in 2.0
-- script.on_configuration_changed(
--   function()
--     for redacted, theForce in pairs(game.forces) do
--       for k, v in pairs(theForce.technologies) do
--         if v.researched then
--           for k2, v2 in pairs(v.effects) do
--             if v2.recipe then
--               theForce.recipes[v2.recipe].enabled = true
--             end
--           end
--         end
--       end
--     end
--   end
-- )


script.on_init(
  function()
    local luna = game.surfaces["luna"]
    if script.active_mods["LunarLandings"] and (not script.active_mods["BrassTacks-Updated"]) and luna then
      local cheese_settings = game.surfaces.nauvis.map_gen_settings.autoplace_controls["cheese-ore"]
      local mgs = luna.map_gen_settings
      mgs.autoplace_controls["cheese-ore"] = cheese_settings
      mgs.autoplace_settings.entity.settings["cheese-ore"] = cheese_settings
      luna.map_gen_settings = mgs
      luna.regenerate_entity("cheese-ore")
    end
  end
)

remote.add_interface("ThemTharHills-Milestones", {
    milestones_preset_addons = function()
        return {
            ["Them Thar Hills"] = {
                required_mods = {"ThemTharHills-Updated"},
                forbidden_mods = {"248k-Redux"},
                milestones = {
                    {type="group", name="Resources"},
                    {type="item",  name="gold-plate", quantity=1}
                }
            }
        }
    end
})
