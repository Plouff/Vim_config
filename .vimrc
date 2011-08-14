" Enable commands not implemented in Vi (not sure)
" This must be first, because it changes other options as a side effect.
set nocompatible

"activate pathogen
if &diff
  silent! call pathogen#runtime_append_all_bundles() " silent to avoid issue with DesSync diff
else
  call pathogen#runtime_append_all_bundles()
endif
call pathogen#helptags()

"======================================================
"======================================================
"==========                                   =========
"==========     VARIABLES CONFIGURATION       =========
"==========                                   =========
"======================================================
"======================================================

" Font of the gui
"set guifont=-b&h-lucida\ sans\ typewriter-medium-r-normal-sans-12-120-72-72-m-0-iso8859-1
"set guifontset=-*-*-medium-r-normal--12-*-*-*-m-*-*-*
"set guifont=-adobe-courier-medium-r-normal--12-120-75-75-m-70-*
set guifont=LucidaTypewriter\ 9

if v:version >= 703
    "undo settings
    set undodir=~/.vim/undofiles
    set undofile

    set colorcolumn=+1 "mark the ideal max text width
endif

" Display line numbers
set number
" Enable deletion of some special characters
set backspace=start,eol,indent

" Indent settings
set sw=2  " Size of shifts (<<, >>, etc. commands)
set shiftround " Round indent to multiple of 'shiftwidth'.  Applies to > and < commands.
set smartindent
set autoindent

" Fold settings
set foldmethod=indent " Fold based on indent
set foldnestmax=3     " Deepest fold is 3 levels
set nofoldenable      " Dont fold by default
"set foldlevel=999    " Open all fold at start up

" Search settings
set incsearch " Find the next match as we type the search
set hlsearch  " Highlight search )=> :nohls to disable highlight

" Add bottom slider
set guioptions+=b

" Set formatting of file in UNIX style (end of line)
" if has( "unix")
set ff=unix
set ffs=unix
" endif

" Tabulations setting
set expandtab " Replace tabulation with spaces
set ts=2      " Size of tabulation in space

"set wildmode=list:longest   " Make cmdline tab completion similar to bash
"set wildmenu                " Enable ctrl-n and ctrl-p to scroll thru matches
"set wildignore=*.o,*.obj,*~ " Stuff to ignore when tab completing

"display tabs and trailing spaces
"set list
"set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

" Always show current mode
set showmode
"show incomplete cmds down the bottom
set showcmd
" Sentence are wrapped without breaking words
set linebreak

" Dictionary location
set dictionary=/usr/share/dict/words
" Enable completion from dict
"set complete+=k

" Comment leader is inserted automatically when starting a new line in a comment (<CTRL-U> to remove comment of a line)
set formatoptions+=r

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

" Window size and position
"winpos 1 37
if has("gui_running")
  set lines=50
  set columns=120
endif
if &diff
  set lines=50
  set columns=200
endif
" Deafult register of vim is the clipboard of the operating system
set clipboard=unnamed
" Number of remembered commands
set history=500
" This sets the minimum window height to N
set wmh=0
" Always show status line
set laststatus=2
" Show the cursor position all the time
set ruler

" Load filetype plugin and indent files
filetype indent on
filetype plugin on

" Some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

" Tell the term has 256 colors
set t_Co=256

" Use interactive shells with ! to use aliases
" set shellcmdflag+=ic

"diff options
set diffopt=filler,iwhite

"Maximum width of text that is being inserted.  A longer line will be broken after white space to get this width
set textwidth=0

" Auto change directory
set autochdir

" Clear autocommands before doing anything
"autocmd! BufNewFile,BufRead *.h
"autocmd! BufNewFile,BufRead *.svh
"autocmd! BufNewFile,BufRead *.svp

"autocmd BufNewFile,BufRead *.h   set syntax=verilog_systemverilog
"autocmd BufNewFile,BufRead *.h   set filetype=verilog_systemverilog
"autocmd BufNewFile,BufRead *.svh set syntax=verilog_systemverilog
"autocmd BufNewFile,BufRead *.svh set filetype=verilog_systemverilog
"autocmd BufNewFile,BufRead *.svp set syntax=verilog_systemverilog
"autocmd BufNewFile,BufRead *.svp set filetype=verilog_systemverilog

