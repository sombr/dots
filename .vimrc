set nocp
set ttyfast
set t_Co=256
colors twilight256
filetype on
filetype plugin on
filetype indent on
set tabstop=4 shiftwidth=4 expandtab
set ai
set si
set nu
syntax on

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
set statusline=%f%m%r%h%w\ %y\ branch:%{branch}%=col:%2c\ line:%2l/%L\ [%2p%%]

function FixSpaces()
    %s/^\(.*\S\)\s*$/\1/g
endfunction

function Comment()
    '<,'>s/^/#/g
endfunction

function UnComment()
    '<,'>s/^#//g
endfunction

function Pod(word)
    let cline = line('.')
    let pl = getline(cline)
    split pod
    let cmd = "read !echo '" . pl . "±§±" . a:word .  "'|perl -e '$_=<>; ($a, $b) = split(/±§±/, $_); chomp $b; $a =~ /([\\w:]*?$b[\\w:]*)/; print $1;' | xargs perldoc -t "
    return cmd
endfunction

function GetBranch()
    return system("git branch | grep '*' | perl -e '$_ = <STDIN>; chomp $_; $_ =~ s/[^\\w\\d_]+//g; print $_;'")
endfunction

function MakeTestFile()
    if isdirectory("lib")
        if !isdirectory("t")
            call mkdir("t", "p")
        endif
        let package = search("package\\s\\+\\S\\+;", "bsW")
        if package
            Wyt;
            g'
        endif
        tabedit t/test
        
    endif
endfunction

let branch = GetBranch()

map <C-E> $a
map <C-A> ^i
imap <C-E> $a
imap <C-A> ^i

map <Leader>f <ESC>:execute FixSpaces()<RETURN>

vmap <Leader>c :<C-U>call Comment()<CR>
vmap <Leader>C :<C-U>call UnComment()<CR>

setlocal errorformat=line\ %l.
setlocal makeprg=perl\ -c\ %

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_max_files=0
set wildignore+=*/tmp/*,*.so,*.swp,*.deb

execute pathogen#infect()
