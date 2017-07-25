set nocp
set ttyfast
set t_Co=256

filetype on
filetype plugin on
filetype indent on
set tabstop=4 shiftwidth=4 expandtab
set ai
set si
set nu

set formatprg=par

set hlsearch
nnoremap <CR> :nohlsearch<CR><CR>

syntax on

set statusline+=%#warningmsg#
set statusline+=%*

let g:airline_powerline_fonts = 1
" Disable Ex mode
nnoremap Q <nop>

" ----- Spell check -----
" Git commits.
autocmd FileType gitcommit setlocal spell
"
" " Subversion commits.
autocmd FileType svn       setlocal spell
"
" " Mercurial commits.
autocmd FileType asciidoc  setlocal spell

set backspace=2 " now it works properly!

au FileType html setlocal ts=2 sw=2 sts=2
au FileType ruby setlocal ts=2 sw=2 sts=2
au FileType cpp setlocal ts=4 sw=4 sts=4

" highlight trailing tabs and spaces
set list
set listchars=tab:↣⇢,trail:·

set visualbell          " don't beep!
set wildmenu            " improved file select menu
set wildmode=list:longest " consistent with bash

let mapleader = ","
let g:mapleader = ","
set laststatus=2

" disable, because I don't really use them, but Ctrl-y,e are quite nice on their own
"map <C-E> $a
"map <C-A> ^i
"imap <C-E> $a
"imap <C-A> ^i

setlocal errorformat=line\ %l.
setlocal makeprg=perl\ -c\ %

set runtimepath^=~/.vim/bundle/ctrlp.vim
set runtimepath+=~/.vim/snippets

set path+=acceptance
set path+=src
set path+=tst

let g:UltiSnipsSnippetDirectories=["usnippets"]
let g:UltiSnipsSnippetsDir="~/.vim/snippets/usnippets"

let g:ctrlp_max_files=0
set wildignore+=*/tmp/*,*.so,*.swp,*.deb

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

execute pathogen#infect()
"colors twilight256
"colors wombat256
"colors gruvbox
colors mytwilight

map JI :JavaImport<CR>
map JO :JavaImportOrganize<CR>:%!imports<CR>
map JS :JavaSearch<CR>
map JC :JavaCorrect<CR>
map CC :%s/\s\+$//g<CR>
map JU :JUnit %<CR>

map { :tabprev<CR>
map } :tabnext<CR>

set showbreak=↪
