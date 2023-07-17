--[[
***********
Glowstone
from Blox
by Sanchez

modified mapgen
by blert2112
***********
--]]

blox = {}

local version = "0.8"

local moreblocks = minetest.get_modpath("moreblocks")

-- Nodes

minetest.register_node("glowstone:glowstone", {
	description = "Glowstone",
	tiles = {"ethereal_glostone.png"},
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 14,
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("glowstone:glowore", {
	description = "Glow Ore",
	tiles = {"default_stone.png^blox_glowore.png"},
	--inventory_image = {"default_stone.png^blox_glowore.png"},
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = false,
	light_source = 8,
		drop = {
		max_items = 1,
		items = {
			{
				items = {"glowstone:glowstone"},
				rarity = 15,
			},
			{
				items = {"glowstone:glowdust 6"},
			}
		}
	},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("glowstone:glowdust", {
	description = "Glow Dust",
	drawtype = "plantlike",
	tiles = {"blox_glowdust.png"},
	inventory_image = "blox_glowdust.png",
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 9,
	walkable = false,
	groups = {cracky=3, snappy=3},
	})


minetest.register_craft({
	output = 'glowstone:glowstone 2',
	recipe = {
		{"", 'glowstone:glowdust', ""},
		{'glowstone:glowdust', 'default:stone', 'glowstone:glowdust'},
		{"", 'glowstone:glowdust', ""},
	}
})

-- Ores

local sea_level = 1

minetest.register_on_mapgen_init(function(mapgen_params)
	sea_level = mapgen_params.water_level
end)

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "glowstone:glowore",
	wherein        = "default:stone",
	clust_scarcity = 36 * 36 * 36,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min          = sea_level,
	y_max          = 31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "glowstone:glowore",
	wherein        = "default:stone",
	clust_scarcity = 14 * 14 * 14,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min          = sea_level - 30,
	y_max          = sea_level + 20,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "glowstone:glowore",
	wherein        = "default:stone",
	clust_scarcity = 36 * 36 * 36,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min          = -31000,
	y_max          = sea_level - 1,
})

print("Glowstone Mod [" ..version.. "] Loaded!")
