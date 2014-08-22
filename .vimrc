"Load plugins with Vundle
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()
runtime macros/matchit.vim

if exists('g:loaded_airline')
  set noshowmode
endif

" Syntax Plugins
Bundle 'digitaltoad/vim-jade'
Bundle 'elixir-lang/vim-elixir'
Bundle 'elzr/vim-json'
Bundle 'JavaScript-Indent'
Bundle 'kchmck/vim-coffee-script'
Bundle 'othree/javascript-libraries-syntax.vim'
Bundle 'slim-template/vim-slim'
Bundle 'tpope/vim-haml'
Bundle 'groenewege/vim-less'
Bundle 'VimClojure'

" Functionality plugins
Bundle 'bling/vim-airline'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'gmarik/vundle'
Bundle 'godlygeek/tabular'
Bundle 'junegunn/goyo.vim'
Bundle 'junegunn/limelight.vim'
Bundle 'lord-garbage/tslime.vim'
Bundle 'mattn/gist-vim'
Bundle 'mhinz/vim-signify'
Bundle 'mhinz/vim-tmuxify'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'rking/ag.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/unite.vim'
Bundle 'sudo.vim'
Bundle 'sunaku/vim-ruby-minitest'
Bundle 'terryma/vim-expand-region'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'Valloric/YouCompleteMe'
Bundle 'vim-ruby/vim-ruby'
Bundle 'UltiSnips'
Bundle 'vimwiki'

" Colo Plugins
Bundle 'flazz/vim-colorschemes'
Bundle 'jordwalke/flatlandia'

" Dependencies - plugins I don't use directly but that other plugins need
Bundle 'kana/vim-textobj-user'
Bundle 'mattn/webapi-vim'

filetype plugin indent on

for cs in ['hybrid', 'wombat256mod', 'wombat256', 'default']
  try
    execute 'colorscheme' cs
    break
  catch
  endtry
endfor

"Set options for plugins
let g:airline_left_sep=' '
let g:airline_right_sep=' '

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.linenr     = '␤'
let g:airline_symbols.branch     = '⎇'
let g:airline_symbols.readonly   = 'RO'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_powerline_fonts    = 1

let g:syntastic_mode_map            = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }
let g:syntastic_auto_jump           = 0
let g:syntastic_auto_loc_list       = 0
let g:syntastic_enable_signs        = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_quiet_messages      = { 'level': 'warnings' }

let g:vimwiki_list         = [{'path': '~/Dropbox/docs/vimwiki/'}]
let g:vimwiki_conceallevel = 0
let g:vimwiki_hl_headers   = 1

let g:gist_clip_command            = 'pbcopy'
let g:gist_open_browser_after_post = 1

let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsEditSplit     = 'horizontal'

let g:used_javascript_libs = 'angularjs'

let g:ycm_server_keep_logfiles = 1

let g:goyo_width = 100

if executable('ag')
  let g:ackprg                          = 'ag --nogroup --nocolor --column'
  let g:unite_source_rec_async_command  = 'ag -i --nocolor --nogroup'
  let g:unite_source_grep_command       = 'ag'
  let g:unite_source_grep_default_ops   = '--line-numbers --nocolor --nogroup --hidden ' .
        \ '--ignore ''.git'' --ignore ''tmp'' --ignore ''node_modules'''
  let g:unite_source_grep_recursive_opt = ''
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

let g:tmuxify_custom_command = 'tmux split-window -p 20'
let g:tmuxify_map_prefix = '<space>m'
let g:tmuxify_run = {
      \ 'c':  'rails c',
      \ 'gs': 'gs'
      \ }

command! W :w
command! Q :q
command! Bd :bd
command! RS :source ~/.vimrc
command! -nargs=1 MyWinOpen :new <args> | :resize 100

" Highlight matched HTML tags
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
syntax on
set backspace=2                        " backspace behaves as in other software
set laststatus=2                       " always show statusline

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Tab formatting
set shiftwidth=2
set softtabstop=2
set expandtab

" Wrapping
set wrap
set linebreak

" Character Listing
set list
set listchars=tab:‣-,trail:·

" Searching
set hlsearch
set incsearch

set ttimeoutlen=50

" Swap j/k with gj/gk for normal, visual, and select modes
nnoremap j  gj
xnoremap j  gj
vnoremap j  gj
nnoremap k  gk
xnoremap k  gk
vnoremap k  gk

nnoremap gj j
xnoremap gj j
vnoremap gj j
nnoremap gk k
xnoremap gk k
vnoremap gk k

" Join up
nnoremap K kJ
nnoremap <A-j> ddkkpJ

" Clear search highlighting with \c
nnoremap <silent><Leader>c :nohls<CR>
nnoremap <silent><c-n> :nohls<CR>

" Various leader maps
" save and unload
nnoremap <silent><Leader>w :w<cr>:bd<cr>
" open/close location list
nnoremap <silent><Leader>l :lopen<cr>
nnoremap <silent><Leader>L <C-w>k:lclose<cr><C-w>_

" reduce down to current buffer
nnoremap <silent><Leader>o :only<cr>

