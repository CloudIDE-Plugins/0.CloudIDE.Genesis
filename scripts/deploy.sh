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
		BO_format "$VERBOSE" "HEADER" "Deploying system ..."

		pushd "$WORKSPACE_DIR" > /dev/null

            # TODO: Switch to deploy branch, add template files and zero system submodule and then deploy.

            # TODO: Use config to determine if to use '0' or '0.dev' for deployment.


echo "TODO: Deploy!!"
            
            
            
            

#		    "$WORKSPACE_DIR/0/scripts/deploy.sh"

		popd > /dev/null

		BO_format "$VERBOSE" "FOOTER"
	}

	Deploy $@

}
init $@