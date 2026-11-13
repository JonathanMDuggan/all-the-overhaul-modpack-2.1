-- Reset the 5dim modules to their Factorio 2.0 values before anything builds on them (see integrations/5dim/baseline.lua)
require("__all-the-overhaul-modpack__/integrations/5dim/baseline")("updates")
require("integrations/updates")
require("compatibility/updates")

-- Chemical plant mk1 requires tungsten so we move it further down
atom.util.Technology("kr-fluids-chemistry").removeRecipe("chemical-plant")
atom.util.Technology("oil-processing").addRecipe("chemical-plant")

-- Change tech icon of oil processing back to vanilla
data.raw.technology["oil-processing"].icon = "__base__/graphics/technology/oil-processing.png"
data.raw.technology["oil-processing"].icon_size = 256
data.raw.technology["oil-processing"].icons = nil