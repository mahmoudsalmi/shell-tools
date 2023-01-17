#!/bin/sh

# =========================== styles
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

# =========================== Printers
exitError() {
	printf "\n❌ ${RED}${BRIGHT}[ERROR] ${1:-ERROR FATAL !}\n${NORMAL}" >&2
	exit ${2:-5}
}

printH1() {
	printf "${BLUE}${BRIGHT}\n\n########### $1 ###########\n\n${NORMAL}"
}

printKV() {
	printf "${POWDER_BLUE}#===== $1 ${BRIGHT}[$2]\n${NORMAL}"
}

printTitle() {
	lineC="-"
	decoL="#------------"	
	decoR="------------#"	

	title=${1:-NO_TITLE}
	titleLen=${#title}

	printf "${CYAN}\n%s%s" ${decoL} ${lineC}
	for ((i=0; i<${#title}; i=i+1)); do printf "%s" ${lineC}; done 
	printf "%s%s" ${lineC} ${decoR}
	
	printf "\n$decoL ${title} $decoR" 
	
	printf "\n%s%s" ${decoL} ${lineC}
	for ((i=0; i<${#title}; i=i+1)); do printf "%s" ${lineC}; done 
	printf "%s%s\n\n${NORMAL}" ${lineC} ${decoR}
}

printDone() {
	printf "\n✅ ${GREEN}${BRIGHT}[DONE] ${1:- }\n${NORMAL}"
}
