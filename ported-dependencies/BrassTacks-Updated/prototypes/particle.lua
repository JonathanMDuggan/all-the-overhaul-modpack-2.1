
local function createOreParticle(ore, path, variants)
  local particle = {
    type="optimized-particle",
    name= ore .. "-particle",
    life_time=180,
    pictures = {},
    shadows = {}
  }
  for count = 1,variants,1 do
    table.insert(particle.pictures,
    {
        --so long as the files are copied from vanilla and mass-renamed with the ore name changed this pattern should hold
        filename = path .. "/hr-" .. ore .. "-particle-" .. count .. ".png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      })
  end
  for count = 1,variants,1 do
    table.insert(particle.shadows,
    {
        filename = path .. "/hr-" .. ore .. "-particle-shadow-" .. count .. ".png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      })
  end
  return particle
end

data:extend({
  createOreParticle("zinc", "__BrassTacks-Updated__/graphics/ore", 4)
})
