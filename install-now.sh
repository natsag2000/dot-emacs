#!/bin/sh

# This script installs all modules listed in the "modelist" file.
# To use, just edit the list and run it.

# Variables
# ---------
MODELST="./config/modelist"
MAKEFILE="./Makefile.in"
OS=$(uname)


# Check OS
# --------
if [ x$OS = xLinux ]; then
    MAKECMD=make
fi

if [ x$OS = xFreeBSD ]; then
    MAKCMD=gmake
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
cat $MODELST | grep -v "[*]" | grep -v '^$' | grep -v '^#' | cut -d" " -f1 | xargs $MAKECMD -I {} -f $MAKEFILE
