local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

spacer = function(width)
  spacer_widget = wibox.widget {
    {
      widget = wibox.widget.separator,
      opacity = 0,
      forced_width = width,
    },
    layout = wibox.layout.fixed.horizontal,
  }
  return spacer_widget
end
return spacer
