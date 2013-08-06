"Load plugins with Vundle
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/vundle
set runtimepath+=~/.vim/bundle/powerline/powerline/bindings/vim
call vundle#rc()

if exists('g:loaded_airline')
  set noshowmode
endif

if has("mac")
  Bundle 'sjl/vitality.vim'
  let g:vitality_fix_cursor=0
endif

" Vim-scripts plugins
Bundle 'JSON.vim'
Bundle 'JavaScript-Indent'
Bundle 'UltiSnips'
Bundle 'vimwiki'

" Independent Plugins (on github)
Bundle 'bling/vim-airline'
Bundle 'elixir-lang/vim-elixir'
Bundle 'elzr/vim-json'
Bundle 'flazz/vim-colorschemes'
Bundle 'gmarik/vundle'
Bundle 'hsitz/VimOrganizer'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kogakure/vim-sparkup'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'mhinz/vim-signify'
Bundle 'scrooloose/syntastic'
Bundle 'tobiassvn/vim-gemfile'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'Valloric/YouCompleteMe'
Bundle 'vim-ruby/vim-ruby'
Bundle 'wikitopian/hardmode'

filetype plugin indent on

set t_Co=256

for cs in ['wombat256mod', 'wombat256', 'default']
  try
    execute 'colorscheme' cs
    break
  catch
  endtry
endfor

"Set options for plugins
let g:airline_left_sep=' '
let g:airline_right_sep=' '
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
let g:gist_clip_command = 'pbcopy'
let g:gist_open_browser_after_post = 1
let g:UltiSnipsExpandTrigger="<c-j>"

let @w ='/=== Daily LogjV/=== On Deckkd/=== Past Weeksp/=== Daily Logj'

command! W :w
command! Q :q
command! Bd :bd
command! RS :source ~/.vimrc
command! -nargs=1 MyWinOpen :new <args> | :resize 100

"Highlight matched HTML tags
set matchpairs+=<:>
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
set backspace=2                        " backspace behaves as in other software
set laststatus=2                       " always show statusline
set statusline=%m%y\ %f%=%#warningmsg#%{fugitive#statusline()}%{SyntasticStatuslineFlag()}%*[%2c,%3l]\ %4L\ \ Buf:%2n\ \ %3p%% 

" Tab formatting
set shiftwidth=2
set softtabstop=2
set expandtab

" Wrapping
set wrap
set linebreak
set nolist

" Clear search highlighting with \c
set hlsearch
set incsearch
nnoremap <silent><Leader>c :nohls<CR>

" Various leader maps
nnoremap <silent><Leader>x :s/^ /✓/<cr>:nohls<cr> 
nnoremap <silent><Leader>X :s/^✓/ /<cr>:nohls<cr>
nnoremap <silent><Leader>w :w<cr>:bd<cr>
nnoremap <silent><Leader>l :lopen<cr>
nnoremap <silent><Leader>L <C-w>k:lclose<cr>
nnoremap <silent><Leader>g :GHDashboard<cr>
nnoremap <silent><Leader>o :only<cr>
nnoremap ZA :wqa<cr>

" extra escape option
inoremap kj <esc>

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
nnoremap <Leader>t :set nosplitbelow<cr>:99new<space>
nnoremap <Leader>T :set splitbelow<cr>:99new<space>
nnoremap <Leader>v :set splitright<cr>:vnew<space>
nnoremap <Leader>V :set nosplitright<cr>:vnew<space>
set noequalalways " Prevent window stack from automatically evening out when one closes
set winminheight=0 " No max height on windows.
set splitright

"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

set autoread " automatically reload externally changed buffers
au BufRead,BufNewFile *.rem setfiletype remind
au BufRead,BufNewFile *.tex setfiletype tex
au BufRead,BufNewFile *.god setfiletype rb
au FocusLost * stopinsert
