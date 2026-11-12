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

parts.brassExperiment = mods["BrassTacks-Updated"] and settings.startup["brasstacks-experimental-intermediates"].value
parts.nickelExperiment = mods["IfNickel-Updated"] and settings.startup["ifnickel-experimental-intermediates"].value

function parts.qualityIconPath(mod, icon)
  local prefix = ""
  --I intend to reuse this function between mods, hence checking for itself and specifying which mod to look in.
  --Other mods may add an alternate recipe and need to look up an icon, etc.
  --Possible that I am over-engineering this system.
  if mod == "brasstacks" and mods["BrassTacks-Updated"] then
    if settings.startup["brasstacks-classic-icons"].value then
      prefix = "__BrassTacks-Updated__/graphics/classic/"
    else
      prefix = "__BrassTacks-Updated__/graphics/galdoc/"
    end
  end
  if prefix ~= "" then
    return prefix .. icon
  end
end

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

return parts
