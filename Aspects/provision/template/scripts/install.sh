#!/bin/bash -e
if [ -z "$HOME" ]; then
	echo "ERROR: 'HOME' environment variable is not set!"
	exit 1
fi
# Source https://github.com/bash-origin/bash.origin
. "$HOME/.bash.origin"
function init {
	eval BO_SELF_BASH_SOURCE="$BO_READ_SELF_BASH_SOURCE"
	BO_deriveSelfDir ___TMP___ "$BO_SELF_BASH_SOURCE"
	local __BO_DIR__="$___TMP___"

	BO_sourcePrototype "node_modules/0.workspace/scripts/expand.proto.sh"

	function InstallConcreteWorkspace {
		# **************************************************
		# **************************************************




		echo "TODO: Add your custom install code here!"




		# **************************************************
		# **************************************************
	}

	0.workspace.ensure.abstract $@
}
init $@