local M = {}

M.WAYWALL_CONFIG_DIR = os.getenv("HOME") .. "/.config/waywall/"
M.PLUG_CONFIG_DIR = (os.getenv("XDG_STATE_HOME") or (os.getenv("HOME") .. "/.local/state")) .. "/waywall/plug/"

return M
