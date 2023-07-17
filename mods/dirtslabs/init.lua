--local modpath = minetest.get_modpath("dirtslabs")
local woodsoilspath = minetest.get_modpath("woodsoils")

-- TODO: make grass &c spread onto the plain dirt slabs and from the non-plain ones

stairs.register_slab("dirt", "default:dirt",
                     {crumbly = 3 },
                     {"default_dirt.png"},
                     "Dirt Slab",
                     default.node_sound_dirt_defaults(),
                     true)

stairs.register_slab("dirt_with_grass", "default:dirt_with_grass",
                     {crumbly = 3 },
                     {"default_grass.png", "default_dirt.png",
                      "default_dirt.png^default_grass_side.png"},
                     "Dirt Slab with Grass",
                     default.node_sound_dirt_defaults({
                        footstep = {name = "default_grass_footstep", gain = 0.25},
                     }),
                     true)

stairs.register_slab("dirt_with_rainforest_litter", "default:dirt_with_rainforest_litter",
                     {crumbly = 3, spreading_dirt_type = 1 },
                     {  "default_rainforest_litter.png",
                        "default_dirt.png",
                        {name = "default_dirt.png^default_rainforest_litter_side.png",
                         tileable_vertical = false}
                     },
                     "Dirt Slab with Rainforest Litter",
                     default.node_sound_dirt_defaults({
                        footstep = {name = "default_grass_footstep", gain = 0.4},
                     }),
                     true)

stairs.register_slab("dirt_with_coniferous_litter", "default:dirt_with_coniferous_litter",
                     {crumbly = 3, spreading_dirt_type = 1 },
                     {  "default_coniferous_litter.png",
                        "default_dirt.png",
                        {name = "default_dirt.png^default_coniferous_litter_side.png",
                         tileable_vertical = false}
                     },
                     "Dirt Slab with Coniferous Litter",
                     default.node_sound_dirt_defaults({
                        footstep = {name = "default_grass_footstep", gain = 0.4},
                     }),
                     true)

stairs.register_slab("dry dirt", "default:dry_dirt",
                     {crumbly = 3 },
                     {"default_dry_dirt.png"},
                     "Dry Dirt Slab",
                     default.node_sound_dirt_defaults(),
                     true)

stairs.register_slab("dry_dirt_with_dry_grass", "default:dry_dirt_with_dry_grass",
                     {crumbly = 3, spreading_dirt_type = 1 },
                     {  "default_dry_grass.png",
                        "default_dry_dirt.png",
                        {name = "default_dry_dirt.png^default_dry_grass_side.png",
                         tileable_vertical = false}
                     },
                     "Dry Dirt Slab with Dry Grass",
                     default.node_sound_dirt_defaults({
                        footstep = {name = "default_grass_footstep", gain = 0.4},
                     }),
                     true)


if woodsoilspath then
    stairs.register_slab("dirt_with_leaves_1", "woodsoils:dirt_with_leaves_1",
                        {crumbly = 3 },
                        {
		                   "default_dirt.png^woodsoils_ground_cover.png",
		                   "default_dirt.png",
		                   "default_dirt.png^woodsoils_ground_cover_side.png"},
                        "Forest Soil 1 Slab",
                        default.node_sound_dirt_defaults(),
                        true)
    stairs.register_slab("dirt_with_leaves_2", "woodsoils:dirt_with_leaves_2",
                        {crumbly = 3},
                        {
		                   "woodsoils_ground.png",
		                   "default_dirt.png",
		                   "default_dirt.png^woodsoils_ground_side.png"},
                        "Forest Soil 2 Slab",
                        default.node_sound_dirt_defaults(),
                        true)
    stairs.register_slab("grass_with_leaves_1", "woodsoils:grass_with_leaves_1",
                        {crumbly = 3 },
                        {
		                   "default_grass.png^woodsoils_ground_cover.png",
		                   "default_dirt.png",
		                   "default_dirt.png^default_grass_side.png^woodsoils_ground_cover_side2.png"},
                        "Forest Soil 3 Slab",
                        default.node_sound_dirt_defaults(),
                        true)
    stairs.register_slab("grass_with_leaves_2", "woodsoils:grass_with_leaves_2",
                        {crumbly = 3},
                        {
		                   "default_grass.png^woodsoils_ground_cover.png",
		                   "default_dirt.png",
		                   "default_dirt.png^default_grass_side.png^woodsoils_ground_cover_side.png"},
                        "Forest Soil 4 Slab",
                        default.node_sound_dirt_defaults(),
                        true)
end
