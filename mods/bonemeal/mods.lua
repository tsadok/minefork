
-- craft bones from animalmaterials into bonemeal
if minetest.get_modpath("animalmaterials") then

	minetest.register_craft({
		type = "shapeless",
		output = "bonemeal:bonemeal 2",
		recipe = {"animalmaterials:bone"}
	})
end


if farming and farming.mod and farming.mod == "redo" then

	bonemeal:add_crop({
		{"farming:tomato_", 8},
		{"farming:corn_", 8},
		{"farming:melon_", 8},
		{"farming:pumpkin_", 8},
		{"farming:beanpole_", 5},
		{"farming:blueberry_", 4},
		{"farming:raspberry_", 4},
		{"farming:carrot_", 8},
		{"farming:cocoa_", 4},
		{"farming:coffee_", 5},
		{"farming:cucumber_", 4},
		{"farming:potato_", 4},
		{"farming:grapes_", 8},
		{"farming:rhubarb_", 3},
		{"farming:barley_", 7},
		{"farming:hemp_", 8},
		{"farming:chili_", 8},
		{"farming:garlic_", 5},
		{"farming:onion_", 5},
		{"farming:pepper_", 7},
		{"farming:pineapple_", 8},
		{"farming:pea_", 5},
		{"farming:beetroot_", 5},
		{"farming:rye_", 8},
		{"farming:oat_", 8},
		{"farming:rice_", 8},
		{"farming:mint_", 4},
		{"farming:cabbage_", 6},
		{"farming:lettuce_", 5},
		{"farming:blackberry_", 4},
		{"farming:vanilla_", 8},
		{"farming:soy_", 7},
		{"farming:artichoke_", 5},
		{"farming:parsley_", 3}
	})
end


if minetest.get_modpath("ethereal") then

	bonemeal:add_crop({
		{"ethereal:strawberry_", 8},
		{"ethereal:onion_", 5}
	})

	bonemeal:add_sapling({
		{"ethereal:palm_sapling", ethereal.grow_palm_tree, "soil"},
		{"ethereal:palm_sapling", ethereal.grow_palm_tree, "sand"},
		{"ethereal:yellow_tree_sapling", ethereal.grow_yellow_tree, "soil"},
		{"ethereal:big_tree_sapling", ethereal.grow_big_tree, "soil"},
		{"ethereal:banana_tree_sapling", ethereal.grow_banana_tree, "soil"},
		{"ethereal:frost_tree_sapling", ethereal.grow_frost_tree, "soil"},
		{"ethereal:mushroom_sapling", ethereal.grow_mushroom_tree, "soil"},
		{"ethereal:willow_sapling", ethereal.grow_willow_tree, "soil"},
		{"ethereal:redwood_sapling", ethereal.grow_redwood_tree, "soil"},
		{"ethereal:orange_tree_sapling", ethereal.grow_orange_tree, "soil"},
		{"ethereal:bamboo_sprout", ethereal.grow_bamboo_tree, "soil"},
		{"ethereal:birch_sapling", ethereal.grow_birch_tree, "soil"},
		{"ethereal:sakura_sapling", ethereal.grow_sakura_tree, "soil"},
		{"ethereal:lemon_tree_sapling", ethereal.grow_lemon_tree, "soil"},
		{"ethereal:olive_tree_sapling", ethereal.grow_olive_tree, "soil"}
	})

	local grass = {"default:grass_3", "default:grass_4", "default:grass_5", ""}

	bonemeal:add_deco({
		{"ethereal:crystal_dirt", {"ethereal:crystalgrass", "", "", "", ""}, {}},
		{"ethereal:fiery_dirt", {"ethereal:dry_shrub", "", "", "", ""}, {}},
		{"ethereal:prairie_dirt", grass, {"flowers:dandelion_white",
			"flowers:dandelion_yellow", "flowers:geranium", "flowers:rose",
			"flowers:tulip", "flowers:viola", "ethereal:strawberry_7"}},
		{"ethereal:gray_dirt", {}, {"ethereal:snowygrass", "", ""}},
		{"ethereal:cold_dirt", {}, {"ethereal:snowygrass", "", ""}},
		{"ethereal:mushroom_dirt", {}, {"flowers:mushroom_red", "flowers:mushroom_brown", "", "", ""}},
		{"ethereal:jungle_dirt", grass, {"default:junglegrass", "", "", ""}},
		{"ethereal:grove_dirt", grass, {"ethereal:fern", "", "", ""}},
		{"ethereal:bamboo_dirt", grass, {}}
	})
end


