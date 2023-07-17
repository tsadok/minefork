
local original_get_node_drops = minetest.get_node_drops
local original_handle_node_drops = minetest.handle_node_drops

function minetest.get_node_drops(node, toolname)
   local nodename = node
   local param2   = 0
   if (type(node) == "table") then
      nodename = node.name
      param2 = node.param2
   end
   --minetest.log("action", "tool_materials: get_node_drops(" .. nodename .. ", " .. toolname .. ")")
   if minetest.get_item_group(toolname, "shovel") > 0 then
      if minetest.get_item_group(nodename, "crumbly") == 0 then
          --minetest.log("action", "tool_materials: digging non-crumbly block with a shovel: vanilla behavior")
          return original_get_node_drops(node, toolname)
      end
   elseif minetest.get_item_group(toolname, "pickaxe") > 0 then
      if minetest.get_item_group(nodename, "cracky") == 0 then
          --minetest.log("action", "tool_materials: digging non-cracky block with a pick: vanilla behavior")
          return original_get_node_drops(node, toolname)
      end
   elseif minetest.get_item_group(toolname, "axe") > 0 then
      if minetest.get_item_group(nodename, "choppy") == 0 then
          --minetest.log("action", "tool_materials: digging non-choppy block with an axe: vanilla behavior")
          return original_get_node_drops(node, toolname)
      end
   else
      if ((minetest.get_item_group(nodename, "snappy") == 0) and
          (minetest.get_item_group(nodename, "explody") == 0) and
          (minetest.get_item_group(nodename, "oddly_breakable_by_hand") == 0)) then
          --minetest.log("action", "tool_materials: digging non-snappy, non-explody, non-hand-breakable block with unknown tool: vanilla behavior")
          return original_get_node_drops(node, toolname)
      end
   end
   local alatro = (minetest.get_item_group(toolname, "alatrotool") > 0)
   local midas  = (minetest.get_item_group(toolname, "goldtool") > 0)
   --minetest.log("action", "tool_materials: get_node_drops(" .. nodename .. ", " .. toolname .. "): alatro " .. (alatro and "YES" or "no") .. "; midas " .. (midas and "YES" or "no"))
   if (alatro or midas) then
      local nodedef = minetest.registered_nodes[nodename]
      local ptype = nodedef and nodedef.paramtype2
      local palette_index = minetest.strip_param2_color(param2, ptype)
      local dropinfo = nodedef and nodedef.drop
      if (midas and dropinfo and (type(dropinfo) == "string")) then
        -- Try to make the midas touch work on ores that just always drop a lump;
        -- we want them to now drop potentially multiple lumps.
        local cnt = 1
        -- Does this particular ore normally break down into multiple lumps or whatever?
        local pos
        local len
        local di
        local num
        pos, len, di, num = string.find(dropinfo, "(.*)%s+(%d)%s*$")
        if not (pos == nil) then
           cnt = num
           dropinfo = di
        end
        cnt = cnt + math.random(4)
        -- Now we know what we want, we just have to figure out how to return it:
        -- table expected, got string: return dropinfo .. " " .. cnt
        return {dropinfo .. " " .. cnt}
      elseif ((dropinfo == nil) or (type(dropinfo) == "string") or
          (dropinfo.items == nil)) then
         return original_get_node_drops(node, toolname)
      elseif alatro then
        -- Alatro tools subvert rarity by treating it as frequency.
        -- The more rare a drop is supposed to be, the more likely
        -- it is an alatro tool will give it to you.  So e.g. if
        -- gravel normally drops flint one out of sixteen times and
        -- just drops gravel otherwise, then with an alatro shovel,
        -- you'll get the flint sixteen out of seventeen times.
        -- It gets slightly more complex if there are more than
        -- two options, but the idea is the same.
        local idx = 0
        local result = {}
        local candidate = {}
        local candcount = 0
        for _, optn in ipairs(dropinfo.items) do
            idx = idx + 1
            local max = (optn.max_items or #(optn.items))
            for _, thing in ipairs(optn.items) do
               local stack = ItemStack(thing)
               if optn.inherit_color and palette_index then
                  stack:get_meta():set_int("palette_index", palette_index)
               end
               thing = stack:to_string()
               local cnt = (optn.rarity or 1)
               for i=1,cnt do
                  candidate[1 + #candidate] = thing
                  candcount = candcount + 1
               end
            end
        end
        local chosen = math.random(1,candcount)
        --minetest.log("action", "Alatro tool selects option " .. chosen .. " (" .. candidate[chosen] .. ")"  .. " out of " .. candcount .. ".")
        result[1 + #result] = candidate[chosen]
        return result
      elseif midas then
        -- Using a gold tool multiplies drops when you get them,
        -- so for example you get more than one lump of iron
        -- when mining iron ore with a gold pick.  This is
        -- limited by the max stack size.  Rarity works as usual.
        -- Adapted from core.get_node_drops() in builtin/game/item.lua
        -- But we already know we're using the right tool type.
        local got_count = 0
        local got_items = {}
        for _, item in ipairs(dropinfo.items) do
            local good_rarity = true
            if item.rarity ~= nil then
               good_rarity = (item.rarity < 1 or
                              (math.random(item.rarity) == 1))
            end
            if good_rarity then
               got_count = got_count + 1
               for _, add_item in ipairs(item.items) do
                 local stack = ItemStack(add_item)
                 -- add color if necessary
                 if item.inherit_color and palette_index then
                    stack:get_meta():set_int("palette_index", palette_index)
                 end
                 local nam = stack:get_name()
                 if ((nam ~= "default:cobble") and
                     (nam ~= "default:desert_cobble") and
                     (minetest.get_item_group(nam, "nomidas") == 0) and
                     (minetest.get_item_group(nam, "glooptest_gem") == 0)) then
                    local multiplier = math.random(2,4)
                    stack:set_count(multiplier * stack:get_count())
                    if (stack:get_count() > stack:get_stack_max()) then
                       stack:set_count(stack:get_stack_max())
                    end
                    got_items[1 + #got_items] = stack:to_string()
                 end
               end
            end
        end
        if (#got_items > 0) then
           return got_items
        end
      end
   end
   return original_get_node_drops(node, toolname)
end

function minetest.handle_node_drops(pos, drops, digger)
   local toolname = digger:get_wielded_item():get_name();
   local nodename = minetest.get_node(pos).name
   if minetest.get_item_group(toolname, "shovel") > 0 then
      if minetest.get_item_group(nodename, "crumbly") == 0 then
          return original_handle_node_drops(pos, drops, digger)
      end
   elseif minetest.get_item_group(toolname, "pickaxe") > 0 then
      if minetest.get_item_group(nodename, "cracky") == 0 then
          return original_handle_node_drops(pos, drops, digger)
      end
   elseif minetest.get_item_group(toolname, "axe") > 0 then
      if minetest.get_item_group(nodename, "choppy") == 0 then
          return original_handle_node_drops(pos, drops, digger)
      end
   else
      if ((minetest.get_item_group(nodename, "snappy") == 0) and
          (minetest.get_item_group(nodename, "explody") == 0) and
          (minetest.get_item_group(nodename, "oddly_breakable_by_hand") == 0)) then
          return original_handle_node_drops(pos, drops, digger)
      end
   end
   if minetest.get_item_group(toolname, "mesetool") > 0 then
      -- Mese tools extract and return the node itself, unaltered.
      return original_handle_node_drops(pos, {ItemStack(nodename)}, digger)
   end
   -- Other tool materials can be handled here, if handle_node_drops is where
   -- what they do needs to happen.  But Midas touch (from gold tools) needs
   -- to happen earlier, in get_node_drops(), wherein the drops variable that
   -- is passed to handle_node_drops() is constructed.
   return original_handle_node_drops(pos, drops, digger)
end

digtron.mark_diggable_mesetouch = function(pos, nodes_dug, player)
    -- mark the node as dug, if the player provided would have been able to dig it.
    -- Don't *actually* dig the node yet, though, because if we dig a node with sand over it the sand will start falling
    -- and then destroy whatever node we place there subsequently (either by a builder head or by moving a digtron node)
    -- I don't like sand. It's coarse and rough and irritating and it gets everywhere. And it necessitates complicated dig routines.
    -- returns fuel cost and what will be dropped by digging these nodes, which in this case is the nodes themselves, because we
    -- are using mese digheads and mese is magical in this way.

    local target = minetest.get_node(pos)
    
    -- prevent digtrons from being marked for digging.
    if minetest.get_item_group(target.name, "digtron") ~= 0 or
        minetest.get_item_group(target.name, "digtron_protected") ~= 0 or
        minetest.get_item_group(target.name, "immortal") ~= 0 then
        return 0
    end

    local targetdef = minetest.registered_nodes[target.name]
    if targetdef == nil or targetdef.can_dig == nil or targetdef.can_dig(pos, player) then
        nodes_dug:set(pos.x, pos.y, pos.z, true)
        if target.name ~= "air" then
            local in_known_group = false
            local material_cost = 0
            
            if digtron.config.uses_resources then
                if minetest.get_item_group(target.name, "cracky") ~= 0 then
                    in_known_group = true
                    material_cost = math.max(material_cost, digtron.config.dig_cost_cracky)
                end
                if minetest.get_item_group(target.name, "crumbly") ~= 0 then
                    in_known_group = true
                    material_cost = math.max(material_cost, digtron.config.dig_cost_crumbly)
                end
                if minetest.get_item_group(target.name, "choppy") ~= 0 then
                    in_known_group = true
                    material_cost = math.max(material_cost, digtron.config.dig_cost_choppy)
                end
                if not in_known_group then
                    material_cost = digtron.config.dig_cost_default
                end
            end
    
            return material_cost, {target.name}
        end
    end
    return 0
end

minetest.register_tool("tool_materials:pick_gold", {
    description = "Gold Pickaxe",
    inventory_image = "tool_materials_goldpick.png",
    tool_capabilities = {
        full_punch_interval = 1.3,
        max_drop_level=0,
        groupcaps={
            cracky = {times={[2]=2.0, [3]=1.00}, uses=20, maxlevel=1},
        },
        damage_groups = {fleshy=3},
    },
    sound = {breaks = "default_tool_breaks"},
    groups = {pickaxe = 1, goldtool = 1}
})

minetest.register_tool("tool_materials:shovel_gold", {
    description = "Gold Shovel",
    inventory_image = "tool_materials_goldshovel.png",
    wield_image = "default_tool_goldshovel.png^[transformR90",
    tool_capabilities = {
        full_punch_interval = 1.4,
        max_drop_level=0,
        groupcaps={
            crumbly = {times={[1]=1.80, [2]=1.20, [3]=0.50}, uses=20, maxlevel=1},
        },
        damage_groups = {fleshy=2},
    },
    sound = {breaks = "default_tool_breaks"},
    groups = {shovel = 1, goldtool = 1}
})

minetest.register_tool("tool_materials:axe_gold", {
    description = "Gold Axe",
    inventory_image = "tool_materials_goldaxe.png",
    tool_capabilities = {
        full_punch_interval = 1.2,
        max_drop_level=0,
        groupcaps={
            choppy={times={[1]=3.00, [2]=2.00, [3]=1.30}, uses=20, maxlevel=1},
        },
        damage_groups = {fleshy=3},
    },
    sound = {breaks = "default_tool_breaks"},
    groups = {axe = 1, goldtool = 1}
})

minetest.register_craft({
   output = "tool_materials:pick_gold",
   recipe = {
      {"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
      {"", "group:stick", ""},
      {"", "group:stick", ""}
   }
})

minetest.register_craft({
   output = "tool_materials:shovel_gold",
   recipe = {
      {"default:gold_ingot"},
      {"group:stick"},
      {"group:stick"}
   }
})

minetest.register_craft({
   output = "tool_materials:axe_gold",
   recipe = {
      {"default:gold_ingot", "default:gold_ingot"},
      {"default:gold_ingot", "group:stick"},
      {"", "group:stick"}
   }
})


minetest.register_craft({
   output = "moreores:hoe_mithril",
   recipe = {
      {"moreores:mithril_ingot", "moreores:mithril_ingot"},
      { "", "group:stick" },
      { "", "group:stick" }
   }
})

if minetest.get_modpath("digtron") then
    local digger_nodebox = {
        {-0.5, -0.5, 0, 0.5, 0.5, 0.4375}, -- Block
        {-0.4375, -0.3125, 0.4375, 0.4375, 0.3125, 0.5}, -- Cutter1
        {-0.3125, -0.4375, 0.4375, 0.3125, 0.4375, 0.5}, -- Cutter2
        {-0.5, -0.125, -0.125, 0.5, 0.125, 0}, -- BackFrame1
        {-0.125, -0.5, -0.125, 0.125, 0.5, 0}, -- BackFrame2
        {-0.25, -0.25, -0.5, 0.25, 0.25, 0}, -- Drive
    }
    local dual_digger_nodebox = {
        {-0.5, -0.4375, 0, 0.5, 0.5, 0.4375}, -- Block
        {-0.4375, -0.3125, 0.4375, 0.4375, 0.3125, 0.5}, -- Cutter1
        {-0.3125, -0.4375, 0.4375, 0.3125, 0.4375, 0.5}, -- Cutter2
        {-0.5, 0, -0.125, 0.5, 0.125, 0}, -- BackFrame1
        {-0.25, 0, -0.5, 0.25, 0.25, 0}, -- Drive
        {-0.25, 0.25, -0.25, 0.25, 0.5, 0}, -- Upper_Drive
        {-0.5, -0.4375, -0.5, 0.5, 0, 0.4375}, -- Lower_Block
        {-0.3125, -0.5, -0.4375, 0.3125, -0.4375, 0.4375}, -- Lower_Cutter_1
        {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125}, -- Lower_Cutter_2
    }
    minetest.register_node("tool_materials:digtron_mesetouch_digger", {
        description = "Digtron Mesetouch Digger Head",
        _doc_items_longdesc = digtron.doc.digger_longdesc,
        _doc_items_usagehelp = digtron.doc.digger_usagehelp,
        groups = {cracky = 3,  oddly_breakable_by_hand=3, digtron = 3},
        drop = "tool_materials:digtron_mesetouch_digger",
        sounds = digtron.metal_sounds,
        paramtype = "light",
        paramtype2= "facedir",
        is_ground_content = false,
        drawtype="nodebox",
        node_box = {
            type = "fixed",
            fixed = digger_nodebox,
        },
        
        -- Aims in the +Z direction by default
        tiles = {
            "digtron_plate.png^[transformR90",
            "digtron_plate.png^[transformR270",
            "digtron_plate.png",
            "digtron_plate.png^[transformR180",
            {
                name = "digtron_digger_yb.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.0,
                },
            },
            "digtron_plate.png^digtron_motor.png",
        },
    
        -- returns fuel_cost, item_produced
        execute_dig = function(pos, protected_nodes, nodes_dug, controlling_coordinate, lateral_dig, player)
            local facing = minetest.get_node(pos).param2
            local digpos = digtron.find_new_pos(pos, facing)
    
            if protected_nodes:get(digpos.x, digpos.y, digpos.z) then
                return 0
            end
            
            return digtron.mark_diggable_mesetouch(digpos, nodes_dug, player)
        end,
        
        damage_creatures = function(player, pos, controlling_coordinate, items_dropped)
            local facing = minetest.get_node(pos).param2
            digtron.damage_creatures(player, pos, digtron.find_new_pos(pos, facing), damage_hp, items_dropped)
        end,
    })
    minetest.register_node("tool_materials:digtron_mesetouch_dual_digger", {
        description = "Digtron Dual Mesetouch Digger Head",
        _doc_items_longdesc = digtron.doc.dual_digger_longdesc,
        _doc_items_usagehelp = digtron.doc.dual_digger_usagehelp,
        groups = {cracky = 3,  oddly_breakable_by_hand=3, digtron = 3},
        drop = "tool_materials:digtron_mesetouch_dual_digger",
        sounds = digtron.metal_sounds,
        paramtype = "light",
        paramtype2= "facedir",
        is_ground_content = false,
        drawtype="nodebox",
        node_box = {
            type = "fixed",
            fixed = dual_digger_nodebox,
        },
        
        -- Aims in the +Z and -Y direction by default
        tiles = {
            "digtron_plate.png^digtron_motor.png",
            {
                name = "digtron_digger_yb.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.0,
                },
            },
            "digtron_plate.png",
            "digtron_plate.png^[transformR180",
            {
                name = "digtron_digger_yb.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.0,
                },
            },
            "digtron_plate.png^digtron_motor.png",
        },

        -- returns fuel_cost, items_produced
        execute_dig = function(pos, protected_nodes, nodes_dug, controlling_coordinate, lateral_dig, player)
            local facing = minetest.get_node(pos).param2
            local digpos = digtron.find_new_pos(pos, facing)
            local digdown = digtron.find_new_pos_downward(pos, facing)
    
            local items = {}
            local cost = 0
            
            if protected_nodes:get(digpos.x, digpos.y, digpos.z) ~= true then
                local forward_cost, forward_items = digtron.mark_diggable_mesetouch(digpos, nodes_dug, player)
                if forward_items ~= nil then
                    for _, item in pairs(forward_items) do
                        table.insert(items, item)
                    end
                end
                cost = cost + forward_cost
            end
            if protected_nodes:get(digdown.x, digdown.y, digdown.z) ~= true then
                local down_cost, down_items = digtron.mark_diggable_mesetouch(digdown, nodes_dug, player)
                if down_items ~= nil then
                    for _, item in pairs(down_items) do
                        table.insert(items, item)
                    end
                end
                cost = cost + down_cost
            end
            
            return cost, items
        end,
    
        damage_creatures = function(player, pos, controlling_coordinate, items_dropped)
            local facing = minetest.get_node(pos).param2
            digtron.damage_creatures(player, pos, digtron.find_new_pos(pos, facing), damage_hp, items_dropped)
            digtron.damage_creatures(player, pos, digtron.find_new_pos_downward(pos, facing), damage_hp, items_dropped)
        end,
    })


    minetest.register_craft({
        output = "tool_materials:digtron_mesetouch_digger",
        recipe = {
                {"","default:mese_crystal",""},
                {"default:mese_crystal","digtron:digger","default:mese_crystal"},
                {"","default:mese_crystal",""}
        }
    })
    minetest.register_craft({
        output = "tool_materials:digtron_mesetouch_dual_digger",
        type = "shapeless",
        recipe = {"tool_materials:digtron_mesetouch_digger", "tool_materials:digtron_mesetouch_digger"},
    })
    minetest.register_craft({
        output = "tool_materials:digtron_mesetouch_digger 2",
        recipe = {
                {"tool_materials:digtron_mesetouch_dual_digger"},
        }
    })
end
