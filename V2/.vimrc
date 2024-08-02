" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable file type detection and related settings.
filetype plugin indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number

" Toggle line numbers with F2
nnoremap <F2> :set number!<CR>
vnoremap <F2> :set number!<CR>

" Set indentation options.
set shiftwidth=4
set tabstop=4
set expandtab

" General editing settings.
set noshowmatch
set nobackup
set scrolloff=10
set nowrap

" Search settings.
set incsearch
set ignorecase
set smartcase
set hlsearch

" Show various modes and commands.
set showcmd
set showmode

" History and completion settings.
set history=1000
set wildmenu
set wildmode=list:longest

" Ignore certain file extensions in wildmenu.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Set leader key to space.
let mapleader=" "

" Window management key mappings.
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l

" Select all text in the current buffer.
nnoremap <C-a> gg<S-v>G

" Tab management key mappings.
nnoremap <leader>te :tabedit<CR>
nnoremap <leader>t :tabnext<CR>
nnoremap <leader>T :tabprev<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>

" Split window management.
nnoremap <leader>s :split<CR>
nnoremap <leader>v :vsplit<CR>

" Alternate resize window key mappings.
nnoremap <silent> <leader><Left> :vertical resize -1<CR>
nnoremap <silent> <leader><Right> :vertical resize +1<CR>
nnoremap <silent> <leader><Up> :resize +1<CR>
nnoremap <silent> <leader><Down> :resize -1<CR>

" Replace text using the word under the cursor.
nnoremap <leader>rs :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Open file explorer.
nnoremap <leader>e :Ex<CR>

" Compile and run C++ script.
nnoremap <leader>rr :w<CR>:!clear && cd %:p:h && g++ %:t -o %:t:r && ./%:t:r<CR>

" Save the current file.
nnoremap <C-s> :w<CR>
vnoremap <C-s> :w<CR>

" Quit Vim.
nnoremap <leader>q :q!<CR>

" Ultimate remap for Esc.
inoremap jk <Esc>

" Map <leader>y to yank to the system clipboard.
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" Add freopen statements and sync settings below int main().
map <leader>af /int main() {<CR>ofreopen("<C-R>=expand('%:t:r')<CR>.inp", "r", stdin); freopen("<C-R>=expand('%:t:r')<CR>.out", "w", stdout);

" Define a function to insert the C++ boilerplate code.
function! InsertCppBoilerplate()
    " Get the base name of the current file without extension.
    let base_filename = expand('%:t:r')

    " Define the full boilerplate code.
    let boilerplate = "#include <bits/stdc++.h>\n\n"
    let boilerplate .= "using namespace std;\n\n"
    let boilerplate .= "int main() {\n"
    let boilerplate .= "    ios_base::sync_with_stdio(false);    cin.tie(nullptr);    cout.tie(nullptr);\n\n"
    let boilerplate .= "    return 0;\n"
    let boilerplate .= "}\n"

    " Insert the boilerplate code into the buffer.
    call setline(1, split(boilerplate, '\n'))
endfunction

" Map <leader>df to call the function.
nnoremap <leader>df :call InsertCppBoilerplate()<CR>

" Map to auto split.
nnoremap <leader>sp :vsplit<CR><C-w>l:split<CR><C-w>h:vertical resize +32<CR>

" Vim-Plug plugin manager setup.
call plug#begin()
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
call plug#end()

" Enable syntax highlighting and set colorscheme.
syntax enable
set background=dark
colorscheme catppuccin_mocha

" Enable true color support if available.
if has("termguicolors")
    set termguicolors
endif

