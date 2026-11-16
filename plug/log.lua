local waywall = require("waywall")

local M = {}

--- @enum LogLevel
local LogLevel = {
	ERROR = 0,
	WARN = 1,
	INFO = 2,
	DEBUG = 3,
}

--- @class Logger
--- @field __log fun(self, msg: string)
--- @field __log_error fun(self, msg: string)
--- @field __error_output any
--- @field level LogLevel
--- @field debug fun(self, msg: string)
--- @field info fun(self, msg: string)
--- @field warn fun(self, msg: string)
--- @field error fun(self, msg: string)
local Logger = {}

function Logger:__log_error(msg)
	waywall.listen("load", function()
		local start = msg:match(".*:()")
		local output = msg:sub(start)
		if self.__error_output then
			self.__error_output:close()
			self.__error_output = nil
		end
		-- Delay the text output a little to allow the GUI to load.
		waywall.sleep(2500)
		self.__error_output = waywall.text("Error:" .. output, { x = 0, y = 0, color = "#F7768E", size = 3 })
		waywall.sleep(3500)
		if self.__error_output then
			self.__error_output:close()
			self.__error_output = nil
		end
	end)
	self:__log("Error: " .. msg)
end

function Logger:__log(msg)
	print("[plug.waywall] - " .. msg)
end

function Logger.new()
	local self = setmetatable({}, { __index = Logger })
	self.level = LogLevel.INFO
	return self
end

function Logger:debug(msg)
	if self.level >= LogLevel.DEBUG then
		self:__log(msg)
	end
end

function Logger:info(msg)
	if self.level >= LogLevel.INFO then
		self:__log(msg)
	end
end

function Logger:warn(msg)
	if self.level >= LogLevel.WARN then
		self:__log(msg)
	end
end

function Logger:error(msg)
	if self.level >= LogLevel.ERROR then
		self:__log_error(msg)
	end
end

M.Logger = Logger
M.LogLevel = LogLevel

return M
