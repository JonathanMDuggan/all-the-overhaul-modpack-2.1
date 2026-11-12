script.on_init(
  function()
    if remote.interfaces["freeplay"] then
      local care_package = remote.call("freeplay", "get_created_items")
      care_package["gunpowder"] = 100
      remote.call("freeplay", "set_created_items", care_package)
    end
  end
)

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

remote.add_interface("BrimStuff-Milestones", {
    milestones_preset_addons = function()
        return {
            ["BrimStuff-Updated"] = {
                required_mods = {"BrimStuff-Updated"},
                milestones = {
                    {type="group", name="Resources"},
                    {type="item",  name="rubber", quantity=1},
                    {type="item",  name="gunpowder", quantity=1},
                    {type="fluid",  name=script.active_mods["Krastorio2"] and "kr-nitric-acid" or "nitric-acid", quantity=1},
                }
            }
        }
    end
})
