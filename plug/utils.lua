local M = {}

--- @param module_name string
--- @return table | nil
--- @return string | nil
function M.Prequire(module_name)
	local ok, mod = pcall(require, module_name)
	if not ok then
		return nil, mod -- returns nil and the error message
	end
	return mod, nil -- returns the loaded module
end

--- @param path string
function M.Normalize_path(path)
	if path:sub(1, 1) == "~" then
		local home = os.getenv("HOME")
		path = home .. path:sub(2)
	end
	if path:sub(-1) ~= "/" then
		path = path .. "/"
	end
	return path
end

return M
