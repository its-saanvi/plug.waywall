local types = require("plug.types")
local utils = require("plug.utils")

local M = {}

--- @param spec table<string, any>
--- @return string | nil
function M.load_from_spec(spec)
	if not spec.url then
		return "load spec: failed to load plugin: url not provided"
	end

	--- @type PluginSpec
	local pspec = types.PluginSpec.new(spec.url, spec.name, spec.config)

	local success, err = pspec:load()
	if not success then
		return "load spec: failed to load plugin: " .. err
	end

	local plugin = utils.Prequire("plug." .. pspec.name .. ".init")
	if not plugin then
		return "load plugin: failed to load plugin init"
	end
	if pspec.config then
		pspec.config()
	end
	return nil
end

return M
