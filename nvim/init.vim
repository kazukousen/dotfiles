syntax on
set t_Co=256
set autoindent
set smartindent " automatically insert appropriate indentation for each language
set expandtab " use space instead of tab
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,utf-8,ucs-2,cp932,sjis
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
" set hidden
set nobackup
set nowritebackup
set conceallevel=0

inoremap <silent> jj <ESC>

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
"
call plug#('Shougo/ddc.vim')
call plug#('vim-denops/denops.vim')
call plug#('Shougo/pum.vim')
call plug#('Shougo/ddc-around')
call plug#('LumaKernel/ddc-file')
call plug#('Shougo/ddc-matcher_head')
call plug#('Shougo/ddc-sorter_rank')
call plug#('Shougo/ddc-converter_remove_overlap')
call plug#('prabirshrestha/vim-lsp')
call plug#('mattn/vim-lsp-settings')


call ddc#custom#patch_global('completionMenu', 'pum.vim')
call ddc#custom#patch_global('sources', [
 \ 'around',
 \ 'vim-lsp',
 \ 'file'
 \ ])
call ddc#custom#patch_global('sourceOptions', {
 \ '_': {
 \   'matchers': ['matcher_head'],
 \   'sorters': ['sorter_rank'],
 \   'converters': ['converter_remove_overlap'],
 \ },
 \ 'around': {'mark': 'Around'},
 \ 'vim-lsp': {
 \   'mark': 'LSP', 
 \   'matchers': ['matcher_head'],
 \   'forceCompletionPattern': '\.|:|->|"\w+/*'
 \ },
 \ 'file': {
 \   'mark': 'file',
 \   'isVolatile': v:true, 
 \   'forceCompletionPattern': '\S/\S*'
 \ }})
call ddc#enable()

inoremap <Tab> <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>

