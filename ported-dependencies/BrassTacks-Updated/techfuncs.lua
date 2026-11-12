local techfuncs = {}

function techfuncs.addRecipeUnlock(tech, rec)
	if not (data.raw.technology[tech] and data.raw.recipe[rec]) then
    error("Trying to add recipe: " .. rec .. "(" .. serpent.line(data.raw.recipe[rec], {maxlength = 10}) .. ") to tech: " .. tech .. " (" .. serpent.line(data.raw.technology[tech], {maxlength = 10}) .. ")but one doesn't exist! ")
		return
	end
	if data.raw.technology[tech].effects then
		local found  = false
		for k, v in pairs(data.raw.technology[tech].effects) do
			if v.recipe == rec then
				found = true
				break
			end
		end
		if not found then
			table.insert(data.raw.technology[tech].effects, {type = "unlock-recipe", recipe = rec})
		end
	else
		data.raw.technology[tech].effects = {{type = "unlock-recipe", recipe = rec}}
	end
end

function techfuncs.removeRecipeUnlock(tech, rec)
	if not data.raw.technology[tech] then
		return
	end
	if data.raw.technology[tech].effects then
    local fi = -1
		for k, v in pairs(data.raw.technology[tech].effects) do
			if v.recipe == rec then
				fi = k
				break
			end
		end
    if fi > 0 then
      table.remove(data.raw.technology[tech].effects, fi)
    end
	end
end

function techfuncs.addPrereq(tech, prereq)
	if not (data.raw.technology[tech] and data.raw.technology[prereq]) then
    error("Trying to add tech prereq: " .. prereq .. "(" .. serpent.line(data.raw.technology[prereq], {maxlength = 10}) .. ") to tech: " .. tech .. " (" .. serpent.line(data.raw.technology[tech], {maxlength = 10}) .. ")but one doesn't exist! ")
		return
	end
	local pr = data.raw.technology[tech].prerequisites
	if pr then
		found = false
		for k, v in pairs(pr) do
			if v == prereq then
				found = true
				break
			end
		end
		if not found then
			table.insert(pr, prereq)
		end
	else
		data.raw.technology[tech].prerequisites = {prereq}
	end
end

function techfuncs.removePrereq(tech, prereq)
	--don't check for prereq tech's existence - the reason we're removing the requirement might be we've deleted it already!
	if not data.raw.technology[tech] then
		return
	end
	local pr = data.raw.technology[tech].prerequisites
  local fi = -1
	if pr then
		for k, v in pairs(pr) do
			if v == prereq then
				fi = k
				break
			end
		end
    if fi > 0 then
      table.remove(pr, fi)
    end
	end
end

function techfuncs.addSciencePackToTech(tech, item)
	if tech then
		if tech.unit then
			if tech.unit.ingredients then
				local found = false
				for k, v in pairs(tech.unit.ingredients) do
					if v[1] == item or v["name"] == item then
						found = true
					end
				end
				if not found then
					table.insert(tech.unit.ingredients, {item, 1})
				end
			end
		else
			tech.unit.ingredients = {{item, 1}}
		end
	end
end

function techfuncs.addSciencePack(tech, item)
	if not (data.raw.technology[tech] and (data.raw.tool[item] or data.raw.item[item])) then
    error("Trying to add science: " .. item .. "(" .. serpent.line(data.raw.tool[item], {maxlength = 10}) .. ") to tech: " .. tech .. " (" .. serpent.line(data.raw.technology[tech], {maxlength = 10}) .. ")but one doesn't exist! ")
		return
	end
	local t = data.raw.technology[tech]
	techfuncs.addSciencePackToTech(t, item)
end

function techfuncs.removeSciencePackFromDifficulty(tech, item)
	if tech then
		if tech.unit then
			if tech.unit.ingredients then
        local fi = -1
				for k, v in pairs(tech.unit.ingredients) do
					if v[1] == item or v["name"] == item then
						fi = k
						break
					end
				end
        if fi > 0 then
          table.remove(tech.unit.ingredients, fi)
        end
			end
		end
	end
end

function techfuncs.removeSciencePack(tech, item)
	if not (data.raw.technology[tech] and (data.raw.tool[item] or data.raw.item[item])) then
		return
	end
	local t = data.raw.technology[tech]
	techfuncs.removeSciencePackFromDifficulty(t, item)
end

function techfuncs.compilePrereqs(...)
  local pr = {}
  for k, v in pairs(...) do
    if k and v then
      table.insert(pr, v)
    end
  end
  return pr
end

return techfuncs
