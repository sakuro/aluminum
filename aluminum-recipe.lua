-- Aluminum smelting

local util = require("data-util");

local alumina_results = {}

if mods.bzsilicon and not mods.Krastorio2 then
  alumina_results ={
    {type="item", name = "alumina", amount=1, probability=0.95},
    {type="item", name = "silica", amount=1, probability=0.05},
  }
elseif mods.bzsilicon and mods.Krastorio2 then
  alumina_results ={
    {type="item", name = "alumina", amount=5, probability=0.95},
    {type="item", name = "silica", amount=1, probability=0.05},
  }
elseif mods.Krastorio2 then
  alumina_results ={
    {type="item", name = "alumina", amount=5},
  }
else 
  alumina_results ={
    {type="item", name = "alumina", amount=1},
  }
end

if (not mods["pyrawores"] and not mods["bobplates"] and not mods["angelssmelting"] ) then
data:extend({
  {
    type = "recipe",
    name = "alumina",
    category = "smelting",
    subgroup = "raw-material",
    order = "d[alumina]",
    icons = (mods["Krastorio2"] and
        {
          { icon = "__bzaluminum__/graphics/icons/alumina.png", icon_size = 128},
          { icon = "__bzaluminum__/graphics/icons/aluminum-ore.png", icon_size = 64, icon_mipmaps = 3, scale=0.25, shift= {-8, -8}},
        } or {
          { icon = "__bzaluminum__/graphics/icons/alumina.png", icon_size = 128},
        }
),
    enabled = true,
    energy_required = mods.Krastorio2 and 16 or 3.2,
    ingredients = {{"aluminum-ore", mods.Krastorio2 and 10 or 1}},
    results = alumina_results,
  },
  {
    type = "recipe",
    name = "aluminum-plate",
    category = "smelting",
    subgroup = "raw-material",
    order = "d[aluminum-plate]",
    icons = (mods["Krastorio2"] and
        {
          { icon = "__bzaluminum__/graphics/icons/aluminum-plate.png", icon_size = 128},
          { icon = "__bzaluminum__/graphics/icons/alumina.png", icon_size = 128, scale=0.25, shift= {-8, -8}},
        } or {
          { icon = "__bzaluminum__/graphics/icons/aluminum-plate.png", icon_size = 128},
        }
),
    normal = (mods["Krastorio2"] and
        {
          enabled = true,
          energy_required = 16,
          ingredients = {{"alumina", 10}},
          results = {
            {type="item", name = "aluminum-plate", amount=10}
          }
        } or
        {
          enabled = true,
          energy_required = 3.2,
          ingredients = {{"alumina", 1}},
          results = {
            {type="item", name = "aluminum-plate", amount=1}
          }
        }),
    expensive =
    {
      enabled = true,
      energy_required = 3.2,
      ingredients = {{"alumina", 2}},
      results = {
        {type="item", name = "aluminum-plate", amount=1},
      }
    }
  },
  {
    type = "item",
    name = "alumina",
    icon = "__bzaluminum__/graphics/icons/alumina.png",
    icon_size = 128,
    subgroup = "raw-material",
    order = "b[alumina]",
    stack_size = util.get_stack_size(100)
  },
  {
    type = "item",
    name = "aluminum-plate",
    icon = "__bzaluminum__/graphics/icons/aluminum-plate.png",
    icon_size = 128,
    subgroup = "raw-material",
    order = "b[aluminum-plate]",
    stack_size = util.get_stack_size(100)
  },
})

data:extend({
  {
    type = "technology",
    name = "copper-processing",
    icon = "__base__/graphics/icons/copper-plate.png",
    icon_size = 64, icon_mipmaps=4,
    effects = {
      { type = "unlock-recipe", recipe = "copper-plate" },
      { type = "unlock-recipe", recipe = "copper-cable" },
    },
    unit = {
      count = 10, time = 15,
      ingredients = mods.Krastorio2 and 
      {{"basic-tech-card", 1}} or {{"automation-science-pack", 1}},
    },
    prerequisites = {"automation"},
    order = "b-b",
  },
})

data:extend({
  {
    type = "technology",
    name = "reinforced-cable",
    icon = "__bzaluminum__/graphics/technology/reinforced-cable.png",
    icon_size = 256,
    effects = {
      { type = "unlock-recipe", recipe = "acsr-cable" },
    },
    unit = {
      count = 60, time = 15,
      ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}},
    },
    prerequisites = {"steel-processing"},
    order = "b-b",
  },
})

util.add_prerequisite("electric-energy-distribution-1", "reinforced-cable")
data:extend({
  {
    type = "item",
    name = "aluminum-cable",
    icon = "__bzaluminum__/graphics/icons/aluminum-cable.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "intermediate-product",
    order = "b[aluminum-cable]",
    stack_size = util.get_stack_size(100),
  },
  {
    type = "recipe",
    name = "aluminum-cable",
    category = "crafting",
    order = "d[aluminum-cable]",
    enabled = true,
    energy_required = 0.5,
    ingredients = {{"aluminum-plate", 2}},
    results = {{"aluminum-cable", 1}},
  },
  {
    type = "item",
    name = "acsr-cable",
    icon = "__bzaluminum__/graphics/icons/acsr-cable.png",
    icon_size = 128,
    subgroup = "intermediate-product",
    order = "b[aluminum-cable]",
    stack_size = 50,
  },
  {
    type = "recipe",
    name = "acsr-cable",
    category = "crafting",
    order = "d[acsr-cable]",
    enabled = true,
    energy_required = 0.5,
    ingredients = {{"aluminum-cable", 1}, {"steel-plate", 1}},
    results = {{"acsr-cable", 1}},
  }
})

end
