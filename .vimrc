"Load plugins with Vundle
set nocompatible
filetype off
"set runtimepath+=~/.vim/bundle/Vundle.vim
"call vundle#rc()
"call plug#begin('~/.local/share/nvim/site/plugged')
call plug#begin( stdpath('data') . '/plugged')
runtime macros/matchit.vim

set runtimepath^=~/.vim
set redrawtime=100000
set encoding=UTF-8

if exists('g:loaded_airline')
  set noshowmode
endif

" Syntax Plugins
"" Markup
Plug 'ap/vim-css-color'
Plug 'dahu/vim-asciidoc'
Plug 'digitaltoad/vim-jade'
Plug 'elzr/vim-json'
Plug 'othree/html5.vim'
Plug 'posva/vim-vue'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'

"" Prog Langs
Plug 'OmniSharp/omnisharp-vim'
Plug 'OrangeT/vim-csharp'
Plug 'elixir-lang/vim-elixir'
Plug 'groenewege/vim-less'
Plug 'kchmck/vim-coffee-script'
Plug 'mattn/emmet-vim'
Plug 'neilhwatson/vim_cf3'
Plug 'rust-lang/rust.vim'
Plug 'simeng/vim-imba'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'html', 'vue'] }
Plug 'mxw/vim-jsx'

" Functionality plugins
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'EinfachToll/DidYouMean'
Plug 'Lokaltog/vim-easymotion'
Plug 'SirVer/UltiSnips'
Plug 'bling/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'godlygeek/tabular'
Plug 'janko/vim-test'
Plug 'kien/ctrlp.vim'
Plug 'lambdalisue/suda.vim'
Plug 'mattn/gist-vim'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-tmuxify'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'notalex/vim-run-live'
Plug 'parkr/vim-jekyll'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'terryma/vim-expand-region'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-ruby/vim-ruby'

" Colo Plugins
Plug 'ajh17/Spacegray.vim'
Plug 'cseelus/vim-colors-clearance'
Plug 'flazz/vim-colorschemes'
Plug 'zefei/vim-colortuner'
Plug 'mhartington/oceanic-next'

" Dependencies - plugins I don't use directly but that other plugins need
Plug 'kana/vim-textobj-user'
Plug 'mattn/webapi-vim'

if has('nvim')
  "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'neoclide/coc.nvim', {'branch': 'release' }

  " Coc Nvim Config
  set hidden
  set cmdheight=2
  set updatetime=300
  set shortmess+=c
  set signcolumn=yes
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()

filetype plugin indent on


if (has("termguicolors"))
  set termguicolors
  execute 'colorscheme spacegray'
else
  for cs in ['spacegray', 'pencil', 'hybrid', 'wombat256mod', 'wombat256', 'default']
    try
      execute 'colorscheme' cs
      break
    catch
    endtry
  endfor
endif

"Set options for plugins
let g:python3_host_prog='/usr/local/bin/python3'
let g:pymode_python = 'python3'

let g:airline_theme='oceanicnext'
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

let g:webdevicons_enable = 1
let g:webdevicons_enable_airline_statusline = 1
let g:WebDevIconsOS = 'Darwin'

let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': [] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_jump                = 0
let g:syntastic_auto_loc_list            = 0
let g:syntastic_enable_signs             = 1
let g:syntastic_enable_highlighting      = 1
let g:syntastic_scss_checkers            = ['scss_lint']
let g:syntastic_python_python_exec = '/usr/bin/python3'

let g:vimwiki_list         = [{'path': '~/Dropbox/docs/vimwiki/'}]
let g:vimwiki_conceallevel = 0
let g:vimwiki_hl_headers   = 1

let g:gist_clip_command            = 'pbcopy'
let g:gist_open_browser_after_post = 1

let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsEditSplit     = 'horizontal'

"let g:deoplete#enable_at_startup = 1

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

let g:tmuxify_custom_command = 'tmux split-window -l 16'
let g:tmuxify_map_prefix = '<space>m'
let g:tmuxify_run = {
      \ 'c':  'rails c',
      \ 'gs': 'gs'
      \ }

let g:ctrlp_map = 'go'
let g:ctrlp_show_hidden = 1
let g:ctrlp_switch_buffer = 'ETVH'
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/]\.?(node_modules|tmp|public/assets|git|hg|svn)$'
      \}

nmap gr :CtrlPMRU<cr>

let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_settings = {
  \  'html' : {
  \    'indentation' : '  '
  \  },
  \}

let g:rust_recommended_style = 0

let g:jsx_ext_required = 0 " Allow JSX in normal JS files

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

" Might be nvim-only?
set clipboard+=unnamedplus

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

let g:run_mode_map = '<Leader>rr'

nmap ge :E
nmap gx :S
nmap g\ :V

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

" Better save
nnoremap <space>ww :w<cr>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

autocmd FileType css,vue setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown,vue setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript,vue setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType python setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

autocmd VimEnter * CtrlPClearCache

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

autocmd BufNewFile,BufNewFile html,javascript,css,sass,ruby let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)

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
let g:EasyMotion_keys = 'asdfjklzxcvqwer'
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

nmap <silent> <space>tn :TestNearest<CR>
nmap <silent> <space>tf :TestFile<CR>
nmap <silent> <space>ts :TestSuite<CR>
nmap <silent> <space>tl :TestLast<CR>
nmap <silent> <space>tg :TestVisit<CR>

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
match OverLength /\%101v./

" Jump around
nnoremap z[ {zt
nnoremap z] }zt

" Netrw
let g:netrw_liststyle=3
nnoremap <silent><space>gn :Explore<cr>

