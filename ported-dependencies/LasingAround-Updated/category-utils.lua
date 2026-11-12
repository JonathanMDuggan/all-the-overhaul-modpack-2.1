local cu = {}

function cu.moveItem(item, category, order)
  if data.raw.item[item] then
    local theItem = data.raw.item[item]
    theItem.subgroup = category
    theItem.order = order
  end
end

function cu.moveRecipe(recipe, category, order)
  if data.raw.recipe[recipe] then
    local theRecipe = data.raw.recipe[recipe]
    theRecipe.subgroup = category
    theRecipe.order = order
  end
end

function cu.moveGroup(subgroup, category, order)
  if data.raw["item-subgroup"][subgroup] then
    local theGroup = data.raw["item-subgroup"][subgroup]
    theGroup.group = category
    theGroup.order = order
  end
end

return cu
