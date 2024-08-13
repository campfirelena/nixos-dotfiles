local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')
local spotify_widget = require('widgets.top-panel.spotify')

configuration = require('configuration.config')
require('widgets.top-panel')

local TopPanel = function(s)

  -- Wiboxes are much more flexible than wibars simply for the fact that there are no defaults, however if you'd rather have the ease of a wibar you can replace this with the original wibar code
  local panel =
  wibox({
    ontop = true,
    screen = s,
    height = configuration.toppanel_height,
    width = s.geometry.width,
    x = s.geometry.x,
    y = s.geometry.y,
    stretch = false,
    bg = beautiful.transparent,
    fg = beautiful.fg_normal,
    struts = {
      top = configuration.toppanel_height
    },
    type = "dock",
  })

  panel:struts({
    top = configuration.toppanel_height
  })

  panel:setup {
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,
      launcherboxed,
      s.mytasklist,
      s.mypromptbox,
    },
    s.mytaglist,
    {
      layout = wibox.layout.fixed.horizontal,
      systray,
      spotify_widget(),
      mytextclock,
    },
  }


  return panel
end

return TopPanel

