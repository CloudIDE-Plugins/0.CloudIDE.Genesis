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


	function Deploy {
		BO_format "$VERBOSE" "HEADER" "Installing system ..."

		pushd "$WORKSPACE_DIR" > /dev/null

		    "$WORKSPACE_DIR/0/scripts/install.sh"

		    # TODO: Install user stacks as well

		popd > /dev/null

		BO_format "$VERBOSE" "FOOTER"
	}

	Deploy $@

}
init $@