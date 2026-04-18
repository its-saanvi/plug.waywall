# plug.waywall
A simple plugin manager for waywall.
> Note: This is a work in progress and is not ready for use.

# Installation
## Dependencies
- git
- [waywall](https://github.com/tesselslate/waywall)

## Bootstrap plug.waywall
Put the following code in your `init.lua` or any `profile.lua` file.
```lua
-- Bootstrap plug.waywall
local plug_repo = "https://github.com/its-saanvi/plug.waywall"
local waywall_share = os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share") .. "/waywall"
local plug_path = waywall_share .. "/plug"
local file, err = io.open(plug_path .. "/.check_temp", "w")
if not file and err then
	if string.find(err, "No such file or directory") then
		if not os.execute("mkdir -p " .. waywall_share) then
			print("Failed to create waywall share directory")
		end
		if not os.execute("git clone " .. plug_repo .. " " .. plug_path) then
			print("Failed to clone plug.waywall")
		end
	end
else
	file:close()
	os.remove(plug_path .. "/.check_temp")
end
package.path = package.path .. ";" .. waywall_share .. "/?/init.lua" .. ";" .. plug_path .. "/?.lua"

local plug = require("plug")
plug.setup({})
```

If you do not have an existing config, you can use the [example.lua](./example.lua) and modify it to your liking.

# Usage
## Plugin Configuration
```lua
plug.setup({
	-- Use a custom directory for plugins with each .lua returning a plugin spec.
	-- This setting is relative to the .config directory.
	-- Eg: This would search for plugins in ~/.config/waywall/plugins.
	dir = "plugins",
	config = config,
	path = "~/.local/waywall", -- Optional, set to override the path plugins are installed in (default is ~/.config/waywall)

	-- Or specify a list of plugin specs.
	-- plugins = {
	-- 	{
	--    -- 	Set source URL for the plugin
	-- 		url = "https://example.com/author/sample",
	-- 		name = "sample", -- Optional name for the plugin
	-- 		config = function(config) -- `config` is the waywall config table.
	--      -- See sample/init.lua for an example plugin
	-- 			print(require("sample.init").loaded)
	-- 		end,
	-- 		enabled = false, -- Optional, set to true to enable the plugin
	-- 		dependencies = {
	--      -- Optional, list of plugin specs that this plugin depends on
	-- 		}
	-- 		update_on_load = false, -- Optional, set to true to update the plugin on load
	-- 	},
	-- },
})
```

## Plugin updates
```lua
-- Update plugin with name "<name>"
-- Returns true if successful, false otherwise.
-- You can set it to a keybind through waywall.
local success = plug.update({ name = "<name>" })
```

```lua
-- Update all plugins
-- Returns true if successful, false otherwise.
-- You can also set it to a keybind through waywall.
local success_all = plug.update_all()
```
See [sample](./sample/init.lua) for an example plugin.

# License
[GNU GPL v2](./LICENSE)

# Thanks
- [tesselslate](https://github.com/tesselslate) for [waywall](https://github.com/tesselslate/waywall)
- [folke](https://github.com/folke) for [lazy.nvim](https://github.com/folke/lazy.nvim) which heavily inspired this.
