local limit = {}

minetest.register_on_joinplayer(function(player)
    local limit_can = minetest.check_player_privs(player, {limit=true})
    if limit_can then
inventory_plus.register_button(player,"limit","Limit Gui")
end
end)

-- each time a player clicks an inventory button, this is called
minetest.register_on_player_receive_fields(function(player, formname, fields)

---Local hosts
local name = tostring(fields.player_name)
local reason = tostring(fields.reason)
local privs_kick = minetest.get_player_privs(player:get_player_name()).kick
local privs_ban = minetest.get_player_privs(player:get_player_name()).ban
local pl = player:get_player_name()

-- Error Callbacks
if fields.ban_player and name == "" then
inventory_plus.set_inventory_formspec(player, limit.get_formspec_2(player))
name = "null"
end

if fields.kick_player and name == "" then
inventory_plus.set_inventory_formspec(player, limit.get_formspec_2(player))
name = "null"
end

if fields.limit_player and name == "" then
inventory_plus.set_inventory_formspec(player, limit.get_formspec_2(player))
name = "null"
end


if fields.kick_player and reason == "" then
inventory_plus.set_inventory_formspec(player, limit.get_formspec_2(player))
reason = "Kicked by staff."
end

if fields.limit_player and reason == "" then
inventory_plus.set_inventory_formspec(player, limit.get_formspec_2(player))
reason = "Limited by staff."
end

if fields.ban_player and reason == "" then 
inventory_plus.set_inventory_formspec(player, limit.get_formspec_2(player))
reason = "Banned by staff."
end

-----Immune

if fields.kick_player and minetest.get_player_privs(name).protection_bypass or fields.ban_player and minetest.get_player_privs(name).protection_bypass then
inventory_plus.set_inventory_formspec(player, limit.get_formspec_2(player))
name = "null"
end

----Callbacks
    if fields.limit then
        inventory_plus.set_inventory_formspec(player, limit.get_formspec_2(player))
end

    if privs_kick and fields.kick_player then
        inventory_plus.set_inventory_formspec(player, limit.get_formspec_2(player))
 minetest.kick_player(name, reason)
    end

    if privs_ban and fields.ban_player then
    inventory_plus.set_inventory_formspec(player, limit.get_formspec_2(player))
    minetest.ban_player(name, reason)
end

    if fields.limit_player then
    inventory_plus.set_inventory_formspec(player, limit.get_formspec_2(player))
    minetest.set_player_privs(name, {})
    minetest.chat_send_player(name, pl.." limit you for: "..reason)
end
end)
 
-----------------LIMIT GUI
limit.get_formspec_2 = function(player)
local formspec = "size[6,5]"
    .."button[0,0;2,1;main;Back]"
    .."button[2,0;2,1;craft;Craft]"
    .."field[0.5,1.8;5.5,1;player_name;Name;]"
    --.."dropdown[0.2,1.5;5.5,1;player_name;;1]"
    .."field[0.5,3;5.5,1;reason;Reason;]"
    .."button_exit[2,4;2,1;ban_player;Ban]"
    .."button_exit[4,4;2,1;kick_player;Kick]"
    .."button_exit[0,4;2,1;limit_player;Limit]"
    --.."dropdown[2.4,0.75;5.2,1;receiver;"
if minetest.get_modpath("bags") then
formspec = formspec
      .."button[4,0;2,1;bags;Bags]"
end
    return formspec
end


