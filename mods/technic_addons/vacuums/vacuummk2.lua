-- Configuration
local vacuum_max_charge        = 25000 -- 10000 - Maximum charge of the vacuum cleaner
local vacuum_charge_per_object = 90   -- 100   - Capable of picking up 50 objects
local vacuum_range             = 16     -- 8     - Area in which to pick up objects

local S = technic.getter

technic.register_power_tool("technic_addons:vacuummk2", vacuum_max_charge)

minetest.register_tool("technic_addons:vacuummk2", {
	description = S("Vacuum Cleaner Mk2"),
	inventory_image = "technicaddons_vacuummk2.png",
	stack_max = 1,
	wear_represents = "technic_RE_charge",
	on_refill = technic.refill_RE_charge,
	on_use = function(itemstack, user, pointed_thing)
		local meta = minetest.deserialize(itemstack:get_metadata())
		if not meta or not meta.charge then
			return
		end
		if meta.charge > vacuum_charge_per_object then
			minetest.sound_play("vacuumcleaner", {
				to_player = user:get_player_name(),
				gain = 0.4,
			})
		end
		local pos = user:get_pos()
		local inv = user:get_inventory()
		for _, object in ipairs(minetest.get_objects_inside_radius(pos, vacuum_range)) do
			local luaentity = object:get_luaentity()
			if not object:is_player() and luaentity and luaentity.name == "__builtin:item" and luaentity.itemstring ~= "" then
				if inv and inv:room_for_item("main", ItemStack(luaentity.itemstring)) then
					meta.charge = meta.charge - vacuum_charge_per_object
					if meta.charge < vacuum_charge_per_object then
						return
					end
					inv:add_item("main", ItemStack(luaentity.itemstring))
					minetest.sound_play("item_drop_pickup", {
						to_player = user:get_player_name(),
						gain = 0.4,
					})
					luaentity.itemstring = ""
					object:remove()
				end
			end
		end

		technic.set_RE_wear(itemstack, meta.charge, vacuum_max_charge)
		itemstack:set_metadata(minetest.serialize(meta))
		return itemstack
	end,
})

minetest.register_craft({
	output = 'technic_addons:vacuummk2',
	recipe = {
		{'basic_materials:plastic_sheet',              '', 'basic_materials:plastic_sheet'},
		{'basic_materials:plastic_sheet',              'technic:vacuum',    'basic_materials:plastic_sheet'},
		{'basic_materials:plastic_sheet', 'technic:green_energy_crystal',                 'basic_materials:plastic_sheet'},
	}
})
