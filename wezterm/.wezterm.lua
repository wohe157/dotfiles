local wezterm = require("wezterm")

-- Utility functions
function os_config(apple_value, linux_value, windows_value)
  if string.find(wezterm.target_triple, "apple") then
    return apple_value
  elseif string.find(wezterm.target_triple, "linux") then
    return linux_value
  elseif string.find(wezterm.target_triple, "windows") then
    return windows_value
  else
    error("Unsupported operating system: " .. wezterm.target_triple)
  end
end

-- Set initial screen size
local mux = wezterm.mux
wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

-- Build config
local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night Storm"
config.window_decorations = "RESIZE"

config.default_prog = os_config(
  { "/opt/homebrew/bin/fish", "-l" },
  { "/usr/local/bin/fish", "-l" },
  { "C:\\windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" }
)

config.keys = {
  {
    key = "\\",
    mods = "CTRL",
    action = wezterm.action.SplitHorizontal({domain = "CurrentPaneDomain"})
  },
  {
    key = "-",
    mods = "CTRL",
    action = wezterm.action.SplitVertical({domain = "CurrentPaneDomain"})
  },
  {
    key = "t",
    mods = "CTRL",
    action = wezterm.action.SpawnTab("CurrentPaneDomain")
  },
  {
    key = "h",
    mods = "CTRL",
    action = wezterm.action.ActivatePaneDirection("Left")
  },
  {
    key = "j",
    mods = "CTRL",
    action = wezterm.action.ActivatePaneDirection("Down")
  },
  {
    key = "k",
    mods = "CTRL",
    action = wezterm.action.ActivatePaneDirection("Up")
  },
  {
    key = "l",
    mods = "CTRL",
    action = wezterm.action.ActivatePaneDirection("Right")
  },
  {
    key = "n",
    mods = "CTRL",
    action = wezterm.action.ActivateTabRelative(1)
  },
  {
    key = "p",
    mods = "CTRL",
    action = wezterm.action.ActivateTabRelative(-1)
  },
  {
    key = "x",
    mods = "CTRL",
    action = wezterm.action.CloseCurrentPane({confirm=false})
  }
}

return config
