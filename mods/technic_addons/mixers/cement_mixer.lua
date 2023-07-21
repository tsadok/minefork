
-- This device takes advantage of an adjacent stream of flowing water,
-- to simplify the process of mixing materials that must be mixed wet.

local function get_water_flow(pos)
    local node = minetest.get_node(pos)
    if minetest.get_item_group(node.name, "water") == 3 and string.find(node.name, "flowing") then
        return node.param2 -- returns approx. water flow, if any
    end
    return 0
end

local trytomixmv = function(pos, node)
   return technic_addons_trytomix(pos, node, "MV", 15)
end

function technic_addons_trytomix(pos, node, tier, speed)
    local ltier             = string.lower(tier)
    local meta              = minetest.get_meta(pos)
    local inv               = meta:get_inventory()
    local water_flow        = 0
    local eu_input          = meta:get_int(tier .. "_EU_input")
    local machine_desc_tier = tier .. " Cement Mixer"
    local machine_node      = "technic_addons:" .. ltier .. "_cement_mixer"
    local machine_demand    = {3000, 2000, 1000}
    if not eu_input then
        meta:set_int(tier .. "MV_EU_demand", machine_demand[1])
        meta:set_int(tier .. "MV_EU_input", 0)
        return
    end

    local positions = {
        {x=pos.x+1, y=pos.y, z=pos.z},
        {x=pos.x-1, y=pos.y, z=pos.z},
        {x=pos.x,   y=pos.y, z=pos.z+1},
        {x=pos.x,   y=pos.y, z=pos.z-1},
    }

    for _, p in pairs(positions) do
        water_flow = water_flow + get_water_flow(p)
    end

    local EU_upgrade, tube_upgrade = 0, 0
    EU_upgrade, tube_upgrade = technic.handle_machine_upgrades(meta)
    technic.handle_machine_pipeworks(pos, tube_upgrade)
    local powered = eu_input >= machine_demand[EU_upgrade+1]
    if powered then
        meta:set_int("src_time", meta:get_int("src_time") + round(speed))
    end

    if water_flow > 0 then
        while true do
            local result = technic.get_recipe("wetmixing", inv:get_list("src"))
            if not result then
                technic.swap_node(pos, machine_node)
                meta:set_string("infotext", ("%s Idle"):format(machine_desc_tier))
                meta:set_int(tier .. "_EU_demand", 0)
                meta:set_int("src_time", 0)
                return
            end
            meta:set_int(tier.."_EU_demand", machine_demand[EU_upgrade+1])
            technic.swap_node(pos, machine_node.."_active")
            meta:set_string("infotext", ("%s Active"):format(machine_desc_tier))
            if meta:get_int("src_time") < round(result.time*10) then
                if not powered then
                    technic.swap_node(pos, machine_node)
                    meta:set_string("infotext", ("%s Unpowered"):format(machine_desc_tier))
                end
                return
            end
            local output = result.output
            if type(output) ~= "table" then output = { output } end
            local output_stacks = {}
            for _, o in ipairs(output) do
                table.insert(output_stacks, ItemStack(o))
            end
            local room_for_output = true
            inv:set_size("dst_tmp", inv:get_size("dst"))
            inv:set_list("dst_tmp", inv:get_list("dst"))
            for _, o in ipairs(output_stacks) do
                if not inv:room_for_item("dst_tmp", o) then
                    room_for_output = false
                    break
                end
                inv:add_item("dst_tmp", o)
            end
            if not room_for_output then
                technic.swap_node(pos, machine_node)
                meta:set_string("infotext", ("%s Idle"):format(machine_desc_tier))
                meta:set_int(tier.."_EU_demand", 0)
                meta:set_int("src_time", round(result.time*10))
                return
            end
            meta:set_int("src_time", meta:get_int("src_time") - round(result.time*10))
            inv:set_list("src", result.new_input)
            inv:set_list("dst", inv:get_list("dst_tmp"))
        end
    end
end

