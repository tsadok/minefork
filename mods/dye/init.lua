-- dye/init.lua

dye = {}

-- Load support for MT game translation.
local S = minetest.get_translator("dye")

-- Make dye names and descriptions available globally

dye.dyes = {
	{"white",        "White",         { r = 255, g = 255, b = 255 },  },
	{"grey",         "Grey",          { r = 127, g = 127, b = 127 },  },
	{"dark_grey",    "Dark Grey",     { r =  63, g =  63, b =  63 },  },
	{"black",        "Black",         { r =  16, g =  16, b =  16 },  },
	{"brown",        "Brown",         { r =  90, g =  45, b =   0 },  },
    {"tan",          "Tan",           { r = 114, g =  67, b =   0 },  },
	{"red",          "Red",           { r = 171, g =  17, b =  17 },  },
	{"orange",       "Orange",        { r = 209, g =  76, b =  19 },  },
	{"yellow",       "Yellow",        { r = 253, g = 228, b =  14 },  },
    {"spring_green", "Spring Green",  { r = 196, g = 246, b =  59 },  },
	{"green",        "Green",         { r =  93, g = 217, b =  28 },  },
	{"dark_green",   "Dark Green",    { r =  35, g = 107, b =   0 },  },
	{"cyan",         "Cyan",          { r =   0, g = 133, b = 141 },  },
	{"blue",         "Blue",          { r =   0, g =  70, b = 188 },  },
    {"navy",         "Navy Blue",     { r =   0, g =  15, b =  84 },  },
    {"indigo",       "Indigo",        { r =  56, g =   0, b = 140 },  },
	{"violet",       "Violet",        { r =  67, g =   4, b = 119 },  },
	{"magenta",      "Magenta",       { r = 199, g =   2, b = 108 },  },
	{"pink",         "Pink",          { r = 255, g = 147, b = 147 },  },
}

-- Define items

for _, row in ipairs(dye.dyes) do
	local name = row[1]
	local description = row[2]
	local groups = {dye = 1}
	groups["color_" .. name] = 1

	minetest.register_craftitem("dye:" .. name, {
		inventory_image = "dye_" .. name .. ".png",
		description = S(description .. " Dye"),
		groups = groups
	})

	minetest.register_craft({
		output = "dye:" .. name .. " 4",
		recipe = {
			{"group:flower,color_" .. name}
		},
	})
end

-- Manually add coal -> black dye

minetest.register_craft({
	output = "dye:black 4",
	recipe = {
		{"group:coal"}
	},
})

-- Manually add blueberries->violet dye, and similar

minetest.register_craft({
	output = "dye:violet 2",
	recipe = {
		{"default:blueberries"}
	},
})
minetest.register_craft({
	output = "dye:violet 2",
	recipe = {
		{"group:food_blueberry"}
	},
})
minetest.register_craft({
	output = "dye:blue 2",
	recipe = {
		{"group:makes_blue_dye"}
	},
})
minetest.register_craft({
	output = "dye:red 2",
	recipe = {
		{"group:food_raspberries"}
	},
})
minetest.register_craft({
	output = "dye:black 2",
	recipe = {
		{"group:food_blackberry"}
	},
})
minetest.register_craft({
	output = "dye:yellow 2",
	recipe = {
		{"group:food_onion"}
	},
})


-- Mix recipes

local dye_recipes = {
	-- src1, src2, dst
	-- RYB mixes
	{"red", "blue", "violet"}, -- "purple"
	{"yellow", "red", "orange"},
	{"yellow", "blue", "green"},
	-- RYB complementary mixes
	{"yellow", "violet", "dark_grey"},
	{"blue", "orange", "dark_grey"},
	-- CMY mixes - approximation
	{"cyan", "yellow", "green"},
	{"cyan", "magenta", "blue"},
	{"yellow", "magenta", "red"},
	-- other mixes that result in a color we have
	{"red", "green", "brown"},
	{"magenta", "blue", "violet"},
    {"violet", "blue", "indigo"},
	{"green", "blue", "cyan"},
	{"pink", "violet", "magenta"},
    {"yellow", "brown", "tan"},
	-- mixes with black
	{"white", "black", "grey"},
	{"grey", "black", "dark_grey"},
	{"green", "black", "dark_green"},
	{"orange", "black", "brown"},
    {"blue", "black", "navy"},
	-- mixes with white
	{"white", "red", "pink"},
	{"white", "dark_grey", "grey"},
	{"white", "dark_green", "green"},
}

for _, mix in pairs(dye_recipes) do
	minetest.register_craft({
		type = "shapeless",
		output = "dye:" .. mix[3] .. " 2",
		recipe = {"dye:" .. mix[1], "dye:" .. mix[2]},
	})
end

minetest.register_craft({
	type = "shapeless",
	output = "dye:spring_green 3",
	recipe = {"dye:yellow", "dye:yellow", "dye:green"},
})


-- Dummy calls to S() to allow translation scripts to detect the strings.
-- To update this run:
-- for _,e in ipairs(dye.dyes) do print(("S(%q)"):format(e[2].." Dye")) end

--[[
S("White Dye")
S("Grey Dye")
S("Dark Grey Dye")
S("Black Dye")
S("Violet Dye")
S("Indigo Dye")
S("Navy Blue Dye")
S("Blue Dye")
S("Cyan Dye")
S("Dark Green Dye")
S("Green Dye")
S("Spring Green Dye")
S("Yellow Dye")
S("Brown Dye")
S("Orange Dye")
S("Red Dye")
S("Magenta Dye")
S("Pink Dye")
S("Tan Dye")
--]]
