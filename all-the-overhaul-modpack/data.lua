-- Reset the 5dim modules to their Factorio 2.0 values before anything builds on them (see integrations/5dim/baseline.lua)
require("__all-the-overhaul-modpack__/integrations/5dim/baseline")("data")
require("_data")

atom = atom or {}
atom.stage = "data"

atom.debug = false

require("util.util")
require("content.data")
require("integrations.data")