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
Plugin 'JavaScript-Indent'
Plugin 'VimClojure'
Plugin 'dahu/vim-asciidoc'
Plugin 'digitaltoad/vim-jade'
Plugin 'elixir-lang/vim-elixir'
Plugin 'elzr/vim-json'
Plugin 'groenewege/vim-less'
Plugin 'kchmck/vim-coffee-script'
Plugin 'neilhwatson/vim_cf3'
Plugin 'othree/html5.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'othree/yajs.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'slim-template/vim-slim'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'

" Functionality plugins
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'AndrewRadev/switch.vim'
Plugin 'EinfachToll/DidYouMean'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Shougo/neocomplcache'
Plugin 'UltiSnips'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'diepm/vim-rest-console'
Plugin 'floobits/floobits-neovim'
Plugin 'gmarik/vundle'
Plugin 'godlygeek/tabular'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/gist-vim'
Plugin 'mhinz/vim-signify'
Plugin 'mhinz/vim-tmuxify'
Plugin 'neilagabriel/vim-geeknote'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'notalex/vim-run-live'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sudo.vim'
Plugin 'sunaku/vim-ruby-minitest'
Plugin 'terryma/vim-expand-region'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vimwiki'
"Plugin 'wincent/vim-clipper'

" Colo Plugins
Plugin 'ajh17/Spacegray.vim'
Plugin 'cseelus/vim-colors-clearance'
Plugin 'flazz/vim-colorschemes'
Plugin 'jordwalke/flatlandia'
Plugin 'morhetz/gruvbox'
Plugin 'noahfrederick/vim-hemisu'
Plugin 'reedes/vim-colors-pencil'
Plugin 'wesgibbs/vim-irblack'
Plugin 'zefei/vim-colortuner'

" Dependencies - plugins I don't use directly but that other plugins need
Plugin 'kana/vim-textobj-user'
Plugin 'mattn/webapi-vim'

filetype plugin indent on

for cs in ['pencil', 'hybrid', 'wombat256mod', 'wombat256', 'default']
  try
    execute 'colorscheme' cs
    break
  catch
  endtry
endfor

"Set options for plugins
let g:airline_theme = 'pencil'
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
let g:syntastic_auto_loc_list       = 1
let g:syntastic_enable_signs        = 0
let g:syntastic_enable_highlighting = 1
let g:syntastic_scss_checkers       = ['scss_lint']

let g:vimwiki_list         = [{'path': '~/Dropbox/docs/vimwiki/'}]
let g:vimwiki_conceallevel = 0
let g:vimwiki_hl_headers   = 1

let g:gist_clip_command            = 'pbcopy'
let g:gist_open_browser_after_post = 1

let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsEditSplit     = 'horizontal'

let g:used_javascript_libs = 'angularjs'

let g:ycm_server_keep_logfiles = 1

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 2

let g:goyo_width = 80

let g:calendar_google_calendar = 1

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

let g:tmuxify_custom_command = 'tmux split-window -l 16'
let g:tmuxify_map_prefix = '<space>m'
let g:tmuxify_run = {
      \ 'c':  'rails c',
      \ 'gs': 'gs'
      \ }

let g:ctrlp_map = 'go'
let g:ctrlp_show_hidden = 1
let g:ctrlp_switch_buffer = 'ETVH'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v(tmp|public/assets)'
      \}

nmap gr :CtrlPMRU<cr>

let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_settings = {
\  'html' : {
\    'indentation' : '  '
\  },
\}

let g:rust_recommended_style = 0

command! W :w
command! Q :q
command! Qa :qa
command! Bd :bd
command! RS :source ~/.vimrc

" Default height of window is maxxed on new
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

" No code folding
set nofoldenable

" Basic color and format defaults
set hidden
set number
set ruler
syntax on
set backspace=2                        " backspace behaves as in other software
set laststatus=2                       " always show statusline
set background=dark

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

if !has('win32')
  set list
  set listchars=tab:‣-,trail:·
endif

" Searching
" set hlsearch
set incsearch

set ttimeoutlen=0

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

" Clear search highlighting with \c
set nohlsearch
nnoremap <silent><space>l :nohls<CR>

" Various leader maps

" reduce down to current buffer
nnoremap <silent><Leader>o :only<cr>

" Open snippets file for current filetype
nnoremap <silent><Leader>uu :UltiSnipsEdit<cr>
nnoremap <Leader>U :UltiSnipsEdit<space>
nnoremap <silent><Leader>ua :UltiSnipsEdit<space>all<cr>
nnoremap <silent><Leader>ur :UltiSnipsEdit<space>ruby<cr>
nnoremap <silent><Leader>uj :UltiSnipsEdit<space>javascript<cr>

" Insert mapping for calling UltiSnips expand trigger
" lets me use snippets in mappings!
inoremap <silent><c-b> <C-R>=UltiSnips_ExpandSnippetOrJump()<cr>

" minor cursor adjust without leaving insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>

" For Dane and William
inoremap dk <esc>

" Save and quit in the ZZ ZQ family
nnoremap ZA :wqa<cr>

" Kick the cursor habit (disable arrow keys in ivn modes)
for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor

" Better yank
map Y y$
nnoremap gy "+y

" A whole bunch of mappings to make window management easy and a little bit
" more like tab management in other editors.
"  - Ctrl-m will maximize the current window.
"  - Ctrl-t creates a new window and maximizes it
"  - Ctrl-j and k move up/down in window stack
"    and maximize after the new bufffer is selected
"  - Ctrl h and l move left/right between window stacks

