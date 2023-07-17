
local S = farming.intllib

-- cabbage
minetest.register_craftitem("farming:cabbage", {
	description = S("Cabbage"),
	inventory_image = "farming_cabbage.png",
	groups = {seed = 2, food_cabbage = 1, flammable = 2},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:cabbage_1")
	end,
	on_use = minetest.item_eat(1)
})

minetest.register_craftitem("farming:redcabbage", {
	description = S("Red Cabbage"),
	inventory_image = "farming_cabbage_red.png",
	groups = {seed = 2, food_cabbage = 1, flammable = 2, makes_blue_dye = 1 },
    -- Yes, red cabbage can be used to make blue dye, IRL, for real.  Look it up.
    -- (It turns back to red in an acidic environment.  But we only need so much realism here.)
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:redcabbage_1")
	end,
	on_use = minetest.item_eat(1)
})

local def = {
	drawtype = "plantlike",
	tiles = {"farming_cabbage_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}

local red = {
	drawtype = "plantlike",
	tiles = {"farming_cabbage_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("farming:cabbage_1", table.copy(def))
minetest.register_node("farming:redcabbage_1", table.copy(red))

-- stage 2
def.tiles = {"farming_cabbage_2.png"}
minetest.register_node("farming:cabbage_2", table.copy(def))

red.tiles = {"farming_cabbage_2.png"}
minetest.register_node("farming:redcabbage_2", table.copy(red))

-- stage 3
def.tiles = {"farming_cabbage_3.png"}
minetest.register_node("farming:cabbage_3", table.copy(def))

red.tiles = {"farming_cabbage_3.png"}
minetest.register_node("farming:redcabbage_3", table.copy(red))

-- stage 4
def.tiles = {"farming_cabbage_4.png"}
minetest.register_node("farming:cabbage_4", table.copy(def))

red.tiles = {"farming_cabbage_red_4.png"}
minetest.register_node("farming:redcabbage_4", table.copy(red))

-- stage 5
def.tiles = {"farming_cabbage_5.png"}
minetest.register_node("farming:cabbage_5", table.copy(def))

def.tiles = {"farming_cabbage_red_5.png"}
minetest.register_node("farming:redcabbage_5", table.copy(def))

-- stage 6
def.tiles = {"farming_cabbage_6.png"}
def.groups.growing = nil
def.drop = {
	max_items = 2, items = {
		{items = {"farming:cabbage 2"}, rarity = 1},
		{items = {"farming:cabbage 1"}, rarity = 2}
	}
}
minetest.register_node("farming:cabbage_6", table.copy(def))

red.tiles = {"farming_cabbage_red_6.png"}
red.groups.growing = nil
red.drop = {
	max_items = 2, items = {
		{items = {"farming:redcabbage 2"}, rarity = 1},
		{items = {"farming:redcabbage 1"}, rarity = 2}
	}
}
minetest.register_node("farming:redcabbage_6", table.copy(red))

-- add to registered_plants
farming.registered_plants["farming:cabbage"] = {
	crop = "farming:cabbage",
	seed = "farming:cabbage",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 6
}
farming.registered_plants["farming:redcabbage"] = {
	crop = "farming:redcabbage",
	seed = "farming:redcabbage",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 6
}

minetest.register_alias("farming:cabbage_red", "farming:redcabbage")
minetest.register_alias("farming:cabbage_red_1", "farming:redcabbage_1")
minetest.register_alias("farming:cabbage_red_2", "farming:redcabbage_2")
minetest.register_alias("farming:cabbage_red_3", "farming:redcabbage_3")
minetest.register_alias("farming:cabbage_red_4", "farming:redcabbage_4")
minetest.register_alias("farming:cabbage_red_5", "farming:redcabbage_5")
minetest.register_alias("farming:cabbage_red_6", "farming:redcabbage_6")

