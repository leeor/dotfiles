
" Key-mappings
"---------------------------------------------------------

" Non-standard {{{
" ------------

" Window-control prefix
nnoremap  [Window]   <Nop>
nmap      s [Window]

" File-operations prefix
nnoremap [File]  <Nop>
xnoremap [File]  <Nop>
nmap     ; [File]
xmap     ; [File]

" Fix keybind name for Ctrl+Spacebar
map <Nul> <C-Space>
map! <Nul> <C-Space>

" Disable arrow movement, resize splits instead.
if get(g:, 'elite_mode')
	nnoremap <Up>    :resize +2<CR>
	nnoremap <Down>  :resize -2<CR>
	nnoremap <Left>  :vertical resize +2<CR>
	nnoremap <Right> :vertical resize -2<CR>
endif

" Toggle fold
nnoremap <CR> za

" Use backspace key for matchit.vim
nmap <BS> %
xmap <BS> %

"}}}
" Global niceties {{{
" ---------------

" Start an external command with a single bang
nnoremap ! :!

" Allow misspellings
cnoreabbrev qw wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd
cnoreabbrev t tabe
cnoreabbrev T tabe

" Quick substitute within selected area
xnoremap s :s//<Left>

" Improve scroll, credits: https://github.com/Shougo
nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
	\ 'zt' : (winline() == 1) ? 'zb' : 'zz'
noremap <expr> <C-f> max([winheight(0) - 2, 1])
	\ ."\<C-d>".(line('w$') >= line('$') ? "L" : "M")
noremap <expr> <C-b> max([winheight(0) - 2, 1])
	\ ."\<C-u>".(line('w0') <= 1 ? "H" : "M")
noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "3\<C-e>")
noremap <expr> <C-y> (line("w0") <= 1         ? "k" : "3\<C-y>")

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Use tab for indenting in visual mode
vnoremap <Tab> >gv|
vnoremap <S-Tab> <gv
nnoremap > >>_
nnoremap < <<_

" Select last paste
nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

" Disable EX-mode
nnoremap  Q <Nop>
nnoremap gQ <Nop>

" Navigation in command line
cnoremap <C-j> <Left>
cnoremap <C-k> <Right>
cnoremap <C-h> <Home>
cnoremap <C-l> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <C-w>

" }}}
" File operations {{{
" ---------------

" When pressing <leader>cd switch to the directory of the open buffer
"map <Leader>cd :lcd %:p:h<CR>:pwd<CR>

" Save a file with sudo
" http://forrst.com/posts/Use_w_to_sudo_write_a_file_with_Vim-uAN
cmap W!! w !sudo tee % >/dev/null

" }}}
" Editor UI {{{
" ---------

" Show highlight names under cursor
nmap gh :echo 'hi<'.synIDattr(synID(line('.'), col('.'), 1), 'name')
	\.'> trans<'.synIDattr(synID(line('.'), col('.'), 0), 'name').'> lo<'
	\.synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name').'>'<CR>

" Toggle editor visuals
nmap <silent> <Leader>ts :setlocal spell!<cr>
nmap <silent> <Leader>th :nohlsearch<CR>
nmap <silent> <Leader>tw :setlocal wrap! breakindent!<CR>

" Tabs
nnoremap <silent> g0 :<C-u>tabfirst<CR>
nnoremap <silent> g$ :<C-u>tablast<CR>
nnoremap <silent> gr :<C-u>tabprevious<CR>

" }}}
" Totally Custom {{{
" --------------

" Remove spaces at the end of lines
nnoremap <silent> ,<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" Diff
nnoremap <silent> <expr> ,d ":\<C-u>".(&diff?"diffoff":"diffthis")."\<CR>"

" Source line and selection in vim
vnoremap <Leader>S y:execute @@<CR>:echo 'Sourced selection.'<CR>
nnoremap <Leader>S ^vg_y:execute @@<CR>:echo 'Sourced line.'<CR>

" Yank buffer's absolute path to X11 clipboard
nnoremap <Leader>y :let @+=expand("%:p")<CR>:echo 'Copied to clipboard.'<CR>

