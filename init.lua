local log = require("log")
local plugin = require("plugin")
local globals = require("globals")

local M = {}

--- @type Logger
Log = log.Logger:new()

--- @param path string
local function __normalize_path(path)
	if path:sub(1, 1) == "~" then
		local home = os.getenv("HOME")
		path = home .. path:sub(2)
	end
	if path:sub(-1) ~= "/" then
		path = path .. "/"
	end
	return path
end

--- @param dir string
--- @param config table<any, any>
local function __setup_dir(dir, config)
	local command = 'ls -a "' .. globals.WAYWALL_CONFIG_DIR .. dir .. '"'
	local handle = io.popen(command)
	if not handle then
		Log:error("setup dir failed: popen failed")
		return
	end
	for filename in handle:lines() do
		if filename == "." or filename == ".." then
			goto continue
		end
		if filename:sub(-#".lua") ~= ".lua" then
			Log:debug("setup dir: skip non lua file")
			goto continue
		end
		--- @type table<string, any> | nil
		filename = filename:sub(0, -#".lua" - 1)
		Log:debug("setup dir: load spec: " .. dir .. "." .. filename)
		local ok, spec = pcall(require, dir .. "." .. filename)
		if not ok then
			Log:error("setup dir: failed to load spec: " .. spec)
			goto continue
		end
		local pspec, err2 = plugin.load_from_spec(spec, config)
		if err2 then
			Log:error("setup dir: failed to load plugin: " .. err2)
			goto continue
		end
		Log:debug("setup dir: loaded plugin: " .. pspec.name)
		::continue::
	end
end

--- @param plugins table<string, any>[]
--- @param config table<any, any>
local function __setup_plugins(plugins, config)
	for _, spec in ipairs(plugins) do
		local pspec, err = plugin.load_from_spec(spec, config)
		if err then
			Log:error("setup plugins: failed to load plugin: " .. err)
			goto continue
		end
		Log:debug("setup plugins: loaded plugin: " .. pspec.name)
		::continue::
	end
end

--- @param opts SetupOpts
function M.setup(opts)
	Log:debug("setup start")

	Log.level = (function()
		-- If opts.log_level is set, use it.
		if opts.log_level then
			if opts.log_level == "error" then
				return log.LogLevel.ERROR
			elseif opts.log_level == "warn" then
				return log.LogLevel.WARN
			elseif opts.log_level == "info" then
				return log.LogLevel.INFO
			elseif opts.log_level == "debug" then
				return log.LogLevel.DEBUG
			end
		end

		-- Otherwise, default to info
		return log.LogLevel.INFO
	end)()
	Log:debug("Log level: " .. Log.level)

	local path = __normalize_path(opts.path or globals.PLUG_CONFIG_DIR)
	Log:debug("plugins path: '" .. "'")
	globals.PLUG_CONFIG_DIR = path
	package.path = package.path .. ";" .. path .. "?/init.lua" .. ";" .. path .. "?.lua" .. ";" .. path .. "?/?.lua"

	if opts.dir then
		Log:debug("setup dir")
		__setup_dir(opts.dir, opts.config)
	elseif opts.plugins then
		Log:debug("setup plugins")
		__setup_plugins(opts.plugins, opts.config)
	else
		Log:error("setup failed: no dir or plugins")
	end
	Log:debug("setup end")
end

--- @param opts UpdateOpts
--- @return boolean
function M.update(opts)
	Log:debug("update start")
	if not opts.name then
		Log:error("update failed: no name")
		return false
	end

	local success, err = plugin.update_from_name(opts.name)
	if not success then
		Log:error("update failed: " .. err)
		return false
	end

	Log:debug("update end")
	return true
end

--- @return boolean
function M.update_all()
	Log:debug("update all start")
	local success, err = plugin.update_all()
	if not success then
		Log:error("update all failed: " .. err)
		return false
	end

	Log:debug("update all end")
	return true
end

return M
