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


map j <Left>
map k <Up>
map l <Down>
map ; <Right>
imap jj <Esc>
set ignorecase
set smartcase

"Prevent clear register when text pasted
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'
