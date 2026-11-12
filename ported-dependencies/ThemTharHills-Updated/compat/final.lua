local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")
local cu = require("category-utils")

--this gets changed between so do it last instead of in the main krastorio part
if mods["Krastorio2"] then
  if mods["aai-industry"] then
    rm.AddProductRaw("sand", {type="item", name="potassium-nitrate", amount=1, independent_probability=0.05})
  end
  rm.AddProductRaw("kr-sand", {type="item", name="potassium-nitrate", amount=1, independent_probability=0.15})
end

if mods["space-exploration"] then
  if parts.bz.gold then
    rm.AddProductRaw("se-core-fragment-omni", {type="item", name="gold-ore", amount=1})
  else
    rm.RemoveProduct("se-core-fragment-omni", "gold-ore", 5)
  end

  rm.ReplaceProportional("speed-module-3", "advanced-circuit", "integrated-circuit", 2)
  rm.ReplaceProportional("efficiency-module-3", "advanced-circuit", "integrated-circuit", 2)
  rm.ReplaceProportional("productivity-module-3", "advanced-circuit", "integrated-circuit", 2)

  if rm.CheckIngredient("se-processing-unit-holmium", mods["Krastorio2"] and "kr-silicon" or "silicon") then
    rm.ReplaceIngredient("se-processing-unit-holmium", mods["Krastorio2"] and "kr-silicon" or "silicon", "integrated-circuit", 5)
  else if rm.CheckIngredient("se-processing-unit-holmium", "silicon-wafer") then
    rm.ReplaceIngredient("se-processing-unit-holmium", "silicon-wafer", "integrated-circuit", 5)
  else
    rm.ReplaceIngredient("se-processing-unit-holmium", "electronic-circuit", "integrated-circuit", 5)
  end end
end

if mods["bismuth"] then
  --I'm not sure why it does this.
  rm.RemoveIngredient("gold-plate", "gold-ore", 99999)
end

--TTH uses the SE ingot/plate distinction. bzgold's gold-plate analogue is called gold-ingot
--Therefore one gold ingot is worth 10 plates, but the bzgold recipes are treating them as worth less.
--These recipes are both too strong and superfluous so get rid of them.
if mods["space-exploration"] then
  tf.removeRecipeUnlock("advanced-founding", "gold-ingot-casting-refractory")
  tf.removeRecipeUnlock("se-pyroflux-smelting", "gold-ingot-casting")
else
  tf.removeRecipeUnlock("advanced-founding", "gold-ingot-refractory")
end

--Removing these may seem too harsh. TTH has no enriched gold recipe because there's no good way to make it more complex than basic processing
--other than "just acid wash it twice lol" which isn't very interesting.
if mods["Krastorio2"] then
  tf.removeRecipeUnlock("advanced-founding", "enriched-gold-ingot-refractory")
  tf.removeRecipeUnlock("kr-enriched-ores", "enriched-gold")
  tf.removeRecipeUnlock("kr-enriched-ores", "enriched-gold-ingot")
end

if parts.bz.gold and mods["space-exploration"] then
  rm.ReplaceProportional("speed-module-5", "gold-ingot", parts.gold, 1)
  rm.ReplaceProportional("se-heavy-bearing", "gold-ingot", parts.gold, 1)
  rm.ReplaceProportional("cpu-holmium", "gold-ingot", parts.gold, 1)
  rm.ReplaceProportional("mainboard-holmium", "gold-ingot", parts.gold, 1)
  --already uses gold via ICs
  data.raw.recipe["se-empty-data-gold"].hidden = true
end

cu.moveItem("copper-cable", "cable", "a")
cu.moveItem("silver-wire", "cable", "b")
cu.moveRecipe("silver-wire", "cable", "b")
cu.moveItem("aluminum-cable", "cable", "c")
cu.moveItem("tinned-cable", "cable", "d")
cu.moveItem("optical-fiber", "cable", "e")
cu.moveItem(parts.wire, "cable", "f")
cu.moveItem("acsr-cable", "cable", "g")
cu.moveRecipe("acsr-cable", "cable", "g")
cu.moveItem("advanced-cable", "cable", "h")
cu.moveItem("se-holmium-cable", "cable", "i")
cu.moveItem("se-superconductive-cable", "cable", "j")

if mods["space-exploration"] then
  cu.moveGroup("generic-circuits", "intermediate-products", "a-c-z") -- electronic is a-c, processor is a-d.
  cu.moveGroup("fiddly-electrical-gubbins", "intermediate-products", "a-c-y")
  cu.moveGroup("specialized-electronics", "intermediate-products", "a-d-b")
  cu.moveItem("mainboard", "processor", "a")
  cu.moveRecipe("mainboard", "processor", "a")
  cu.moveRecipe("mainboard-holmium", "processor", "ab")
  cu.moveItem("kr-ai-core", "processor", "z-011")
