# coding: utf-8

"""Solarized theme for pudb."""

# Supported 16 color values:
#   'h0' (color number 0) through 'h15' (color number 15)
#    or
#   'default' (use the terminal's default foreground),
#   'black', 'dark red', 'dark green', 'brown', 'dark blue',
#   'dark magenta', 'dark cyan', 'light gray', 'dark gray',
#   'light red', 'light green', 'yellow', 'light blue',
#   'light magenta', 'light cyan', 'white'
#
# Supported 256 color values:
#   'h0' (color number 0) through 'h255' (color number 255)
#
# 256 color chart: http://en.wikipedia.org/wiki/File:Xterm_color_chart.png
#
# "setting_name": (foreground_color, background_color),

# See pudb/theme.py
# (https://github.com/inducer/pudb/blob/master/pudb/theme.py) to see what keys
# there are.

# Note, be sure to test your theme in both curses and raw mode (see the bottom
# of the preferences window). Curses mode will be used with screen or tmux.


# Based on XCode's midnight theme
# Looks best in a console with green text against black background
palette.update({
    "variables": ("white", "default"),

    "var label": ("light blue", "default"),
    "var value": ("white", "default"),

    "stack": ("white", "default"),

    "frame name": ("white", "default"),
    "frame class": ("dark blue", "default"),
    "frame location": ("light cyan", "default"),

    "current frame name": (add_setting("white", "bold"), "default"),
    "current frame class": ("dark blue", "default"),
    "current frame location": ("light cyan", "default"),

    "focused frame name": ("black", "dark green"),
    "focused frame class": (add_setting("white", "bold"), "dark green"),
    "focused frame location": ("dark blue", "dark green"),

    "focused current frame name": ("black", "dark green"),
    "focused current frame class": (add_setting("white", "bold"), "dark green"),
    "focused current frame location": ("dark blue", "dark green"),

    "breakpoint": ("default", "default"),

    "search box": ("default", "default"),

    "source": ("white", "default"),
    "highlighted source": ("white", "light cyan"),
    "current source": ("white", "light gray"),
    "current focused source": ("white", "brown"),

    "line number": ("light gray", "default"),
    "keyword": ("dark magenta", "default"),
    "name": ("white", "default"),
    "literal": ("dark cyan", "default"),
    "string": ("dark red", "default"),
    "doublestring": ("dark red", "default"),
    "singlestring": ("light blue", "default"),
    "docstring": ("light red", "default"),
    "backtick": ("light green", "default"),
    "punctuation": ("white", "default"),
    "comment": ("dark green", "default"),
    "classname": ("dark cyan", "default"),
    "funcname": ("white", "default"),

    "breakpoint marker": ("dark red", "default"),

    # {{{ shell

    "command line edit": ("white", "default"),
    "command line prompt": (add_setting("white", "bold"), "default"),

    "command line output": (add_setting("white", "bold"), "default"),
    "command line input": (add_setting("white", "bold"), "default"),
    "command line error": (add_setting("light red", "bold"), "default"),

    "focused command line output": ("black", "dark green"),
    "focused command line input": (add_setting("white", "bold"), "dark green"),
    "focused command line error": ("black", "dark green"),

    "command line clear button": (add_setting("white", "bold"), "default"),
    "command line focused button": ("black", "light gray"), # White
    # doesn't work in curses mode
})
