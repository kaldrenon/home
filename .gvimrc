""" GVim/MacVim specific options (gui only) """
" Disable macvim blinking cursor
set gcr=n:blinkon0

set guioptions-=T
set guioptions-=r
" Window size
set columns=100 

cd ~/Dropbox

if has("mac")
  set guifont=Consolas:h16
endif

