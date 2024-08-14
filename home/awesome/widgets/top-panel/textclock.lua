local wibox = require("wibox")
local gears = require ("gears")

-- Create a textclock widget
mytextclock = wibox.widget {
  {
    widget = wibox.widget.textclock()
  },
  bg = "#000000",
  shape = gears.shape.rounded_rect,
  widget = wibox.container.background
}
