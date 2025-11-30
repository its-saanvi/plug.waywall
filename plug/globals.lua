local M = {}

M.PLUG_CONFIG_DIR = (function()
	if os.getenv("XDG_CONFIG_HOME") then
		return os.getenv("XDG_CONFIG_HOME") .. "/waywall/plug/"
	end
	return os.getenv("HOME") .. "/.config/waywall/plug/"
end)()

M.WAYWALL_CONFIG_DIR = os.getenv("HOME") .. "/.config/waywall/"

return M