else
  cu.moveItem("battery", "generic-circuits", "b")
  cu.moveItem("mainboard", "generic-circuits", "i")
  cu.moveRecipe("mainboard", "generic-circuits", "i")
  cu.moveItem("processing-unit", "generic-circuits", "j")
  if mods["LunarLandings"] then
    cu.moveItem("ll-quantum-processor", "generic-circuits", "k")
  end
end
cu.moveItem("solder", "generic-circuits", "a")
cu.moveItem("electronic-circuit", "generic-circuits", "c")
cu.moveItem("pcb-substrate", "generic-circuits", "d")
cu.moveItem("pcb", "generic-circuits", "e")
cu.moveItem("advanced-circuit", "generic-circuits", "f")
cu.moveItem("silicon-wafer", "generic-circuits", "g")
cu.moveItem("integrated-circuit", "generic-circuits", "h")

  --for some reason these have separate recipe and item orders despite being only craftable one way
  cu.moveRecipe("solder", "generic-circuits", "a")
  cu.moveRecipe("silicon-wafer", "generic-circuits", "g")

if mods["Krastorio2"] or parts.bz.gold or parts.bz.chlorine then
  cu.moveItem("solder", "fiddly-electrical-gubbins", "a")
  cu.moveItem("pcb-solder", "fiddly-electrical-gubbins", "ab")
  cu.moveItem("battery", "fiddly-electrical-gubbins", "c")
  cu.moveItem("kr-electronic-components", "fiddly-electrical-gubbins", "d")
  cu.moveItem("silicon-wafer", "fiddly-electrical-gubbins", "e")
  cu.moveItem("temperature-sensor", "fiddly-electrical-gubbins", "f")
  cu.moveItem("mlcc", "fiddly-electrical-gubbins", "g")
  cu.moveItem("cpu", "fiddly-electrical-gubbins", "h")

  cu.moveRecipe("solder", "fiddly-electrical-gubbins", "a")
  cu.moveRecipe("pcb-solder", "fiddly-electrical-gubbins", "ab")
  cu.moveRecipe("battery", "fiddly-electrical-gubbins", "c")
  cu.moveRecipe("kr-electronic-components", "fiddly-electrical-gubbins", "d")
  cu.moveRecipe("silicon-wafer", "fiddly-electrical-gubbins", "e")
  cu.moveRecipe("temperature-sensor", "fiddly-electrical-gubbins", "f")
  cu.moveRecipe("mlcc", "fiddly-electrical-gubbins", "g")
  cu.moveRecipe("cpu", "fiddly-electrical-gubbins", "h")
  cu.moveRecipe("cpu-holmium", "fiddly-electrical-gubbins", "i")

  if not mods["IfNickel-Updated"] then
    cu.moveItem("spark-plug", "fiddly-electrical-gubbins", "b")
    cu.moveRecipe("spark-plug", "fiddly-electrical-gubbins", "b")
  end
end

cu.moveItem("solar-cell", "specialized-electronics", "a")
cu.moveItem("transceiver", "specialized-electronics", "b")
cu.moveItem("gyro", "specialized-electronics", "c")
cu.moveItem("gyroscope", "specialized-electronics", "c")
cu.moveItem("hv-power-regulator", "specialized-electronics", "d")
if not mods["space-exploration"] then
  cu.moveItem("flying-robot-frame", "specialized-electronics", "e")
  --cu.moveItem("rocket-control-unit", "specialized-electronics", "f")
end
cu.moveItem("kr-energy-control-unit", "specialized-electronics", "g")
cu.moveRecipe("solar-cell", "specialized-electronics", "a")

if not mods["Krastorio2"] and not mods["space-exploration"] then
  cu.moveRecipe("sulfuric-acid", "advanced-chemicals", "a")
  cu.moveRecipe("nitric-acid", "advanced-chemicals", "b")
  cu.moveRecipe("nitric-acid-early", "advanced-chemicals", "b2")
  cu.moveRecipe("aqua-regia", "advanced-chemicals", "b3")
  cu.moveRecipe("hydrogen-chloride-pure", "advanced-chemicals", "c")
  cu.moveRecipe("hydrogen-chloride-salt", "advanced-chemicals", "d")
  cu.moveRecipe("vinyl-chloride", "advanced-chemicals", "e")
  cu.moveRecipe("chlorine", "advanced-chemicals", "f")
  cu.moveRecipe("epoxy", "advanced-chemicals", "g")
  cu.moveRecipe("organotins", "advanced-chemicals", "h")
end
