local awful = require('awful')
local gears = require('gears')
-- local icons = require('theme.icons')
local apps = require('configuration.apps')

-- Configure Tag Properties
awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.suit.tile)
end)

