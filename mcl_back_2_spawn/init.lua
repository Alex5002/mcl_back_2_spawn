S = minetest.get_translator('mcl_back_2_spawn')

minetest.register_chatcommand("back_2_spawn", {
	description = "Go back to your personnal spawn point, or, if a player name is given, apply this command to him (requires \'server\' and \'tp\' privileges).",
	params = '[<player>]',
	privs = {},
	func = function(name,param)
		if ( param == name ) or ( param == '' ) then
			local targetplayer = minetest.get_player_by_name(name)
			local targetpos, is_in_bed = mcl_spawn.get_player_spawn_pos( targetplayer )
			targetplayer:set_pos(targetpos)
			minetest.chat_send_player(name, S('You have teleported yourself to your spawn point.'))
		elseif ( minetest.get_player_by_name(param) ) then
			if ( minetest.check_player_privs( name , { server = true , tp = true } ) ) then
				local targetplayer = minetest.get_player_by_name(param)
				local targetpos, is_in_bed = mcl_spawn.get_player_spawn_pos( targetplayer )
				targetplayer:set_pos(targetpos)
				minetest.chat_send_player(param, S('You have been teleported to your spawn point by ') .. name .. S('!'))
				minetest.chat_send_player(name, S('You have teleported ') .. param .. S(' to his spawn point!'))
			else
				minetest.chat_send_player(name, S('You need the \'server\' and \'tp\' privileges to run the command on someone else than you!'))
				end
		else
			minetest.chat_send_player(name, S('The given player is not online.'))
		end
	end
})