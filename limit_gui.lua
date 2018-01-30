minetest.register_privilege("limit", "Limiting player interaction with world.")

sfinv.register_page("limit:limit_gui", {
    title = "Limit Gui",
    get = function(self, player, context)
        local players = {}
        context.limit_players = players

        -- Using an array to build a formspec is considerably faster
        local formspec = {
            "textlist[0.1,0.1;7.8,2;playerlist;"
        }

        -- Add all players to the text list, and to the players list
        local is_first = true
        for _ , player in pairs(minetest.get_connected_players()) do
            local player_name = player:get_player_name()
            players[#players + 1] = player_name
            if not is_first then
                formspec[#formspec + 1] = ","
            end
            formspec[#formspec + 1] = minetest.formspec_escape(player_name)
            is_first = false
        end
        formspec[#formspec + 1] = "]"

        -- Add buttons
        formspec[#formspec + 1] = "field[0.4,2.7;8,1;reason;Reason;]"
        formspec[#formspec + 1] = "button[0.1,3.3;2,1;kick;Kick]"
        formspec[#formspec + 1] = "button[2.1,3.3;2,1;ban;Ban]"
        formspec[#formspec + 1] = "button[4.1,3.3;2,1;limit;Limit]"
        formspec[#formspec + 1] = "button[6.1,3.3;2,1;lkick;Kick Limit]"

        -- Wrap the formspec in sfinv's layout (ie: adds the tabs and background)
        return sfinv.make_formspec(player, context,
                table.concat(formspec, ""), true)
    end,
on_player_receive_fields = function(self, player, context, fields)
    -- text list event,  check event type and set index if selection changed
    local reason = tostring(fields.reason)
    if fields.kick and reason == "" or fields.jail and reason == "" then
    reason = "Kicked by staff."
end
    if fields.ban and reason == "" then
    reason = "Banned by staff."
end
    if fields.limit and reason == "" then
    reason = "Limited by staff."  
end
    if fields.jail then
    reason = "Jailed by staff."
end
    if fields.playerlist then
        local event = minetest.explode_textlist_event(fields.playerlist)
        if event.type == "CHG" then
            context.limit_selected_idx = event.index
        end

    -- Kick button was pressed
    elseif fields.kick then
        local player_name = context.limit_players[context.limit_selected_idx]
        local privs = minetest.get_player_privs(player:get_player_name()).kick
        if privs and player_name then
            minetest.chat_send_player(player:get_player_name(),
                    "Kicked " .. player_name)
            minetest.kick_player(player_name, reason)
        end
    elseif fields.limit then
        local privs = minetest.get_player_privs(player:get_player_name()).limit
        local player_name = context.limit_players[context.limit_selected_idx]
        if privs and player_name then
            minetest.chat_send_player(player_name,
                    player:get_player_name().." limit " .. player_name .. " for: " .. reason)
            minetest.chat_send_player(player:get_player_name(), player_name.." limited.")
            minetest.set_player_privs(player_name, {})
        end
    elseif fields.lkick then
        local privs = minetest.get_player_privs(player:get_player_name()).limit
        local privs_k = minetest.get_player_privs(player:get_player_name()).kick
        local player_name = context.limit_players[context.limit_selected_idx]
        local statjail = (minetest.setting_get_pos("staticjail") or {x = 0, y = -1, z = 0})
        if privs and privs_k and player_name then
        minetest.kick_player(player_name, reason)
        minetest.set_player_privs(player_name, {})
        minetest.chat_send_player(player:get_player_name(), player_name.." limited.")
        end
    -- Ban button was pressed
    elseif fields.ban then
        local privs = minetest.get_player_privs(player:get_player_name()).ban
        local player_name = context.limit_players[context.limit_selected_idx]
        if privs and player_name then
            minetest.chat_send_player(player:get_player_name(),
                    "Banned " .. player_name)
            minetest.ban_player(player_name, reason)
        end
end
end,
})
