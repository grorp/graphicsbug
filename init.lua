core.register_chatcommand("gb", {
    description = "Show a downscaled texture to show artifacts caused by bilinear filtering + repeating.",
    params = "<string: variant> [<bool: apply noalpha texture modifier, default false>] [<int: texture size, default 360>]",
    func = function(name, str)
        local p = core.get_player_by_name(name)
        local winfo = core.get_player_window_information(name)

        local params = string.split(str, " ")

        if not params[1] then
            return false, "variant must be 'red', 'prang_white_transparent_bg' or 'prang_black_transparent_bg'"
        end

        local fg = "graphicsbug_fg_" .. params[1] .. ".png"
        if core.is_yes(params[2]) then
            fg = fg .. "^[noalpha"
        end

        local image_w_px = tonumber(params[3]) or 360
        local image_w_fs = winfo.max_formspec_size.x / winfo.size.x * image_w_px
        local image_h_fs = 80 / 385 * image_w_fs


        local fs = {
            "formspec_version[8]",
            ("size[%f,%f]"):format(winfo.max_formspec_size.x, winfo.max_formspec_size.y),
            "padding[0,0]",
            "bgcolor[;true]",
            ("image[%f,%f;%f,%f;graphicsbug_bg.png]"):format(
                0, 0,
                winfo.max_formspec_size.x,
                winfo.max_formspec_size.y),
            ("image[%f,%f;%f,%f;%s]"):format(
                winfo.max_formspec_size.x / 2 - image_w_fs / 2,
                winfo.max_formspec_size.y / 2 - image_h_fs / 2,
                image_w_fs, image_h_fs,
                core.formspec_escape(fg)),
        }
        core.show_formspec(name, "graphicsbug:gb", table.concat(fs, ""))
        return true, "Formspec shown."
    end,
})
