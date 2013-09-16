"Load plugins with Vundle
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()

if exists('g:loaded_airline')
  set noshowmode
endif

" Syntax Plugins
Bundle 'elzr/vim-json'
Bundle 'JavaScript-Indent'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-haml'

" Functionality plugins
Bundle 'bling/vim-airline'
Bundle 'elixir-lang/vim-elixir'
Bundle 'flazz/vim-colorschemes'
Bundle 'gmarik/vundle'
Bundle 'hsitz/VimOrganizer'
Bundle 'kogakure/vim-sparkup'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'mhinz/vim-signify'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/unite.vim'
Bundle 'tobiassvn/vim-gemfile'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'Valloric/YouCompleteMe'
Bundle 'vim-ruby/vim-ruby'
Bundle 'wikitopian/hardmode'
Bundle 'UltiSnips'
Bundle 'vimwiki'

filetype plugin indent on

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
let g:github_dashboard = { 'username': 'kaldrenon' }
let g:gist_clip_command = 'pbcopy'
let g:gist_open_browser_after_post = 1
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsEditSplit='horizontal'
let g:miniBufExplMinSize = 2

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
set mouse=a
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
nnoremap <silent><c-n> :nohls<CR>

" Various leader maps
nnoremap <silent><Leader>x :s/^ /✓/<cr>:nohls<cr> 
nnoremap <silent><Leader>X :s/^✓/ /<cr>:nohls<cr>
nnoremap <silent><Leader>w :w<cr>:bd<cr>
nnoremap <silent><Leader>l :lopen<cr>
nnoremap <silent><Leader>L <C-w>k:lclose<cr><C-w>_
nnoremap <silent><Leader>g :GHDashboard<cr>
nnoremap <silent><Leader>o :only<cr>
nnoremap <silent><Leader>U :UltiSnipsEdit<cr>
nnoremap <silent><Leader>f 'a/\[ \]<cr>:noh<cr>
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
set noequalalways " Prevent window stack from automatically evening out when one closes
set winminheight=0 " No max height on windows.
set splitright

" Unite.vim mappings
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <Leader>t :set nosplitbelow<cr>:Unite -default-action=split -start-insert file_rec<cr>
nnoremap <Leader>T :set splitbelow<cr>:Unite -default-action=split -start-insert file_rec<cr>
nnoremap <Leader>v :set splitright<cr>:Unite -default-action=vsplit -start-insert file_rec<cr>
nnoremap <Leader>V :set nosplitright<cr>:Unite -default-action=vsplit -start-insert file_rec<cr>
nnoremap <Leader>n :Unite -default-action=split -start-insert file/new<cr>

nnoremap <Leader>e :Unite -start-insert file_rec<cr>
nnoremap <Leader>B :Unite -start-insert buffer<cr>
nnoremap <Leader>b :Unite buffer<cr>

nnoremap <space>/ :Unite grep:.<cr>
nnoremap <space>s :Unite -quick-match buffer<cr>

" Vimwiki Task related mappings
nnoremap <space><space> o<esc>0C
nnoremap <space>t o<esc>0CT
nnoremap <space>r o<esc>0Cr

" * search in visual mode
vnoremap * y/<C-r>"<cr>

"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

set autoread " automatically reload externally changed buffers
au BufRead,BufNewFile *.rem setfiletype remind
au BufRead,BufNewFile *.tex setfiletype tex
au BufRead,BufNewFile *.god setfiletype rb
au FocusLost * stopinsert
au BufRead,BufNewFile,BufEnter Pomodoro.wiki nnoremap <buffer> <space>j gg/-<space>\[<space>\]<cr>:nohls<cr>zz

nnoremap <space>M ?^\s\+#\n^\s\+#.\+\n^\s\+#<cr>zt:nohls<cr>
nnoremap <space>m /^\s\+#\n^\s\+#.\+\n^\s\+#<cr>zt:nohls<cr>
