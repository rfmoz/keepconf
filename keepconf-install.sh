#!/bin/bash

#
# Keepconf installation script
# v.1.0
#

git --version &> /dev/null
if [ $? -ne 0 ]; then
	echo "ERROR: Git command not available"
	echo "Please, install it"; exit 1
fi

rsync --version &> /dev/null
if [ $? -ne 0 ]; then
	echo "ERROR: Rsync command not available"
	echo "Please, install it"; exit 1
fi

file --version &> /dev/null
if [ $? -ne 0 ]; then
	echo "ERROR: File command not available"
	echo "Please, install it"; exit 1
fi

pyver=`python --version 2>&1 /dev/null`
if [ $? -ne 0 ]; then
	echo "ERROR: Python not available"
	echo "Please, install it"; exit 1
else
	pynum=`echo ${pyver} | cut -d' ' -f 2 | cut -c-3`
	pyresult=`echo "$pynum > 2.6" | bc -l`
	if [ $pyresult -eq 0 ] ; then
		echo "ERROR: Python version ${pynum} is lower than 2.7"
		echo "Please, upgrade it."; exit 1
	else
		echo "Please, ensure that this Python modules are available in the local system:"
		echo "sys optparse os glob time time string re ConfigParser tempfile subprocess distutils collections"
	fi
fi

F_TMP1=`mktemp -d`
D_CNF='/etc/keepconf'
D_BIN='/usr/bin'

echo "Clonning repository..."
git clone https://github.com/rfrail3/keepconf.git ${F_TMP1}

echo "Creating paths..."
mkdir -p ${D_CNF}/hosts/grp
mkdir ${D_CNF}/pre-get.d
mkdir ${D_CNF}/post-get.d
mkdir ${D_CNF}/pre-commit.d
mkdir ${D_CNF}/post-commit.d

echo "Copying files..."
cp ${F_TMP1}/latest/keepconf ${D_BIN}/keepconf
chmod 644 ${D_BIN}/keepconf
cp ${F_TMP1}/latest/keepconf.cfg ${D_CNF}/
cp ${F_TMP1}/latest/pre-get.d/* ${D_CNF}/pre-get.d/
cp ${F_TMP1}/latest/post-get.d/* ${D_CNF}/post-get.d/
cp ${F_TMP1}/latest/pre-commit.d/* ${D_CNF}/pre-commit.d/
cp ${F_TMP1}/latest/post-commit.d/* ${D_CNF}/post-commit.d/
cp ${F_TMP1}/latest/hosts/* ${D_CNF}/hosts/
cp ${F_TMP1}/latest/hosts/grp/* ${D_CNF}/hosts/grp/

cd ${D_CNF} && ls

echo "Instalation Complete, configure as your needs"
echo "Don't forget a entry line in cron for schedule the process"
echo "Enjoy!"
