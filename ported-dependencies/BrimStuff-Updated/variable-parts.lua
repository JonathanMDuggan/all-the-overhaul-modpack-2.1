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

parts.green = settings.startup["brimstuff-greenhouse"].value
parts.waste = settings.startup["brimstuff-waste-treatment"].value
parts.oil_tol = settings.startup["brimstuff-toluene-from-oil"].value
parts.coke_tol = settings.startup["brimstuff-toluene-from-coke"].value

if mods["ThemTharHills-Updated"] then
  parts.acidwaste = "depleted-acid"
else
  parts.acidwaste = "chemical-waste"
end

parts.zinc = mods["BrassTacks-Updated"]
parts.steelValve = mods["IfNickel-Updated"] and settings.startup["ifnickel-steel-valve"].value
if parts.zinc then
  parts.brassExperiment = settings.startup["brasstacks-experimental-intermediates"].value
else
  parts.brassExperiment = false
end
parts.aai = mods["aai-industry"]

parts.motor = "motor"
if parts.aai then
  parts.motor = "electric-motor"
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
