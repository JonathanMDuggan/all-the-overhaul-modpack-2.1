local recipemod = {}

if not __DEBUG then
  local log = function(...) end
end

local function AddToIngList(ingredients, toadd, count)
  local done = false
  if not data.raw.item[toadd] or not data.raw.fluid[toadd] then
    if data.raw.item["kr-" .. toadd] or data.raw.fluid["kr-" .. toadd] then log("K2 Version found for " .. toadd .. "!") end
  end
  for k, v in pairs(ingredients) do
    if v[1] == toadd then
      v[2] = v[2] + count
      done = true
      break
    end
    if v["name"] == toadd then
      v["amount"] = v["amount"] + count
      done = true
      break
    end
  end
  if not done then
    if data.raw.fluid[toadd] then
      table.insert(ingredients, {type="fluid", name=toadd, amount=count})
    else
      table.insert(ingredients, {type="item", name=toadd, amount=count})
    end
  end
end

function recipemod.AddIngredient(recipename, ingredient, amt)
  local rec = data.raw.recipe[recipename]
  if rec then
    if rec.ingredients and amt and amt > 0 then
      AddToIngList(rec.ingredients, ingredient, amt)
    end
  else
    log("BRASSTACKS LOG: " .. recipename .. " recipe not found!")
    if data.raw.recipe["kr-" .. recipename] then log("K2 Version found!") end
  end
end

local function RemoveFromIngList(ingredients, toremove, count)
  local done = false
  if not data.raw.item[toremove] or not data.raw.fluid[toremove] then
    if data.raw.item["kr-" .. toremove] or data.raw.fluid["kr-" .. toremove] then log("K2 Version found for " .. toremove .. "!") end
  end
  for k, v in pairs(ingredients) do
    if v[1] == toremove then
      if v[2] > count then
        v[2] = v[2] - count
      else
        table.remove(ingredients, k)
      end
      return true
    end
    if v["name"] == toremove then
      if v["amount"] > count then
        v["amount"] = v["amount"] - count
      else
        table.remove(ingredients, k)
      end
      return true
    end
  end
  return false
end

--no checks for >0. remove 0 is effectively a test if ingredient is present.
function recipemod.RemoveIngredient(recipename, ingredient, amt)
  local removed = false;
  local rec = data.raw.recipe[recipename]
  if rec then
    if rec.ingredients and amt then
      removed = RemoveFromIngList(rec.ingredients, ingredient, amt) or removed
    end
  else
    log("BRASSTACKS LOG: " .. recipename .. " recipe not found!")
    if data.raw.recipe["kr-" .. recipename] then log("K2 Version found!") end
  end
  return removed
end

--ONLY INTENDED FOR MULTI PRODUCT RECIPES
function recipemod.RemoveProduct(recipename, product, amt)
  local removed = false;
  local rec = data.raw.recipe[recipename]
  if rec then
    if rec.results and amt then
      removed = RemoveFromIngList(rec.results, product, amt) or removed
    end
  else
    log("BRASSTACKS LOG: " .. recipename .. " recipe not found!")
    if data.raw.recipe["kr-" .. recipename] then log("K2 Version found!") end
  end
  return removed
end

function recipemod.AddProductRaw(recipename, product)
  local rec = data.raw.recipe[recipename]
  if rec and product then
    if rec.results and product then
      table.insert(rec.results, product)
      if not rec.main_product then
        rec.main_product = rec.results[1].name
      end
    else
      rec.results = {product}
    end
  else
    if not rec then
      log("BRASSTACKS LOG: " .. recipename .. " recipe not found!")
      if data.raw.recipe["kr-" .. recipename] then log("K2 Version found!") end
    end
    if not product then 
      log("BRASSTACKS LOG: " .. product .. " item not found!")
      if data.raw.item["kr-" .. product] or data.raw.fluid["kr-" .. product] then log("K2 Version found!") end
    end
  end
end

