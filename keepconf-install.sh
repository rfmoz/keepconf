#!/bin/bash

#
# Keepconf installation script
# v.1.1
#

git --version &> /dev/null
if [ $? -ne 0 ]; then
	echo "ERROR: \"git\" command not available"
	echo "Please, install it"; exit 1
fi

rsync --version &> /dev/null
if [ $? -ne 0 ]; then
	echo "ERROR: \"rsync\" command not available"
	echo "Please, install it"; exit 1
fi

file /dev/null &> /dev/null  # For 01-remove-binary script
if [ $? -ne 0 ]; then
	echo "ERROR: \"file\" command not available"
	echo "Please, install it"; exit 1
fi

pyver=`python --version 2>&1 /dev/null`
if [ $? -ne 0 ]; then
	echo "ERROR: Python not available"
	echo "Please, install version 2.7"; exit 1
else
	pynum=`echo ${pyver} | tr -d '.''' | grep -Eo  '[0-9]*' | cut -c 1-2`
	if [ $pynum -ne 27 ] ; then
		echo "ERROR: Its needed Python version 2.7, not ${pyver}"
		echo "Please, upgrade it."; exit 1
	else
                echo '##########################################################################################'
		echo "Please, ensure that this Python modules are available in the local system:"
		echo "sys optparse os glob time string re ConfigParser tempfile subprocess distutils collections"
                echo '##########################################################################################'
	fi
fi

F_TMP1=`mktemp -d`
D_CNF='/etc/keepconf'
D_BIN='/usr/bin'

echo "Keepconf installation script"
echo ""

echo "Clonning repository..."
git clone https://github.com/rfrail3/keepconf.git ${F_TMP1}

echo "Creating paths..."
mkdir -p ${D_CNF}/hosts
mkdir ${D_CNF}/pre-get.d
mkdir ${D_CNF}/post-get.d
mkdir ${D_CNF}/pre-commit.d
mkdir ${D_CNF}/post-commit.d

echo "Copying files..."
cp -a ${F_TMP1}/src/* ${D_CNF}/
mv ${D_CNF}/keepconf ${D_BIN}/keepconf
chmod 744 ${D_BIN}/keepconf
rm -f ${D_CNF}/pre-get.d/*.txt
rm -f ${D_CNF}/post-get.d/*.txt
rm -f ${D_CNF}/pre-commit.d/*.txt
rm -f ${D_CNF}/post-commit.d/*.txt

cd ${D_CNF} && ls

echo "Instalation Complete, configure as your needs"
echo "Don't forget an entry line in cron for schedule the process"
echo "Enjoy!"