" Uncomment these and comment the ones below to disable tmux nav
" nnoremap <silent> <C-m> :wincmd _ <cr>
" nnoremap <silent> <C-j> <C-W>j<C-W>_
" nnoremap <silent> <C-k> <C-W>k<C-W>_
" nnoremap <silent> <C-h> :wincmd h <cr>
" nnoremap <silent> <C-l> :wincmd l <cr>

let g:tmux_navigator_no_mappings = 1

" Uncomment these and comment the ones above to enable tmux nav
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr><C-w>_zz
nnoremap <silent> <C-k> :TmuxNavigateUp<cr><C-w>_zz
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

" Fast zoom and even-out
nnoremap <silent> <C-=> <C-w>=
nnoremap <silent> <C-m> <C-w>_

" Prevent window stack from evening out when one closes
set noequalalways
set winminheight=0 " No max height on windows.
set splitright

" Mark something completed with a unicode check
nnoremap <Leader>x I✓<space><esc>

" Goyo / Limelight Mappings
nnoremap <silent> <space><space> :Goyo<cr>
nnoremap <silent> <Leader>l :Limelight!!<cr>

" recapitalize a word
nnoremap <silent> <space>c viw~

nnoremap <silent> <space>sc :SyntasticCheck<cr>
nnoremap <silent> <space>sC :lclose<cr><C-w>_


"""""
" Vimwiki related mappings
"""""
" Task snippets which rely on UltiSnips snippets
" New Pomodoro task entry
nmap <space>p o<esc>0Cp<C-j>
nmap <space>P O<esc>0Cp<C-j>

" New quick task entry
nmap <space>t o<esc>0CT<C-j>
nmap <space>T O<esc>0CT<C-j>

" New task description line
nmap <space>r o<esc>0Cr<C-j>
nmap <space>R O<esc>0Cr<C-j>

nnoremap <silent><space>cw :e ~/Dropbox/docs/vimwiki/comcast/index.wiki<cr>

" Better save
nnoremap <space>ww :w<cr>

" Enable tab completion for popup menus in vimwiki buffers
au FileType vimwiki inoremap <expr> <buffer> <tab> pumvisible() ? "\<C-N>" : "\<Tab>"

""""

inoremap <expr><tab> pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" * search in visual mode
vnoremap *     y/<C-r>"<cr>
vnoremap <Tab> :Tabularize<space>/

"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

set autoread " automatically reload externally changed buffers

" Extension to filetype config
autocmd BufRead,BufNewFile *.tex setfiletype tex
autocmd BufRead,BufNewFile *.god setfiletype rb
autocmd BufNewFile,BufRead,BufReadPost *.jade.html set filetype=jade

autocmd BufNewFile,BufNewFile html,javascript,css,sass,ruby let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" Mappings for common Tabularizations
nnoremap <Leader>a= :Tabularize /=<CR>
vnoremap <Leader>a= :Tabularize /=<CR>
nnoremap <Leader>a: :Tabularize /:\zs<CR>
vnoremap <Leader>a: :Tabularize /:\zs<CR>

nnoremap - :NERDTreeToggle<cr><C-w>=

""" Mouse Settings
set ttyfast
if !has('nvim')
  set ttymouse=xterm2
endif
set mouse=a

""" EasyMotion
let g:EasyMotion_leader_key = '<leader>'
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" Version 2 Needs one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s)
nmap S <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t)
nmap T <Plug>(easymotion-T2)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" replace incremental search
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  ? <Plug>(easymotion-sn)
omap ? <Plug>(easymotion-tn)

" replace n/N for fast targeting
nmap <space>n <Plug>(easymotion-next)
nmap <space>N <Plug>(easymotion-prev)

" Highlight long rows
" ctermbg 52 is dark red
" TODO: Only apply this in certain fts
highlight OverLength ctermbg=52 ctermfg=white guibg=#770000
match OverLength /\%81v./

nnoremap <space>jp :%!python -m json.tool<CR>:w<CR>

" Jump around
nnoremap z[ {zt
nnoremap z] }zt

"
" Geeknote
"
nnoremap <space>g    :Geeknote<cr>
nnoremap <space>gn   :GeeknoteCreateNote<space>
nnoremap <space>gb   :GeeknoteCreateNotebook<space>
nnoremap <space>gn   :GeeknoteCreateNote<space>
nnoremap <space>gs   :GeeknoteSearch<space>
nnoremap <space>gy   :GeeknoteSync<cr>
nnoremap <space>gt   :GeeknoteCreateNote<space>dstamp
nnoremap <space>gw   :GeeknoteSaveAsNote<cr>
nnoremap <space>gx   :Subvert/{[ ],[X]}/{[X],[ ]}/g<cr>
nnoremap <space>g'   :%s/\(&amp;\)\?&apos;/'/g<cr>

autocmd BufReadPre *__Geeknote__* set ft=markdown

" Mappings to suport new day notes
cabbrev dstamp <C-R>=strftime("%Y-%m-%d - %A")<CR>
iabbrev dstamp <C-R>=strftime("%Y-%m-%d - %A")<CR>

autocmd FileType markdown
      \ nnoremap <C-x> :Subvert/{[ ],[X]}/{[X],[ ]}/g<cr>
