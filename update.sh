#!/bin/bash
cp ~/.vimrc .vimrc
cp ~/.bashrc .bashrc
cp ~/.tmux.conf .tmux.conf
cp /usr/share/vim/vim74/colors/acg_color.vim acg_color.vim
git add .
git commit -m "automated commit $(date +%Y%m%d)"
git push origin master