"autocmd BufNewFile,BufRead *.cpf set syntax=tcl
"autocmd BufNewFile,BufRead *.cpf set filetype=tcl

if has('win32') || has ('win64')
    let $VIMHOME = $VIM."/vimfiles"
else
    let $VIMHOME = $HOME."/.vim"
endif
" Load manually the snip mate plugin
source $VIMHOME/bundle/SnipMate/after/plugin/snipMate.vim

"======================================================
"======================================================
"==========                                   =========
"==========           TAGS USAGE              =========
"==========                                   =========
"======================================================
"======================================================
" Tags file search
set tags=./tags;/

" For taglist plugin
if has("unix") " For environment at ST
  let Tlist_Ctags_Cmd = "~/mytools/ctags"
elseif has("win32")
  let Tlist_Ctags_Cmd="C:/cygwin/bin/ctags.exe"
elseif has("win32unix") " For Cygwin
  let Tlist_Ctags_Cmd="/usr/bin/ctags"
endif
" Open tag under cursor in new tab
nmap <C-Enter> <C-w><C-]><C-w>T

"======================================================
"======================================================
"==========                                   =========
"==========          STATUS LINE MGT          =========
"==========                                   =========
"======================================================
"======================================================
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=underline
  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif


" General
"set statusline=%<%f\ %h%w%m%r%y\ \%{g:TabStatStr}%{&ff}\ %=L:%l/%L(%p%%)\ C:%c\ F:%{foldlevel('.')}
set statusline=%f
set statusline+=%#error#
set statusline+=\%{g:TabStatStr}
set statusline+=%*

"display a warning if fileformat isnt unix
if has("unix") || has("win32unix")
  set statusline+=%#warningmsg#
  set statusline+=%{&ff!='unix'?'['.&ff.']':''}
  set statusline+=%*
elseif has("win32") || has("win64")
  set statusline+=%#warningmsg#
  set statusline+=%{&ff!='dos'?'['.&ff.']':''}
  set statusline+=%*
endif

set statusline+=%h "help file flag
set statusline+=%y "filetype
set statusline+=%r "read only flag
set statusline+=%m "modified flag

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%#warningmsg#
set statusline+=%{StatuslineTrailingSpaceWarning()}
set statusline+=%*

if ! &diff
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
endif

" Right alignment
set statusline+=%=
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=L:%l/%L(%p%%)\ C:%c\ F:%{foldlevel('.')}

"======================================================
"======================================================
"==========                                   =========
"==========     HIGHLIGHTING MANAGEMENT       =========
"==========                                   =========
"======================================================
"======================================================

" Define autocmd for some highlighting *before* the colorscheme is loaded
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=#444444
autocmd ColorScheme * highlight Tab             ctermbg=blue      guibg=blue
" For function ToggleTabDisp
let TabAreBlue = 1
let TabStatStr = ""

" Load color scheme
colorscheme elflord

" Enable syntax detection
syntax enable

" Show trailing whitepace and spaces before a tab
autocmd Syntax * syn match ExtraWhitespace / \+$\| \+\ze\t/ containedin=ALL
"  Show tabs
autocmd Syntax * syn match Tab /\t/ containedin=ALL

" Disable matching of EOL spaces during insert mode
" FIXME
" To avoid memory leak with lots of syn match definitions when entering and leaving insert mode
"autocmd BufWinLeave * call clearmatches()
"autocmd InsertEnter * syn match ExtraWhitespace / \+\(\%#\)\@<!$/ containedin=ALL
"autocmd InsertLeave * syn match ExtraWhitespace / \+$\| \+\ze\t/ containedin=ALL

"======================================================
"======================================================
"==========                                   =========
"==========           AUTOCOMMANDS            =========
"==========                                   =========
"======================================================
"======================================================

