
-- register bypass priv
minetest.register_privilege("news_bypass", {
	description = "Skip the news.", give_to_singleplayer = false})

-- create formspec from text file
local function get_formspec()
	local news_file = io.open(minetest.get_worldpath().."/news.txt", "r")
	local news_fs = 'size[12,8.25]'..
		"button_exit[-0.05,7.8;2,1;exit;Close]"
	if news_file then
		local news = news_file:read("*a")
		news_file:close()
		news_fs = news_fs.."textarea[0.25,0;12.1,9;;Server Information;"..minetest.formspec_escape(news).."]"
	else
		news_fs = news_fs.."textarea[0.25,0;12.1,9;;Server Information;No current news.]"
	end
	return news_fs
end

-- show news formspec on player join, unless player has bypass priv
minetest.register_on_joinplayer(function (player)
	local name = player:get_player_name()
	if minetest.get_player_privs(name).news_bypass then
		return
	else
		minetest.show_formspec(name, "news", get_formspec())
	end
end)

-- command to display server news at any time
minetest.register_chatcommand("news", {
	description = "Shows server news to the player",
	func = function (name)
		local player = minetest.get_player_by_name(name)
		minetest.show_formspec(name, "news", get_formspec())	
	end
})
