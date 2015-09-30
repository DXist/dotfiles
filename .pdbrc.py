# coding: utf-8

"""Pdb++ defaults"""

from pdb import DefaultConfig


class Config(DefaultConfig):

    sticky_by_default = True
    # 40 + number - https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
    current_line_color = 40
