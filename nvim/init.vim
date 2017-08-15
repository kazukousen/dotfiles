" dein settings {{{
if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/plugins.toml'
let s:lazy_toml_file = fnamemodify(expand('<sfile>'), ':h').'/lazy.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file, {'lazy': 0})
  call dein#load_toml(s:lazy_toml_file, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

" }}}

inoremap <silent> jj <ESC>

syntax on
set t_Co=256
set termguicolors
set background=dark

" colorscheme material-theme
colorscheme solarized

set tabstop=2
set shiftwidth=2
set clipboard+=unnamedplus

tnoremap <silent> <ESC> <C-\><C-n>

nnoremap <silent><C-e> :NERDTreeToggle<CR>
nnoremap <silent><C-c> :closetab<CR>

" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" 自動的に閉じ括弧を入力
""""""""""""""""""""""""""""""
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

inoremap {<Enter> {}<Left><CR><Esc><S-o>
inoremap (<Enter> ()<Left><CR><Esc><S-o>
inoremap [<Enter> []<Left><CR><Esc><S-o>
nnoremap <Esc><Esc> :nohlsearch<CR>

augroup ftindent
  autocmd!
  autocmd BufNewFile,BufRead *.html,*.css,*.js,*.jsx,*.rb,*.sh,*.go setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup myXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

augroup myVue
	autocmd!
	autocmd BufNewFile,BufRead *.vue set filetype=html
augroup END

setlocal omnifunc=syntaxcomplete#Complete
