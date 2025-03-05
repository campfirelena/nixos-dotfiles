require("awful")
require("wibox")
require("gears")

clickable_widget = wibox.widget {
    {
        {
            id = "maintext",
            text = "text",
            widget = wibox.widget.textbox,
        },
        widget = wibox.container.background,
        bg = "#000000",
    },
    layout = wibox.layout.fixed.horizontal,
}

local set_popup = function(parent, first, second)
    local popup = awful.popup {
        widget = {
            {
                {
                    id = "secondtext",
                    text = first,
                    widget = textbox,
                },
                second,
                widget = wibox.container.margin
                margins = 10,
            },
        },
        placement = {},
        ontop = true,
        visible = false,
        parent = parent,
    }
    return popup
end

local content_widget = wibox.widget {
    {
        id = "content",
        text = "content",
        widget = wibox.widget.textbox
    },
    layout = wibox.layout.fixed.horizontal,
}

popup_widget = set_popup(clickable_widget, "titletext", content_widget)

clickable_widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        awful.placement.next-to(popup_widget, {
            preferred_positions = { "bottom" },
            preferred_anchors = { "back" },
        })
    )
))