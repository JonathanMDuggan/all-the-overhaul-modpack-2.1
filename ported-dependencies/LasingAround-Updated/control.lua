-- Not needed in 2.0
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

remote.add_interface("LasingAround-Milestones", {
    milestones_preset_addons = function()
        return {
            ["Lasing Around"] = {
                required_mods = {"LasingAround-Updated"},
                milestones = {
                    {type="group", name="Resources"},
                    {type="fluid",  name="helium", quantity=1},
                    {type="group", name="Progress"},
                    {type="technology", name="laser-mill", quantity=1}
                }
            }
        }
    end
})
