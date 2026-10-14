-- Variables
local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "thunar"

-------------
-- Basic
-------------

-- Open terminal
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))

-- Open File Manager 
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(fileManager))

-- Close window
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- Exit Hyprland
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())

-- Reload Config
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.reload_config())

-------------
-- Movement
-------------

-- Focus left
hl.bind(mainMod .. " + L", hl.dsp.focus({
  direction = "left"
}))

-- Focus right
hl.bind(mainMod .. " + H", hl.dsp.focus({
  direction = "right"
}))

-- Focus up
hl.bind(mainMod .. " + K", hl.dsp.focus({
  direction = "up"
}))

-- Focus down
hl.bind(mainMod .. " + J", hl.dsp.focus({
  direction = "down"
}))


-- Move left
hl.bind(mainMod .. " + L", hl.dsp.move({
  direction = "lemove"
}))

-- Move right
hl.bind(mainMod .. " + H", hl.dsp.move({
  direction = "right"
}))

-- Move up
hl.bind(mainMod .. " + K", hl.dsp.move({
  direction = "up"
}))

-- Move down
hl.bind(mainMod .. " + J", hl.dsp.move({
  direction = "down"
}))

-- Switch workspaces with mainMod and move active window to workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })



