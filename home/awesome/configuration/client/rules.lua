local awful = require('awful')
local gears = require('gears')
local client_keys = require('configuration.client.keys')
local client_buttons = require('configuration.client.buttons')
local title_bars = require('configuration.client.titlebars')
local beautiful = require("beautiful")

client.connect_signal("manage", function(c)
  c.shape = gears.shape.rounded_rect
end)
-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientKeys,
                     buttons = clientButtons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
		     floating = false,
		     maximised = false,
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false, floating = false }
    },

	-- Set Firefox to always map on the tag named "1" on screen 2.
	{ rule = { class = "Floorp" },
		properties = { screen = 2, tag = "1", floating = false, maximised = false } },
	{ rule = { class = "Vesktop" },
		properties = { screen = 2, tag = "2", floating = false, maximised = false } },
	{ rule = { class = "Spicetify" },
		properties = { screen = 2, tag = "3", floating = false, maximised = false } },

    { -- General plasma rules
    rule_any = {
        class = {
            "plasmashell",
            "ksmserver-logout-greeter",
        },
    },
    properties = {
        floating = true,
        border_width = 0,
        titlebars = false, -- custom property to control titlebars
    },

},
{ -- KDE apps
    rule_any = {
        class = {
            "spectacle",
            "krunner"
        }
    },
    properties = {
        floating = true,
    }
},

}
-- }}}

