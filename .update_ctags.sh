#!/bin/bash
`which ctags` -R -o ~/mytags.tmp $@
mv ~/mytags.tmp ~/mytags
