local S = minetest.get_translator("currency")

minetest.register_craftitem("currency:minegeld", {
	description = S("@1 Minegeld Note", "1"),
	inventory_image = "minegeld.png",
		stack_max = 65535,
		groups = {minegeld = 1, minegeld_note = 1}
})

minetest.register_craftitem("currency:minegeld_5", {
	description = S("@1 Minegeld Note", "5"),
	inventory_image = "minegeld_5.png",
		stack_max = 65535,
		groups = {minegeld = 1, minegeld_note = 1}
})

minetest.register_craftitem("currency:minegeld_20", {
	description = S("@1 Minegeld Note", "20"),
	inventory_image = "minegeld_20.png",
		stack_max = 65535,
		groups = {minegeld = 1, minegeld_note = 1}
})

minetest.register_craftitem("currency:minegeld_100", {
	description = S("@1 Minegeld Note", "100"),
	inventory_image = "minegeld_100.png",
		stack_max = 65535,
		groups = {minegeld = 1, minegeld_note = 1}
})

