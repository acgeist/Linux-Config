#!/bin/sh
cp ~/.vimrc .vimrc
cp ~/.bashrc .bashrc
cp ~/.tmux.conf .tmux.conf
cp $VIMRUNTIME/colors/acg_color.vim acg_color.vim
cp $HOME/.vim/.bp.c .bp.c
cp $HOME/.vim/.bp.sh .bp.sh
git add .
git commit -m "automated commit $(date +%Y%m%d)"
git push origin master
