require('vis')

local plug = (function() if not pcall(require, 'plugins/vis-plug') then
 	os.execute('git clone --quiet https://github.com/erf/vis-plug ' ..
	 	(os.getenv('XDG_CONFIG_HOME') or os.getenv('HOME') .. '/.config')
	 	.. '/vis/plugins/vis-plug')
end return require('plugins/vis-plug') end)()

local plugins = {
	{ 'erf/vis-highlight', alias = 'hi' },
}

plug.init(plugins, true)
plug.plugins.hi.patterns['[ \t]+\n'] = { style = 'back:#00FF00' }

ftset = require('plugins/filetype-settings')

ftset.settings = {
	rust = {"set tabwidth 4"}
}

vis.events.subscribe(vis.events.INIT, function()
	vis:command('set theme red')
end)
vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	vis:command('set nu')
end)
