--CaveRealms crafting.lua

--CRAFT ITEMS--

--mycena powder
minetest.register_craftitem("caverealms:mycena_powder", {
	description = "Mycena Powder",
	inventory_image = "caverealms_mycena_powder.png",
})

--CRAFT RECIPES--

--mycena powder
minetest.register_craft({
	output = "caverealms:mycena_powder",
	type = "shapeless",
	recipe = {"caverealms:mycena"}
})


--glow mese block
minetest.register_craft({
	output = "caverealms:glow_mese",
	recipe = {
		{"default:mese_crystal_fragment","default:mese_crystal_fragment","default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment","caverealms:mycena_powder","default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment","default:mese_crystal_fragment","default:mese_crystal_fragment"}
	}
})

--reverse craft for glow mese
minetest.register_craft({
	output = "default:mese_crystal_fragment 8",
	type = "shapeless",
	recipe = {"caverealms:glow_mese"}
})

--thin ice to water
minetest.register_craft({
	output = "default:water_source",
	type = "shapeless",
	recipe = {"caverealms:thin_ice"}
})

--use for coal dust
minetest.register_craft({
	output = "default:coalblock",
	recipe = {
		{"caverealms:coal_dust","caverealms:coal_dust","caverealms:coal_dust"},
		{"caverealms:coal_dust","caverealms:coal_dust","caverealms:coal_dust"},
		{"caverealms:coal_dust","caverealms:coal_dust","caverealms:coal_dust"}
	}
})

minetest.register_craft({
    output = "caverealms:salt_crystal",
    recipe = {
        {"group:salt_gem","group:salt_gem","group:salt_gem"},
        {"group:salt_gem","group:salt_gem","group:salt_gem"},
        {"group:salt_gem","group:salt_gem","group:salt_gem"}
    }
})

minetest.register_craft({
    output = "caverealms:salt_gem 9",
    recipe = {
         {"caverealms:salt_crystal"}
    }
})

minetest.register_craft({
    output = "caverealms:salt_gem",
    recipe = {
        {"caverealms:salt_gem_5"},
    }
})
minetest.register_craft({
    output = "caverealms:salt_gem_5",
    recipe = {
        {"caverealms:salt_gem_4"},
    }
})
minetest.register_craft({
    output = "caverealms:salt_gem_4",
    recipe = {
        {"caverealms:salt_gem_3"},
    }
})
minetest.register_craft({
    output = "caverealms:salt_gem_3",
    recipe = {
        {"caverealms:salt_gem_2"},
    }
})
minetest.register_craft({
    output = "caverealms:salt_gem_2",
    recipe = {
        {"caverealms:salt_gem"},
    }
})
