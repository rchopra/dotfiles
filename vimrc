" Started from PeepCode basic configuration and tweaked from there

call plug#begin('~/.vim/plugged')
Plug 'elmcast/elm-vim'
Plug 'pgr0ss/vimux-ruby-test'
Plug 'guns/vim-clojure-static'
call plug#end()

" First, get pathogen set up
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

set nocompatible                  " Must come first because it changes other options.

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Absolute line number on current line.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set tabstop=4                    " Global tab width.
set shiftwidth=4                 " And again, related.
set expandtab                    " Use spaces instead of tabs

let mapleader=" "
" Filetypes that require only two spaces for tabs
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType eruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

" Lightline config
set noshowmode
let g:lightline = {
  \ 'colorscheme': 'Tomorrow_Night',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head'
  \ },
  \ }

" Tmuxline config
let g:tmuxline_powerline_separators = 0

" Set color scheme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" Fast saving
nnoremap <leader>w :w!<cr>
" inoremap jj <esc>:w!<cr>

" Tab mappings.
" map <leader>tt :tabnew<cr>
" map <leader>te :tabedit
" map <leader>tc :tabclose<cr>
" map <leader>to :tabonly<cr>
" map <leader>tn :tabnext<cr>
" map <leader>tp :tabprevious<cr>
" map <leader>tf :tabfirst<cr>
" map <leader>tl :tablast<cr>
" map <leader>tm :tabmove

" NERDTree
nnoremap <leader>nt :NERDTree<cr>

" Split navigation
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>

"Remove all trailing whitespace by pressing <leader>cw
nnoremap <leader>cw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Turn off search highlighting
nnoremap <silent> <leader>nh :noh<cr>

set splitbelow
set splitright

" Vim Hard Time Settings
let g:hardtime_default_on = 0

" FZF
set rtp+=/usr/local/opt/fzf
imap <c-x><c-o> <plug>(fzf-complete-line)
map <leader>b :Buffers<cr>
map <leader>f :Files<cr>
map <leader>g :GFiles<cr>
map <leader>t :Tags<cr>

" vim-jsx
let g:jsx_ext_required = 0  " Use JSX syntax highlighting on file extensions with .js

" Vimux
map <leader>rf :RunRubyFocusedTest<CR>
map <leader>rc :RunRubyFocusedContext<CR>
map <leader>rb :RunAllRubyTests<CR>
map <leader>rl :VimuxRunLastCommand<CR>

" Ale
let g:ale_fixers = {
\   'javascript': ['prettier_eslint'],
\}
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

" Neoformatter
autocmd FileType javascript setlocal formatprg=prettier\ --stdin\ --tab-width\ 4\ --print-width\ 120
let g:neoformat_try_formatprg = 1
map <Leader>p :Neoformat<cr>


" Custom test functions
function! TestCurrentReactBuffer()
    let path = expand('%:p')
    let filename = substitute(path, "test\.", "", "")
    execute "!npm test " . path . " -- --coverage --collectCoverageFrom=\'[\"" . filename . "\"]\'"
endfunction

" Testing in Clojure
function! TestToplevel() abort
    "Eval the toplevel clojure form (a deftest) and then test-var the result."
    normal! ^
    let line1 = searchpair('(','',')', 'bcrn', g:fireplace#skip)
    let line2 = searchpair('(','',')', 'rn',
    g:fireplace#skip)
    let expr = join(getline(line1, line2), "\n")
    let var = fireplace#session_eval(expr)
    let result = fireplace#echo_session_eval("(clojure.test/test-var" . var . ")")
    return result
endfunction

au Filetype clojure nmap <c-c><c-t> :call TestToplevel()<cr>

" Hot reload code into the JVM
au Filetype clojure nmap <c-c><c-k> :Require<cr>

" Elm
let g:elm_jump_to_error = 0
let g:elm_make_output_file = "elm.js"
let g:elm_make_show_warnings = 0
let g:elm_syntastic_show_warnings = 0
let g:elm_browser_command = ""
let g:elm_detailed_complete = 0
let g:elm_format_autosave = 1
let g:elm_format_fail_silently = 0
let g:elm_setup_keybindings = 1
