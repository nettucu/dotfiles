" vim: set fdm=marker foldlevel=0 nomodeline ts=2 sw=2 expandtab:

" Start - really ? {{{
let mapleader=','
let leader=','
" }}}

" Plugins (vim-plug) {{{
" https://github.com/junegunn/vim-plug
if has('nvim')
    call plug#begin(stdpath('data') . '/plugged')
else
    call plug#begin('~/.local/share/nvim/plugged')
endif

Plug 'mhinz/vim-startify' " {{{
let g:startify_custom_header = []
let g:startify_change_to_dir = 0
" }}}

""" Some sane defaults
Plug 'tpope/vim-sensible'

""" Appearance
Plug 'altercation/vim-colors-solarized'
Plug 'overcache/NeoSolarized'
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim'

""" Git
Plug 'tpope/vim-fugitive'

"Plug 'junegunn/fzf' not needed because fzf is installed at os level
Plug 'junegunn/fzf.vim'

Plug 'easymotion/vim-easymotion' " {{{
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1  " Turn on case insensitive feature
let g:EasyMotion_startofline = 0    " keep cursor column when JK motion
nmap s <Plug>(easymotion-s)
" JK motions: Line motions
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
" }}}

""" Database
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-completion'

""" Completion
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
Plug 'zchee/deoplete-clang' " {{{ C/C++ completion using clang
let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header='/usr/lib/clang'
" }}}
Plug 'ervandew/supertab'

Plug 'scrooloose/syntastic' " {{{

" }}}

Plug 'haya14busa/incsearch.vim' " {{{
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" }}}

Plug 'SirVer/ultisnips' " {{{ Snippets
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<C-x>"
" }}}

call plug#end()
" }}}

" General Settings {{{
" some sensible settings already handled by vim-sensible plugin
set t_Co=256
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set history=10000
set number
set relativenumber

" HTML, XML
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
" }}}

" Appearance {{{
syntax enable
let g:lightline = {
    \ 'colorscheme' : 'solarized',
    \ 'active': {
    \   'left': [
    \       [ 'mode', 'paste' ],
    \       [ 'gitbranch', 'readonly', 'filename', 'modified', 'charvaluehex' ]
    \   ],
    \   'right': [
    \       [ 'lineinfo'],
    \       [ 'precent' ],
    \       [ 'fileformat', 'fileencoding', 'filetype', 'syntastic' ]
    \   ]
    \ },
    \ 'component' : {
    \   'charvaluehex' : '0x%B'
    \ },
    \ 'component_function' : {
    \   'gitbranch': 'FugitiveHead'
    \ },
    \ 'component_expand' : {
    \    'syntastic' : 'SyntasticStatuslineFlag',
    \ },
    \ 'component_type' : {
    \    'syntastic' : 'middle',
    \ }
    \ }
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline

function! s:syntastic()
    SyntasticCheck
    call lightline#update()
endfunction

if has('gui_running')
    set background=light
else
    set background=dark
end
let g:solarized_termcolors=256
" colorscheme solarized

" gruvbox specific in case colorscheme is changed
let g:gruvbox_contrast_dark = 'soft'

" seoul256 specific
let g:seoul256_background=235
colorscheme seoul256
" }}}

" {{{ Plugins configuration
""" fzf-vim
let g:fzf_command_prefix = 'Fzf'

function! s:find_git_root()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

" If in git repo, go to root of repo and use fzf there
command! ProjectFiles execute 'Files' s:find_git_root()

nnoremap <C-p> :FzfFiles<CR>
nnoremap <silent> <leader>b :FzfBuffers<CR>
nnoremap <silent> <leader>m :FzfHistory<CR>
nnoremap <silent> <leader>; :FzfBLines<CR>
nnoremap <silent> <leader>. :FzfLines<CR>

" Better command history with q:
command! CmdHist call fzf#vim#command_history({'right': '40'})
nnoremap q: :CmdHist<CR>

" Better search history
command! QHist call fzf#vim#search_history({'right': '40'})
nnoremap q/ :QHist<CR>
" }}}

