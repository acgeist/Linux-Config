" Andrew Geist's .vimrc file
"
" Last update: Wed Dec  5 12:16:36 2018 

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

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " vim.wikia.com/wiki/Dictionary_completions
  au FileType * execute 'setlocal dict+=~/.vim/'.&filetype.'.txt'

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

" Save backup/swap files to a specific directory vice wherever you're
" currently working. Reference:
" stackoverflow.com/questions/607435/why-does-vim-save-files-with-a-extension
" medium.com/@Aenon/vim-swap-backup-undo-git-2bf353caa02f
set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//

" Disable bell. Reference:
" vim.wikia.com/wiki/Disable_beeping
set noerrorbells visualbell t_vb=
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif

" /usr/share/vim/vim74/colors/acg_color.vim
" /usr/local/share/vim/vim81/colors/acg_color.vim
" New colorschemes can be created and downloaded at 
" bytefluent.com/vivify/index.php
colorscheme acg_color

" Use some kind of visual formatting to highligh lines that stretch past 80
" characters.  There are multiple ways to accomplish this, as seen below:
" Reference: vim.wikia.com/wiki/Highlight_long_lines 
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
set expandtab 
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
set statusline+=%2*[%t]%*				" File name
set statusline+=%3*%y%*					" File type
set statusline+=%4*%m%*					" File modified since last save flag
set statusline+=%=						" Left/right separator
set statusline+=%2*[C:%c]%*				" Column
set statusline+=%3*[L:%l/%L]%*			" Current line/total lines

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
nnoremap <leader>q :q!<cr>
" Uses leader + movement vice Ctrl+W-->movement to change panes in split view.
" Reference:
" https://www.quora.com/How-do-I-switch-between-panes-in-split-mode-in-Vim
nnoremap <leader>k <C-w>k
nnoremap <leader>j <C-w>j
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l

nnoremap H Hzz
nnoremap L Lzz

" 'ev' = 'edit .vimrc'
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
" 'sv' = 'source .vimrc'
nnoremap <leader>sv :source $MYVIMRC<cr>

" 'da' = 'delete all'
nnoremap <leader>da ggdG

" F5 inserts current date/time.
" Reference: vim.wikia.com/wiki/Insert_current_date_or_time
nnoremap <F5> "=strftime(" %c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>

"Use TAB to complete when typing words, else inserts TABs as usual.
function! Tab_Or_Complete()
	if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
		return "\<C-N>"
	else
		return "\<Tab>"
	endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

"                ***********Snippets************
" Reference: https://youtu.be/XA2WjJbmmoM?t=38m24s
" 
" .bp.[filetype] = "boilerplate"
"
" Basic C template.  
nnoremap <leader>c :-1read $HOME/.vim/.bp.c<CR>2jA<C-R>=strftime("%c")<CR><Esc>/main(<CR>0mmo
" 'df' = 'declare function'
nnoremap <leader>df 0mzyf)/main(<cr>kO<Esc>pa;<Esc>`z
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
