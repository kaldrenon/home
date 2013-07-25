"Load plugins with Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
call vundle#rc()

if exists('g:powerline_loaded')
  set noshowmode
endif

" Vim-scripts plugins
Bundle 'JSON.vim'
Bundle 'JavaScript-Indent'
Bundle 'neocomplcache'
Bundle 'vimwiki'

" Independent Plugins (on github)
Bundle 'elixir-lang/vim-elixir'
Bundle 'elzr/vim-json'
Bundle 'flazz/vim-colorschemes'
Bundle 'gmarik/vundle'
Bundle 'hsitz/VimOrganizer'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kogakure/vim-sparkup'
Bundle 'Lokaltog/powerline'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tobiassvn/vim-gemfile'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'vim-ruby/vim-ruby'
Bundle 'wikitopian/hardmode'

filetype plugin indent on

set t_Co=256
silent! colorscheme wombat256

"Set options for plugins
let g:neocomplcache_enable_at_startup = 1
let g:syntastic_auto_jump = 1
let g:syntastic_auto_loc_list = 0 
let g:syntastic_enable_signs = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_quiet_warnings = 0
let g:vimwiki_list = [{'path': '~/Dropbox/docs/vimwiki/'}]
let g:vimwiki_conceallevel = 0
let g:vimroom_width=100
let g:vimroom_navigational_keys=0
let g:github_dashboard = { 'username': 'kaldrenon' }

" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

hi NonText guibg=bg guifg=#353535
hi SpecialChars guibg=bg guifg=#353535

command! W :w
command! Q :q
command! Bd :bd

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
set stl=%m%y\ %f%=%#warningmsg#%{fugitive#statusline()}%{SyntasticStatuslineFlag()}%*[%2c,%3l]\ %4L\ \ Buf:%2n\ \ %3p%% 

" Tab formatting
set shiftwidth=2
set softtabstop=2
set expandtab

" Wrapping
set wrap
set linebreak
set nolist

" Clear search highlighting with \c
set hls
set incsearch
nnoremap <silent><Leader>c :nohls<CR>

" Various leader maps
nnoremap <silent><Leader>x :s/^ /✓/<cr>:nohls<cr> 
nnoremap <silent><Leader>X :s/^✓/ /<cr>:nohls<cr>
nnoremap <silent><Leader>t :NERDTree<cr>
nnoremap <silent><Leader>T :NERDTreeClose<cr>
nnoremap <silent><Leader>w :w<cr>:bd<cr>
nnoremap <silent><Leader>l :lopen<cr>
nnoremap <silent><Leader>L <C-w>k:lclose<cr>
nnoremap <silent><Leader>g :GHDashboard<cr>
nnoremap <silent><Leader>o :only<cr>


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
nnoremap <silent> <C-m> :wincmd _ <cr>
nnoremap <silent> <C-j> <C-W>j<C-W>_
nnoremap <silent> <C-k> <C-W>k<C-W>_
nnoremap <silent> <C-h> :wincmd h <cr>
nnoremap <silent> <C-l> :wincmd l <cr>
nnoremap <C-t> :99new 
set noea " Prevent window stack from automatically evening out when one closes
set wmh=0 " No max height on windows.

"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

au BufRead,BufNewFile *.rem setfiletype remind
au BufRead,BufNewFile *.tex setfiletype tex
