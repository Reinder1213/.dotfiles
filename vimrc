" Disables compatibility with vi which can cause unexpected issues.
set nocompatible

" Enables type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enables plugins and load plugin for the detected file type.
filetype plugin on
filetype plugin indent on

" Loads an indent file for the detected file type.
filetype indent on

" Turns on syntax highlighting
syntax on

" Adds line number to & numbers relative to current line
set number
set relativenumber

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" Ignores capital letters during search.
set ignorecase

" Overrides the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

augroup random
  autocmd BufRead,BufNewFile *.lexs set filetype=elixir
augroup END    

" COLORS AND STUFF ---------------------------------------------------- {{{

" Pmenu (CoC uses this as well)
func! s:my_colors_setup() abort
    hi Pmenu guibg=#d7e5dc gui=NONE
    hi PmenuSel guibg=#b7c7b7 gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858
endfunc

augroup colorscheme_coc_setup | au!
    au ColorScheme * call s:my_colors_setup()
augroup END

" }}}

" ALE SETUP ------------------------------------------------------------ {{{

" Optional, configure as-you-type completions
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1

let g:ale_linters = {}
let g:ale_linters.elixir = ['elixir-ls', 'credo']

let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_fixers.elixir = ['mix_format']

let g:ale_elixir_credo_strict = 1

let g:ale_elixir_elixir_ls_release = expand("~/Workspace/elixir-ls/rel")
let g:ale_elixir_elixir_ls_config = {'elixirLS': {'dialyzerEnabled': v:false}}

" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2

" }}}

" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

  Plug 'dense-analysis/ale'

  Plug 'preservim/nerdtree'

  Plug 'mhinz/vim-mix-format'
  let g:mix_format_on_save = 1

  Plug 'elixir-editors/vim-elixir'

  " Make sure FZF is also installed on your system
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'amiralies/coc-elixir', {'do': 'yarn install && yarn prepack'}

call plug#end()

" }}}

" MAPPINGS --------------------------------------------------------------- {{{

" Navigating panes (NERDTree navigation)
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Invokes FZF the same way VSCode does filesearch
map <c-p> :Files<CR>
 
" use <tab> for trigger completion (coc)  and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" }}}

" View documentation on the fly & Semantic code navigation
nnoremap dt :ALEGoToDefinition<cr>
nnoremap df :ALEFix<cr>
nnoremap K :ALEHover<cr>

let g:markdown_fenced_languages = ['html', 'vim', 'ruby', 'elixir', 'bash=sh', 'javascript']
