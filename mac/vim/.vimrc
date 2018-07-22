" pathogen
execute pathogen#infect()
filetype plugin indent on
syntax on

" space leader
let mapleader = "\<Space>"
map <Leader> <Plug>(easymotion-prefix)

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 3
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = '💩'
let g:syntastic_warning_symbol = '🔥'
let g:syntastic_style_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⚠️'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" for better color readability against dark backgrounds
set background=dark

" fix backspace
set backspace=indent,eol,start

" ruler
set ruler

" no delay when escaping
set ttimeoutlen=0
" show status line
set laststatus=2
" modern encoding default
set encoding=utf-8

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

" wildmenu
set wildmenu
set wildmode=longest:full,full

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
" highlight search and remove highlights by pressing space
set hlsearch
map <Space> :nohlsearch<CR>
 
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
" nnoremap <C-h> :tabp<CR>
" nnoremap <C-l> :tabn<CR>

"switch splits
nnoremap <C-j> <C-w>j<CR>
nnoremap <C-k> <C-w>k<CR>
nnoremap <C-h> <C-w>h<CR>
nnoremap <C-l> <C-w>l<CR>

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

" move current window through tabs and merge
function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

nnoremap <C-m> :call MoveToNextTab()<CR><C-w>H
nnoremap <C-n> :call MoveToPrevTab()<CR><C-w>H
