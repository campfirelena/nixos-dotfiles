local awful = require ("awful")
local wibox = require ("wibox")
local gears = require ("gears")
local beautiful = require ("beautiful")
local naughty = require ("naughty")

local timeout = 1

local ICON = "/home/elena/.config/awesome/widgets/assets/volume-icon.svg"
local MAIN_CMD = "wpctl"
local STATUS_CMD = MAIN_CMD .. " status"
local VOLUME_CMD = MAIN_CMD .. " set-volume"
local MUTE_CMD = MAIN_CMD .. " set-mute"
local INSPECT_CMD = MAIN_CMD .. " inspect"

local volume_widget = {}

awful.widget.watch(STATUS_CMD, timeout, function(widget,stdout)
	local output = stdout
	local sinks = {}
	local sources = {}

	local selected_sink = ""
	local selected_source = ""
	local in_sources = false
	local in_sinks = false
	local in_audio = false

	for line in output:gmatch("[^\r\n]+") do

		if string.match(line, "Audio") then
			in_audio = true end
		if in_audio then
			if string.match(line, "Video") then
				in_audio = false
				break
			end
			if string.match(line, "Sinks:") then
				in_sinks = true
				in_sources = false
			end
			if string.match(line, "Sources:") then
				in_sinks = false
				in_sources = true
			end
			if in_sinks == true then
				if gears.string.startswith(line, " │  *") then
					selected_sink = line:gsub(".(%b.d)?(.)%b(.).","")
				elseif gears.string.startswith(line, " │   ") then 
					table.insert(sinks, line:gsub(".(%b.d)?(.)%b(.).","")) 
				end
			end

			if in_sources == true then
				if gears.string.startswith(line, " │  *") then
					selected_source = line:gsub(".(%b.d)?(.)%b(.).","")
				elseif gears.string.startswith(line, " │   ") then
					table.insert(sources, line:gsub(".(%b.d)?(.)%b(.).","")) 
				end
			end
		end
	end
	return sinks, sources, selected_sink, selected_source
end)

volume_widget = wibox.widget {
  {
    id = "text",
    text = "Volume",
    widget = wibox.widget.textbox,
  },
  layout = wibox.layout.fixed.horizontal,
}

local volume_widget_content = wibox.widget {
  {
    widget = wibox.widget.slider,
    handle_shape = gears.shape.rectangle,
    handle_width = 2,
    handle_color = "#FFFFFF",
    bar_shape = gears.shape.rounded_bar,
    bar_color = "#151515",
    bar_height = 2,
  },
  {
    id = "other text",
    text = "popup content",
    widget = wibox.widget.textbox,
  },
  layout = wibox.layout.fixed.horizontal,
}

local function make_popup(title, content, parent)
  local popup_widget = awful.popup {
    widget = {
      {
        {
          text = title,
          widget = wibox.widget.textbox
        },
        content,
        layout = wibox.layout.fixed.vertical,
      },
      margins = 10,
      widget = wibox.container.margin
    },
    placement = {},
    ontop = true,
    visible = false,
    parent = parent
  }
  return popup_widget
end

local volume_popup = make_popup("Volume", volume_widget_content, volume_widget)

volume_widget:buttons(
  gears.table.join(
    awful.button({}, 1, function()
      awful.placement.next_to(volume_popup,
        {
          preferred_positions = { "bottom" },
          preferred_anchors = { "back" },
        }
      )
      volume_popup.visible = not volume_popup.visible
    end)
    )
  )

return volume_widget
