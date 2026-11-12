local cu = require("category-utils")
local rm = require("recipe-modify")

cu.moveItem("nickel-electromagnet", "effector-components", "g")
cu.moveItem("se-holmium-solenoid", "effector-components", "h")
cu.moveItem("se-dynamic-emitter", "effector-components", "i")

if mods["248k-Redux"] then
  rm.ReplaceProportional("fi_refinery_basic", "crude-oil", "filtered-oil", 1)
  rm.ReplaceProportional("fi_refinery_coal", "crude-oil", "filtered-oil", 1)
  rm.ReplaceProportional("fi_refinery_sulfur", "crude-oil", "filtered-oil", 1)
end

if mods["ChemistryForYou2"] then
  rm.ReplaceProportional("air-scrubing-oil-processing", "crude-oil", "filtered-oil", 1)
end