#!/bin/bash -e
if [ -z "$npm_config_argv" ]; then
	echo "ERROR: Must run with 'npm install'!"
	exit 1
fi
if [ -z "$HOME" ]; then
	echo "ERROR: 'HOME' environment variable is not set!"
	exit 1
fi

if [ -z "$Z0_ROOT" ]; then
	export Z0_ROOT="$__BO_DIR__/../.."
fi
pushd "$Z0_ROOT" > /dev/null
	git submodule update --init --rebase lib/bash.origin
	lib/bash.origin/bash.origin BO install
popd > /dev/null

# Source https://github.com/bash-origin/bash.origin
. "$HOME/.bash.origin"
function init {
	eval BO_SELF_BASH_SOURCE="$BO_READ_SELF_BASH_SOURCE"
	BO_deriveSelfDir ___TMP___ "$BO_SELF_BASH_SOURCE"
	local __BO_DIR__="$___TMP___"


	function Deploy {
		BO_format "$VERBOSE" "HEADER" "Installing system ..."

		BO_log "$VERBOSE" "PWD: $PWD"

	    "$Z0_ROOT/scripts/install.sh"

	    # TODO: Install user stacks as well


		BO_format "$VERBOSE" "FOOTER"
	}

	Deploy $@

}
init $@