limit = {}

limit.path = minetest.get_modpath("inventory_plus")
limit.ipath = minetest.get_modpath("sfinv")
limit.thispath = minetest.get_modpath("limit")

local limit_path = minetest.get_modpath("inventory_plus")
local limit_ipath = minetest.get_modpath("sfinv")
local limit_thispath = minetest.get_modpath("limit")

dofile(limit.thispath .. "/commands.lua")

----Commands and privs
minetest.register_privilege("limit", "Limiting player interaction with world.")
----end

if limit_path then
dofile(limit.thispath .. "/unifined.lua")
end

if not limit_path and limit_ipath then
dofile(limit.thispath .. "/limit_gui.lua")
end
