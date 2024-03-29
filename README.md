keepconf
========

Keepconf is a agentless tool for backup and track files from remote hosts, using rsync and git for the purpose.
Indeed, it can:
  - Process lists of files/folders for retrieve it from hosts
  - Limit size of the files fetched
  - Store content in different defined directories
  - Trigger hooks for execute whatever after/before fetching/committing
  - Use a local or remote git repository
  - Report the final status for monitoring the results in csv format


### Basic Installation and usage

Clone the repository or copy the installation script and execute it. Install all the python modules required with pip or with your preferred package manager:

        curl -k 'https://raw.githubusercontent.com/rfmoz/keepconf/master/keepconf-install.sh' > keepconf-install.sh
        bash keepconf-install.sh

For this guide, a ssh connection to localhost is enought, but normally, a ssh connection to remote hosts its required:

        ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
        cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

Test the connection, you need to login without password prompt (Accept with 'yes' the first attempt):

        ssh localhost

For this test, rsync user will be root, add the following line under the commented sync_user in "/etc/keepconf/keepconf.cfg":

        # sync_user = backup
        rsync_user = root

Run it.
Some sample files are located inside "/etc/keepconf/hosts" and "/etc/keepconf/files" for backup all "/etc/*" content in "localhost" plus some commented examples.

        keepconf

Now, inside the destionation folder, there are all the files fetched and the git repo:

        cd /var/keepconf/hosts/localhost && ls
        git log


### More information

Please, read keepconf-manual.txt for a complete reference manual.
