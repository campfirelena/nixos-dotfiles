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
	{
	image = ICON,
	widget = wibox.widget.imagebox
	},
	valign = 'center',
	layout = wibox.container.place,
},
}

return volume_widget
