" Andrew Geist's .vimrc file
"
" Last change: Wed 01 Nov 2017 09:04:00 AM EDT 
"
" To use it (on linux), copy it to:  ~/.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=1000	" how many lines of command line history to keep
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
"  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" Save backup/swap files to a specific directory vice wherever you're
" currently working. Reference:
" stackoverflow.com/questions/607435/why-does-vim-save-files-with-a-extension
set backupdir=~/Documents/Code/vimtmp,.
set directory=~/Documents/Code/vimtmp,.
set undodir=~/Documents/Code/vimtmp,.

" Disable bell. Reference:
" vim.wikia.com/wiki/Disable_beeping
set noerrorbells visualbell t_vb=
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif

" /usr/share/vim/vim74/colors/acg_color.vim
" New colorschemes can be created and downloaded at 
" bytefluent.com/vivify/index.php
colorscheme acg_color

" Use some kind of visual formatting to highligh lines that stretch past 80
" characters.  There are multiple ways to accomplish this, as seen below:
"
" Set color column, a visual reminder for good formatting. 
"set cc=80
"hi ColorColumn ctermbg=lightgrey guibg=lightgrey
" Alternatively, to highlight only characters that go over the line:
" Reference: vim.wikia.com/wiki/Highlight_long_lines 
" match ErrorMsg '\%80v.\+'
2mat ErrorMsg '\%81v.'

" Display line numbers
set number
set relativenumber
set numberwidth=2

" From https://learnxinyminutes.com/docs/vim
" Set indentation options
set tabstop=4
set softtabstop=4
set shiftwidth=4
" convert tabs to spaces
" set expandtab 
" enable tab 'intellisense'
set smarttab 

" Fold options:
set foldmethod=indent

" Set highlighting off by default
noh
set nohlsearch

"************************Status Line Stuff************************************
set laststatus=2
set statusline=	
set statusline+=%1*[Buffer\ %n]%*		" Buffer number
set statusline+=%2*[%t]%*				" File name
set statusline+=%3*%y%*					" File type
set statusline+=%4*%m%*					" File modified since last save flag
set statusline+=%=						" Left/right separator
set statusline+=%2*[C:%c]%*				" Column
set statusline+=%3*[L:%l/%L]%*			" Current line/total lines
set statusline+=%4*[char:\ 0x%2.2B]%*	" Hex value of current character

" To match these colors to colors from the current scheme,
" reference the current colorscheme, located in 
" /usr/share/vim/vim74/colors/ and use bytefluent.com/vivify
hi User1 ctermfg=124	ctermbg=235
hi User2 ctermfg=74		ctermbg=235
hi User3 ctermfg=70		ctermbg=235
hi User4 ctermfg=104	ctermbg=235

"*********************Personalized key maps***********************************
let mapleader = ","

imap jj <Esc>

" For adding a new 'paragraph' of code
nnoremap <leader><space> yy2p
" Save and close
nnoremap <leader>x ZZ
" Save (uses one less keystroke - worth it!)
nnoremap <leader>s :w<cr>
" Uses leader + movement vice Ctrl+W-->movement to change panes in split view.
" Reference:
" https://www.quora.com/How-do-I-switch-between-panes-in-split-mode-in-Vim
nnoremap <leader>k <C-w>k
nnoremap <leader>j <C-w>j
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l

" 'ev' = 'edit .vimrc'
nnoremap <leader>ev :split $MYVIMRC<cr>
" 'sv' = 'source .vimrc'
nnoremap <leader>sv :source $MYVIMRC<cr>

" F5 inserts current date/time.
" Reference: vim.wikia.com/wiki/Insert_current_date_or_time
nnoremap <F5> "=strftime(" %c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>

"                ***********Snippets************
" Reference: https://youtu.be/XA2WjJbmmoM?t=38m24s
" 
" .bp.[filetype] = "boilerplate"
"
" Basic C template.  
nnoremap <leader>c :-1read $HOME/.vim/.bp.c<CR>2jA<C-R>=strftime("%c")<CR><Esc>7Go
" 'df' = 'declare function'
nnoremap <leader>df 0mzyt{/#include<cr>No<cr><Esc>pa;<Esc>`z
" 'sc' = "save c"
nnoremap <leader>sc 0mz/Last Update:<cr>f:ld$a <C-R>=strftime ("%c")<CR><Esc>`zzz:w<cr> 
" Bash template
nnoremap <leader>sh :-1read $HOME/.vim/.bp.sh<CR>o
" Markdown wiki page template
nnoremap <leader>mdw :-1read $HOME/.vim/.bp.md<CR>7j$"=strftime(" %c")<CR>PGdd6k0fT
" When working with Markdown Wiki pages, this command (sw = "save wiki")
" updates the 'last updated' time at the bottom of the page before saving.
nnoremap <leader>sw maGf:2ld$"=strftime(" %c")<CR>P'a:w<cr>zz
" Modify the markdown wiki page template for K & R exercises.
nnoremap <leader>kr1 ggf(li../<Esc>$a  <Esc>o[C](../c.md)<Esc>jd4dyy2p:read !cat ~/Documents/Code/C/cBook/archive/1-
nnoremap <leader>kr2 /Exercise<CR>kdd03xi# <Esc>/#<CR>kddO```c<Esc>G2ki```<Esc>

nnoremap ,pe_clean /problem_content<cr>0bdgg/div><cr>F<i<cr><esc>dG:%s/<.\{-}>//g<cr>ggdd<C-v>GI * <Esc>O<Esc>0i/<Esc>Go<bs>/<cr>#include <stdio.h><cr><cr>int main(void){<cr>}<Esc>:w<cr>:noh<cr>O
"*********************Learning Vim the Hard way*********************************
iabbrev @@ acgeist@gmail.com
iabbrev ssig -- <cr>Andrew Geist <cr>acgeist@gmail.com
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
noremap <leader>' my0v$<esc>i'<esc>0i'<esc>`y
