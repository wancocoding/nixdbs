#!/bin/bash

# check install path
if [ ! -d $HOME/.nixdbs ]; then
	echo "Nixdbs not install correctly! please reinstall it."
	echo 'curl -fsSL https://raw.githubusercontent.com/wancocoding/nixdbs/master/tools/install.sh | bash'
	exit 1
fi

# rcfile
append_rc '# ====== NIXDBS SETTINGS ======'
append_rc 'export NIXDBS_HOME=$HOME/.nixdbs'
append_rc 'export PATH=$HOME/.local/bin:$PATH'
