local modpath = minetest.get_modpath("paneling")

local paneling_list = {
  {"ea",       "Early American", "default:wood", "moretrees:oak_planks", "default:wood" },
  {"white",    "White",          "default:aspen_wood", "df_trees:tower_cap_wood", "df_trees:spore_tree_wood" },
  {"dark",     "Dark",           "default:jungle_wood", "ebony:wood", "default:jungle_wood" },
  {"red",      "Red",            "default:acacia_wood", "moretrees:sequoia_planks", "cherrytree:wood" },
  {"sunshine", "Sunshine",       "moretrees:yellow_planks", "moretrees:galion_planks", "moretrees:crimson_planks" },
  {"tyedye",   "Tye-Dye",        "moretrees:azure_planks", "moretrees:springgreen_planks", "moretrees:magenta_planks" },
  {"purple",   "Purple",         "moretrees:date_palm_planks", "moretrees:hotpink_planks", "moretrees:blueberry_planks" },
}

for i in ipairs(paneling_list) do
  local panelid   = paneling_list[i][1]
  local panelname = paneling_list[i][2]
  local woodone   = paneling_list[i][3]
  local woodtwo   = paneling_list[i][4]
  local woodthree = paneling_list[i][5]
  minetest.register_node("paneling:" .. panelid, {
      description = panelname .. " Paneling",
      drawtype = "nodebox",
      walkable = true,
      paramtype = "light",
      paramtype2 = "facedir",
      tiles = { "paneling_" .. panelid .. ".png", },
      inventory_image = "paneling_" .. panelid .. ".png",
      node_box = {
          type = "fixed",
          fixed = {-0.5, -0.5, 0.48, 0.5, 0.5, 0.5}
      },
      is_ground_content = false,
      groups = {snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
      sounds = default.node_sound_wood_defaults(),
      on_place = minetest.rotate_nodem
  })
  minetest.register_craft({
      output = "paneling:" .. panelid .. " 48",
      recipe = {
        { woodone, woodtwo, woodthree },
      }
  })
end
