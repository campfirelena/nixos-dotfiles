-- originally made by streetturtle, modified by campfirelena for spotify-cli-linux (NixOS)
-- also removed album section as I don't feel the need to have it, and to improve performance
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local beautiful = require("beautiful")
local naughty = require("naughty")

local function ellipsize(text, length)
  -- utf8 only available in Lua 5.3+
  if utf8 == nil then
    return text:sub(0, length)
  end
  return (utf8.len(text) > length and length > 0)
  and text:sub(0, utf8.offset(text, length - 2) - 1) .. '...'
  or text
end

local spotify_widget = {}

local function worker(user_args)

  local args = user_args or {}

  local play_icon = args.play_icon or '/home/elena/.config/awesome/widgets/top-panel/assets/media-playback-start.png'
  local pause_icon = args.pause_icon or '/home/elena/.config/awesome/widgets/top-panel/assets/media-playback-pause.png'
  local font = args.font or 'JetBrainsMono NFM Light'
  local dim_when_paused = args.dim_when_paused == nil and false or args.dim_when_paused
  local dim_opacity = args.dim_opacity or 0.2
  local max_length = args.max_length or 99
  local show_tooltip = args.show_tooltip == nil and true or args.show_tooltip
  local timeout = args.timeout or 1
  local sp_bin = args.sp_bin or 'spotifycli'

  local GET_STATUS_CMD = sp_bin .. ' --playbackstatus'
  local GET_SONG_ARTIST_CMD = sp_bin .. ' --status'
  local PLAY_PAUSE_CMD = sp_bin .. ' --playpause'
  local NEXT_SONG_CMD = sp_bin .. ' --next'
  local PREVIOUS_SONG_CMD = sp_bin .. ' --prev'

  local artist_song = {}
  local cur_artist = ' '
  local cur_title = ' '
  local cur_song = ' '
  local running = false

  local spotify_widget = wibox.widget { 
    bg = beautiful.bg_transparent,
    {
      id = 'artistw',
      font = font,
      widget = wibox.widget.textbox,
    },
    {
      layout = wibox.layout.stack,
      {
        id = "icon",
        widget = wibox.widget.imagebox,
      },
      {
        widget = wibox.widget.textbox,
        font = font,
        text = ' ',
        forced_height = 1
      }
    },
    layout = wibox.layout.fixed.horizontal,
    {
      layout = wibox.container.scroll.horizontal,
      max_size = 100,
      step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
      speed = 40,
      {
        id = 'songw',
        font = font,
        widget = wibox.widget.textbox,
      }
    },
    layout = wibox.layout.align.horizontal,
    set_status = function(self, is_playing)
      self:get_children_by_id('icon')[1]:set_image(is_playing and play_icon or pause_icon)
      if dim_when_paused then
        self:get_children_by_id('icon')[1]:set_opacity(is_playing and 1 or dim_opacity)

        self:get_children_by_id('songw')[1]:set_opacity(is_playing and 1 or dim_opacity)
        self:get_children_by_id('songw')[1]:emit_signal('widget::redraw_needed')

        self:get_children_by_id('artistw')[1]:set_opacity(is_playing and 1 or dim_opacity)
        self:get_children_by_id('artistw')[1]:emit_signal('widget::redraw_needed')
      end
    end,
    set_text = function(self, artist, song)
      local artist_to_display = ellipsize(cur_artist, max_length)
      if self:get_children_by_id('artistw')[1]:get_markup() ~= artist_to_display then
        self:get_children_by_id('artistw')[1]:set_markup(artist_to_display)
      end

      local song_to_display = ellipsize(cur_song, max_length)
      if self:get_children_by_id('songw')[1]:get_markup() ~= song_to_display then
        self:get_children_by_id('songw')[1]:set_markup(song_to_display)
      end
    end
  }

  local function update_widget_icon(widget, status)
    status:gsub("[\n\r+]","")
    widget:set_status(status == '▮▮' and true or false)
    if status:gmatch("Spotify") then
      running = false
    end
  end

  local function update_widget_text(widget, data)
    if data:len() == 0 then
      cur_artist = " "
      cur_song = " "
    else
      artist_song = gears.string.split(data:gsub("[\n+][%s?]"," "), "-")
      cur_artist = artist_song[1]
      cur_song = artist_song[2]
    end
    widget:set_text(cur_artist .. " " .. cur_song)
    widget:set_visible(true)
  end

  watch(GET_SONG_ARTIST_CMD, timeout, function(widget, stdout)
    local temp = stdout
    update_widget_text(spotify_widget, temp)
  end, spotify_widget)
  watch(GET_STATUS_CMD, timeout, function(widget, stdout)
    local status = stdout
    update_widget_icon(spotify_widget, status)
  end, spotify_widget)

  spotify_widget:connect_signal("button::press", function(_, _, _, button)
    if (button == 1) then
      awful.spawn(PLAY_PAUSE_CMD, false)      -- left click
      if not running then
        awful.spawn("bash -c spotify")
        running = true
      end
    elseif (button == 4) then
      awful.spawn(NEXT_SONG_CMD, false)       -- scroll down
    elseif (button == 5) then
      awful.spawn(PREVIOUS_SONG_CMD, false)   -- scroll up
    end
  end)


  if show_tooltip then
    local spotify_tooltip = awful.tooltip {
      mode = 'outside',
      preferred_positions = {'bottom'},
    }

    spotify_tooltip:add_to_object(spotify_widget)

    spotify_widget:connect_signal('mouse::enter', function()
      spotify_tooltip.markup =
      '<b>Artist</b>: ' .. cur_artist
      .. '\n<b>Song</b>: ' .. cur_song:gsub("\n","")
    end)
  end

  return spotify_widget
end


return setmetatable(spotify_widget, { __call = function(_, ...)
  return worker(...)
end })
