-- LV Electric Furnace
-- This is a faster version of the stone furnace which runs on EUs

minetest.register_craft({
	output = 'technic:electric_furnace',
	recipe = {
		{'default:cobble', 'basic_materials:heating_element', 'default:cobble'},
		{'default:cobble', 'technic:machine_casing',          'default:cobble'},
		{'default:cobble', 'technic:lv_cable',                'default:cobble'},
	}
})

technic.register_electric_furnace({tier="LV", demand={300}, speed = 2})


