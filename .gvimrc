""" GVim/MacVim specific options (gui only) """
" Disable macvim blinking cursor
set gcr=n:blinkon0

set guioptions-=T
set guioptions-=r
" Window size
set columns=100 

cd ~/Dropbox

function! DoFocusMode()
  set invfu 
  set columns=100
endfunction

command! FocusMode call DoFocusMode()
map <silent> <F1> :FocusMode <cr>
