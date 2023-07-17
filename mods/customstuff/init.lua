
-- This is all server-specific.

function bestow_items(player)
   minetest.log("action", "Bestowing items upon " .. player:get_player_name())
   --local inv = player:get_inventory()
   local fibrenum = math.random(1,60)
   local dyenum   = math.random(1,8)
   local foodnum  = math.random(1,5)
   local treenum  = math.random(1,12)
   local utilnum  = math.random(1,11)
   --minetest.log("action", "Item: pickaxe...")
   --give_initial_stuff.add("default:pick_stone")
   --minetest.log("action", "Item: stone axe...")
   --give_initial_stuff.add("default:axe_stone")
   if fibrenum <= 30 then
      minetest.log("action", "Item: cotton seeds")
      give_initial_stuff.add("farming:seed_cotton 5")
   elseif fibrenum <= 50 then
      minetest.log("action", "Item: hemp seeds")
      give_initial_stuff.add("farming:seed_hemp 5")
   else
      minetest.log("action", "Item: pig tail seeds")
      give_initial_stuff.add("df_farming:pig_tail_seed 5")
   end
   if dyenum <= 1 then
      -- red
      minetest.log("action", "Item: chili peppers")
      give_initial_stuff.add("farming:chili_pepper 3")
   elseif dyenum <= 2 then
      -- violet
      minetest.log("action", "Item: blueberries")
      give_initial_stuff.add("farming:blueberries 3")
   elseif dyenum <= 3 then
      -- black
      minetest.log("action", "Item: blackberries")
      give_initial_stuff.add("farming:blackberry 3")
   elseif dyenum <= 4 then
      -- yellow
      minetest.log("action", "Item: onions")
      give_initial_stuff.add("farming:onion 3")
   elseif dyenum <= 5 then
      -- brown
      minetest.log("action", "Item: coffee beans")
      give_initial_stuff.add("farming:coffee_beans 3")
   -- TODO: white
   else
      minetest.log("action", "Item: red cabbage")
      give_initial_stuff.add("farming:redcabbage 2")
   end
   if foodnum <= 1 then
      minetest.log("action", "Item: stack of apples")
      give_initial_stuff.add("default:apple 99")
   elseif foodnum <= 2 then
      minetest.log("action", "Item: pumpkin (and cutting board)")
      give_initial_stuff.add("farming:pumpkin 5")
      give_initial_stuff.add("farming:cutting_board")
   elseif foodnum <= 3 then
      minetest.log("action", "Item: melon (and cutting board)")
      give_initial_stuff.add("farming:melon_8 5")
      give_initial_stuff.add("farming:cutting_board")
   elseif foodnum <= 4 then
      minetest.log("action", "Item: garlic cloves")
      give_initial_stuff.add("farming:garlic_clove 10")
   else
      minetest.log("action", "Item: cucumbers")
      give_initial_stuff.add("farming_cucumber 20")
   end
   if treenum <= 1 then
      minetest.log("action", "Item: palm saplings")
      give_initial_stuff.add("palm:sapling 25")
   elseif treenum <= 2 then
      minetest.log("action", "Item: plum saplings")
      give_initial_stuff.add("plumtree:sapling 25")
   elseif treenum <= 3 then
      minetest.log("action", "Item: acacia saplings")
      give_initial_stuff.add("default:acacia_sapling 25")
   elseif treenum <= 4 then
      minetest.log("action", "Item: aspen saplings")
      give_initial_stuff.add("default:aspen_sapling 25")
   elseif treenum <= 5 then
      minetest.log("action", "Item: birch saplings")
      give_initial_stuff.add("birch:sapling 25")
   elseif treenum <= 6 then
      minetest.log("action", "Item: willow saplings")
      give_initial_stuff.add("willow:sapling 25")
   elseif treenum <= 7 then
      minetest.log("action", "Item: maple saplings")
      give_initial_stuff.add("maple:sapling 25")
   elseif treenum <= 8 then
      minetest.log("action", "Item: cherry saplings")
      give_initial_stuff.add("cherrytree:sapling 25")
   elseif treenum <= 9 then
      minetest.log("action", "Item: mahogany saplings")
      give_initial_stuff.add("mahogany:sapling 25")
   else
      minetest.log("action", "Item: pine saplings")
      give_initial_stuff.add("default:pine_sapling 25")
   end
   if utilnum <= 4 then
      minetest.log("action", "Item: mapping kit")
      give_initial_stuff.add("map:mapping_kit")
   elseif utilnum <= 8 then
      minetest.log("action", "Item: water buckets")
      give_initial_stuff.add("bucket:bucket_water")
      give_initial_stuff.add("bucket:bucket_water")
   else
      minetest.log("action", "Item: binoculars")
      give_initial_stuff.add("binoculars:binoculars")
   end
   minetest.log("action", "Bestowing all those items on the new player.")
   give_initial_stuff.give(player)
end


minetest.register_on_newplayer(bestow_items)