" autochdir is used but "When this option is on some plugins may not work."
" autocmd BufEnter * lcd %:p:h


"======================================================
"======================================================
"==========                                   =========
"==========         PLUGIN OPTIONS            =========
"==========                                   =========
"======================================================
"======================================================

" // is used as comment for verilog
let NERD_use_c_style_verilog_comments = 0

"
" syntastic settings
"
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

"
" taglist settings
"
nnoremap <silent> <F9> :TlistToggle<CR>
let tlist_verilog_systemverilog_settings = 'SystemVerilog;' .
      \'f:function;' .
      \'t:task;' .
      \'m:module;' .
      \'p:program;' .
      \'i:interface;' .
      \'k:package;' .
      \'c:class;' .
      \'v:variable;' .
      \'e:enum;' .
      \'d:typedef;' .
      \'r:real'

let Tlist_Compact_Format = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 0
let Tlist_WinWidth = 35
let tlist_php_settings = 'php;c:class;f:Functions'
let Tlist_Use_Right_Window=1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Display_Tag_Scope = 1
let Tlist_Process_File_Always = 0
let Tlist_Show_One_File = 1

"======================================================
"======================================================
"==========                                   =========
"==========            KEY BINDINGS           =========
"==========                                   =========
"======================================================
"======================================================

" Toogle hlsearch
noremap ,h :set invhlsearch<CR>
noremap ,w :let &wrap = !&wrap<CR>
noremap ,s :source ~/.vimrc<CR>
if has("unix") || has("win32unix")
  noremap ,e :tabnew ~/.vimrc<CR>
elseif has("win32") || has("win64")
  noremap ,e :tabnew $VIM/_vimrc<CR>
endif
noremap ,l :set background=light<CR>
noremap ,d :set background=dark<CR>
noremap ,t :call ToggleTabDisp()<CR>
noremap Q A

" Switch windows splits
" ^Wt     makes the first (topleft) window current
" ^WK     moves the current window to full-width at the very top
" ^WH     moves the current window to full-height at far left
noremap <Leader>v <C-W>t<C-W>H
noremap <Leader>h <C-W>t<C-W>K

" Reselect a visual selection after shift or indent
vnoremap < <gv
vnoremap > >gv

vnoremap = =gv

" To move between buffers and maximise the selected one
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
" Change size of windows
map <M--> <C-W>-
map <M-+> <C-W>+

" Move and shift display
noremap <M-j> jzz
noremap <M-k> kzz

" Move display line by display line instead of line by line
noremap  <silent> <Up>   gk
noremap  <silent> <Down> gj
inoremap <silent> <Up>   <C-O>gk
inoremap <silent> <Down> <C-O>gj
inoremap <silent> <Home> <C-o>g<Home>
inoremap <silent> <End>  <C-o>g<End>

