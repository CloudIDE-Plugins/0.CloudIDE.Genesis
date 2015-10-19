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


    BO_sourcePrototype "$__BO_DIR__/activate.sh"


    OUR_BASE_DIR="$__BO_DIR__"


	function Expand {
		BO_format "$VERBOSE" "HEADER" "Expanding system ..."

		pushd "$WORKSPACE_DIR" > /dev/null

		    BO_log "$VERBOSE" "WORKSPACE_DIR: $WORKSPACE_DIR"
			BO_log "$VERBOSE" "PWD: $PWD"

		    BO_log "$VERBOSE" "Checking prerequisites ..."

		    # Check if git initialized
		    if [ ! -e ".git" ]; then
		        echo "ERROR: '$WORKSPACE_DIR/.git' not found! Directory '$WORKSPACE_DIR' must be an initialized GIT repository!"
		        echo "ACTION: Run 'git init'"
		        exit 1;
		    fi

		    # Check if git dirty
		    if [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] || [[ $(git status -s 2> /dev/null | tail -n1) != "" ]]; then
		        echo "ERROR: Your working directory '$WORKSPACE_DIR' contains uncommitted changes!"
		        echo "ACTION: Commit your changes"
# TODO: Make exiting optional and turn above error into warning if option set.
#		        exit 1;
	        fi


		    GIT_IGNORE_PATH=".git/info/exclude"
			if [ ! -d "$GIT_IGNORE_PATH/.." ]; then
				GIT_IGNORE_PATH=".gitignore"
			fi
		    BO_log "$VERBOSE" "Prepare git ignore rules file '$GIT_IGNORE_PATH' ..."
			# Ensure trailing newline
			# @source http://stackoverflow.com/a/16198793/330439
			[[ $(tail -c1 "$GIT_IGNORE_PATH") && -f "$GIT_IGNORE_PATH" ]] && echo '' >> "$GIT_IGNORE_PATH"
			if [ ! -f "$GIT_IGNORE_PATH" ]; then
				BO_log "$VERBOSE" "Create ignore file: $GIT_IGNORE_PATH"
				touch "$GIT_IGNORE_PATH"
			fi

			function ensureIgnoreRule {
				BO_log "$VERBOSE" "Ensuring ignore rule '$1' in ignore file: $GIT_IGNORE_PATH"
    			if ! grep -qe "^$1$" $GIT_IGNORE_PATH; then
    				BO_log "$VERBOSE" "Append '$1' to ignore file: $GIT_IGNORE_PATH"
    			    echo -e "$1" >> $GIT_IGNORE_PATH
    			fi
			}

			ensureIgnoreRule "/.c9/"
			ensureIgnoreRule "/.bash.origin.cache/"
			ensureIgnoreRule ".sm.*"
			ensureIgnoreRule ".rt/"
			ensureIgnoreRule "npm-debug.log"
			ensureIgnoreRule ".cache/"
			ensureIgnoreRule ".gitmodules.initialized"
			ensureIgnoreRule ".0"


			function copyFile {
    		    BO_log "$VERBOSE" "Copying file '$1' to '$2'"
    		    cp -f "$1" "$2"
			}
			function copyAndIgnoreFile {
				copyFile "$1" "$2"
    		    ensureIgnoreRule "/$2"
			}

		    BO_log "$VERBOSE" "Copying files ..."

			# TODO: Copy all files and do it based on declaration accross all nodes.
#		    copyAndIgnoreFile "$OUR_BASE_DIR/../Meta/Inception.0/Deployment/os.osx/tpl/contract.sh" "contract.sh"
#		    copyAndIgnoreFile "$OUR_BASE_DIR/../Meta/Inception.0/Deployment/os.osx/tpl/run.sh" "run.sh"


			# Ensure workspace and zero system is installed
			"$OUR_BASE_DIR/install.sh"

		popd > /dev/null

		BO_format "$VERBOSE" "FOOTER"
	}

	Expand $@
}
init $@