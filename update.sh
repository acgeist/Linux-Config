#!/bin/sh
cp ~/.vimrc .vimrc
cp ~/.bashrc .bashrc
cp ~/.tmux.conf .tmux.conf
cp /usr/local/share/vim/vim81/colors/acg_color.vim acg_color.vim
cp $HOME/.vim/.bp.c .bp.c
cp $HOME/.vim/.bp.sh .bp.sh
cp $HOME/.vim/.bp.md .bp.md
cp $HOME/.vim/python.txt python.txt
git add .
git commit -m "automated commit $(date +%Y%m%d)"
git push origin master
