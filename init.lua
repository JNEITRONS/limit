limit = {}

limit.path = minetest.get_modpath("inventory_plus")
limit.ipath = minetest.get_modpath("sfinv")
limit.thispath = minetest.get_modpath("limit")

local limit_path = minetest.get_modpath("inventory_plus")
local limit_ipath = minetest.get_modpath("sfinv")
local limit_thispath = minetest.get_modpath("limit")
local version = "0.5"

minetest.register_privilege("limit", "Limiting player interaction with world.")

if limit_path then
dofile(limit.thispath .. "/unifined.lua")
end

if not limit_path and limit_ipath then
dofile(limit.thispath .. "/limit_gui.lua")
end
print ("[MOD] Limit_Gui["..version.."] loaded!")
