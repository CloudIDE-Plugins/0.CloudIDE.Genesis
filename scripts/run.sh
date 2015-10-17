#!/bin/bash
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


	export WORKSPACE_DIR="$__BO_DIR__"
	export BOOT_CONFIG_PATH="$__BO_DIR__/PINF.Genesis.ccjson"

	export PATH_OVERRIDES="$WORKSPACE_DIR/0/0.CloudIDE.Genesis/scripts"


	function Run {
		BO_format "$VERBOSE" "HEADER" "Running system ..."

		pushd "$WORKSPACE_DIR" > /dev/null

		    # Start editor

		    "$WORKSPACE_DIR/0/scripts/edit.sh"

		popd > /dev/null

		BO_format "$VERBOSE" "FOOTER"
	}

	Run $@

}
init $@