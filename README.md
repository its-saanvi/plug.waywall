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
Or, if you do not have an existing config, you can use the init.lua already cloned in `~/.config/waywall` and modify it to your liking.

# Usage
```lua
local plug = require("plug.init")
plug.setup({
	-- Use a custom directory for plugins with each .lua returning a plugin spec.
    -- This setting is relative to the .config directory.
    -- Eg: This would search for plugins in ~/.config/waywall/plugins.
	dir = "plugins",

    -- Or specify a list of plugin specs.
    -- plugins = {
    -- 	{
    --      -- 	Set source URL for the plugin
    -- 		url = "https://example.com/author/sample",
    -- 		name = "sample", -- Optional name for the plugin.
    -- 		config = function()
    -- 			print(require("plug.sample.init").loaded) -- Field exported from example plugin.
    -- 		end,
    -- 	},
    -- },
})
```
See [plug.sample](./plug/sample/init.lua) for an example plugin.

# License
[GNU GPL v2](./LICENSE)

# Thanks
- [tesselslate](https://github.com/tesselslate) for [waywall](https://github.com/tesselslate/waywall)
- [folke](https://github.com/folke) for [lazy.nvim](https://github.com/folke/lazy.nvim) which heavily inspired this.
