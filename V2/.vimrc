" Disable compatibility with vi
set nocompatible

" Enable file type detection, plugins, and indentation
filetype plugin indent on

" Line number settings
set number
nnoremap <F2> :set number!<CR>  " Toggle line numbers with F2

" Enable mouse support
set mouse=a
set mouse+=nvi

" Indentation settings
set shiftwidth=4
set tabstop=4
set expandtab  " Use spaces instead of tabs

" General editing settings
set noshowmatch       " Disable matching bracket highlighting (optional)
set nobackup          " Disable backup files
set nowritebackup     " Avoid file corruption by disabling write backup
set scrolloff=10      " Keep 10 lines visible when scrolling
set nowrap            " Disable line wrapping
set lazyredraw        " Improve performance during macros or complex tasks
set noswapfile        " Disable swap file for performance, enable if needed
set undofile          " Enable persistent undo

" Search settings
set incsearch         " Show matches as you type
set ignorecase        " Ignore case in search patterns
set smartcase         " Override 'ignorecase' if uppercase is used
set hlsearch          " Highlight search results
set nowrapscan        " Prevent search from wrapping around the file

" Command mode settings
set showcmd           " Display incomplete commands
set showmode          " Display current mode

" History and completion settings
set history=1000      " Increase command history size
set wildmenu          " Enhanced command-line completion
set wildmode=list:longest
set magic             " Enable enhanced regular expressions

" Show invisible characters
" set list
" set listchars=tab:»·,trail:·

" Ignore certain file types in completion
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Use system clipboard for yank operations
set clipboard=unnamedplus

" Set leader key to space
let mapleader=" "

" Window navigation mappings
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wh <C-w>h
nnoremap <leader>wl <C-w>l

" Select all text in the current buffer
nnoremap <C-a> gg<S-v>G

" Tab management mappings
nnoremap <leader>te :tabedit<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>t  :tabnext<CR>
nnoremap <leader>T  :tabprev<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>to :tabonly<CR>

" Window resizing mappings
nnoremap <silent> <leader><Left> :vertical resize -1<CR>
nnoremap <silent> <leader><Right> :vertical resize +1<CR>
nnoremap <silent> <leader><Up> :resize +1<CR>
nnoremap <silent> <leader><Down> :resize -1<CR>

" Replace word under cursor
nnoremap <leader>rs :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
vnoremap <leader>rs :s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" File explorer
nnoremap <leader>e :Ex<CR>

" Close current buffer
nnoremap <leader>g :bp<bar>bd<CR>

" FZF file searching (requires fzf plugin)
let g:fzf_layout = { 'down': '40%' }
let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-/']
nnoremap <silent> <leader>f :Files<CR>
nnoremap <leader>bl :Buffers<CR>  " List open buffers
nnoremap <leader>ll :Lines<CR>    " Search lines in the current buffer

" Show all key mappings
nnoremap <C-?> :Maps<CR>

" Compile and run C++ program
nnoremap db :w<CR>:!clear && cd %:p:h && g++ %:t -o %:t:r 2>&1 && ./%:t:r<CR>

" Save the current file
nnoremap <C-s> :w<CR>
vnoremap <C-s> :w<CR>

" Quit Vim
nnoremap <leader>q :q!<CR>

" Autosave buffers on focus loss
autocmd BufLeave,FocusLost * silent! wa

" Disable linting during text changes for performance
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1

" Use Zoxide for directory jumping
nnoremap <leader>z :Z<CR>

" Ultimate remap for Esc
inoremap jk <Esc>

" Remove everything before and after a slash
nnoremap <leader>rm 0f/d$

" Insert freopen and sync settings in C++
nnoremap <leader>af /int main() {<CR>ofreopen("<C-R>=expand('%:t:r')<CR>.inp", "r", stdin); freopen("<C-R>=expand('%:t:r')<CR>.out", "w", stdout);<Esc>

" Function to insert C++ boilerplate code
function! InsertCppBoilerplate()
    let boilerplate = "#include <bits/stdc++.h>\n\n"
    let boilerplate .= "using namespace std;\n"
    let boilerplate .= "#define TIME (1.0 * clock() / CLOCKS_PER_SEC)\n\n"
    let boilerplate .= "int main() {\n"
    let boilerplate .= "    ios_base::sync_with_stdio(false);   cin.tie(nullptr);   cout.tie(nullptr);\n\n"
    let boilerplate .= "    cerr << \"Time elapsed: \" << TIME << \"s.\";\n"
    let boilerplate .= "    return 0;\n"
    let boilerplate .= "}\n"
    call setline(1, split(boilerplate, '\n'))
endfunction

" Map <leader>df to insert C++ boilerplate
nnoremap <leader>df :call InsertCppBoilerplate()<CR>7j5l

" Function to insert a graph-related C++ boilerplate
function! Dt()
    let boilerplate = "#include <bits/stdc++.h>\n\n"
    let boilerplate .= "using namespace std;\n"
    let boilerplate .= "#define TIME (1.0 * clock() / CLOCKS_PER_SEC)\n\n"
    let boilerplate .= "int dinh, canh;\n"
    let boilerplate .= "vector<bool> dd;\n"
    let boilerplate .= "vector<vector<int>> danhsachke;\n\n"
    let boilerplate .= "void nhap() {\n"
    let boilerplate .= "    cin >> dinh >> canh;\n"
    let boilerplate .= "    dd.resize(dinh + 1);\n"
    let boilerplate .= "    fill(dd.begin(), dd.end(), false);\n"
    let boilerplate .= "    for (int i = 0; i < canh; ++i) {\n"
    let boilerplate .= "        int u, v;\n"
    let boilerplate .= "        cin >> u >> v;\n"
    let boilerplate .= "        danhsachke[u].push_back(v);\n"
    let boilerplate .= "        danhsachke[v].push_back(u);\n"
    let boilerplate .= "    }\n"
    let boilerplate .= "}\n\n"
    let boilerplate .= "int main() {\n"
    let boilerplate .= "    ios_base::sync_with_stdio(false);   cin.tie(nullptr);   cout.tie(nullptr);\n"
    let boilerplate .= "    nhap();\n\n"
    let boilerplate .= "    cerr << \"Time elapsed: \" << TIME << \"s.\";\n"
    let boilerplate .= "    return 0;\n"
    let boilerplate .= "}\n"
    call setline(1, split(boilerplate, '\n'))
endfunction

" Map <leader>dt to insert graph-related C++ boilerplate
nnoremap <leader>dt :call Dt()<CR>24j5l

" Launch Codeium AI assistant
nnoremap <leader>ai :call codeium#Chat()<CR>

" Toggle search highlighting
nnoremap <leader>h :set hlsearch!<CR>

" Plugin management
call plug#begin()
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
  Plug 'nanotee/zoxide.vim'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'dense-analysis/ale'
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-fugitive'
  Plug 'tribela/vim-transparent'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Plug 'Exafunction/codeium.vim', { 'branch': 'main' }
call plug#end()

" Enable syntax highlighting and set colorscheme
syntax enable
set background=dark
colorscheme solarized-osaka
"colorscheme catppuccin_mocha

" Enable true color support
if has("termguicolors")
    set termguicolors
endif

" Performance optimizations
set timeoutlen=200            " Reduce timeout for mapped sequences
set updatetime=200            " Reduce time for update events
set autoread                  " Automatically reload files changed outside of Vim

