limit = {}

limit.path = minetest.get_modpath("inventory_plus")
limit.ipath = minetest.get_modpath("sfinv")
limit.thispath = minetest.get_modpath("limit")

local limit_path = minetest.get_modpath("inventory_plus")
local limit_ipath = minetest.get_modpath("sfinv")
local limit_thispath = minetest.get_modpath("limit")

----Commands and privs
minetest.register_privilege("limit", "Limiting player interaction with world.")

minetest.register_chatcommand("limit", {
	params = "<name>",
	description = "Limiting player",
	privs = {limit=true},
	func = function(name, param)
	local player = minetest.get_player_by_name(param)
        if player then
        local privs = minetest.get_player_privs(param)
 
	minetest.set_player_privs(param, {})
		return true, param.." limited."
end
        if not param or param == "" then
		return false, "No such player."
        end
	end,
})
----end

if limit_path then
dofile(limit.thispath .. "/unifined.lua")
end

if not limit_path and limit_ipath then
dofile(limit.thispath .. "/limit_gui.lua")
end
