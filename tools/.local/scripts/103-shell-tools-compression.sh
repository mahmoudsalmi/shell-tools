#!/bin/sh

. "$HOME/.local/scripts/100-shell-tools-printer.sh"
. "$HOME/.local/scripts/101-shell-tools-files.sh"

# =========================== compression
tarDir() {
	tarDirSrc=${1:-/UNKOWN_PATH}
	tarTarget=${2:-/UNKOWN_PATH}
	tarDirOrigin=$(pwd)
	
	printKV "Compress" "$tarDirSrc to $tarTarget"

	echo "$tarTarget"
	if [ $tarTarget != ${tarTarget%%.tar.gz}.tar.gz ]; then 
		exitError "[$tarTarget] invalid tarTarget file!" 5
	fi
	
	echo "$tarTarget"
	moveTo "$tarDirSrc" > /dev/null 
	tar zcvf $tarTarget ./* > /dev/null 2>&1 || exitError "[$tarTarget] tar error !" 100 #  \

	cd $tarDirOrigin
}

war2tar() {
	warFile=${1:-/UNKOWN_PATH}
	tarFile=${2:-/UNKOWN_PATH}
	w2tOrigin=$(pwd)
	
	printKV "Convert" "$warFile to $tarFile"

  if [ ! -f ${warFile%%.war}.war ]; then
		exitError "[$warFile] invalid war file!" 5
	fi

	if [ $tarFile != ${tarFile%%.tar.gz}.tar.gz ]; then
		exitError "[$tarFile] invalid tarFile file!" 5
	fi	

	if [ -f $tarFile ]; then
		exitError "[$tarFile] already exists!" 4
	fi	

	uuid="$(date '+%Y-%m-%d_%H-%M-%S')"
	w2tTmpDir=/tmp/lop_tmp_$uuid
	
	newDir $w2tTmpDir > /dev/null
	clearDir $w2tTmpDir > /dev/null 
	unzip "$warFile" -d $w2tTmpDir > /dev/null 2>&1 || exitError "[$warFile] unzip error !" 100
	tarDir $w2tTmpDir $tarFile > /dev/null 2>&1 || exit 6

	cd $w2tOrigin
	/bin/rm -rf $w2tTmpDir 
}

decompressTar() {
	tarToDecompress=${1:-/UNKOWN_PATH}
	decompressTarOrigin=$(pwd)
	
	printKV "Decompress" "$tarToDecompress"

  if [ ! -f ${tarToDecompress%%.tar.gz}.tar.gz ]; then
		exitError "[$tarToDecompress] invalid tarFile file!" 5
	fi

	tarFilename="$(basename $tarToDecompress)"
	tarTargetParent="$(dirname $tarToDecompress)"
	tarTargetName="${tarFilename%%.tar.gz}"
	
	tarTarget="$tarTargetParent/$tarTargetName"
	
	if [ -n "$2" ]; then
		tarTarget=$2
		if [ ! -d $tarTarget ]; then
			exitError "[$tarTarget] not a folder!" 5
		fi
	else
		if [ -d $tarTarget ]; then
			exitError "[$tarTarget] folder already exists!" 5
		fi
		newDir $tarTarget > /dev/null
	fi

	moveFile "$tarToDecompress" "$tarTarget/$tarFilename" > /dev/null
	moveTo $tarTarget > /dev/null

	tar zxvf $tarFilename > /dev/null 2>&1 || exitError "[$tarToDecompress] unTar error !" 100
	deleteFile $tarFilename > /dev/null

	cd $decompressTarOrigin
}

decompressWar() {
	warToDecompress=${1:-/UNKOWN_PATH}
	decompressWarOrigin=$(pwd)
	
	printKV "Decompress" "$warToDecompress"

  if [ ! -f ${warToDecompress%%.war}.war ]; then
		exitError "[$warToDecompress] invalid warFile file!" 5
	fi

	warFilename="$(basename $warToDecompress)"
	warTargetParent="$(dirname $warToDecompress)"
	warTargetName="${warFilename%%.war}"
	warTarget="$warTargetParent/$warTargetName"
  
	if [ -d $warTarget ]; then
		exitError "[$warTarget] folder already exists!" 5
	fi

	newDir $warTarget > /dev/null
	moveFile "$warToDecompress" "$warTarget/$warFilename" > /dev/null
	moveTo $warTarget > /dev/null

	unzip $warFilename > /dev/null 2>&1 || exitError "[$warToDecompress] unzip error !" 100
	deleteFile $warFilename > /dev/null

	cd $decompressWarOrigin
}

