
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

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>

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

" s: Windows and buffers {{{
" Split current buffer, go to previous window and previous buffer
nnoremap <silent> [Window]sh :split<CR>:wincmd p<CR>:e#<CR>
nnoremap <silent> [Window]sv :vsplit<CR>:wincmd p<CR>:e#<CR>
"}}}

" Plugins {{{

" fugitive {{{
nnoremap <Leader>gs :vertical Git<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>go :Gread<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>ga :Gcommit --amend<CR>
nnoremap <Leader>gB :Gbrowse<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gE :Gedit<Space>
"}}}

" NERDTree {{{
map <silent>[File]a :<C-u>NERDTreeFind<CR>
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

" Goyo {{{
nnoremap <Leader>G :Goyo<CR>
"}}}

" quickr-preview {{{
nmap <leader>p <plug>(quickr_preview)
"}}}

" netrw {{{
autocmd filetype netrw nmap <buffer> l <cr>
"}}}

"}}}

" populate the args list with the files in quickfix list
command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

" choosewin
nmap  -  <Plug>(choosewin)
nmap  <silent> _ :ChooseWinSwapStay<CR>

" vim: set ts=2 sw=2 tw=80 noet :
