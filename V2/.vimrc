" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable file type detection and related settings
filetype plugin indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number

" Highlight cursor line and column.
" set cursorline
" set cursorcolumn

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
set showcmd
set showmode
set showmatch

" History and completion settings.
set history=1000
set wildmenu
set wildmode=list:longest

" Ignore certain file extensions in wildmenu.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Set leader key to space
let mapleader=" "

" Window management key mappings
nnoremap sq <C-w>q
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sh <C-w>h
nnoremap sl <C-w>l

" Select all text in the current buffer
nnoremap <C-a> gg<S-v>G

" Tab management key mappings
nnoremap te :tabedit<CR>
nnoremap <leader><Tab>] :tabnext<CR>
nnoremap <leader><Tab>[ :tabprev<CR>
nnoremap tn :tabnew<CR>
nnoremap tc :tabclose<CR>

" Split window management
nnoremap ss :split<CR>
nnoremap sv :vsplit<CR>

" Resize window key mappings
nnoremap <C-w><left> <C-w><
nnoremap <C-w><right> <C-w>>
nnoremap <C-w><up> <C-w>+
nnoremap <C-w><down> <C-w>-

" Replace text using the word under the cursor
nnoremap rs :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Open file explorer
nnoremap <leader>e :Ex<CR>

" Compile and run C++ script
nnoremap rr :w<CR>:!clear && cd %:p:h && g++ %:t -o %:t:r && ./%:t:r<CR>

" Save the current file
nnoremap <C-s> :w<CR>

" Quit Vim
nnoremap <leader>q :q!<CR>

" Disable auto-pairing in insert mode
inoremap ( (
inoremap ) )
inoremap [ [
inoremap ] ]
inoremap { {
inoremap } }
inoremap " "
inoremap ' '
inoremap ` `

" Add freopen statements and sync settings below int main() {
map rn /int main() {<CR>ofreopen("<C-R>=expand('%:t:r')<CR>.inp", "r", stdin); freopen("<C-R>=expand('%:t:r')<CR>.out", "w", stdout);<CR>ios_base::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr);<ESC>

" Vim-Plug plugin manager setup
call plug#begin()
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
call plug#end()

" Enable syntax highlighting and set colorscheme
syntax enable
set background=dark
colorscheme  catppuccin_mocha

" Enable true color support if available
if has("termguicolors")
  set termguicolors
endif
