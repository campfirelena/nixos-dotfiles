local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

systray = wibox.widget {
  {
    {
      id = "text1",
      text = "  V  ",
      widget = wibox.widget.textbox,
    },
    widget = wibox.container.background,
    bg = "#000000",
    shape_border_color = "#999999",
    shape_border_width = 2,
    width = 10,
    height = 10,
    shape = gears.shape.rounded_rect,
  },
  layout = wibox.layout.fixed.horizontal,
}

local function make_popup()
  my_systray = wibox.widget.systray()
  my_systray.base_size = 25
  local popup = awful.popup {
    widget = {
      {
        {
            widget = my_systray,
            opacity = 1,
            visible = true,
        },
        layout = wibox.layout.fixed.vertical,
      },
      top = 4,
      bottom = 4,
      left = 4,
      right = 4,
      widget = wibox.container.margin,
    },
    parent = systray,
    ontop = true,
    visible = false,
    placement = {},
    border_color = "#111111",
    border_width = 2,
    shape = gears.shape.rounded_bar,
    width = 250,
    height = 50,
  }
  return popup
end

systray:connect_signal("mouse::enter", function()
  my_systray.set_screen(awful.screen.focused())
  --naughty.notify({ text = tostring(awful.screen.focused())})
end)

local systray_popup = make_popup()

systray:buttons(awful.util.table.join(
awful.button({}, 1, function()
  systray_popup.visible = not systray_popup.visible
  awful.placement.next_to(systray_popup,
  {
    preferred_positions = { "bottom" },
    preferred_anchors = { "back" },
    geometry = bottom,
  }
  )
end))
)

