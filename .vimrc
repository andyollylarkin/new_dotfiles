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
:imap jj <Esc>
vmap j <Left>
vmap k <Up>
vmap l <Down>
vmap ; <Right>
vmap jj <Esc>
set ignorecase
set smartcase


noremap j <Left>
noremap k <Up>
noremap l <Down>
noremap ; <Right>
imap jj <Esc>

vmap j <Left>
vmap k <Up>
vmap l <Down>
vmap ; <Right>
vmap jj <Esc>
"Prevent clear register when text pasted
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'
