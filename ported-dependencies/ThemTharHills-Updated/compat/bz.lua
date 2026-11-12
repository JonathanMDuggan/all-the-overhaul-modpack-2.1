local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")
local cu = require("category-utils")

if parts.bz.gold then
  rm.RemoveIngredient("satellite", "gold-ingot", 99999)
  rm.ReplaceProportional("cpu", "gold-ingot", parts.gold, 1)
  rm.ReplaceProportional("mainboard", "gold-ingot", parts.gold, 1)

  --small amount relative to cost of ICs but idk
  rm.RemoveIngredient("cpu", "silicon-wafer", 10)
  rm.RemoveIngredient("cpu", mods["Krastorio2"] and "kr-silicon" or "silicon", 5)


  if data.raw.item["gimbaled-thruster"] then
    --rcu is getting a bit overcrowded and the temp sensor should be in the part of the rocket that might plausibly overheat anyway
    --rm.RemoveIngredient("rocket-control-unit", "temperature-sensor", 99999)
    if mods["space-exploration"] then
      rm.AddIngredient("gimbaled-thruster", "temperature-sensor", 1)
    else
      rm.AddIngredient("gimbaled-thruster", "temperature-sensor", 2)
    end
  end

  if data.raw.item["temperature-sensor"] and not data.raw.item["cooling-fan"] then
    rm.AddIngredient("hv-power-regulator", "temperature-sensor")
    tf.addPrereq("high-voltage-equipment", "temperature-regulation")
  end

  if data.raw.item["silver-ore"] then
    -- default chance of silver from gold processing in bzgold is 20% per 2 ore.
    -- TTH gold is worth less per item so processing 1 TTH gold should be less than half of 2 BZG gold
    rm.AddProductRaw("gold-powder", {type="item", name="silver-ore", amount=1, independent_probability=mods["Krastorio2"] and 0.1 or 0.05})
    rm.AddProductRaw("depleted-acid-treatment", {type="item", name="silver-ore", amount=1, independent_probability=0.1})
    -- default chance of silver is 10% per 1 copper. recipe uses 3 but is intentionally somewhat wasteful
    rm.AddProductRaw("trace-gold-from-copper", {type="item", name="silver-ore", amount=1, independent_probability=0.2})
  end

  if mods["space-exploration"] then

    if data.raw.item["rich-copper-ore"] then
      --add a bad way to make rich copper ore on nauvis to prevent deadlock
      --this is an ill-considered giant hammer solution and probably sucks!
      --then again it is making the already-not-great recipe more viable by adding extra products
      rm.AddProductRaw("trace-gold-from-copper", {type="item", name="rich-copper-ore", amount=1, independent_probability=0.1})
      rm.AddProductRaw("depleted-acid-treatment", {type="item", name="rich-copper-ore", amount=1, independent_probability=0.05})
    end
    tf.removeSciencePack("platinum-processing", "se-rocket-science-pack")
    tf.removePrereq("platinum-processing", "se-rocket-science-pack")
    tf.addPrereq("platinum-processing", "chemical-science-pack")
    tf.removeSciencePack("palladium-processing", "se-rocket-science-pack")
    tf.removeSciencePack("temperature-regulation", "se-rocket-science-pack")
    tf.removePrereq("palladium-processing", "se-rocket-science-pack")
    tf.addPrereq("palladium-processing", "chemical-science-pack")
    if data.raw.item["silver-wire"] then
      rm.ReplaceIngredient("advanced-cable", parts.wire, "silver-wire", 4)
    else if data.raw.item["tinned-cable"] then --i should look into how much sense this makes
      rm.ReplaceIngredient("advanced-cable", parts.wire, "tinned-cable", 4)
    else
      rm.ReplaceIngredient("advanced-cable", parts.wire, "copper-cable", 4)
    end end

    tf.removeRecipeUnlock("se-space-data-card", "se-empty-data-gold")
  end
end

if parts.bz.aluminum then
  tf.addPrereq("high-voltage-equipment", "reinforced-cable")
end
