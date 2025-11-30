local globals = require("plug.globals")

local M = {}

--- @class PluginSpec
--- @field url string
--- @field name string | nil
--- @field config fun() | nil
local PluginSpec = {}

--- @param url string
--- @param name string | nil
--- @param config fun() | nil
function PluginSpec.new(url, name, config)
	if not name then
		local start = url:match(".*/()")
		if not start then
			Log:error("PluginSpec: failed to parse url")
			return nil
		end
		name = url:sub(start)
		Log:debug("PluginSpec: name not provided, using " .. name)
	end
	local self = setmetatable({}, { __index = PluginSpec })
	self.url = url
	self.name = name
	self.config = config
	return self
end

--- @return boolean, string | nil
function PluginSpec:load()
	local store_path = globals.PLUG_CONFIG_DIR .. self.name
	local file, err = io.open(store_path .. "/.check_temp", "w")
	if not file and err then
		if string.find(err, "No such file or directory") then
			-- Plugin not found, clone it
			if not os.execute("mkdir -p " .. globals.PLUG_CONFIG_DIR) then
				return false, "failed to create plugin directory"
			end
			-- Use git to clone the plugin
			local command = "git clone " .. self.url .. " " .. store_path
			if not os.execute(command) then
				return false, "failed to clone plugin"
			end
		else
			return false, err
		end
	end
	if file then
		io.close(file)
	end
	os.remove(store_path .. "/.check_temp")
	return true, nil
end

--- @class SetupOpts
--- @field dir string | nil
--- @field plugins PluginSpec[] | nil
local SetupOpts = {}

M.PluginSpec = PluginSpec
M.SetupOpts = SetupOpts

return M
