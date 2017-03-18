#!/bin/bash
cp ~/.vimrc .vimrc
cp ~/.bashrc .bashrc
cp ~/.tmux.conf .tmux.conf
git add .
git commit -m "automated commit $(date +%Y%m%d)"
git push origin master
