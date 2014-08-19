# coding: utf-8

"""Solarized theme for pudb."""

# Supported 16 color values:
#   'h0' (color number 0) through 'h15' (color number 15)
#    or
#   'default' (use the terminal's default foreground),
#   'black', 'dark red', 'light green', 'brown', 'dark blue',
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
    # UI
    "header": ("black", "light blue", "standout"),
    "focused sidebar": ("yellow", "light blue", "standout"),
    "group head": ("dark blue", "light blue"),
    "background": ("black", "light blue"),
    "selectable": ("black", "dark cyan"),
    "focused selectable": ("black", "dark green"),

    "variables": ("light blue", "default"),

    "var label": ("light blue", "default"),
    "var value": ("light green", "default"),
    "focused var label": ("white", "light green"),
    "focused var value": ("black", "light green"),

    "highlighted var label": ("white", "dark blue"),
    "highlighted var value": ("black", "dark blue"),
    "focused highlighted var label": ("white", "dark blue"),
    "focused highlighted var value": ("black", "dark blue"),

    "stack": ("light blue", "default"),

    "frame name": ("dark blue", "default"),
    "frame class": ("light blue", "default"),
    "frame location": ("light green", "default"),

    "focused frame name": ("white", "light green"),
    "focused frame class": ("black", "light green"),
    "focused frame location": ("dark gray", "light green"),

    "current frame name": ("white", "dark blue"),
    "current frame class": ("black", "dark blue"),
    "current frame location": ("dark gray", "dark blue"),

    "focused current frame name": ("white", "dark blue"),
    "focused current frame class": ("black", "dark blue"),
    "focused current frame location": ("dark gray", "dark blue"),

    # breakpoints
    "breakpoint": ("light blue", "default"),
    "focused breakpoint": ("white", "light green"),
    "current breakpoint": ("white", "dark blue"),
    "focused current breakpoint": ("white", "dark blue"),

    # source
    "breakpoint source": ("light blue", "black"),
    "current breakpoint source": ("black", "light green"),
    "breakpoint focused source": ("dark gray", "dark blue"),
    "current breakpoint focused source": ("black", "light green"),
    "breakpoint marker": ("dark red", "default"),

    "search box": ("default", "default"),

    "source": ("light blue", "default"),
    "current source": ("black", "light green"),
    "current focused source": ("black", "light green"),

    "focused source": ("dark gray", "dark blue"),

    "current highlighted source": ("black", "dark cyan"),
    "highlighted source": ("light blue", "black"),

    "line number": ("light blue", "default"),
    "keyword": ("dark green", "default"),
    "name": ("light blue", "default"),
    "literal": ("dark cyan", "default"),
    "string": ("dark cyan", "default"),
    "doublestring": ("dark cyan", "default"),
    "singlestring": ("light blue", "default"),
    "docstring": ("dark cyan", "default"),
    "backtick": ("light green", "default"),
    "punctuation": ("light blue", "default"),
    "comment": ("light green", "default"),
    "classname": ("dark blue", "default"),
    "funcname": ("dark blue", "default"),

    # {{{ shell

    "command line edit": ("light blue", "default"),
    "command line prompt": ("light blue", "default"),

    "command line output": ("light blue", "default"),
    "command line input": ("light blue", "default"),
    "command line error": ("dark red", "default"),

    "focused command line output": ("black", "light green"),
    "focused command line input": ("black", "light green"),
    "focused command line error": ("dark red", "light blue"),

    "command line clear button": ("light blue", "default"),
    "command line focused button": ("black", "light blue"), # light blue
    # doesn't work in curses mode
})
