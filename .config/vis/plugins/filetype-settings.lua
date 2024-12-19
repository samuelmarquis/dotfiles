-- vis-filetype-settings
-- (https://github.com/jocap/vis-filetype-settings)

-- This plugin provides a declarative interface for setting vis
-- options depending on filetype.
-- 
-- It expects a module attribute called `settings` to be defined:
-- 
-- 	ft.settings = {
-- 		markdown = {"set expandtab on", "set tabwidth 4"}
-- 	}
-- 
-- In this variable, filetypes are mapped to sets of settings that are
-- to be executed when a window containing the specified filetype is
-- opened.
-- 
-- If you want to do more than setting simple options, you can specify a function instead:
-- 
-- 	ft.settings = {
-- 		bash = function(win)
-- 			-- do things for shell scripts
-- 		end
-- 	}
-- 
-- Be sure not to run commands that open another window with the same
-- filetype, leading to an infinite loop.

local M = {}

--- Dump value of a variable in a formatted string
--
--- @param o    table       Dumpable object
--- @param tbs  string|nil  Tabulation string, '  ' by default
--- @param tb   number|nil  Initial tabulation level, 0 by default
--- @return     string
local function dump(o, tbs, tb)
    tb = tb or 0
    tbs = tbs or "  "
    if type(o) == "table" then
        local s = "{"
        if (next(o)) then
            s = s .. "\n"
        else
            return s .. "}"
        end
        tb = tb + 1
        for k, v in pairs(o) do
            if type(k) ~= "number" then
                k = '"' .. k .. '"'
            end
            s = s .. tbs:rep(tb) .. "[" .. k .. "] = " .. dump(v, tbs, tb)
            s = s .. ",\n"
        end
        tb = tb - 1
        return s .. tbs:rep(tb) .. "}"
    else
        return tostring(o)
    end
end

M.settings = {}

function execute(s, arg, arg2)
	if type(s) == "table" then
		for key, setting in pairs(s) do
			if type(key) == "number" then -- ignore EVENT keys
				vis:command(setting)
			end
		end
	elseif type(s) == "function" then
		if arg2 then
			s(arg, arg2)
		else
			s(arg)
		end
	end
end

-- TODO There is something wrong, gh#jocap/vis-filetype-settings!5 mentions
-- settings = {
-- 	['.funkytype'] = {
-- 		"set expandtab on",
-- 	}
-- }
-- That dot makes me wonder

-- Register events

vis.events.subscribe(vis.events.INPUT, function()
	if M.settings[vis.win.syntax] and M.settings[vis.win.syntax].INPUT then
		execute(M.settings[vis.win.syntax].INPUT, nil)
	end
end)

local file_events = {
	"FILE_OPEN",
	"FILE_CLOSE",
	"FILE_SAVE_POST",
	"FILE_SAVE_PRE"
}

for _, event in pairs(file_events) do
	vis.events.subscribe(vis.events[event], function(file, path)
		for win in vis:windows() do
			-- vis:info("FILE win.file " .. win.file.name .. ", syntax " .. win.syntax)
			if win.file == file then
				if M.settings[win.syntax] and M.settings[win.syntax][event] then
					execute(M.settings[win.syntax][event], file, path)
				end
			end
		end
	end)
end

local win_events = {
	"WIN_CLOSE",
	"WIN_HIGHLIGHT",
	"WIN_OPEN",
	"WIN_STATUS"
}

-- vis.events.subscribe(vis.events.WIN_OPEN, function(win)
-- 	if settings == nil then return end
-- 	local window_settings = settings[win.syntax]
-- 
-- 	if type(window_settings) == "table" then
-- 		for _, setting in pairs(window_settings) do
-- 			vis:command(setting)

for _, event in pairs(win_events) do
	vis.events.subscribe(vis.events[event], function(win)
		if win.file.size > 0 then
			-- if win.syntax ~= nil then
			-- 	vis:info("WIN file " .. win.file.path .. ", WIN syntax " .. win.syntax .. ", partial set " .. dump(M.settings[win.syntax]))
			-- end
		end
		if M.settings[win.syntax] == nil then return end
		if M.settings[win.syntax] then
			if M.settings[win.syntax][event] then
				execute(M.settings[win.syntax][event], win)
			elseif event == "WIN_OPEN" then -- default event
				execute(M.settings[win.syntax], win)
			end
		end
	end)
end

return M
