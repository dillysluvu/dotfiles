" Disable compatibility with vi
set nocompatible

" Enable file type detection and related settings
filetype plugin indent on

" Turn syntax highlighting on
syntax on

" Line numbers settings
set number
nnoremap <F2> :set number!<CR>
vnoremap <F2> :set number!<CR>

" Indentation settings
set shiftwidth=4
set tabstop=4
set expandtab

" General editing settings
set noshowmatch
set nobackup
set scrolloff=10
set nowrap

" Search settings
set incsearch
set ignorecase
set smartcase
set hlsearch

" Show command modes
set showcmd
set showmode

" History and completion settings
set history=1000
set wildmenu
set wildmode=list:longest

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
nnoremap <leader>T :tabprev<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>

" Split window management
nnoremap <leader>s :split<CR>
nnoremap <leader>v :vsplit<CR>

" Resize window key mappings
nnoremap <silent> <leader><Left> :vertical resize -1<CR>
nnoremap <silent> <leader><Right> :vertical resize +1<CR>
nnoremap <silent> <leader><Up> :resize +1<CR>
nnoremap <silent> <leader><Down> :resize -1<CR>

" Replace text using the word under the cursor
nnoremap <leader>rs :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
vnoremap <leader>rs :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Open file explorer
nnoremap <leader>e :Ex<CR>
nnoremap <leader>g :bd<CR>

" File searching
nnoremap <silent> <leader>f :FZF<CR>
nnoremap <silent> <leader>fh :FZF ~<CR>

" Compile and run C++ script
nnoremap <leader>rr :w<CR>:!clear && cd %:p:h && g++ %:t -o %:t:r && ./%:t:r<CR>

" Save the current file
nnoremap <C-s> :w<CR>
vnoremap <C-s> :w<CR>

" Quit Vim
nnoremap <leader>q :q!<CR>

" Ultimate remap for Esc
inoremap jk <Esc>

" Ultimate map 
nnoremap <leader>rm 0f/d$

" Add freopen statements and sync settings below int main()
nnoremap <leader>af /int main() {<CR>ofreopen("<C-R>=expand('%:t:r')<CR>.inp", "r", stdin); freopen("<C-R>=expand('%:t:r')<CR>.out", "w", stdout);<Esc>

" Function to insert C++ boilerplate code
function! InsertCppBoilerplate()
    let boilerplate = "#include <bits/stdc++.h>\n\n"
    let boilerplate .= "using namespace std;\n\n"
    let boilerplate .= "int main() {\n"
    let boilerplate .= "    ios_base::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr);\n\n"
    let boilerplate .= "    return 0;\n"
    let boilerplate .= "}\n"
    call setline(1, split(boilerplate, '\n'))
endfunction

" Map <leader>df to call the function
nnoremap <leader>df :call InsertCppBoilerplate()<CR>

" Auto split mapping
nnoremap <leader>sp :vsplit<CR><C-w>l:split<CR><C-w>h:vertical resize +32<CR>

" Vim-Plug plugin manager setup
call plug#begin()
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
  Plug 'nanotee/zoxide.vim'
  Plug 'junegunn/fzf'
  Plug 'ycm-core/YouCompleteMe'
  Plug 'codota/tabnine-vim'
call plug#end()

" Enable syntax highlighting and set colorscheme
syntax enable
set background=dark
colorscheme catppuccin_mocha

" Enable true color support if available
if has("termguicolors")
    set termguicolors
endif

