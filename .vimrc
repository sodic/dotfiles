
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" Declare the list of plugins.
Plug 'morhetz/gruvbox'
Plug 'zah/nim.vim'
Plug 'mattn/emmet-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'roman/golden-ratio'
Plug 'godlygeek/tabular'
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
Plug 'vim-syntastic/syntastic'
Plug 'vim-scripts/indentpython.vim'
Plug 'chriskempson/base16-vim'
Plug 'pangloss/vim-javascript'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" syntastic checks for python3
let g:syntastic_python_python_exec = 'python3'


" highlight the current line and show hybrid line numbers
:set cursorline
:set number relativenumber

" theme settings
set termguicolors 
"let g:gruvbox_italic=1
"colorscheme gruvbox
"set background=dark    " Setting dark mode

let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-default-dark

" currently sets materia
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Override materia
colorscheme base16-material

" This sets the indicator for the 80 character line limit (Python, Haskell,
" Nim...)
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif


