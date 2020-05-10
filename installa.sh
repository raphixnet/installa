#!/bin/bash

# [INFO] #####################################################################
# Repo:		https://github.com/raphixnet/installa.git
# Arg1:		...                                                                                           
# Developer:	Raphix                                                
# EMail:	raphix(at)geekmail.de                                           
# [COMMENTS] #################################################################
# (0)		Only users with $UID 0 have root privileges.
# (1)		Non-root exit error.
# (2)		exit if the user is no root or sudo => run script only as root
# (3)		-ne means not equal: 
#		https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html
##############################################################################

ROOT_UID=0 # (0)
E_NOTROOT=87 # (1)
SUCCESS=0
CFG_DIR=cfg/
ROUTINES=()
ROUTINEARG=$1

if [ "$UID" -ne "$ROOT_UID" ] # (3)
then
  echo "Must be root to run this script."
  exit $E_NOTROOT
fi

while IFS= read -r line || [[ "$line" ]]; do
  ROUTINES+=("$line")
done < ${CFG_DIR}routines.cfg

function getCommand() {
  declare -a hash=("${!1}")
  REQROUTINE="$2"
  for routine in "${hash[@]}"; do
    set -f
    stringtmp=${routine// /<s>}
    array=(${stringtmp//:/ })
    if [ "${array[0]}" = "$REQROUTINE" ]
    then
      echo "${array[1]//<s>/ }"
    fi
  done
}

function routine() {
  eval $(getCommand ROUTINES[@] $1)
}

routine $ROUTINEARG

exit $SUCCESS
