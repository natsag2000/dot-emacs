#!/bin/sh

# This script installs all modules listed in the "modelist" file.
# To use, just edit the list and run it.

# Variables
# ---------
#BASEFOLDER="/tmp/elisp" # for test
#DOTEMACSPATH="/tmp"     # for test
BASEFOLDER="$HOME/elisp"
DOTEMACSPATH="$HOME"
MODELST="./config/modelisttest"
MAKEFILE="./Makefile.in"
OS=$(uname)

#DATEFMT=`date '+%y_%m_%y_%H_%M_%S'`

# Check OS
# --------
if [ x$OS = xLinux ]; then
    MAKECMD=make
fi

if [ x$OS = xFreeBSD ]; then
    MAKECMD=gmake
fi

if [ x$OS = x ]; then
    echo "ERROR: The OS is neither Linux and FreeBSD!"
    exit 1
fi

# Check Modelist
# --------------
if [ ! -f $MODELST ]; then
    echo "ERROR: The file \"$MODELST\" is not found!!"
    exit 1
fi

# Check Makefile
# --------------
if [ ! -f $MAKEFILE ]; then
    echo "ERROR: The file \"$MAKEFILE\" is not found!!"
    exit 1
fi

# Check tools
# -----------
for chtool in wget svn
do
    result=$(which $chtool)
    if [ x$result = x ]; then
        echo "ERROR: $chtool is not installed!!"
        exit 1
    fi
    echo $chtool " is   FOUND"
done

# Install modes from list file
# ----------------------------
#cat $MODELST | grep -v "[*]" | grep -v '^$' | grep -v '^#' | cut -d" " -f1
echo $MAKECMD
for F in `cat $MODELST | grep -v "[*]" | grep -v '^$' | grep -v '^#' | cut -d" " -f1`
do
    $MAKECMD $F -f $MAKEFILE BASEDIR=$BASEFOLDER
done

#cat $MODELST | grep -v "[*]" | grep -v '^$' | grep -v '^#' | cut -d" " -f1 | xargs "$MAKECMD" -I '{}' "-f $MAKEFILE" BASEDIR="$BASEFOLDER"

# copy elisp files
cp elisp/* $BASEFOLDER


# create bin dir
if [ ! -d $BASEFOLDER/bin ]
then
    mkdir $BASEFOLDER/bin
fi

# for erlang development
echo "#!$HOME/erlang/current/bin/escript" > $BASEFOLDER/bin/eflymake
echo "" >> $BASEFOLDER/bin/eflymake
cat templates/eflymake_tail >> $BASEFOLDER/bin/eflymake && chmod +x $BASEFOLDER/bin/eflymake

sed "s_ELISPHOME_$BASEFOLDER/_" dot-emacs > $DOTEMACSPATH/.emacs
