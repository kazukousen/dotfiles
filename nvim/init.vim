syntax on
set t_Co=256
set autoindent
set smartindent " automatically insert appropriate indentation for each language
set expandtab " use space instead of tab
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,mac,dos
set softtabstop=4 " amout of space when pushed Tab key
set shiftwidth=4 " amount of space as indentation
" set cursorline
set number " show line numbers
" set showmode
" set showmatch
set title
set backspace=indent,eol,start
" set inccommand=split
" set imdisable
set hidden
set nobackup
set nowritebackup
set conceallevel=0
set display=lastline
set clipboard+=unnamedplus

inoremap <silent> jj <ESC>
tnoremap <silent> <C-n><C-n> <C-\><C-n>

"dein Scripts-----------------------------

let s:dein_dir = expand('$HOME/go/src/github.com/kazukousen/dotfiles/nvim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    call dein#load_toml(s:dein_dir . '/dein.toml', {'lazy': 0})
    call dein#load_toml(s:dein_dir . '/dein_lazy.toml', {'lazy': 1})
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" If the following mapping are not present, the desired Completion is not be inserted but instead the completion window opened by coc.nvim is closed.
" See https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-cr-to-confirm-completion
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

