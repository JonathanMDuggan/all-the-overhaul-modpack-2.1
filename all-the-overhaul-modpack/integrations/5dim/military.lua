-- Military stuff is not added to ATOM

-- Recipes

local Recipe = require("__all-the-overhaul-modpack__/util/legacy-recipe")

for i = 2, 10 do
    Recipe("5d-stone-wall-" .. string.format("%02d", i)):set_enabled(false)
    Recipe("5d-gate-" .. string.format("%02d", i)):set_enabled(false)
end


-- Technologies

for i = 1, 9 do
    atom.util.technology.hide("stone-wall-" .. i)
    atom.util.technology.hide("gate-" .. i)
end