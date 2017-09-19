" Plugin Settings
"---------------------------------------------------------

if dein#tap('nerdtree') "{{{
	" auto open nerdtree on vim open if no files provided
	"autocmd StdinReadPre * let s:std_in=1
	"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

	" autpmatically exit vim in the last window is nerdtree
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

	map <silent>[unite]a :<C-u>NERDTreeFind<CR>

	let NERDTreeMapActivateNode = 'l'
	let NERDTreeMapCloseDir = 'h'
	let NERDTreeQuitOnOpen = 1
endif

"}}}
if dein#tap('YouCompleteMe') "{{{
	function! YcmRefactorRename()
		let s:new_name = input('Rename '. expand('<cword>') .' to: ')
		execute "YcmCompleter RefactorRename" s:new_name
	endfunction
	command! -nargs=+ -complete=file YcmRefactorRename <args>
	autocmd MyAutoCmd FileType javascript.jsx
		\ nnoremap <silent><Leader>jd :<c-u>YcmCompleter GoTo<CR>
		\ | nnoremap <silent><Leader>jr :<c-u>YcmCompleter GoToReferences<CR>
		\ | nnoremap <silent><Leader>jt :<c-u>YcmCompleter GetType<CR>
		\ | nnoremap <silent><Leader>rn :<c-u>call YcmRefactorRename()<CR>
endif

"}}}
if dein#tap('ctrlp.vim') "{{{
	let g:ctrlp_map = '<c-p>'
	let g:ctrlp_cmd = 'CtrlPMixed'
	nnoremap <silent> [unite]f  :<C-u>CtrlP<CR>
	nnoremap <silent> [unite]b  :<C-u>CtrlPBuffer<CR>
	let g:ctrlp_working_path_mode = 'ra'
endif

"}}}
if dein#tap('vim-grepper') "{{{
	nnoremap <silent> [unite]g  :<C-u>Grepper -tool ag<CR>
	nnoremap <silent> <Leader>gg :<C-u>Grepper -cword -noprompt -tool ag<CR><CR>
	vnoremap <silent> <Leader>gg
		\ :<C-u>call VSetSearch('/')<CR>:execute 'Grepper -noprompt -tool ag -query "'.@/.'"'<CR><CR>
endif

"}}}
if dein#tap('vim-operator-surround') "{{{
	map <silent>sa <Plug>(operator-surround-append)
	map <silent>sd <Plug>(operator-surround-delete)
	map <silent>sr <Plug>(operator-surround-replace)
	nmap <silent>saa <Plug>(operator-surround-append)<Plug>(textobj-multiblock-i)
	nmap <silent>sdd <Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)
	nmap <silent>srr <Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)
endif

"}}}
if dein#tap('vim-operator-replace') "{{{
	xmap p <Plug>(operator-replace)
endif

"}}}
if dein#tap('vim-operator-flashy') "{{{
	map y <Plug>(operator-flashy)
	nmap Y <Plug>(operator-flashy)$
endif

"}}}
if dein#tap('vim-niceblock') "{{{
	xmap I  <Plug>(niceblock-I)
	xmap A  <Plug>(niceblock-A)
endif

"}}}
if dein#tap('committia.vim') "{{{
	let g:committia_hooks = {}
	function! g:committia_hooks.edit_open(info)
		imap <buffer><C-d> <Plug>(committia-scroll-diff-down-half)
		imap <buffer><C-u> <Plug>(committia-scroll-diff-up-half)

		setlocal winminheight=1 winheight=1
		resize 10
	endfunction
endif

"}}}
if dein#tap('jedi-vim') "{{{
	let g:jedi#completions_command = ''
	let g:jedi#documentation_command = 'K'
	let g:jedi#use_splits_not_buffers = 'right'
	let g:jedi#goto_command = '<leader>d'
	let g:jedi#goto_assignments_command = '<leader>g'
	let g:jedi#rename_command = '<Leader>r'
	let g:jedi#usages_command = '<Leader>n'
endif

"}}}
if dein#tap('vim-gitgutter') "{{{
	let g:gitgutter_sign_added = '▎'
	let g:gitgutter_sign_modified = '▎'
	let g:gitgutter_sign_removed = '▏'
	let g:gitgutter_sign_removed_first_line = '▔'
	let g:gitgutter_sign_modified_removed = '▋'
	highlight! GitGutterAdd ctermfg=22 guifg=#006000 ctermbg=NONE guibg=NONE
	highlight! GitGutterChange ctermfg=58 guifg=#5F6000 ctermbg=NONE guibg=NONE
	highlight! GitGutterDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
	highlight! GitGutterChangeDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
	nmap <Leader>hj <Plug>GitGutterNextHunk
	nmap <Leader>hk <Plug>GitGutterPrevHunk
	nmap <Leader>hs <Plug>GitGutterStageHunk
	nmap <Leader>hr <Plug>GitGutterUndoHunk
	nmap <Leader>hp <Plug>GitGutterPreviewHunk
