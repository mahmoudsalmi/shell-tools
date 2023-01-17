#!/bin/sh

. "$HOME/.local/scripts/100-shell-tools-printer.sh"
. "$HOME/.local/scripts/101-shell-tools-files.sh"

# =========================== git
git_reset() {
	gsOrigin=$(pwd)
	gsRepo=${1:-/UNKOWN_PATH}
	
	printKV "[GIT] reset" $gsRepo
	moveTo $gsRepo > /dev/null

	git fetch
  git reset --hard
  git pull --prune --rebase
  git clean -fdx

	cd $gsOrigin
}
