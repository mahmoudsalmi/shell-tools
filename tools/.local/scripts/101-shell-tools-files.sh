#!/bin/sh

. "$HOME/.local/scripts/100-shell-tools-printer.sh"

# =========================== IO manipulation
moveTo() {
	moveToTarget=${1:-/UNKOWN_PATH}
	printKV "Move to" $moveToTarget
	cd $moveToTarget || exitError "[$moveToTarget] not found or inaccessible!" 5
}

newDir() {
	newDirTarget=${1:-/UNKOWN_PATH}
	printKV "Create" $newDirTarget
	mkdir -p $newDirTarget || exitError "[$newDirTarget] Impossible to create!" 6
}

deleteDir() {
	deleteDirTarget=${1:-/UNKOWN_PATH}
	printKV "Delete" "$deleteDirTarget"
	/bin/rm -rf "$deleteDirTarget" || exitError "[$deleteDirTarget] Impossible to delete!" 6
}

deleteFile() {
	deleteFileTarget=${1:-/UNKOWN_PATH}
	printKV "Delete" "$deleteFileTarget"
	/bin/rm -f "$deleteFileTarget" || exitError "[$deleteFileTarget] Impossible to delete!" 6
}

clearDir() {
	clearDirTarget=${1:-/UNKOWN_PATH}
	printKV "Clear" "$clearDirTarget/*"
	/bin/rm -rf "${clearDirTarget:-/UNKOWN_PATH}"/* || exitError "[$clearDirTarget] Impossible to clear!" 6
}

moveFile() {
	moveSrc=${1:-/UNKOWN_PATH}
	moveTarget=${2:-/UNKOWN_PATH}
	printKV "Move" "$moveSrc to $moveTarget"
	mv "$moveSrc" "$moveTarget" || exitError "[$moveSrc -> $moveTarget] Impossible to move!" 6
}

copyFile() {
	copySrc=${1:-/UNKOWN_PATH}
	copyTarget=${2:-/UNKOWN_PATH}
	printKV "Copy" "$copySrc to $copyTarget"
	cp -f "$copySrc" "$copyTarget" || exitError "[$copySrc -> $copyTarget] Impossible to copy!" 6
}

