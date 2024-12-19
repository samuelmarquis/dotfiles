-- red
local lexers = vis.lexers

local colors = {
	['black'] = '#010101', -- we would LIKE #000000 here, but..
	['dyellow'] = '#AAAA00',
	['yellow'] = '#FFFF00',
	['dgray'] = '#555555',
	['gray'] = '#AAAAAA', --line no, comments
	['lgray'] = '#CCCCCC',
	['white']  = '#FFFFFF', --normal text
	['fuck'] = '#01FF01', --SHOULD BE whitespace errors
	['pink'] = '#ffcccc',
	['magenta'] = '#eebbee',
	['red'] = '#ff4040',
	['blue'] = '#0055ff',
}

lexers.colors = colors
local fg = ',fore:'..colors.white..','
local bg = ',back:'..colors.black..','

lexers.STYLE_DEFAULT = bg..fg
lexers.STYLE_NOTHING = bg
lexers.STYLE_CLASS = 'fore:'..colors.white
lexers.STYLE_COMMENT = 'fore:'..colors.gray..',italics'
lexers.STYLE_CONSTANT = 'fore:'..colors.red
lexers.STYLE_CONSTANT_BUILTIN = 'fore:'..colors.red
lexers.STYLE_DEFINITION = 'fore:'..colors.pink
lexers.STYLE_ERROR = 'back:'..colors.fuck..',fore:'..colors.white
lexers.STYLE_FUNCTION = 'fore:'..colors.white..',bold'
lexers.STYLE_FUNCTION_BUILTIN = 'fore:'..colors.white..',bold'
lexers.STYLE_KEYWORD = 'fore:'..colors.red
lexers.STYLE_LABEL = 'fore:'..colors.red..',underlined'
lexers.STYLE_NUMBER = 'fore:'..colors.white
lexers.STYLE_OPERATOR = 'fore:'..colors.white
lexers.STYLE_REGEX = 'fore:'..colors.magenta
lexers.STYLE_STRING = 'fore:'..colors.pink
lexers.STYLE_PREPROCESSOR = 'fore:'..colors.red..',underlined'
lexers.STYLE_ATTRIBUTE = 'fore:'..colors.blue..',bold'
lexers.STYLE_TAG = 'fore:'..colors.red
lexers.STYLE_TYPE = 'fore:'..colors.red
lexers.STYLE_VARIABLE = 'fore:'..colors.pink
lexers.STYLE_WHITESPACE = ''
lexers.STYLE_EMBEDDED = 'back:'..colors.pink
lexers.STYLE_IDENTIFIER = fg

-- Markdown
lexers.STYLE_HEADING = 'fore:'..colors.pink
lexers.STYLE_LIST = 'fore:'..colors.white
lexers.STYLE_CODE = 'back:'..colors.dgray..',fore:'..colors.white

lexers.STYLE_LINENUMBER = 'fore:'..colors.gray
lexers.STYLE_CURSOR = 'fore:'..colors.black..',back:'..colors.white
lexers.STYLE_CURSOR_PRIMARY = lexers.STYLE_CURSOR..',back:'..colors.yellow
lexers.STYLE_CURSOR_LINE = 'back:'..colors.dyellow
lexers.STYLE_COLOR_COLUMN = 'back:'..colors.dyellow
-- lexers.STYLE_SELECTION = 'back:'..colors.yellow
lexers.STYLE_SELECTION = 'back:'..colors.dyellow..',fore:'..colors.black
lexers.STYLE_STATUS = 'back:'..colors.dgray..',fore:'..colors.white
lexers.STYLE_STATUS_FOCUSED = 'back:'..colors.lgray..',fore:'..colors.black
lexers.STYLE_SEPARATOR = lexers.STYLE_DEFAULT
lexers.STYLE_INFO = 'fore:default,back:default,bold'
lexers.STYLE_EOF = ''
