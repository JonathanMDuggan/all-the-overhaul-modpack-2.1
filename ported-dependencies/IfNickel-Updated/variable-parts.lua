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

parts.experimental = settings.startup["ifnickel-experimental-intermediates"].value
parts.zinc = mods["BrassTacks-Updated"]
parts.steelValve = settings.startup["ifnickel-steel-valve"].value
if parts.zinc then
  parts.brassExperiment = settings.startup["brasstacks-experimental-intermediates"].value
else
  parts.brassExperiment = false
end
parts.aai = mods["aai-industry"]

parts.invartech = mods["galdocs-manufacturing"] and "gm-nickel-and-invar-machined-part-processing" or "invar-processing"

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

parts.nitinol = false
if parts.experimental and mods["space-exploration"] and parts.bz.titanium then
  parts.nitinol = true
end

return parts
