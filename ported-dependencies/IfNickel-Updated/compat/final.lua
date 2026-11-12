local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")
local cu = require("category-utils")

if mods["space-exploration"] then
  if parts.experimental then
    if mods["Krastorio2"] then
      rm.AddIngredient("se-processing-unit-holmium", "cooling-fan", 2)
    else
      rm.AddIngredient("se-processing-unit-holmium", "cooling-fan", 1)
    end
    tf.addPrereq("rocket-silo", "gimbaled-thruster")
  end

  rm.RemoveProduct("se-core-fragment-omni", "nickel-ore", 4)
end

if rm.CheckIngredient("flow-controller", "kr-automation-core") then
  --no actually i want that there
  rm.AddIngredient("flow-controller", "electronic-circuit", 1)
  if rm.CheckIngredient("flow-controller", "tinned-cable") then
    --I want this recipe to max out at 4 ingredients
    rm.RemoveIngredient("flow-controller", "kr-automation-core", 1)
  else
    --only want SE glass in the recipe
    rm.RemoveIngredient("flow-controller", mods["Krastorio2"] and "kr-glass" or "glass", 1)
    --it's in the recipe now, so can be removed from some things that use flow controllers
    rm.RemoveIngredient("kr-electrolysis-plant", "kr-automation-core", 3)
    rm.RemoveIngredient("kr-filtration-plant", "kr-automation-core", 3)
    rm.RemoveIngredient("chemical-plant", "kr-automation-core", 3)
    rm.RemoveIngredient("pumpjack", "kr-automation-core", 3)
    rm.RemoveIngredient("oil-refinery", "kr-automation-core", 5)
  end
end

if mods["Krastorio2"] then
  local ing = {}
  ing = data.raw.recipe["pumpjack"].ingredients
  --data.raw.recipe["kr-mineral-water-pumpjack"].ingredients = ing

  if mods["aai-industry"] then
    rm.RemoveIngredient("bulk-inserter", "electronic-circuit", 2)
  end

  if rm.CheckIngredient("logistic-science-pack", "iron-gear-wheel") then
    if mods["aai-industry"] then
      rm.ReplaceIngredient("logistic-science-pack", "iron-gear-wheel", parts.motor, 5) --AAI motors are more expensive
    else
      rm.AddIngredient("logistic-science-pack", parts.motor, 5) --IN motors are barely more than a vanilla circuit
    end
  end

  if not mods["BrassTacks-Updated"] then
    data.raw.recipe["chemical-science-pack"].categories = table.deepcopy(data.raw.recipe["logistic-science-pack"].categories)
    rm.RemoveIngredient("chemical-science-pack", "sulfuric-acid", 50)
    rm.ReplaceIngredient("chemical-science-pack", mods["Krastorio2"] and "kr-glass" or "glass", "battery", 5)
  elseif not mods["space-exploration"] then
      if rm.CheckIngredient("utility-science-pack", "rocket-fuel") and parts.experimental then
        rm.AddIngredient("utility-science-pack", "complex-joint", 5)
      end
    end

  if parts.nitinol then
    rm.RemoveIngredient("kr-advanced-transport-belt", "titanium-plate", 1)
  end
end

if parts.experimental and parts.brassExperiment then
  rm.RemoveIngredient("assembling-machine-3", "steel-plate", 8)
end

if not mods["BrassTacks-Updated"] then
  if mods["Krastorio2"] or parts.experimental then
    cu.moveItem("articulated-mechanism", "articulated-components", "a")
    cu.moveItem("kr-inserter-parts", "articulated-components", "b")
    cu.moveItem("kr-automation-core", "articulated-components", "c")
    cu.moveItem("motorized-articulator", "articulated-components", "d")
    cu.moveItem("complex-joint", "articulated-components", "e")
    cu.moveItem("machining-tool", "articulated-components", "f")
    cu.moveItem("advanced-machining-tool", "articulated-components", "g")
    cu.moveItem("gimbaled-thruster", "plumbing-components", "h")
    cu.moveItem("skyseeker-armature", "articulated-components", "i")
  end

  if mods["space-exploration"] then
    cu.moveItem("gimbaled-thruster", "rocket-part", "p")
  end

  if data.raw.recipe["airtight-seal"] or parts.experimental then
    cu.moveItem("empty-barrel", "plumbing-components", "a")
    cu.moveRecipe("empty-barrel", "plumbing-components", "a")
    cu.moveItem("bolted-flange", "plumbing-components", "b")
    cu.moveItem("gasket", "plumbing-components", "c")
    cu.moveItem("airtight-seal", "plumbing-components", "c")
    cu.moveItem("titanium-palladium-flange", "plumbing-components", "d")
    cu.moveRecipe("titanium-palladium-flange", "plumbing-components", "d")
    cu.moveItem("invar-valve", "plumbing-components", "e")
    cu.moveItem("flow-controller", "plumbing-components", "f")
    cu.moveItem("advanced-flow-controller", "plumbing-components", "g")
    cu.moveItem("rocket-engine-nozzle", "plumbing-components", "h")
    cu.moveRecipe("rocket-engine-nozzle", "plumbing-components", "h")
    cu.moveItem("self-regulating-valve", "plumbing-components", "i")
  end

  if mods["space-exploration"] then
    cu.moveItem("rocket-engine-nozzle", "rocket-part", "o")
    cu.moveRecipe("rocket-engine-nozzle", "rocket-part", "o")
  end
end

cu.moveItem("motor", "engine-components", "a")
cu.moveItem("motor-silver", "engine-components", "aa")
cu.moveItem("electric-motor", "engine-components", "b")
cu.moveItem("electric-motor-silver", "engine-components", "ba")
cu.moveItem("spark-plug", "engine-components", "c")
cu.moveRecipe("spark-plug", "engine-components", "c")
if (mods["BrassTacks-Updated"] and not parts.experimental) or not mods["BrassTacks-Updated"] then
  cu.moveItem("drive-belt", "engine-components", "d")
end
cu.moveItem("engine-unit", "engine-components", "e")
cu.moveItem("electric-engine-unit", "engine-components", "f")
cu.moveItem("flying-robot-frame", "engine-components", "g")

if rm.CheckIngredient("cooling-fan", "temperature-sensor") then
  rm.RemoveIngredient("mainboard-holmium", "temperature-sensor", 99999)
end
