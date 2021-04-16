syntax enable

" Plugins
call plug#begin(stdpath('data') . '/plugged')
Plug 'benmills/vimux' | Plug 'janko-m/vim-test'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-fugitive'
call plug#end()

" Configure defaults
set backspace=indent,eol,start                " Make backspace work as expected
set number                                    " Turn on line numbers
set ruler                                     " Turn on column numbers
set hidden                                    " Hide buffers when quitting instead of abandoning
set hlsearch                                  " Highlight search results
set incsearch                                 " Turn on incremental search
set ignorecase                                " Search case-insensitive by default
set smartcase                                 " Search case-sensitive when term includes a capital
set isk+=?                                    " Add question mark as a keyword char -- useful for Ruby, Clojure, Elixir, etc.
set nofoldenable                              " Turn off code folding
set scrolloff=5                               " Give five lines of context around the cursor
set textwidth=0                               " Don't assume a line length when pasting
set nosmartindent                             " Turn off 'smart identing'
set expandtab                                 " Make the tab key insert spaces
set tabstop=2 shiftwidth=2 softtabstop=2      " Set tabs and indents to two spaces
set wildignore+=*.pyc,*.o,*.class             " Ignore these filetypes when expanding wildcards

" Fuzzy Finder settings and shortcuts
let $FZF_DEFAULT_COMMAND='find * -type f 2>/dev/null | grep -v -E "deps\/|_build\/|node_modules\/|vendor\/|build_intellij\/"'
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_tags_command='ctags -R --exclude=".git" --exclude="node_modules" --exclude="vendor" --exclude="log" --exclude="tmp" --exclude="db" --exclude="pkg" --exclude="deps" --exclude="_build" --extra=+f .'
map <silent> <leader>ff :Files<CR>
map <silent> <leader>fg :GFiles<CR>
map <silent> <leader>fb :Buffers<CR>
map <silent> <leader>ft :Tags<CR>

" Whitespace settings and shortcuts
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=red guibg=red
nnoremap <silent> <leader>cw :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Language-specific settings
autocmd BufNewFile,BufRead *.md,*.markdown setlocal textwidth=80 spell
autocmd FileType go setlocal noexpandtab

" Normal Mode Shortcuts
map <silent> <LocalLeader>nh :nohls<CR>

" Ale settings
let g:ale_linters = {
\   'c': ['clangd'],
\   'go': ['gobuild'],
\   'ruby': ['ruby']
\}
let g:ale_fixers = {
\   'go': ['gofmt', 'goimports'],
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\}
let g:ale_lint_on_insert_leave=1
let g:ale_fix_on_save=1
let g:ale_lint_on_text_changed=0
let g:ale_linters_explicit=1

" Vimux and vim-test settings
let g:VimuxOrientation = 'h'
let g:VimuxHeight = '40'
let g:test#strategy = 'vimux'
let g:test#preserve_screen = 0
nnoremap <silent> <leader>rf :wa<CR>:TestNearest<CR>
nnoremap <silent> <leader>rb :wa<CR>:TestFile<CR>
nnoremap <silent> <leader>ra :wa<CR>:TestSuite<CR>
nnoremap <silent> <leader>rl :wa<CR>:TestLast<CR>

" NERDTree shortcuts
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>

" Themes and colors
set background=dark
let base16colorspace=256     " Access colors present in 256 colorspace
colorscheme base16-eighties

" Status line
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " buffer number, and flags
set statusline+=%-40f\                    " relative path
set statusline+=%=                        " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\                " file type
set statusline+=%10(L(%l/%L)%)\           " line
set statusline+=%2(C(%v/125)%)\           " column
set statusline+=%P                        " percentage of file