endif

"}}}
if dein#tap('vim-go') "{{{
	let g:go_fmt_command = 'goimports'
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
endif

"}}}
if dein#tap('vim-fugitive') "{{{
	nnoremap <Leader>gs :Gstatus<CR>
	nnoremap <Leader>gw :Gwrite<CR>
	nnoremap <Leader>go :Gread<CR>
	nnoremap <Leader>gR :Gremove<CR>
	nnoremap <Leader>gm :Gmove<Space>
	nnoremap <Leader>gc :Gcommit<CR>
	nnoremap <Leader>ga :Gcommit --amend<CR>
	nnoremap <Leader>gd :Gdiff<CR>
	nnoremap <Leader>gb :Gblame<CR>
	nnoremap <Leader>gB :Gbrowse<CR>
	nnoremap <Leader>gp :Git! push<CR>
	nnoremap <Leader>gP :Git! pull<CR>
	nnoremap <Leader>gi :Git!<Space>
	nnoremap <Leader>ge :Gedit<CR>
	nnoremap <Leader>gE :Gedit<Space>
	"
	"nnoremap <Leader>ggc :silent! Ggrep -i<Space>

	" for diffmode
	"noremap <localleader>du :diffupdate<CR>
endif

"}}}
if dein#tap('vim-asterisk') "{{{
	map g*  <Plug>(asterisk-g*)<Plug>(anzu-update-search-status)
	map *   <Plug>(asterisk-*)<Plug>(anzu-update-search-status)
	map g#  <Plug>(asterisk-g#)<Plug>(anzu-update-search-status)
	map #   <Plug>(asterisk-#)<Plug>(anzu-update-search-status)

	map z*  <Plug>(asterisk-z*)<Plug>(anzu-update-search-status)
	map gz* <Plug>(asterisk-gz*)<Plug>(anzu-update-search-status)
	map z#  <Plug>(asterisk-z#)<Plug>(anzu-update-search-status)
	map gz# <Plug>(asterisk-gz#)<Plug>(anzu-update-search-status)
	let g:asterisk#keeppos = 1
endif

"}}}
if dein#tap('CamelCaseMotion') "{{{
	nmap <silent> e <Plug>CamelCaseMotion_e
	xmap <silent> e <Plug>CamelCaseMotion_e
	omap <silent> e <Plug>CamelCaseMotion_e
	nmap <silent> w <Plug>CamelCaseMotion_w
	xmap <silent> w <Plug>CamelCaseMotion_w
	omap <silent> w <Plug>CamelCaseMotion_w
	nmap <silent> b <Plug>CamelCaseMotion_b
	xmap <silent> b <Plug>CamelCaseMotion_b
	omap <silent> b <Plug>CamelCaseMotion_b
endif

"}}}
if dein#tap('vim-textobj-multiblock') "{{{
	omap ab <Plug>(textobj-multiblock-a)
	omap ib <Plug>(textobj-multiblock-i)
	xmap ab <Plug>(textobj-multiblock-a)
	xmap ib <Plug>(textobj-multiblock-i)
endif

"}}}
if dein#tap('vim-choosewin') "{{{
	let g:choosewin_label = 'SDFHJKCN'
endif

"}}}
if dein#tap('vim-airline') "{{{
	if !exists("g:airline_symbols")
		let g:airline_symbols={}
		let g:airline_symbols.branch = ''
	endif
	let g:airline#extensions#tagbar#enabled = 1
endif

"}}}
if dein#tap('ultisnips') "{{{
	let g:UltiSnipsExpandTrigger="<tab>"
	let g:UltiSnipsJumpForwardTrigger="<m-c-l>"
	let g:UltiSnipsJumpBackwardTrigger="<m-c-h>"
	let g:UltiSnipsEditSplit="vertical"
	let g:UltiSnipsSnippetsDir="~/.dotfiles/nvim/snippets"
endif

"}}}
if dein#tap('ale') "{{{
  let g:ale_linters = {
				\ 'javascript': [ 'eslint' ],
				\ }
endif

"}}}
if dein#tap('incsearch.vim') "{{{
	let g:incsearch#auto_nohlsearch = 1

	map n  <Plug>(incsearch-nohl-n)
	map N  <Plug>(incsearch-nohl-N)
	map *  <Plug>(incsearch-nohl-*)
	map #  <Plug>(incsearch-nohl-#)
	map g* <Plug>(incsearch-nohl-g*)
	map g# <Plug>(incsearch-nohl-g#)

	map / <Plug>(incsearch-forward)
	map ? <Plug>(incsearch-backward)
	map g/ <Plug>(incsearch-stay)
endif

"}}}
if dein#tap('incsearch-fuzzy.vim') "{{{
	map z/ <Plug>(incsearch-fuzzy-/)
	map z? <Plug>(incsearch-fuzzy-?)
	map zg/ <Plug>(incsearch-fuzzy-stay)
endif

"}}}

" vim: set ts=2 sw=2 tw=80 noet :
