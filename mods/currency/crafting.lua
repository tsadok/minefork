
if minetest.get_modpath("default") then
  local dosafe   = minetest.setting_get("currency.dosafe")
  local dobarter = minetest.setting_get("currency.dobarter")
  local doshop   = minetest.setting_get("currency.doshop")
  if dosafe then
	minetest.register_craft({
		output = "currency:safe",
		recipe = {
			{"default:steel_ingot", "default:steel_ingot",
				"default:steel_ingot"},
			{"default:steel_ingot", "default:mese_crystal",
				"default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot",
				"default:steel_ingot"},
		}
	})
  end
--   if doshop then
-- 	minetest.register_craft({
-- 		output = "currency:shop",
-- 		recipe = {
-- 			{"default:sign_wall"},
-- 			{"default:chest_locked"},
-- 		}
-- 	})
--   end
--   if dobarter then
-- 	minetest.register_craft({
-- 		output = "currency:barter",
-- 		recipe = {
-- 			{"default:sign_wall"},
-- 			{"default:chest"},
-- 		}
-- 	})
--   end
end

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_5",
	recipe = {
		"currency:minegeld",
		"currency:minegeld",
		"currency:minegeld",
		"currency:minegeld",
		"currency:minegeld"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld 5",
	recipe = {"currency:minegeld_5"},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_20",
	recipe = {
		"currency:minegeld_5",
		"currency:minegeld_5",
		"currency:minegeld_5",
		"currency:minegeld_5"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_5 4",
	recipe = {"currency:minegeld_20"},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_100",
	recipe = {
		"currency:minegeld_20",
		"currency:minegeld_20",
		"currency:minegeld_20",
		"currency:minegeld_20",
		"currency:minegeld_20"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_20 5",
	recipe = {"currency:minegeld_100" },
})

