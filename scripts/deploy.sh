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


    BO_sourcePrototype "$__BO_DIR__/activate.sh"


	function Deploy {
		BO_format "$VERBOSE" "HEADER" "Deploying system ..."

		pushd "$WORKSPACE_DIR" > /dev/null

		    BO_log "$VERBOSE" "WORKSPACE_DIR: $WORKSPACE_DIR"
			BO_log "$VERBOSE" "PWD: $PWD"

	        # TODO: Switch to deploy branch, add template files and zero system submodule and then deploy.
	
	        # TODO: Use config to determine if to use '0' or '0.dev' for deployment.
	
	
	
			# TODO: Get platform names from declarations and deploy to each environment or only some
			#       based on what we are being asked to do.
			export PLATFORM_NAME="com.heroku"
	        for file in $(find ./Deployments/**/*.herokuapp.com.*profile.ccjson); do
	        	file=$(basename $file)
	        	file=${file%.proto.profile.ccjson}
	        	file=${file%.profile.ccjson}

	        	export ENVIRONMENT_NAME="$file"
	        	BO_log "$VERBOSE" "Deploying '$PWD' to platform '$PLATFORM_NAME' using profile '$ENVIRONMENT_NAME' ..."
	
			    "$Z0_ROOT/scripts/deploy.sh"
	        done

		popd > /dev/null

		BO_format "$VERBOSE" "FOOTER"
	}

	Deploy $@

}
init $@