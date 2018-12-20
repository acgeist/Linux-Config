sudo apt update
sudo apt upgrade
sudo apt autoremove
sudo apt install make gcclibncurses5-dev libncursesw5-dev apache2 php libapache2-mod-php php-mysql
sudo apt install build-essential # to install the C compiler
# TODO: make this an if statement - no need to do anything if v8 already exists
sudo apt remove vim
cd ~
git clone https://github.com/vim/vim.git
cd vim/src
make
sudo make install
make clean
hash -r
cd ~
mv .bashrc .bashrc_default
wget https://raw.githubusercontent.com/acgeist/Linux-Config/master/.bashrc
wget https://raw.githubusercontent.com/acgeist/Linux-Config/master/.tmux.conf
wget https://raw.githubusercontent.com/acgeist/Linux-Config/master/.vimrc
cd /usr/local/share/vim/vim81/colors
sudo wget https://raw.githubusercontent.com/acgeist/Linux-Config/master/acg_color.vim
cd ~
sudo service apache2 start
echo "<?php phpinfo(); ?>" > /var/www/html/php-test.php
# TODO: add awk commands to configure apache2
# change DocumentRoot in /etc/apache2/sites-available/000-default.conf to /srv/www
# add following line to /etc/apache2/apache2.conf: DirectoryIndex index.php index.html