local input_size = 2 -- Not 100% certain this is needed
local tier = "MV" -- TODO: also support HV
local machine_desc   = tier .. " Cement Mixer"
local formspec =
    "size[8,9;]"..
    "list[current_name;src;"..(4-input_size)..",1;"..input_size..",1;]"..
    "list[current_name;dst;5,1;2,2;]"..
    "list[current_player;main;0,5;8,4;]"..
    "label[0,0;"..machine_desc:format(tier).."]"..
    "listring[current_name;dst]"..
    "listring[current_player;main]"..
    "listring[current_name;src]"..
    "listring[current_player;main]"..
    "list[current_name;upgrade1;1,3;1,1;]"..
    "list[current_name;upgrade2;2,3;1,1;]"..
    "label[1,4;"..("Upgrade Slots").."]"..
    "listring[current_name;upgrade1]"..
    "listring[current_player;main]"..
    "listring[current_name;upgrade2]"..
    "listring[current_player;main]"

local mixer_recipes = {
  {"default:sand",  "basic_materials:limestone_dust",  "basic_materials:wet_cement 3", 12 },
}

local data = {
   description = tier .. " Cement Mixer",
   tiles = {
       "technic_addons_mv_cement_mixer_side.png^pipeworks_tube_connection_metallic.png", -- top
       "technic_addons_mv_cement_mixer_side.png^technic_cable_connection_overlay.png^pipeworks_tube_connection_metallic.png", -- bottom
       "technic_addons_mv_cement_mixer_side.png^pipeworks_tube_connection_metallic.png", -- side
       "technic_addons_mv_cement_mixer_side.png^pipeworks_tube_connection_metallic.png", -- side
       "technic_addons_mv_cement_mixer_side.png^pipeworks_tube_connection_metallic.png", -- back
       "technic_addons_mv_cement_mixer_front.png",
    },
    paramtype2 = "facedir",
    groups = {snappy=2, choppy=2, oddly_breakable_by_hand=2,
              technic_machine=1, technic_mv=1},
    sounds = default.node_sound_wood_defaults(),
    on_construct = function(pos)
        local node = minetest.get_node(pos)
        local meta = minetest.get_meta(pos)
        local form_buttons = pipeworks.fs_helpers.cycling_button(
            meta,
            pipeworks.button_base,
            "splitstacks",
            {
                pipeworks.button_off,
                pipeworks.button_on
            }
            )..pipeworks.button_label
        meta:set_string("infotext", machine_desc:format(tier))
        meta:set_int("tube_time",  0)
        meta:set_string("formspec", formspec..form_buttons)
        local inv = meta:get_inventory()
        inv:set_size("src", input_size)
        inv:set_size("dst", 4)
        inv:set_size("upgrade1", 1)
        inv:set_size("upgrade2", 1)
    end,
    can_dig = technic.machine_can_dig,
    allow_metadata_inventory_put = technic.machine_inventory_put,
    allow_metadata_inventory_take = technic.machine_inventory_take,
    allow_metadata_inventory_move = technic.machine_inventory_move,
    technic_run = trytomixmv,
    after_place_node = pipeworks.after_place,
    after_dig_node = technic.machine_after_dig_node,
    on_receive_fields = function(pos, formname, fields, sender)
        if fields.quit then return end
        if not pipeworks.may_configure(pos, sender) then return end
        pipeworks.fs_helpers.on_receive_fields(pos, fields)
        local node = minetest.get_node(pos)
        local meta = minetest.get_meta(pos)
        local form_buttons = pipeworks.fs_helpers.cycling_button(
            meta,
            pipeworks.button_base,
            "splitstacks",
            {
                pipeworks.button_off,
                pipeworks.button_on
            }
            )..pipeworks.button_label
        meta:set_string("formspec", formspec..form_buttons)
    end,
}

minetest.register_node("technic_addons:mv_cement_mixer", data)

