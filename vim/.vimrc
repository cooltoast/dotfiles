" for better color readability against dark backgrounds
set background=dark

" leader is space
let mapleader = "\<Space>"

" no delay when escaping
set ttimeoutlen=0
" show status line
set laststatus=2
" modern encoding default
set encoding=utf-8
syntax on

" map jk to esc in insert mode
:imap jk <Esc>
 
" use the damn hjkl keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
 
" remove gui options
set guioptions=

" continue indentation onto next line
set autoindent
" copy indentation structure of previous lines
set copyindent
" make vim smart about tabs
set smarttab
" use spaces for tab
set expandtab
" autoindent
set smartindent
" 2 spaces to tab
set shiftwidth=2
set softtabstop=2
" chhange existing tab characters to match current tab settings
retab
 
" keep 5 lines visible below cursor
set scrolloff=5

" search is case-insensitive unless there is a capital letter
set ignorecase
set smartcase
" show search results as you type
set incsearch
" show matching bracket
set showmatch
 
" scroll faster
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
 
" make : commands easier to type
nnoremap ; :
 
" keep semicolon accessible for idk what
nnoremap <leader>; ;
 
" show file name at bottom
set modeline
set ls=2

" wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" switch tabs faster
nnoremap <C-h> :tabp<CR>
nnoremap <C-l> :tabn<CR>

" yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

"##############################################################################
"#    cursor hacks                                                            #
"##############################################################################
"" use orange cursor in insert mode and gray cursor otherwise
if &term =~ "xterm\\|rxvt"
  let &t_SI = "\<Esc>]12;orange\x7"
  let &t_EI = "\<Esc>]12;gray\x7"
 
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
endif


" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()


" remember cursor location on exit
if has("autocmd")
  augroup vimrcEx
  au!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else
  set autoindent                " always set autoindenting on
endif " has("autocmd")
