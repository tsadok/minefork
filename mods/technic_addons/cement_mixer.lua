
-- This device takes advantage of an adjacent stream of flowing water,
-- to simplify the process of mixing materials that must be mixed wet.

local function get_water_flow(pos)
	local node = minetest.get_node(pos)
	if minetest.get_item_group(node.name, "water") == 3 and string.find(node.name, "flowing") then
		return node.param2 -- returns approx. water flow, if any
	end
	return 0
end

local trytomix = function(pos, node)
    local meta             = minetest.get_meta(pos)
    local water_flow       = 0

    local positions = {
		{x=pos.x+1, y=pos.y, z=pos.z},
		{x=pos.x-1, y=pos.y, z=pos.z},
		{x=pos.x,   y=pos.y, z=pos.z+1},
		{x=pos.x,   y=pos.y, z=pos.z-1},
	}

	for _, p in pairs(positions) do
		water_flow = water_flow + get_water_flow(p)
	end

    if water_flow > 0 then
        -- TODO: if we've got the ingredients, do the mixing
    end
end

if minetest.get_modpath("bucket") then

    local mixer_recipes = {
      {"default:sand",  "basic_materials:limestone_dust",  "basic_materials:wet_cement 3" },
    }

    minetest.register_craft({
    	output = 'technic_addons:cement_mixer',
    	recipe = {
    		{'technic:stainless_steel_ingot', 'technic:water_mill', 'technic:stainless_steel_ingot'},
    		{'bucket:bucket_empty', 'technic:mv_centrifuge', 'bucket:bucket_empty'},
    		{'technic:stainless_steel_ingot', 'technic:mv_cable', 'technic:stainless_steel_ingot'},
    	}
    })

   minetest.register_node("technic_addons:cement_mixer", {
       description = "Cement Mixer",
       tiles = {
           "technic_addons_cement_mixer_top.png",
           "technic_addons_cement_mixer_bottom.png^technic_cable_connection_overlay.png",
           "technic_addons_cement_mixer_side.png",
           "technic_addons_cement_mixer_side.png",
           "technic_addons_cement_mixer_front.png",
           "technic_addons_cement_mixer_back.png",
       },
    paramtype2 = "facedir",
    groups = {snappy=2, choppy=2, oddly_breakable_by_hand=2,
              technic_machine=1, technic_mv=1},
    sounds = default.node_sound_wood_defaults(),
    technic_run = trytomix,
    
   })

end
