-- HV Alloy Furnace
-- Like the MV one but faster.

minetest.register_craft({
	output = 'technic_hv_extend:hv_alloy_furnace',
	recipe = {
		{'technic:carbon_plate',          'technic:mv_alloy_furnace',    'technic:composite_plate'},
		{'pipeworks:tube_1',              'technic:hv_transformer',      'pipeworks:tube_1'},
		{'technic:stainless_steel_ingot', 'technic:hv_cable',            'technic:stainless_steel_ingot'}
	}
})


technic.register_alloy_furnace({tier = "HV", speed = 5, upgrade = 1, tube = 1, demand = {6000, 5000, 3000}, modname="technic_hv_extend"})

