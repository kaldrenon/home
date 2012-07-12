"Load plugins with Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Vim-scripts plugins
Bundle 'JSON.vim'
Bundle 'JavaScript-Indent'
Bundle 'neocomplcache'
Bundle 'vimroom.vim'
Bundle 'vimwiki'

" Independent Plugins (on github)
Bundle 'flazz/vim-colorschemes'
Bundle 'gmarik/vundle'
Bundle 'kogakure/vim-sparkup'
Bundle 'mattn/gist-vim'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'

filetype plugin indent on

silent! colorscheme wombat256

"Set options for plugins
let g:neocomplcache_enable_at_startup = 1
let g:vimwiki_list = [{'path': '~/Dropbox/docs/vimwiki/'}]
let g:vimwiki_conceallevel = 0
let g:vimroom_width=100
let g:vimroom_navigational_keys=0

" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Listchars settings
" Shortcut to rapidly toggle `set list`
nmap <silent><leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬
hi NonText guibg=bg guifg=#353535
hi SpecialChars guibg=bg guifg=#353535

command! W :w

command! -nargs=1 MyWinOpen :new <args> | :resize 100

"Highlight matched HTML tags
set mps+=<:>
set showmatch
set matchtime=3

" Make wildcard completion behave like zsh
set wildmenu
set wildmode=longest,list

" Prevent the use of .swp, ~, and other backup files.
set nobackup
set nowritebackup
set noswapfile

" Basic color and format defaults
set hidden
set number
set ruler
set guifont=Consolas:h12
syntax on
set bs=2
set laststatus=2
set stl=%m%y\ %f%=[%2c,%3l]\ %4L\ \ Buf:%2n\ \ %3p%% 

" Folding
set foldenable
set foldmethod=syntax

" Tab formatting
set shiftwidth=2
set softtabstop=2
set expandtab

" Wrapping
set wrap
set linebreak
set nolist

" Clear search highlighting with \/
set hls
noremap <silent><Leader>c :nohls<CR>
nmap <silent><Leader>t :NERDTree<cr>
nmap <silent><Leader>T :NERDTreeClose<cr>

" Kick the cursor habit
for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor

map Y y$

" A whole bunch of mappings to make window management easy and a little bit
" more like tab management in other editors.
"  - Ctrl-m will maximize the current window.
"  - Ctrl-t creates a new window and maximizes it
"  - Ctrl-j and k move up/down in window stack
"    and maximize after the new bufffer is selected
"  - Ctrl h and l move left/right between window stacks
map <silent> <C-m> :wincmd _ <cr>
map <silent> <C-j> <C-W>j<C-W>_
map <silent> <C-k> <C-W>k<C-W>_
map <silent> <C-h> :wincmd h <cr>
map <silent> <C-l> :wincmd l <cr>
map <silent> <C-t> <C-W>n<C-W>_
set noea " Prevent window stack from automatically evening out when one closes
set wmh=0 " No max height on windows.

"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

au BufRead,BufNewFile *.rem setfiletype remind