augroup MyAutoCmd " {{{
	if has('mac')
		" Use Marked for real-time Markdown preview
		autocmd FileType markdown
			\ nnoremap <Leader>P :silent !open -a Marked\ 2.app '%:p'<CR>:redraw!<CR>
	endif
augroup END
" }}}

" Returns visually selected text
function! VSetSearch(cmdtype) "{{{
	let temp = @s
	normal! gv"sy
	let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
	let @s = temp
endfunction "}}}

" Display diff from last save {{{
command! DiffOrig vert new | setlocal bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" }}}

" Append modeline to EOF {{{
nnoremap <silent> <Leader>ml :call <SID>append_modeline()<CR>

" Append modeline after last line in buffer
" See: http://vim.wikia.com/wiki/Modeline_magic
function! s:append_modeline() "{{{
	let l:modeline = printf(' vim: set ts=%d sw=%d tw=%d %set :',
				\ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
	call append(line('$'), l:modeline)
endfunction "}}}
" }}}

" Edit macro
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

"function! Ulti_ExpandOrJump_and_getRes()
"  call UltiSnips#ExpandSnippetOrJump()
"  return g:ulti_expand_or_jump_res
"endfunction
"autocmd VimEnter *
"  \ inoremap <expr><tab> Ulti_ExpandOrJump_and_getRes() > 0 ? "" : pumvisible() ? "\<c-n>" : "\<c-space>"
"  \ | imap <expr> <s-tab> pumvisible() ? "\<c-p>" : UltiSnips#JumpBackwards()

" s: Windows and buffers {{{

nnoremap <silent> [Window]v  :<C-u>vsplit<CR>
nnoremap <silent> [Window]h  :<C-u>split<CR>
nnoremap <silent> [Window]o  :<C-u>only<CR>
nnoremap <silent> [Window]b  :b#<CR>
nnoremap <silent> [Window]c  :close<CR>
nnoremap <silent><expr> [Window]q winnr('$') != 1 ? ':<C-u>close<CR>' : ''

" Split current buffer, go to previous window and previous buffer
nnoremap <silent> [Window]sh :split<CR>:wincmd p<CR>:e#<CR>
nnoremap <silent> [Window]sv :vsplit<CR>:wincmd p<CR>:e#<CR>
"}}}

" Plugins {{{

" fugitive {{{
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>go :Gread<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>ga :Gcommit --amend<CR>
nnoremap <Leader>gB :Gbrowse<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gE :Gedit<Space>
"}}}

" FZF {{{
nnoremap <silent> [File]f :<c-u>Files<cr>
nnoremap <silent> [File]b :<c-u>Buffers<cr>
nnoremap <silent> [File]h :<c-u>History<cr>
nnoremap <silent> [File]H :<c-u>Helptags<cr>
nnoremap <silent> [File]c :<c-u>BCommits<cr>
nnoremap <silent> [File]C :<c-u>Commits<cr>
nnoremap <silent> [File]g :<c-u>execute 'Ag '.input('Pattern: ')<cr>
nnoremap <silent> [File]l :<c-u>execute 'BLines '.input('Pattern: ')<cr>
nnoremap <silent> [File]L :<c-u>execute 'Lines '.input('Pattern: ')<cr>

nnoremap <silent> <leader>gg :<c-u>Ag <c-r><c-w><cr>
vnoremap <silent> <Leader>gg :<c-u>call VSetSearch('/')<CR>:execute 'Ag '.@/<CR>

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
" }}}

" incsearch {{{
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)

map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
"}}}

" incsearch-fuzzy {{{
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)
"}}}

" NERDTree {{{
map <silent>[File]a :<C-u>NERDTreeFind<CR>
"}}}

" ale {{{
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
"}}}

" Completion {{{
"inoremap <silent> <expr> <CR> ((pumvisible() && empty(v:completed_item)) ?  "\<c-y>\<cr>" : (!empty(v:completed_item) ? ncm2_ultisnips#expand_or("", 'n') : "\<CR>" ))
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return deoplete#mappings#smart_close_popup() . "\<CR>"
endfunction

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"}}}

