local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
require("widgets.mainmenu")

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

launcherboxed = wibox.widget {
  {
    {
      {
        widget = mylauncher
      },
      bg = "#000000",
      shape = gears.shape.rounded_rect,
      widget = wibox.container.background,
    },
    width = 10,
    height = 10,
    strategy = "min",
    layout = wibox.layout.constraint
  },
  top = 2,
  bottom = 2,
  left = 2,
  right = 2,
  layout = wibox.container.margin
}
