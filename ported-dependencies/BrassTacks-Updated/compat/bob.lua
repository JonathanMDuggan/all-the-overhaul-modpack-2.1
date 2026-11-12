local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")

if mods["boblogistics"] then
  rm.multiply("copper-pipe", 5, true, true, true)
  rm.AddIngredient("copper-pipe", "bolted-flange", 1)

  rm.multiply("stone-pipe", 5, true, true, true)
  rm.AddIngredient("stone-pipe", "bolted-flange", 1)

  rm.multiply("steel-pipe", 5, true, true, true)
  rm.AddIngredient("steel-pipe", "bolted-flange", 1)

  rm.multiply("plastic-pipe", 5, true, true, true)
  rm.AddIngredient("plastic-pipe", "bolted-flange", 1)

  --The rest of these should probably not exist; brasstacks is designed to diversify the vanilla intermediates a bit.
  --Bob's mod suite has its own progression which, notably, already includes brass.
  rm.multiply("bronze-pipe", 5, true, true, true)
  rm.AddIngredient("bronze-pipe", "bolted-flange", 1)

  rm.multiply("brass-pipe", 5, true, true, true)
  rm.AddIngredient("brass-pipe", "bolted-flange", 1)

  rm.multiply("titanium-pipe", 5, true, true, true)
  rm.AddIngredient("titanium-pipe", "bolted-flange", 1)

  rm.multiply("ceramic-pipe", 5, true, true, true)
  rm.AddIngredient("ceramic-pipe", "bolted-flange", 1)

  rm.multiply("tungsten-pipe", 5, true, true, true)
  rm.AddIngredient("tungsten-pipe", "bolted-flange", 1)

  rm.multiply("nitinol-pipe", 5, true, true, true)
  rm.AddIngredient("nitinol-pipe", "bolted-flange", 1)

  rm.multiply("copper-tungsten-pipe", 5, true, true, true)
  rm.AddIngredient("copper-tungsten-pipe", "bolted-flange", 1)

  rm.AddIngredient("turbo-transport-belt", "bearing", 4)
  rm.AddIngredient("turbo-underground-belt", "bearing", 20)
  rm.AddIngredient("turbo-splitter", "bearing", 14)

  if parts.experimental then
    rm.AddIngredient("ultimate-transport-belt", "complex-joint", 4)
    rm.AddIngredient("ultimate-underground-belt", "complex-joint", 20)
    rm.AddIngredient("ultimate-splitter", "complex-joint", 14)

    if rm.CheckIngredient("turbo-transport-belt", "steel-plate") and not data.raw.item["titanium-plate"] then --bztitanium is used here, for some reason ??
      rm.ReplaceIngredient("turbo-transport-belt", "steel-plate", "galvanized-steel-plate", 2)
      rm.ReplaceIngredient("turbo-underground-belt", "steel-plate", "galvanized-steel-plate", 14)
      rm.ReplaceIngredient("turbo-splitter", "steel-plate", "galvanized-steel-plate", 8)
    end

    if rm.CheckIngredient("ultimate-transport-belt", "steel-plate") then
      rm.ReplaceIngredient("ultimate-transport-belt", "steel-plate", "hardened-hull", 2)
      rm.ReplaceIngredient("ultimate-underground-belt", "steel-plate", "hardened-hull", 14)
      rm.ReplaceIngredient("ultimate-splitter", "steel-plate", "hardened-hull", 8)
    end
  else
    rm.AddIngredient("ultimate-transport-belt", "bearing", 8)
    rm.AddIngredient("ultimate-underground-belt", "bearing", 40)
    rm.AddIngredient("ultimate-splitter", "bearing", 28)
  end

  if settings.startup["bobmods-logistics-inserteroverhaul"].value then
    --no actually. i won't do it. i refuse -planetfall
    --TODO: you wont, but I might -ashier
  end

  rm.AddIngredient("bob-storage-tank-all-corners", "bolted-flange", 8)
  if parts.experimental then
    rm.ReplaceIngredient("bob-storage-tank-all-corners", "steel-plate", "hardened-hull", 5)
  end

end
