 minetest.register_chatcommand("limit", {
	params = "<name>",
	description = "Limiting player interaction with world",
	privs = {limit=true},
	func = function(name, param)
	local player = minetest.get_player_by_name(param)
        if minetest.get_player_privs(player).protection_bypass then
        return false, param.." is admin."
end
        if player then
	minetest.set_player_privs(param, {})
		return true, param.." limited."
end
        if not param or param == "" then
		return false, "No such player."
        end
	end,
})