" Paste and indent
nnoremap <c-p> p=`]

" Size of windows
noremap <M--> <C-w>-
noremap <M-=> <C-w>+

" Auto-generate named port connections
" USAGE: To use this command, instantiate a module with positional ports all on one line and
" then position the cursor on this line and press the mapped keys.
map <Leader>p 0/(/<cr>i<cr><esc>:s/\([^ (),;][^ (),;]*\)/.\1(\1)/g<cr>kJ

"======================================================
"======================================================
"==========                                   =========
"==========         SOME FUNCTIONS            =========
"==========                                   =========
"======================================================
"======================================================

" Smart home
" the <home> key behave as it does in such IDEs as PythonWin or MSVisualStudio, and that is first go to the first non whitespace, and then to the first char on the line.

function! s:SmartHome()
  if col('.') != match(getline('.'), '\S')+1
    norm ^
  else
    :call cursor(line('.'),2)
    norm h
  endif
endfunction
inoremap <silent><home> <C-O>:call <SID>SmartHome()<CR>
nnoremap <silent><home> :call <SID>SmartHome()<CR>
vnoremap <silent><home> :call <SID>SmartHome()<CR>

" Diff function
set diffexpr=MyDiff()
function! MyDiff()
  let opt = ""
  if &diffopt =~ "icase"
    let opt = opt . "-i "
  endif
  if &diffopt =~ "iwhite"
    let opt = opt . "-b "
  endif
  silent execute "!diff -a --binary " . opt . v:fname_in . " " . v:fname_new . " > " . v:fname_out
endfunction


function! Dec2Hex()
    let lstr = getline(".")
    let linenum = line(".")
    let decstr = matchstr(lstr, '\<[0-9]\+\>')
    while decstr != ""
        let decstr = printf("0x%X", decstr)
        exe 's#\<[0-9]\+\>#'.decstr."#"
        let lstr = getline(".")
        let decstr = matchstr(lstr, '\<[0-9]\+\>')
    endwhile
    echo "line: ".linenum
    "call cursor( linenum ,  "0" )
    "exe 's#0x##g'
endfunction


" To toogle display of tabs
function! ToggleTabDisp()
  if g:TabAreBlue == 1
    highlight Tab guibg=NONE ctermbg=NONE
    let g:TabAreBlue = 0
    let g:TabStatStr = "[NoTab]"
    echo "Tab not highlighted"
  else
    highlight Tab ctermbg=blue  guibg=blue
    let g:TabAreBlue = 1
    let g:TabStatStr = ""
    echo "Tab highlighted"
  endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
  if !exists("b:statusline_tab_warning")
    let b:statusline_tab_warning = ''

    if !&modifiable
      return b:statusline_tab_warning
    endif

    let tabs = search('^\t', 'nw') != 0

    "find spaces that arent used as alignment in the first indent column
    let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

    if tabs && spaces
      let b:statusline_tab_warning = '[mixed-indenting]'
    elseif (spaces && !&et) || (tabs && &et)
      let b:statusline_tab_warning = '[&et]'
    endif
  endif
  return b:statusline_tab_warning
endfunction

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
  if !exists("b:statusline_trailing_space_warning")

    if !&modifiable
      let b:statusline_trailing_space_warning = ''
      return b:statusline_trailing_space_warning
    endif

    if search('\s\+$', 'nw') != 0
      let b:statusline_trailing_space_warning = '[\s]'
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif
  return b:statusline_trailing_space_warning
endfunction

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

" Tabs line management

"set tabline=%!MyTabLine()
"set tabline=%S

"function! MyTabLabel(n)
  "let buflist = tabpagebuflist(a:n)
  "let winnr = tabpagewinnr(a:n)
  "let bname = bufname(buflist[winnr - 1])
  "let bname = substitute( bname, '.*\/', '->' )
  "return bname
"endfunction

"function! MyTabLine()
  "let s = ''
  "for i in range(tabpagenr('$'))
    " select the highlighting
    "if i + 1 == tabpagenr()
      "let s .= '%#TabLineSel#'
    "else
      "let s .= '%#TabLine#'
    "endif

    " set the tab page number (for mouse clicks)
    "let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    "let s .= ' %{MyTabLabel(' . (i + 1) . ')} '

  "endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  "let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  "if tabpagenr('$') > 1
    "let s .= '%=%#TabLine#%999Xclose'
  "endif

  "return s
"endfunction

"======================================================
"======================================================
"==========                                   =========
"==========               TIPS                =========
"==========                                   =========
"======================================================
"======================================================

" Commandes utiles :
" set wrap/nowrap   : cesure des lignes
" set (no)linebreak : cesure en debut de mot ou au milieu des mots
" set hlsearch      : hl apres recherche
" :s/?/!/gc         : c => demande avant de substituer, g => remplace sur toute la ligne
" set scrollbind    : synchronised scrolling

"source $VIMRUNTIME/mswin.vim
"behave mswin

" Ask vim where an option was set.
":verbose set history?

" Match parts of a word
" For instance, "\\<re\\%[tur]\\>" will match "re", "ret", "retu" or "retur"

" Use previous matched pattern:
" :s//\=submatch(n)

" Recompute text width
" gq
" whole file : gg qg G
