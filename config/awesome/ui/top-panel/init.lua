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
    layout = wibox.layout.flex.horizontal,
    {
      widget = wibox.container.place,
      width = 200,
      halign = "left",
      valign = "center",
      {
      layout = wibox.layout.fixed.horizontal,
      launcherboxed,
      spacer(10),
      s.mytasklist,
      spacer(10),
      s.mypromptbox,
    },
    },
    {
      widget = wibox.container.place,
      width = 200,
      halign = "center",
      valign = "center",
      {
      layout = wibox.layout.fixed.horizontal,
    s.mytaglist,
  },
},
    {
      widget = wibox.container.place,
      width = 200,
      halign = "right",
      valign = "center",
      {
      layout = wibox.layout.fixed.horizontal,
      systray,
      spacer(10),
      spotify_widget(),
      spacer(10),
      mytextclock,
    },
    },
  }


  return panel
end

return TopPanel