if minetest.get_modpath("moretrees") then

	-- special fir check for snow
	local function fir_grow(pos)

		if minetest.find_node_near(pos, 1,
			{"default:snow", "default:snowblock", "default:dirt_with_snow"}) then

			moretrees.grow_fir_snow(pos)
		else
			moretrees.grow_fir(pos)
		end
	end

	bonemeal:add_sapling({
		{"moretrees:beech_sapling", moretrees.spawn_beech_object, "soil"},
		{"moretrees:apple_tree_sapling", moretrees.spawn_apple_tree_object, "soil"},
		{"moretrees:oak_sapling", moretrees.spawn_oak_object, "soil"},
		{"moretrees:sequoia_sapling", moretrees.spawn_sequoia_object, "soil"},
		--{"moretrees:birch_sapling", moretrees.spawn_birch_object, "soil"},
		{"moretrees:birch_sapling", moretrees.grow_birch, "soil"},
		{"moretrees:palm_sapling", moretrees.spawn_palm_object, "soil"},
		{"moretrees:palm_sapling", moretrees.spawn_palm_object, "sand"},
		{"moretrees:date_palm_sapling", moretrees.spawn_date_palm_object, "soil"},
		{"moretrees:date_palm_sapling", moretrees.spawn_date_palm_object, "sand"},
		--{"moretrees:spruce_sapling", moretrees.spawn_spruce_object, "soil"},
		{"moretrees:spruce_sapling", moretrees.grow_spruce, "soil"},
		{"moretrees:cedar_sapling", moretrees.spawn_cedar_object, "soil"},
		{"moretrees:poplar_sapling", moretrees.spawn_poplar_object, "soil"},
		{"moretrees:willow_sapling", moretrees.spawn_willow_object, "soil"},
		{"moretrees:rubber_tree_sapling", moretrees.spawn_rubber_tree_object, "soil"},
		{"moretrees:fir_sapling", fir_grow, "soil"}
	})

elseif minetest.get_modpath("technic_worldgen") then

	bonemeal:add_sapling({
		{"moretrees:rubber_tree_sapling", technic.rubber_tree_model, "soil"}
	})
end

if minetest.get_modpath("caverealms") then

	local fil = minetest.get_modpath("caverealms") .. "/schematics/shroom.mts"
	local add_shroom = function(pos)

		minetest.swap_node(pos, {name = "air"})

		minetest.place_schematic(
			{x = pos.x - 5, y = pos.y, z = pos.z - 5}, fil, 0, nil, false)
	end

	bonemeal:add_sapling({
		{"caverealms:mushroom_sapling", add_shroom, "soil"}
	})
end


if minetest.get_modpath("dye") then

	local bonemeal_dyes = {
			bonemeal = "white", fertiliser = "green", mulch = "brown"}

	for mat, dye in pairs(bonemeal_dyes) do

		minetest.register_craft({
			output = "dye:" .. dye .. " 4",
			recipe = {
				{"bonemeal:" .. mat}
			},
		})
	end
end

local leaves = {
  "default:leaves",
  "default:aspen_leaves",
  "default:acacia_leaves",
  "default:jungleleaves",
  "default:pine_needles",

  -- the moretrees module
  "moretrees:apple_tree_leaves",
  "moretrees:apple_blossoms",
  "moretrees:beech_leaves",
  "moretrees:birch_leaves",
  "moretrees:cedar_leaves",
  "moretrees:date_palm_leaves",
  "moretrees:fir_leaves",
  "moretrees:fir_leaves_bright",
  "moretrees:jungletree_leaves_red",
  "moretrees:jungletree_leaves_yellow",
  "moretrees:oak_leaves",
  "moretrees:palm_leaves",
  "moretrees:poplar_leaves",
  "moretrees:rubber_tree_leaves",
  "moretrees:sequoia_leaves",
  "moretrees:spruce_leaves",
  "moretrees:willow_leaves",
  "moretrees:azure_leaves",
  "moretrees:crimson_leaves",
  "moretrees:galion_leaves",
  "moretrees:hotpink_leaves",
  "moretrees:magenta_leaves",
  "moretrees:springgreen_leaves",
  "moretrees:yellow_leaves",

  -- dreambuilder-specific stuff
  "baldycypress:leaves",
  "bamboo:leaves",
  "birch:leaves",
  "cherrytree:blossom_leaves",
  "cherrytree:leaves",
  "chestnuttree:leaves",
  "clementinetree:leaves",
  "ebony:leaves",
  "ebony:liana",
  "hollytree:leaves",
  "jacaranda:blossom_leaves",
  "larch:leaves",
  "larch:moss",
  "lemontree:leaves",
  "mahogany:leaves",
  "maple:leaves",
  "oak:leaves",
  "palm:leaves",
  "plumtree:leaves",
  "pomegranate:leaves",
  "willow:leaves",
  -- why do we have Ethereal stuff here?
  "ethereal:bananaleaves",

  -- various bushes
  "default:bush_leaves",
  "default:acacia_bush_leaves",
  "default:blueberry_bush_leaves",
  "default:pine_bush_needles",
  "bushes:bushbranches1",
  "bushes:bushbranches2",
  "bushes:bushbranches3",
  "bushes:bushbranches4",
  "bushes:BushLeaves1",
  "bushes:BushLeaves2",
  "bushes:BushLeaves3",
  "bushes:BushLeaves4",
  "ebony:creeper_leaves",
  "mahogany:creeper",
  "mahogany:flower_creeper",
  "mahogany:hanging_creeper",

  -- dfcaverns stuff from deep underground
  "df_trees:black_cap_gills",
  "df_trees:goblin_cap_gills",
  "df_trees:nether_cap_gills",
  "df_trees:tower_cap_gills",
  "df_trees:spore_tree_hyphae",
  "df_trees:spore_tree_fruiting_body",
  "df_trees:fungiwood_shelf",
  "df_primordial_items:jungle_leaves",
  "df_primordial_items:jungle_leaves_glowing",
  "df_primordial_items:giant_fern_leaves",
  "df_primordial_items:mushroom_gills",
  "df_primordial_items:mushroom_gills_glowing"
}

for _, leaf in ipairs(leaves) do
   if minetest.get_modpath("technic") then
      technic.register_extractor_recipe({
         input  = {leaf .. " 24"},
         output = "bonemeal:fertiliser",
      })
   end
end
