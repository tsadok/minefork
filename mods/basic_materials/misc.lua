-- Translation support
local S = minetest.get_translator("basic_materials")

-- items

minetest.register_craftitem("basic_materials:oil_extract", {
	description = S("Oil extract"),
	inventory_image = "basic_materials_oil_extract.png",
})

minetest.register_craftitem("basic_materials:paraffin", {
	description = S("Unprocessed paraffin"),
	inventory_image = "basic_materials_paraffin.png",
})

minetest.register_craftitem("basic_materials:terracotta_base", {
	description = S("Uncooked Terracotta Base"),
	inventory_image = "basic_materials_terracotta_base.png",
})

minetest.register_craftitem("basic_materials:wet_cement", {
	description = S("Wet Cement"),
	inventory_image = "basic_materials_wet_cement.png",
})

-- nodes

minetest.register_node("basic_materials:limestone", {
    description = S("Limestone"),
    tiles       = { "basic_materials_limestone.png" },
	is_ground_content = true,
	groups = {cracky=3, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craftitem("basic_materials:limestone_dust", {
    description = S("Lime"),
    inventory_image = "technic_stone_dust.png",
})
stairs.register_slab("limestone",
                     "basic_materials:limestone",
                     { cracky = 3, stone = 1, not_in_creative_inventory = 1 },
                     { "basic_materials_limestone.png" },
                     "Limestone Slab",
                     default.node_sound_stone_defaults(),
                     false)
stairs.register_stair("limestone",
                      "basic_materials:limestone",
                      { cracky = 3, stone = 1, not_in_creative_inventory = 1 },
                      { "basic_materials_limestone.png" },
                      "Limestone Stair",
                      default.node_sound_stone_defaults(),
                      false)

minetest.register_ore({
    ore_type = "sheet",
    ore = "basic_materials:limestone",
    wherein = "default:stone",
    column_height_min = 3,
    column_height_max = 11,
    column_midpoint_factor = 0.3,
    y_min = -4096,
    y_max = -8,
    noise_threshold = 0.4,
    noise_params = {
       offset = 0, scale = 15, spread = {x = 150, y = 150, z = 150},
       seed = 61, octaves = 3, persist = 0.70
    }
})

minetest.register_ore({
    ore_type = "sheet",
    ore = "default:olivine",
    wherein = "default:stone",
    column_height_min = 2,
    column_height_max = 8,
    column_midpoint_factor = 0.3,
    y_min = -16384,
    y_max = -512,
    noise_threshold = 0.4,
    noise_params = {
       offset = 0, scale = 12, spread = {x = 150, y = 150, z = 150},
       seed = 37, octaves = 5, persist = 0.70
    }
})

minetest.register_ore({
    ore_type = "scatter",
    ore = "air",
    wherein = "basic_materials:limestone",
    clust_scarcity = 8 * 8 * 8,
    clust_size = 5,
    y_max = -16,
    y_min = -4096,
})
-- TODO: add fossils in limestone.
-- TODO: add pools and/or rivers of water in limestone.
-- TODO: add sinkholes in limestone.


minetest.register_node("basic_materials:cement_block", {
	description = S("Cement"),
	tiles = {"basic_materials_cement_block.png"},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("basic_materials:concrete_block", {
	description = S("Concrete Block"),
	tiles = {"basic_materials_concrete_block.png",},
	groups = {cracky=1, level=2, concrete=1},
	sounds = default.node_sound_stone_defaults(),
})

-- crafts

minetest.register_craft({
	type = "shapeless",
	output = "basic_materials:oil_extract 2",
	recipe = {
		"group:leaves",
		"group:leaves",
		"group:leaves",
		"group:leaves",
		"group:leaves",
		"group:leaves"
	}
})

minetest.register_craft({
	type = "cooking",
	output = "basic_materials:paraffin",
	recipe = "basic_materials:oil_extract",
})

minetest.register_craft({
	type = "fuel",
	recipe = "basic_materials:oil_extract",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "basic_materials:paraffin",
	burntime = 30,
})

minetest.register_craft( {
	type = "shapeless",
	output = "basic_materials:terracotta_base 8",
	recipe = {
		"bucket:bucket_water",
		"default:clay_lump",
		"default:gravel",
	},
	replacements = { {"bucket:bucket_water", "bucket:bucket_empty"}, },
})

minetest.register_craft({
	type = "shapeless",
	output = "basic_materials:wet_cement 3",
	recipe = {
		"default:sand",
		"basic_materials:limestone_dust",
		"bucket:bucket_water"
	},
	replacements = {{'bucket:bucket_water', 'bucket:bucket_empty'},},
})

minetest.register_craft({
	type = "cooking",
	output = "basic_materials:cement_block",
	recipe = "basic_materials:wet_cement",
	cooktime = 8
})

minetest.register_craft({
	output = 'basic_materials:concrete_block 6',
	recipe = {
		{'group:sand',                'basic_materials:wet_cement', 'default:gravel'},
		{'basic_materials:steel_bar', 'basic_materials:wet_cement', 'basic_materials:steel_bar'},
		{'default:gravel',            'basic_materials:wet_cement', 'group:sand'},
	}
})

-- aliases

minetest.register_alias("homedecor:oil_extract",      "basic_materials:oil_extract")
minetest.register_alias("homedecor:paraffin",         "basic_materials:paraffin")
minetest.register_alias("homedecor:plastic_base",     "basic_materials:paraffin")
minetest.register_alias("homedecor:terracotta_base",  "basic_materials:terracotta_base")

minetest.register_alias("gloopblocks:wet_cement",     "basic_materials:wet_cement")
minetest.register_alias("gloopblocks:cement",         "basic_materials:cement_block")

minetest.register_alias("technic:concrete",           "basic_materials:concrete_block")