local activedata = {
   description = tier .. " Cement Mixer (Active)",
   tiles = {
       "technic_addons_mv_cement_mixer_side.png^pipeworks_tube_connection_metallic.png", -- top
       "technic_addons_mv_cement_mixer_side.png^technic_cable_connection_overlay.png^pipeworks_tube_connection_metallic.png", -- bottom
       "technic_addons_mv_cement_mixer_side.png^pipeworks_tube_connection_metallic.png", -- side
       "technic_addons_mv_cement_mixer_side.png^pipeworks_tube_connection_metallic.png", -- side
       "technic_addons_mv_cement_mixer_side.png^pipeworks_tube_connection_metallic.png", -- back
       "technic_addons_mv_cement_mixer_front_active.png",
    },
    paramtype2 = "facedir",
    groups = {snappy=2, choppy=2, oddly_breakable_by_hand=2,
              technic_machine=1, technic_mv=1,
              not_in_creative_inventory=1},
    sounds = default.node_sound_wood_defaults(),
    technic_run = trytomixmv,
    drop = "technic_addons:mv_cement_mixer",
    technic_disabled_machine_name = "technic_addons:mv_cement_mixer",
    allow_metadata_inventory_put = technic.machine_inventory_put,
    allow_metadata_inventory_take = technic.machine_inventory_take,
    allow_metadata_inventory_move = technic.machine_inventory_move,
    on_receive_fields = function(pos, formname, fields, sender)
    if fields.quit then return end
        if not pipeworks.may_configure(pos, sender) then return end
        pipeworks.fs_helpers.on_receive_fields(pos, fields)
        local node = minetest.get_node(pos)
        local meta = minetest.get_meta(pos)
        local form_buttons = ""
        if not string.find(node.name, ":lv_") then
            form_buttons = pipeworks.fs_helpers.cycling_button(
                meta,
                pipeworks.button_base,
                "splitstacks",
                {
                    pipeworks.button_off,
                    pipeworks.button_on
                }
            )..pipeworks.button_label
        end
        meta:set_string("formspec", formspec..form_buttons)
    end
}

minetest.register_node("technic_addons:mv_cement_mixer_active", activedata)

minetest.register_craft({
    output = 'technic_addons:mv_cement_mixer',
    recipe = {
        {'technic:stainless_steel_ingot', 'technic:water_mill', 'technic:stainless_steel_ingot'},
        {'bucket:bucket_empty', 'technic:mv_centrifuge', 'bucket:bucket_empty'},
        {'technic:stainless_steel_ingot', 'technic:mv_cable', 'technic:stainless_steel_ingot'},
    }
})

technic.register_recipe_type("wetmixing", {
    description = ("Wet Mixing"),
    input_size = 2,
})

-- -- This isn't quite right, because it's not used for things that require
-- -- water, and I think it makes some other assumptions as well.  Also it registers
-- -- the node, so I need to sort out whether to let it do that, or do it above.
-- technic_register_base_machine({
--    tier           = "MV",
--    speed          = 1.5,
--    upgrade        = 1,
--    tube           = 1,
--    demand         = {3000, 2000, 1000},
--    typename       = "wetmixing",
--    machine_name   = "cement_mixer",
--    machine_desc   = "MV Cement Mixer",
--    insert_object  = technic.insert_object_unique_stack,
--    can_insert     = technic.can_insert_unique_stack,
--    modname        = "technic_addons",
-- })
local tier           = "MV"
local typename       = "wetmixing"
local input_size     = 2
local machine_name   = "cement_mixer"
local machine_desc   = tier .. " Cement Mixer"
local ltier          = string.lower(tier)
local modname        = "technic_addons"
local groups = { cracky = 2, technic_machine = 1,
                 tubedevice = 1, tubedevice_receiver = 1,
                 ["technic_"..ltier] = 1}

local tube = technic.new_default_tube()
tube.can_insert = technic.can_insert_unique_stack
tube.insert_object = technic.insert_object_unique_stack

technic.register_machine(tier, modname .. ":" .. ltier .. "_" .. machine_name,              technic.receiver)
technic.register_machine(tier, modname .. ":" .. ltier .. "_" .. machine_name .. "_active", technic.receiver)

for _, data in pairs(mixer_recipes) do
    data.time = data.time or 6
    technic.register_recipe("wetmixing", {input={data[1], data[2]}, output=data[3], time=data[4]})
end

