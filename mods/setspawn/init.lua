
unified_inventory.register_button("setspawn", {
   type      = "image",
   image     = "beds_bed_fancy.png",
   tooltip   = "Set Respawn Point",
   action    = function(player)
                  if player then
                    local name = player:get_player_name()
                    local where = player:get_pos()
                    if name and where then
                       beds.spawn[name] = where
                       beds.save_spawns()
                       minetest.chat_send_player(name, "Respawn point set.")
                    end
                  end
               end,
   condition = function(player)
                 return minetest.check_player_privs(player:get_player_name(), {home=true})
               end,
   hide_lite = true
   -- ^ Button is hidden when following two conditions are met:
   --   Configuration line 'unified_inventory_lite = true'
   --   Player does not have the privilege 'ui_full'
  })
