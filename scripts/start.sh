#!/bin/bash -e
if [ -z "$npm_config_argv" ]; then
	echo "ERROR: Must run with 'npm install'!"
	exit 1
fi
if [ -z "$Z0_ROOT" ]; then
	export Z0_ROOT="$PWD/0"
fi
# Source https://github.com/bash-origin/bash.origin
. "$Z0_ROOT/lib/bash.origin/bash.origin"
function init {
	eval BO_SELF_BASH_SOURCE="$BO_READ_SELF_BASH_SOURCE"
	BO_deriveSelfDir ___TMP___ "$BO_SELF_BASH_SOURCE"
	local __BO_DIR__="$___TMP___"


	function Deploy {
		BO_format "$VERBOSE" "HEADER" "Starting system ..."


    	export BOOT_CONFIG_PATH="$PWD/PINF.Genesis.ccjson"

        BO_sourcePrototype "$Z0_ROOT/scripts/start.sh"


		BO_format "$VERBOSE" "FOOTER"
	}

	Deploy $@

}
init $@