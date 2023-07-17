-- The textures for this module are based on default Minetest Game textures,
-- and are distributed under the same license as Minetest Game.  The remainder
-- of this module is in the public domain.

local stype = {
   { "silver_sand",  "ssand", "Dyed Sand",   "Dyed Sandstone"   },
   { "sand",         "bsand", "Beachsand",   "Beach Sandstone"  },
   { "desert_sand",  "dsand", "Desert Sand", "Desert Sandstone" },
}

minetest.register_craft({
	type = "cooking",
	output = "default:desert_sandstone",
	recipe = "default:sandstone",
})

for _, stype in pairs(stype) do
   for _, colour in pairs(dye.dyes) do
      local rgb = colour[3]
      minetest.register_node("coloredsand:" .. stype[2] .. "_" .. colour[1], {
         description = colour[2] .. " " .. stype[3],
         tiles = { stype[2] .. "_" .. colour[1] .. ".png" },
         groups = { crumbly = 3, falling_node = 1, coloredsand = 1, },
         sounds = default.node_sound_sand_defaults(),
      })
      minetest.register_node("coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1], {
         description = colour[2] .. " " .. stype[4],
         tiles = { stype[2] .. "stone_" .. colour[1] .. ".png" },
         groups = { crumbly = 1, cracky=3 },
         sounds = default.node_sound_stone_defaults(),
      })
      minetest.register_node("coloredsand:" .. stype[2] .. "stone" .. "_brick_" .. colour[1], {
         description = colour[2] .. " " .. stype[4] .. " Brick",
         tiles = { stype[2] .. "stone_brick_" .. colour[1] .. ".png" },
         paramtype2 = "facedir",
         place_param2 = 0,
         is_ground_content = false,
         groups = { cracky=2 },
         sounds = default.node_sound_stone_defaults(),
      })
      minetest.register_node("coloredsand:" .. stype[2] .. "stone" .. "_block_" .. colour[1], {
         description = colour[2] .. " " .. stype[4] .. " Block",
         tiles = { stype[2] .. "stone_block_" .. colour[1] .. ".png" },
         is_ground_content = false,
         groups = { cracky=2 },
         sounds = default.node_sound_stone_defaults(),
      })
      stairs.register_stair(stype[2] .. "stone_block_" .. colour[1],
                            "coloredsand:" .. stype[2] .. "stone_block_" .. colour[1],
                            { cracky = 2, not_in_creative_inventory = 1 },
                            { stype[2] .. "stone_block_" .. colour[1] .. ".png" },
                            colour[2] .. " " .. stype[4] .. " Block Stair",
                            default.node_sound_stone_defaults(), false)
      stairs.register_slab(stype[2] .. "stone_block_" .. colour[1],
                           "coloredsand:" .. stype[2] .. "stone_block_" .. colour[1],
                           { cracky = 2, not_in_creative_inventory = 1 },
                           { stype[2] .. "stone_block_" .. colour[1] .. ".png" },
                           colour[2] .. " " .. stype[4] .. " Block Slab",
                           default.node_sound_stone_defaults(), false)
      stairs.register_stair(stype[2] .. "stone_brick_" .. colour[1],
                            "coloredsand:" .. stype[2] .. "stone_brick_" .. colour[1],
                            { cracky = 2, not_in_creative_inventory = 1 },
                            { stype[2] .. "stone_brick_" .. colour[1] .. ".png" },
                            colour[2] .. " " .. stype[4] .. " Brick Stair",
                            default.node_sound_stone_defaults(), false)
      stairs.register_slab(stype[2] .. "stone_brick_" .. colour[1],
                           "coloredsand:" .. stype[2] .. "stone_brick_" .. colour[1],
                           { cracky = 2, not_in_creative_inventory = 1 },
                           { stype[2] .. "stone_brick_" .. colour[1] .. ".png" },
                           colour[2] .. " " .. stype[4] .. " Brick Slab",
                           default.node_sound_stone_defaults(), false)

      minetest.register_node("coloredsand:" .. "glass_" .. colour[1], {
         description         = colour[2] .. " Glass",
         -- drawtype            = "glasslike_framed_optional",
         -- tiles               = { "glass_" .. colour[1] .. ".png", "glass_" .. colour[1] . "_detail.png" },
         -- use_texture_alpha   = "clip",
         -- sunlight_propagates = true,
         -- paramtype           = "light",
         -- paramtype2          = "glasslikeliquidlevel",
         drawtype            = "glasslike_framed_optional", -- water uses "liquid" here, and achieves transparency...
         tiles               = { { name             = "coloredsand_glass_" .. colour[1] .. ".png",
                                   backface_culling = true, -- I _think_ this is what I want.  Not 100%.
                                  },
                               },
         alpha               = 128, -- might only work with liquids
         use_texture_alpha   = "blend",
         paramtype           = "light",
         post_effect_color   = { a = 103, r = rgb.r, g = rgb.g, b = rgb.b }, -- might only work when the player is inside the node (as with liquids)
         is_ground_content   = false,
         groups              = { cracky = 3, oddly_breakable_by_hand = 3, coloredglass = 1 },
         sounds              = default.node_sound_glass_defaults(),
      })
      
      minetest.register_craft({
         output = "coloredsand:" .. stype[2] .. "_" .. colour[1] .. " 8",
         recipe = {
            { "default:" .. stype[1], "default:" .. stype[1],      "default:" .. stype[1] },
            { "default:" .. stype[1], "dye:" .. colour[1], "default:" .. stype[1] },
            { "default:" .. stype[1], "default:" .. stype[1],      "default:" .. stype[1] },
         }
      })
      minetest.register_craft({
         output = "coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1],
         recipe = {
            { "coloredsand:" .. stype[2] .. "_" .. colour[1], "coloredsand:" .. stype[2] .. "_" .. colour[1] },
            { "coloredsand:" .. stype[2] .. "_" .. colour[1], "coloredsand:" .. stype[2] .. "_" .. colour[1] },
         }
      })
      technic.register_compressor_recipe({
         input  = { "coloredsand:" .. stype[2] .. "_" .. colour[1] .. " 2" },
         output = { "coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1], },
      })
      technic.register_grinder_recipe({
         input  = { "coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1], },
         output = { "coloredsand:" .. stype[2] .. "_" .. colour[1] .. " 2" },
      })
      technic.register_grinder_recipe({
         input  = { "coloredsand:" .. stype[2] .. "stone" .. "_brick_" .. colour[1], },
         output = { "coloredsand:" .. stype[2] .. "_" .. colour[1] .. " 2" },
      })
      technic.register_grinder_recipe({
         input  = { "coloredsand:" .. stype[2] .. "stone" .. "_block_" .. colour[1], },
         output = { "coloredsand:" .. stype[2] .. "_" .. colour[1] .. " 2" },
      })
      minetest.register_craft({
         output = "coloredsand:" .. stype[2] .. "stone" .. "_brick_" .. colour[1] .. " 4",
         recipe = {
            { "coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1],  "coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1], },
            { "coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1],  "coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1], },
         }
      })
      minetest.register_craft({
         output = "coloredsand:" .. stype[2] .. "stone" .. "_block_" .. colour[1] .. " 9",
         recipe = {
            { "coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1], "coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1], "coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1], },
            { "coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1], "coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1], "coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1], },
            { "coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1], "coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1], "coloredsand:" .. stype[2] .. "stone" .. "_" .. colour[1], },
         }
      })
      technic.register_alloy_recipe({
         input  = { "coloredsand:" .. stype[2] .. "_" .. colour[1] .. " 9", "default:dye_" .. colour[1] },
         output = { "coloredsand:" .. "glass_" .. colour[1] .. " 9" },
      })
   end
end
