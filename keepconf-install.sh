#!/bin/bash

#
# Keepconf installation script
# v.1.2
#

# Destination dir for configuration
D_CNF='/etc/keepconf'

# Destination dir for executable file
D_BIN='/usr/bin'


# Test if git is installed
git --version &> /dev/null
if [ $? -ne 0 ]; then
	echo "ERROR: \"git\" command not available"
	echo "Please, install it"; exit 1
fi

# Test if rsync is installed
rsync --version &> /dev/null
if [ $? -ne 0 ]; then
	echo "ERROR: \"rsync\" command not available"
	echo "Please, install it"; exit 1
fi

# Test if file is installed
file /dev/null &> /dev/null  # For 01-remove-binary script
if [ $? -ne 0 ]; then
	echo "ERROR: \"file\" command not available"
	echo "Please, install it"; exit 1
fi

# Test if python is installed
pyver=`python3 --version 2>&1 /dev/null`
if [ $? -ne 0 ]; then
	echo "ERROR: Python not available"
	echo "Please, install version 3"; exit 1
else
	# Test if version 3 of python is installed
	pynum=`echo ${pyver} | tr -d '.''' | grep -Eo  '[0-9]*' | head -1 | cut -c 1-2`
	if [ $pynum -lt 30 ] ; then
		echo "ERROR: Its needed Python version 3, not ${pyver}"
		exit 1
	else
                # Test if all modules needed are available
                pymod=`python3 -c "import sys, optparse, os, glob, time, string, re, tempfile, logging, configparser, subprocess, distutils"`
                if [ $? -ne 0 ]; then
                        echo "ERROR: Please, ensure that these Python modules are available in the local system:"
                        echo "sys, optparse, os, glob, time, string, re, tempfile, logging, configparser, subprocess, distutils"
                fi
	fi
fi

# Temporary dir for clone repo into it
F_TMP1=`mktemp -d`

echo "Keepconf installation script"
echo ""

echo "Clonning repository..."
git clone https://github.com/rfrail3/keepconf.git ${F_TMP1}

echo "Creating paths..."
mkdir ${D_CNF}
mkdir ${D_CNF}/hosts
mkdir ${D_CNF}/files
mkdir ${D_CNF}/pre-get.d
mkdir ${D_CNF}/post-get.d
mkdir ${D_CNF}/pre-commit.d
mkdir ${D_CNF}/post-commit.d

echo "Copying files..."
cp ${F_TMP1}/src/keepconf ${D_BIN}/keepconf
cp ${F_TMP1}/src/keepconf.cfg ${D_CNF}/
cp -r ${F_TMP1}/src/post-get.d/* ${D_CNF}/post-get.d/
cp -r ${F_TMP1}/src/hosts/* ${D_CNF}/hosts/
cp -r ${F_TMP1}/src/files/* ${D_CNF}/files/
chmod 744 ${D_CNF}/post-get.d/*
chmod 744 ${D_BIN}/keepconf

cd ${D_CNF} && ls

echo "Instalation Complete, configure as your needs"
echo "Don't forget an entry line in cron for schedule the process"
echo "Enjoy!"
