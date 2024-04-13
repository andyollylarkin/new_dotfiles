set nu
set ignorecase
set title
set ruler
set smartcase
set autoindent
set ts=4
set expandtab
let python_highlight_all = 1
syntax enable


:noremap j <Left>
:noremap k <Up>
:noremap l <Down>
:noremap ; <Right>
:map h <Nop>
vmap j <Left>
vmap k <Up>
vmap l <Down>
vmap ; <Right>
set ignorecase
set smartcase


noremap j <Left>
noremap k <Up>
noremap l <Down>
noremap ; <Right>

vmap j <Left>
vmap k <Up>
vmap l <Down>
vmap ; <Right>
"Prevent clear register when text pasted
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'
