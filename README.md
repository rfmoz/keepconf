keepconf
========

Keepconf is a agentless tool for backup and track files from remote hosts. It uses rsync and git for the purpose and was inspired in etckeeper and changeconf.

Basic Installation
==================

# git clone https://github.com/rfrail3/keepconf.git
# cd keepconf
# bash keepconf-install.sh
###############################################################################################
Please, ensure that this Python modules are available in the local system:
sys optparse os glob time time string re ConfigParser tempfile subprocess distutils collections
###############################################################################################
Clonning repository...
Cloning into /tmp/tmp.YyY1urCb7C...
remote: Counting objects: 107, done.
remote: Compressing objects: 100% (18/18), done.
remote: Total 107 (delta 7), reused 0 (delta 0)
Receiving objects: 100% (107/107), 37.61 KiB, done.
Resolving deltas: 100% (36/36), done.
Creating paths...
Copying files...
hosts  keepconf.cfg  post-commit.d  post-get.d	pre-commit.d  pre-get.d
Instalation Complete, configure as your needs
Don't forget a entry line in cron for schedule the process
Enjoy!


