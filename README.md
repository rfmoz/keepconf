keepconf
========

Keepconf is a agentless tool for backup and track files from remote hosts, using rsync and git for the purpose.


### Basic Installation and usage

Clone the repository or copy the installation script and execute it. Install all the python modules required with pip or with your preferred package manager:

        curl -k 'https://raw.githubusercontent.com/rfrail3/keepconf/master/keepconf-install.sh' > keepconf-install.sh
        bash keepconf-install.sh

For this guide, a ssh connection to localhost is enought, but normally, a ssh connection to remote hosts its required:

        ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
        cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

Test the connection, you need to login without password prompt (Accept with 'yes' the first attempt):

        ssh localhost

For this test, rsync user will be root, add the following line under the commented sync_user in "/etc/keepconf/keepconf.cfg":

        # sync_user = backup
        rsync_user = root

Initialize the folders and repository:

        keepconf -i

Make a simple file for backup some paths of the local host, take care of the tabs and spaces at the beginning of each line, dont add any of them:

        echo 'localhost' > /etc/keepconf/hosts/hosts.txt
        echo '/etc/resolv.conf' > /etc/keepconf/hosts/files.txt

Finally, launch the command and see the process:

        keepconf

Now, inside the destionation folder, there are all the files fetched:

        cd /var/keepconf/hosts/localhost

And a git repo tracking the files:

        git log


### More information

Please, read keepconf-manual.txt for a complete reference manual.
