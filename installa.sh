#!/bin/bash

# [INFO] #####################################################################
# https://bitbucket.org/raphix-platform/installa/src                                                                               
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

if [ "$UID" -ne "$ROOT_UID" ] # (3)
then
  echo "Must be root to run this script."
  exit $E_NOTROOT
fi

while IFS= read -r line || [[ "$line" ]]; do
  ROUTINES+=("$line")
done < ${CFG_DIR}routines.cfg

echo ${ROUTINES[@]}

exit $SUCCESS
