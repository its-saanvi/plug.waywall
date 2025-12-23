# plug.waywall
A simple plugin manager for waywall.
> Note: This is a work in progress and is not ready for use.

# Installation
## Dependencies
- git
- [waywall](https://github.com/tesselslate/waywall)

## Backup any existing waywall config
```sh
mv ~/.config/waywall ~/.config/waywall.bak
```

## Clone plug.waywall
```sh
git clone https://github.com/its-saanvi/plug.waywall.git ~/.config/waywall/
```

## Copy back your waywall config into ~/.config/waywall/init.lua
```sh
cp ~/.config/waywall.bak/init.lua ~/.config/waywall/init.lua
```
Or, if you do not have an existing config, you can use the `init.lua` already cloned in `~/.config/waywall` and modify it to your liking.

# Usage
## Plugin Configuration
```lua
local plug = require("plug.init")
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
See [plug.sample](./sample/init.lua) for an example plugin.
See [init.lua](./init.lua) for an example waywall config with plug.waywall.

# License
[GNU GPL v2](./LICENSE)

# Thanks
- [tesselslate](https://github.com/tesselslate) for [waywall](https://github.com/tesselslate/waywall)
- [folke](https://github.com/folke) for [lazy.nvim](https://github.com/folke/lazy.nvim) which heavily inspired this.