" CamelCaseMotion {{{
nmap <silent> e <Plug>CamelCaseMotion_e
xmap <silent> e <Plug>CamelCaseMotion_e
omap <silent> e <Plug>CamelCaseMotion_e
nmap <silent> w <Plug>CamelCaseMotion_w
xmap <silent> w <Plug>CamelCaseMotion_w
omap <silent> w <Plug>CamelCaseMotion_w
nmap <silent> b <Plug>CamelCaseMotion_b
xmap <silent> b <Plug>CamelCaseMotion_b
omap <silent> b <Plug>CamelCaseMotion_b
"}}}

" operator-flashy {{{
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
"}}}

" vim-go {{{
autocmd MyAutoCmd FileType go
  \   nmap <C-]> <Plug>(go-def)
  \ | nmap <Leader>god  <Plug>(go-describe)
  \ | nmap <Leader>goc  <Plug>(go-callees)
  \ | nmap <Leader>goC  <Plug>(go-callers)
  \ | nmap <Leader>goi  <Plug>(go-info)
  \ | nmap <Leader>gom  <Plug>(go-implements)
  \ | nmap <Leader>gos  <Plug>(go-callstack)
  \ | nmap <Leader>goe  <Plug>(go-referrers)
  \ | nmap <Leader>gor  <Plug>(go-run)
  \ | nmap <Leader>gov  <Plug>(go-vet)
"}}}

" vim-mundo {{{
nnoremap <Leader>gu :MundoToggle<CR>
"}}}

" vim-asterisk {{{
map g*  <Plug>(incsearch-nohl)<Plug>(asterisk-g*)
map *   <Plug>(incsearch-nohl)<Plug>(asterisk-*)
map g#  <Plug>(incsearch-nohl)<Plug>(asterisk-g#)
map #   <Plug>(incsearch-nohl)<Plug>(asterisk-#)

map z*  <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)
map gz* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)
map z#  <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)
map gz# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)
"}}}

" Goyo {{{
nnoremap <Leader>G :Goyo<CR>
"}}}

" quickr-preview {{{
nmap <leader>p <plug>(quickr_preview)
"}}}

" LanguageClient {{{
augroup LanguageClientConfig
  autocmd!

  " <leader>ld to go to definition
  autocmd FileType sh,go,haskell,purescript,javascript,python,typescript,reason
				\ nnoremap <buffer> <leader>ld :call LanguageClient_textDocument_definition()<cr>
  " <leader>lf to autoformat document
  autocmd FileType sh,go,haskell,purescript,javascript,python,typescript,reason
				\ nnoremap <buffer> <leader>lf :call LanguageClient_textDocument_formatting()<cr>
  " <leader>lt for type info under cursor
  autocmd FileType sh,go,haskell,purescript,javascript,python,typescript,reason
				\ nnoremap <buffer> <leader>lt :call LanguageClient_textDocument_hover()<cr>
  " <leader>lr to rename variable under cursor
  autocmd FileType sh,go,haskell,purescript,javascript,python,typescript,reason
				\ nnoremap <buffer> <leader>lr :call LanguageClient_textDocument_rename()<cr>
  " <leader>lc to switch omnifunc to LanguageClient
  "autocmd FileType sh,go,haskell,purescript,javascript,python,typescript nnoremap <buffer> <leader>lc :setlocal omnifunc=LanguageClient#complete<cr>
  " <leader>ls to fuzzy find the symbols in the current document
  autocmd FileType sh,go,haskell,purescript,javascript,python,typescript,reason
				\ nnoremap <buffer> <leader>ls :call LanguageClient_textDocument_documentSymbol()<cr>

  " Use as omnifunc by default
  "autocmd FileType sh,go,haskell,purescript,javascript,python,typescript setlocal omnifunc=LanguageClient#complete
augroup END
"}}}

"}}}

" vim: set ts=2 sw=2 tw=80 noet :
