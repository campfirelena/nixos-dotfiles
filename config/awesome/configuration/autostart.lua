local apps = require('configuration.apps')
local filesystem = require('gears.filesystem')

-- List of apps to start once on start-up
return {
  run_on_start_up = {
	  "autorandr horizontal",
	  'picom --config ' .. filesystem.get_configuration_dir() .. 'configuration/picom.conf',
	  -- 'nm-applet --indicator', -- wifi
	  -- 'blueberry-tray', -- Bluetooth tray icon
	  -- 'xfce4-power-manager', -- Power manager
	  -- 'numlockx on', -- enable numlock
	  -- 'blueman-tray', -- bluetooth tray

	-- Add applications that need to be killed between reloads
    -- to avoid multipled instances, inside the awspawn script
    '~/.config/awesome/configuration/autostartonce.sh', -- Spawn "dirty" apps that can linger between sessions
    "flameshot",

  }
}
