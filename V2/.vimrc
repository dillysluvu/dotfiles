" Disable compatibility with vi
set nocompatible

" Enable file type detection, plugins, and indentation
filetype plugin indent on

" Line number settings
set number
nnoremap <F2> :set number!<CR>  " Toggle line numbers using F2

" Enable mouse support
set mouse=a

" Indentation settings
set shiftwidth=4
set tabstop=4
set expandtab  " Use spaces instead of tabs

" General editing settings
set noshowmatch       " Disable matching bracket highlighting
set nobackup          " Disable backup files
set nowritebackup     " Disable write backup to avoid file corruption
set scrolloff=10      " Keep 10 lines visible when scrolling
set nowrap            " Disable line wrapping
set lazyredraw        " Improve performance by not redrawing during macros
set swapfile          " Enable swap file for recovery (optional)
set undofile          " Enable persistent undo

" Search settings
set incsearch         " Show matches as you type during search
set ignorecase        " Ignore case in search patterns
set smartcase         " Override 'ignorecase' if search pattern contains uppercase
set hlsearch          " Highlight search results
set nowrapscan        " Prevent search from wrapping around the file

" Command mode settings
set showcmd           " Display incomplete commands
set showmode          " Display current mode

" History and completion settings
set history=1000      " Increase command history size
set wildmenu          " Enable enhanced command-line completion
set wildmode=list:longest
set magic             " Enable enhanced regular expression syntax

" Ignore certain file types in completion
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Use system clipboard for yank operations
set clipboard=unnamedplus

" Set leader key to space
let mapleader=" "

" Window management key mappings
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wh <C-w>h
nnoremap <leader>wl <C-w>l

" Select all text in the current buffer
nnoremap <C-a> gg<S-v>G

" Tab management key mappings
nnoremap <leader>te :tabedit<CR>
nnoremap <leader>t  :tabnext<CR>
nnoremap <leader>T  :tabprev<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>

" Resize window key mappings
nnoremap <silent> <leader><Left> :vertical resize -1<CR>
nnoremap <silent> <leader><Right> :vertical resize +1<CR>
nnoremap <silent> <leader><Up> :resize +1<CR>
nnoremap <silent> <leader><Down> :resize -1<CR>

" Replace text using the word under the cursor
nnoremap <leader>rs :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
vnoremap <leader>rs :s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Open file explorer
nnoremap <leader>e :Ex<CR>

" Close current buffer
nnoremap <leader>g :bd<CR>

" File searching (requires fzf plugin)
nnoremap <silent> <leader>f :Files<CR>

" Show all maps
nnoremap <C-?> :Maps<CR>

" Compile and run C++ script
nnoremap <leader>rr :w<CR>:!clear && cd %:p:h && g++ %:t -o %:t:r && ./%:t:r<CR>

" Save the current file
nnoremap <C-s> :w<CR>
vnoremap <C-s> :w<CR>

" Quit Vim
nnoremap <leader>q :q!<CR>

" Use Zoxide
nnoremap <leader>z :Z 

" Ultimate remap for Esc
inoremap jk <Esc>

" Remove everything before and after a slash
nnoremap <leader>rm 0f/d$

" Add freopen statements and sync settings below int main()
nnoremap <leader>af /int main() {<CR>o//freopen("<C-R>=expand('%:t:r')<CR>.inp", "r", stdin); freopen("<C-R>=expand('%:t:r')<CR>.out", "w", stdout);<Esc>

" Function to insert C++ boilerplate code
function! InsertCppBoilerplate()
    let boilerplate = "#include <bits/stdc++.h>\n\n"
    let boilerplate .= "#pragma GCC optimize(\"O3,unroll-loops\")\n"
    let boilerplate .= "#pragma GCC target(\"avx2,bmi,bmi2,lzcnt,popcnt\")\n\n"
    let boilerplate .= "using namespace std;\n\n"
    let boilerplate .= "int main() {\n"
    let boilerplate .= "    ios_base::sync_with_stdio(false);   cin.tie(nullptr);   cout.tie(nullptr);\n"
    let boilerplate .= "     \n"
    let boilerplate .= "    return 0;\n"
    let boilerplate .= "}\n"
    call setline(1, split(boilerplate, '\n'))
endfunction

" Map <leader>df to insert C++ boilerplate
nnoremap <leader>df :call InsertCppBoilerplate()<CR>9j5l

" Launch Codeium  
nnoremap <leader>ai :call codeium#Chat()<CR>

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
  Plug 'Exafunction/codeium.vim', { 'branch': 'main' }
call plug#end()

" Enable syntax highlighting and set colorscheme
syntax enable
set background=dark
colorscheme solarized-osaka
"colorscheme catppuccin_mocha

" Enable true color support if available
if has("termguicolors")
    set termguicolors
endif

" Performance optimizations
set timeoutlen=500            " Reduce timeout for mapped sequences
set updatetime=300            " Reduce time for update events
set autoread                  " Automatically reload files changed outside of Vim

