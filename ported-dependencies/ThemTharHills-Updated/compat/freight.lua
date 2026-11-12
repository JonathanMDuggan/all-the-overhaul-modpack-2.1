local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")

local goldships = true

if mods["FreightForwarding"] then
  if mods["BrimStuff-Updated"] then
    --gold processable without oil
    rm.AddIngredient("ff-transport-science-pack", "transceiver", 1)
    tf.addPrereq("ff-transport-science-pack", "gold-electronics")
    tf.addPrereq("rail-signals", "gold-electronics")
  else
    goldships = false
  end

  rm.ReplaceProportional("ff-charging-station", "copper-cable", parts.wire, 1)
  rm.ReplaceProportional("ff-discharging-station", "copper-cable", parts.wire, 1)

  rm.ReplaceProportional("ff-seismic-scanner", "advanced-circuit", "hv-power-regulator", 1/5)
  rm.AddIngredient("ff-seismic-scanner", "transceiver", 5)

  tf.addRecipeUnlock("ff-dredging", "noble-nodule-dredging")
  tf.addRecipeUnlock("ff-dredging", "noble-nodule-washing")
end

if mods["cargo-ships"] and goldships then
  --if oil is water-only, need an early source of nitric acid to make transceivers for boats.
  if (not (settings.startup["no_oil_on_land"] and settings.startup["no_oil_on_land"].value)) or mods["BrimStuff-Updated"] or mods["Krastorio2"] then
    rm.ReplaceIngredient("buoy", "iron-plate", parts.wire, 1)
    rm.ReplaceIngredient("chain_buoy", "iron-plate", parts.wire, 1)

    rm.ReplaceProportional("port", "electronic-circuit", "transceiver", 1/3)

    if data.raw.item["flywheel"] then
      --avoid ingredient bloat
      rm.ReplaceProportional("cargo_ship", "electronic-circuit", "transceiver", 1/4)
      rm.ReplaceProportional("oil_tanker", "electronic-circuit", "transceiver", 1/4)
    else
      rm.RemoveIngredient("cargo_ship", "electronic-circuit", 10)
      rm.RemoveIngredient("oil_tanker", "electronic-circuit", 10)
      rm.AddIngredient("cargo_ship", "transceiver", 2)
      rm.AddIngredient("oil_tanker", "transceiver", 2)
    end
  end
end
