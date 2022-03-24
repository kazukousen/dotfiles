call ddc#custom#patch_global('completionMenu', 'pum.vim')
call ddc#custom#patch_global('sources', [
  \ 'file', 'nvim-lsp', 'vsnip'
  \ ])
call ddc#custom#patch_global('sourceOptions', {
  \ '_': {
  \   'matchers': ['matcher_head'],
  \   'sorters': ['sorter_rank'],
  \   'converters': ['converter_remove_overlap'],
  \ },
  \ 'nvim-lsp': {
  \   'mark': 'LSP',
  \ 'forceCompletionPattern': '\.\w*|:\w*|->\w*',
  \ },
  \ 'file': {
  \   'mark': 'file',
  \   'isVolatile': v:true, 
  \   'forceCompletionPattern': '\S/\S*'
  \ }})

 inoremap <silent><expr> <TAB>
      \ ddc#map#pum_visible() ? '<C-n>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '<TAB>' : ddc#map#manual_complete()
 inoremap <expr><S-TAB>  ddc#map#pum_visible() ? '<C-p>' : '<C-h>'

call ddc#enable()