--faster than one then the other
local function ReplaceInIngList(ingredients, toadd, toremove, count)
  local done = false
  local delete_index = -1
  if not data.raw.item[toadd] or not data.raw.fluid[toadd] then
    if data.raw.item["kr-" .. toadd] or data.raw.fluid["kr-" .. toadd] then log("K2 Version found for " .. toadd .. "!") end
  end
  if not data.raw.item[toremove] or not data.raw.fluid[toremove] then
    if data.raw.item["kr-" .. toremove] or data.raw.fluid["kr-" .. toremove] then log("K2 Version found for " .. toremove .. "!") end
  end
  for k, v in pairs(ingredients) do
    if v[1] == toadd then
      v[2] = v[2] + count
      done = true
    end
    if v["name"] == toadd then
      v["amount"] = v["amount"] + count
      done = true
    end
    if v[1] == toremove then
      if v[2] > count then
        v[2] = v[2] - count
      else
        delete_index = k
      end
    end
    if v["name"] == toremove then
      if v["amount"] > count then
        v["amount"] = v["amount"] - count
      else
        delete_index = k
      end
    end
  end
  if delete_index ~= -1 then
    table.remove(ingredients, delete_index)
  end
  if not done then
    if data.raw.fluid[toadd] then
      table.insert(ingredients, {type="fluid", name=toadd, amount=count})
    else
      table.insert(ingredients, {type="item", name=toadd, amount=count})
    end
  end
end

function recipemod.ReplaceIngredient(recipename, toreplace, ingredient, amt)
  local rec = data.raw.recipe[recipename]
  if rec then
    if rec.ingredients and amt and amt > 0 then
      ReplaceInIngList(rec.ingredients, ingredient, toreplace, amt)
    end
  else
    log("BRASSTACKS LOG: " .. recipename .. " recipe not found!")
    if data.raw.recipe["kr-" .. recipename] then log("K2 Version found!") end
  end
end

function recipemod.CheckIngredient(recipename, ingredient) -- omit mode to search all
  local rec = data.raw.recipe[recipename]
  if not rec then
    log("BRASSTACKS LOG: " .. recipename .. " recipe not found!")
    if data.raw.recipe["kr-" .. recipename] then log("K2 Version found!") end
    return false 
  end
  if rec.ingredients then
    for k, v in pairs(rec.ingredients) do
      if v[1] == ingredient then return true end
      if v["name"] == ingredient then return true end
    end
  end
  return false
end

function recipemod.ReplaceProportional(recipename, ingredient, replacement, factor) -- omit mode to search all
  local rec = data.raw.recipe[recipename]
  if not rec then
    log("BRASSTACKS LOG: " .. recipename .. " recipe not found!")
    if data.raw.recipe["kr-" .. recipename] then log("K2 Version found!") end
    return false 
  end
  local amt = 0
  if rec.ingredients then
    for k, v in pairs(rec.ingredients) do
      if v["name"] == ingredient or v[1] == ingredient then
        if v["amount"] then
          amt = v["amount"]
        else if v[2] then
          amt = v[2]
        end end
      end
    end
  end
  local function final_amount(num)
    if num <= 0 then return 0 end
    return math.max(1, math.floor(num))
  end
  if factor >= 1 then
    recipemod.ReplaceIngredient(recipename, ingredient, replacement, final_amount(amt * factor))
  else
    recipemod.RemoveIngredient(recipename, ingredient, amt)
    recipemod.AddIngredient(recipename, replacement, final_amount(amt * factor))
  end
end

function recipemod.multiply(recipe, factor, cost, output, time)
  if type(recipe) == "string" then
    if data.raw.recipe[recipe] then
      recipemod.multiply(data.raw.recipe[recipe], factor, cost, output, time)
    else
      log("BRASSTACKS LOG: " .. recipe .. " recipe not found!")
      if data.raw.recipe["kr-" .. recipe] then log("K2 Version found!") end
    end
    return
  end
  if recipe.ingredients and cost then
    for k, v in pairs(recipe.ingredients) do
      if v[2] then v[2] = v[2] * factor end
      if v["amount"] then v["amount"] = v["amount"] * factor end
    end
  end
  if output then
    if recipe.results then
      for k, v in pairs(recipe.results) do
        if v[2] then v[2] = v[2] * factor end
        if v["amount"] then v["amount"] = v["amount"] * factor end
        if v["amount_min"] then v["amount_min"] = v["amount_min"] * factor end
        if v["amount_max"] then v["amount_max"] = v["amount_max"] * factor end
      end
    end
  end
  if time then
    if recipe.energy_required then
      recipe.energy_required = recipe.energy_required * factor
    else
      recipe.energy_required = factor / 2
    end
  end
end

function recipemod.SetCategory(recipe, category)
  if data.raw.recipe[recipe] then
      data.raw.recipe[recipe].categories = { category }
  end
end

return recipemod
