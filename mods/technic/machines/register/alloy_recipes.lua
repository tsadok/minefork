
local S = technic.getter

technic.register_recipe_type("alloy", {
	description = S("Alloying"),
	input_size = 2,
})

function technic.register_alloy_recipe(data)
	data.time = data.time or 6
	technic.register_recipe("alloy", data)
end

local recipes = {
	{"technic:copper_dust 7",         "technic:tin_dust",           "technic:bronze_dust 8", 12},
	{"default:copper_ingot 7",        "default:tin_ingot",          "default:bronze_ingot 8", 12},
	{"default:copperblock 7",         "default:tinblock",           "default:bronzeblock 8", 96},
	{"technic:wrought_iron_dust 2",   "technic:coal_dust",          "technic:carbon_steel_dust 2", 6},
	{"technic:wrought_iron_ingot 2",  "technic:coal_dust",          "technic:carbon_steel_ingot 2", 6},
	{"technic:carbon_steel_dust 2",   "technic:coal_dust",          "technic:cast_iron_dust 2", 6},
	{"technic:carbon_steel_ingot 2",  "technic:coal_dust",          "technic:cast_iron_ingot 2", 6},
	{"technic:carbon_steel_dust 4",   "technic:chromium_dust",      "technic:stainless_steel_dust 5", 7.5},
	{"technic:carbon_steel_ingot 4",  "technic:chromium_ingot",     "technic:stainless_steel_ingot 5", 7.5},
	{"technic:carbon_steel_block 4",  "technic:chromium_block",     "technic:stainless_steel_block 5", 60},
	{"technic:copper_dust 2",         "technic:zinc_dust",          "technic:brass_dust 3"},
	{"default:copper_ingot 2",        "technic:zinc_ingot",         "basic_materials:brass_ingot 3"},
	{"default:copperblock 2",         "technic:zinc_block",         "basic_materials:brass_block 3", 36},
    {"default:copperblock",        "basic_materials:plastic_sheet", "technic:copperblock_lacquered"},
    {"technic:copper_polished",    "basic_materials:plastic_sheet", "technic:copper_lacquered"},
	{"default:sand 2",                "technic:coal_dust 2",        "technic:silicon_wafer"},
	{"technic:silicon_wafer",         "technic:gold_dust",          "technic:doped_silicon_wafer"},
	-- from https://en.wikipedia.org/wiki/Carbon_black
	-- The highest volume use of carbon black is as a reinforcing filler in rubber products, especially tires.
	-- "[Compounding a] pure gum vulcanizate … with 50% of its weight of carbon black improves its tensile strength and wear resistance …"
	{"technic:raw_latex 4",           "technic:coal_dust 2",        "technic:rubber 6", 2},
	{"default:ice",                   "bucket:bucket_empty",        "bucket:bucket_water", 1 },
}

if minetest.get_modpath("moreblocks") then
    table.insert(recipes, {"moreblocks:clean_glass 8",   "default:mese_crystal_fragment", "moreblocks:clean_super_glow_glass 8", 2 })
    table.insert(recipes, {"default:glass 8",            "default:mese_crystal_fragment", "moreblocks:super_glow_glass 8",       2 })
    table.insert(recipes, {"group:sand 9",               "default:mese_crystal_fragment", "moreblocks:super_glow_glass 9",       12 })
end
if minetest.get_modpath("basic_materials") then
    for _, clr in pairs(dye.dyes) do
       table.insert(recipes, {"basic_materials:paraffin 8", "dye:" .. clr[1], "basic_materials:plastic_" .. clr[1] .. " 2", 6 })
    end
    -- table.insert(recipes, {"basic_materials:paraffin 8", "dye:blue",  "basic_materials:plastic_blue 2",  6 })
    -- table.insert(recipes, {"basic_materials:paraffin 8", "dye:brown", "basic_materials:plastic_brown 2", 6 })
    -- table.insert(recipes, {"basic_materials:paraffin 8", "dye:cyan",  "basic_materials:plastic_cyan 2",  6 })
end
if minetest.get_modpath("glowstone") then
    table.insert(recipes, {"glowstone:glowdust", "technic:stone_dust 4", "glowstone:glowstone 4", 3 })
end

for _, data in pairs(recipes) do
	technic.register_alloy_recipe({input = {data[1], data[2]}, output = data[3], time = data[4]})
end

if minetest.get_modpath("dye") then
  for _, clay in pairs(dye.dyes) do
      technic.register_alloy_recipe({
         input  = { "default:clay 11", "dye:" .. clay[1] },
         output = "bakedclay:" .. clay[1] .. " 11",
         time   = 5
      })
  end
end
