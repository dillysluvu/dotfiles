" Disable compatibility with vi
set nocompatible

" Enable file type detection, plugins, and indentation
filetype plugin indent on

" Turn on syntax highlighting
syntax on

" Line number settings and toggling
set number
nnoremap <F2> :set number!<CR>
vnoremap <F2> :set number!<CR>

" Indentation settings
set shiftwidth=4
set tabstop=4
set expandtab

" General editing settings
set noshowmatch       " Disable matching bracket highlighting
set nobackup          " Disable backup files
set scrolloff=10      " Keep 10 lines visible when scrolling
set nowrap            " Disable line wrapping

" Search settings
set incsearch         " Incremental search
set ignorecase        " Ignore case when searching
set smartcase         " Override ignorecase if search pattern contains uppercase
set hlsearch          " Highlight search results

" Command mode settings
set showcmd           " Display incomplete commands
set showmode          " Display current mode

" History and completion settings
set history=1000      " Increase command history size
set wildmenu          " Enable command-line completion wildmenu
set wildmode=list:longest

set magic             " Enable enhanced regular expression syntax (default behavior)

" Ignore certain file extensions in wildmenu
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Use system clipboard for yank operations
set clipboard=unnamedplus

" Set leader key to space
let mapleader=" "

" Window management key mappings
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l

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

" File searching
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

" Ultimate remap for Esc
inoremap jk <Esc>

" Map for removing everything before and after a slash
nnoremap <leader>rm 0f/d$

" Add freopen statements and sync settings below int main()
nnoremap <leader>af /int main() {<CR>ofreopen("<C-R>=expand('%:t:r')<CR>.inp", "r", stdin); freopen("<C-R>=expand('%:t:r')<CR>.out", "w", stdout);<Esc>

" Function to insert C++ boilerplate code
function! InsertCppBoilerplate()
    let boilerplate = "#include <bits/stdc++.h>\n\n"
    let boilerplate .= "int main() {\n"
    let boilerplate .= "    std::ios_base::sync_with_stdio(false); std::cin.tie(nullptr); std::cout.tie(nullptr);\n"
    let boilerplate .= "     \n"
    let boilerplate .= "    return 0;\n"
    let boilerplate .= "}\n"
    call setline(1, split(boilerplate, '\n'))
endfunction

" Map <leader>df to call the function
nnoremap <leader>df :call InsertCppBoilerplate()<CR>4j5li

" Launch Codeium
nnoremap <leader>ai :call codeium#Chat()<CR>

" Vim-Plug plugin manager setup
call plug#begin()
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
  Plug 'nanotee/zoxide.vim'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'dense-analysis/ale'
  Plug 'jiangmiao/auto-pairs' 
  Plug 'tpope/vim-fugitive'
  Plug 'Exafunction/codeium.vim', { 'branch': 'main' }
call plug#end()

" Enable syntax highlighting and set colorscheme
syntax enable
set background=dark
colorscheme catppuccin_mocha

" Enable true color support if available
if has("termguicolors")
    set termguicolors
endif
