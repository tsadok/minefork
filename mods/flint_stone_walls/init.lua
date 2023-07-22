
minetest.register_node("flint_stone_walls:stone_wall_a", {
    description = "Flint Stone Wall 1",
    paramtype2 = "facedir",
    place_param2 = 0,
    tiles = {
        -- These should all tile interchangeably, so you can build a stone wall and then whack
        -- each voxel a random number of times with a screwdriver and get halfway decent results.
        "flint_stone_wall_a_top.png",
        "flint_stone_wall_a_bottom.png",
        "flint_stone_wall_a_side1.png",
        "flint_stone_wall_a_side2.png",
        "flint_stone_wall_a_side3.png",
        "flint_stone_wall_a_side4.png",
    },
    is_ground_content = false,
    groups = {cracky = 3},
    sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("flint_stone_walls:stone_wall_b", {
    description = "Flint Stone Wall 2",
    paramtype2 = "facedir",
    place_param2 = 0,
    tiles = {
        -- These should all tile interchangeably, so you can build a stone wall and then whack
        -- each voxel a random number of times with a screwdriver and get halfway decent results.
        "flint_stone_wall_b_top.png",
        "flint_stone_wall_b_bottom.png",
        "flint_stone_wall_b_side1.png",
        "flint_stone_wall_b_side2.png",
        "flint_stone_wall_b_side3.png",
        "flint_stone_wall_b_side4.png",
    },
    is_ground_content = false,
    groups = {cracky = 3},
    sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
    output = "flint_stone_walls:stone_wall_a 6",
    recipe = {
       { "default:flint", "default:stone", "default:flint" },
       { "default:stone", "default:flint", "default:stone" },
    }
})

minetest.register_craft({
    output = "flint_stone_walls:stone_wall_b 6",
    recipe = {
       { "default:stone", "default:flint", "default:stone" },
       { "default:flint", "default:stone", "default:flint" },
    }
})

