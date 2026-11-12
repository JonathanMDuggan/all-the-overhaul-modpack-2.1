local parts = {}

parts.bz = {}
parts.bz.carbon = mods["bzcarbon"] or mods["bzcarbon2"]
parts.bz.lead = mods["bzlead"] or mods["bzlead2"]
parts.bz.silicon = mods["bzsilicon"] or mods["bzsilicon2"]
parts.bz.tin = mods["bztin"] or mods["bztin2"]
parts.bz.titanium = mods["bztitanium"] or mods["bztitanium2"]
parts.bz.zirconium = mods["bzzirocnium"] or mods["bzzirocnium2"]
parts.bz.gold = mods["bzgold"] or mods["bzgold2"]
parts.bz.aluminum = mods["bzaluminum"] or mods["bzaluminum2"]
parts.bz.gas = mods["bzgas"] or mods["bzgas2"]
parts.bz.chlorine = mods["bzchlorine"] or mods["bzchlorine2"]
parts.bz.tungsten = mods["bztungsten"] or mods["bztungsten2"]


parts.heavyGyro = false
if mods["BrassTacks-Updated"] and settings.startup["brasstacks-experimental-intermediates"].value and (settings.startup["brasstacks-gyro-override"].value or not parts.bz.silicon) then
  parts.heavyGyro = true
end

parts.aquaregia  = settings.startup["themtharhills-enable-aqua-regia"].value and (mods["Krastorio2"] or parts.bz.chlorine) and not (mods["Krastorio2"] and parts.bz.tungsten and mods["BrimStuff-Updated"] and mods["FreightForwarding"])

function parts.preferred(ingredients, quantities)
  for k, v in ipairs(ingredients) do
    if data.raw.item[v] then
      return {type="item", name=v, amount=quantities[k]}
    end
  end
end

function parts.optionalIngredient(item, amount)
  if data.raw.item[item] then
    return {type="item", name=item, amount=amount}
  end
end

if (mods["bzfoundry"] or mods["bzfoundry2"]) and not settings.startup["bzfoundry-minimal"].value then
  parts.foundryEnabled = true
else
  parts.foundryEnabled = false
end

if mods["248k-Redux"] then
  --THE STANDARD DEVICE TO ALWAYS PREFIX IDS IS PESTILENCE. SOMETIMES COLLISIONS ARE DESIRABLE.
  --(generally you want intermediates to collide and entities to be separate but it is often more subtle than that.)
  parts.gold = "fi_gold"
  parts.wire = "gr_gold_wire"
else
  parts.gold = "gold-plate"
  parts.wire = "gold-wire"
end

return parts
