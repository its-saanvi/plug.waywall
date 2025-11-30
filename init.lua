-- An example init.lua for waywall using plug.waywall.
-- You can modify it to your liking.
local waywall = require("waywall")
local helpers = require("waywall.helpers")

local plug = require("plug.init")
plug.setup({
	-- Use a custom directory for plugins with each .lua returning a plugin spec.
	-- This setting is relative to the .config directory.
	-- Eg: This would search for plugins in ~/.config/waywall/plugins.
	dir = "plugins",

	-- Or specify a list of plugin specs.
	-- plugins = {
	-- 	{
	--    -- 	Set source URL for the plugin
	-- 		url = "https://example.com/author/sample",
	-- 		name = "sample", -- Optional name for the plugin
	-- 		config = function()
	--      -- See plug.sample.init.lua for an example plugin
	-- 			print(require("plug.sample.init").loaded)
	-- 		end,
	-- 	},
	-- },
})

-- Rest of config from here
local config = {
	input = {},
	theme = {},
	experimental = {},
	actions = {},
}

return config