" Open snippets file for current filetype
nnoremap <silent><Leader>uu :UltiSnipsEdit<cr>
nnoremap <Leader>U :UltiSnipsEdit<space>
nnoremap <silent><Leader>ua :UltiSnipsEdit<space>all<cr>
nnoremap <silent><Leader>ur :UltiSnipsEdit<space>ruby<cr>

" Insert mapping for calling UltiSnips expand trigger - lets me use snippets
" in mappings!
inoremap <silent><c-b> <C-R>=UltiSnips_ExpandSnippetOrJump()<cr>

" Go to next uncompleted task in vimwiki buffers
nnoremap ZA :wqa<cr>

" Find uncommented method and class headers
nnoremap <silent><space>h /\v^\s*[^#]*\n^\s*(def\|class)/+1<cr>:noh<cr>
nnoremap <silent><space>H O##

" flip capitalization on a word
nnoremap <silent><leader>~ viw~

" minor cursor adjust without leaving insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>

" Kick the cursor habit (disable arrow keys in ivn modes)
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

"nnoremap <silent> <C-m> :wincmd _ <cr>
"nnoremap <silent> <C-j> <C-W>j<C-W>_
"nnoremap <silent> <C-k> <C-W>k<C-W>_
"nnoremap <silent> <C-h> :wincmd h <cr>
"nnoremap <silent> <C-l> :wincmd l <cr>

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr><C-w>_
nnoremap <silent> <C-k> :TmuxNavigateUp<cr><C-w>_
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>
nnoremap <silent> <C-=> <C-w>=
nnoremap <silent> <C-m> <C-w>_

set noequalalways " Prevent window stack from automatically evening out when one closes
set winminheight=0 " No max height on windows.
set splitright

""""
" Unite.vim mappings
""""
call unite#custom#source('buffer,file,file_mru,file_rec', 'sorters', 'sorter_rank')
call unite#custom#source('file_rec', 'ignore_pattern', 'tmp/*')
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Open windows in horiz/vert splits after fuzzy matching a file name
nnoremap <Leader>t :set nosplitbelow<cr>:Unite -default-action=split -start-insert file_rec<cr>
nnoremap <Leader>T :set splitbelow<cr>:Unite -default-action=split -start-insert file_rec<cr>
nnoremap <Leader>v :set splitright<cr>:Unite -default-action=vsplit -start-insert file_rec<cr>
nnoremap <Leader>V :set nosplitright<cr>:Unite -default-action=vsplit -start-insert file_rec<cr>
nnoremap <Leader>n :Unite -default-action=split -start-insert file/new<cr>

" Read files into current buffer; swap buffers
nnoremap <Leader>e :Unite -start-insert file_rec<cr>
nnoremap <Leader>B :Unite -start-insert buffer<cr>
nnoremap <Leader>b :Unite buffer<cr>
nnoremap <space>s :Unite -quick-match buffer<cr>

" Unite search (I rarely use this)
nnoremap <space>/ :Unite grep:.<cr>

" Mark something completed with a unicode check
nnoremap <Leader>x I✓<space><esc>
nnoremap <Leader>X r✓

" Goyo / Limelight Mappings
nnoremap <silent> <space><space> :Goyo<cr>
nnoremap <silent> <Leader>l :Limelight!!<cr>

" quickly restart YCM server
nnoremap <silent> <space>yr :YcmRestart<cr>

" recapitalize a word
nnoremap <silent> <space>c viw~


"""""
" Vimwiki Task related mappings - rely on UltiSnips snippets
"""""
" New Pomodoro task entry
nmap <space>p o<esc>0Cp<C-j>
nmap <space>P O<esc>0Cp<C-j>

" New quick task entry
nmap <space>t o<esc>0CT<C-j>
nmap <space>T O<esc>0CT<C-j>

" New task description line
nmap <space>r o<esc>0Cr<C-j>
nmap <space>R O<esc>0Cr<C-j>

nnoremap <C-x> A<space>!<C-j><esc><C-space>

" Enable tab completion for popup menus in vimwiki buffers
au FileType vimwiki inoremap <expr> <buffer> <tab> pumvisible() ? "\<C-N>" : "\<Tab>"

" * search in visual mode
vnoremap *     y/<C-r>"<cr>
vnoremap <Tab> :Tabularize<space>/

"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

set autoread " automatically reload externally changed buffers

" Extension to filetype config
au BufRead,BufNewFile *.rem setfiletype remind
au BufRead,BufNewFile *.tex setfiletype tex
au BufRead,BufNewFile *.god setfiletype rb
au BufNewFile,BufRead,BufReadPost *.jade.html set filetype=jade

" Mappings for common Tabularizations
nnoremap <Leader>a= :Tabularize /=<CR>
vnoremap <Leader>a= :Tabularize /=<CR>
nnoremap <Leader>a: :Tabularize /:\zs<CR>
vnoremap <Leader>a: :Tabularize /:\zs<CR>

nnoremap - :NERDTreeToggle<cr>

""" Ruby Specific Bindings

au FileType ruby nnoremap "" :s/"/'/g<cr>
au FileType ruby nnoremap <silent><C-p> :w !ruby<cr>
