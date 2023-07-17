-- Translation support
local S = minetest.get_translator("basic_materials")

-- items

minetest.register_craftitem("basic_materials:plastic_sheet", {
	description = S("Plastic sheet"),
	inventory_image = "basic_materials_plastic_sheet.png",
})

minetest.register_craftitem("basic_materials:plastic_strip", {
	description = S("Plastic strips"),
	groups = { strip = 1 },
	inventory_image = "basic_materials_plastic_strip.png",
})

minetest.register_craftitem("basic_materials:empty_spool", {
	description = S("Empty wire spool"),
	inventory_image = "basic_materials_empty_spool.png"
})

minetest.register_node("basic_materials:plastic_clear", {
    description       = "Clear Plastic",
    drawtype          = "glasslike",
    alpha             = 64,
    use_texture_alpha = "blend",
    paramtype         =       "light",
    tiles             = { "plastic_clear.png" },
    inventory_image   = "plastic_clear_inv.png",
    groups            = { snappy=3, oddly_breakable_by_hand=3, plastic=1 },
})
minetest.register_craft({
    output = "basic_materials:plastic_clear",
    recipe = {
       { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
       { "basic_materials:plastic_sheet", "",                              "basic_materials:plastic_sheet" },
       { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
    }
})

for _, colour in pairs(dye.dyes) do
    minetest.register_node("basic_materials:plastic_".. colour[1], {
       description = colour[2] .. " Plastic",
       tiles = { "plastic_" .. colour[1] .. ".png" },
       groups = { snappy=3, oddly_breakable_by_hand=3, plastic=1 },
    })
    minetest.register_craft({
       output = "basic_materials:plastic_" .. colour[1],
       recipe = {
          { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
          { "basic_materials:plastic_sheet", "dye:" .. colour[1], "basic_materials:plastic_sheet" },
          { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
       }
    })
end

-- crafts

minetest.register_craft({
	type = "cooking",
	output = "basic_materials:plastic_sheet",
	recipe = "basic_materials:paraffin",
})

minetest.register_craft({
	type = "fuel",
	recipe = "basic_materials:plastic_sheet",
	burntime = 30,
})

minetest.register_craft( {
    output = "basic_materials:plastic_strip 9",
    recipe = {
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
    },
})

minetest.register_craft( {
	output = "basic_materials:empty_spool 3",
	recipe = {
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
		{ "", "basic_materials:plastic_sheet", "" },
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
	},
})

-- aliases

minetest.register_alias("homedecor:plastic_sheeting", "basic_materials:plastic_sheet")
minetest.register_alias("homedecor:plastic_strips",   "basic_materials:plastic_strip")
minetest.register_alias("homedecor:empty_spool",      "basic_materials:empty_spool")
