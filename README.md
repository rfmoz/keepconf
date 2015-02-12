keepconf
========

Keepconf is a agentless tool for backup and track files from remote hosts. It uses rsync and git for the purpose and was inspired in etckeeper.


### Basic Installation and usage

Clone the repository or copy the installation script and execute it. Install all the python modules required with pip or with your preferred package manager:

        git clone https://github.com/rfrail3/keepconf.git
        cd keepconf
        bash keepconf-install.sh

For this guide, a ssh connection to localhost is enought, but normally, a ssh connection to remote hosts its required:

        ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
        cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

Test the connection, you need to login without password prompt:

        ssh localhost

Initialize the folders and repository:

        keepconf -i

Make a simple file for backup some paths of the local host:

        cat << END >> /etc/keepconf/hosts/localhost.cfg
        [Main]
        Directory=myhost/
        [Hosts]
        localhost
        [Files]
        /etc/
        !/etc/passwd
        !/etc/group
        !/etc/shadow
        /proc/sys/kernel/*
        END

Finally, launch the command and see the process:

        keepconf

Now, inside the destionation folder, there are all the files fetched:

        cd /var/keepconf/hosts/myhost/localhost

And a git repo tracking the files:

        git log

