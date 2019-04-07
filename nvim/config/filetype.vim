
" File Types
"-------------------------------------------------

" Reload vim config automatically {{{
execute 'autocmd MyAutoCmd BufWritePost '.$VIMPATH.'/config/*,vimrc nested'
	\ .' source $MYVIMRC | redraw'
" }}}

autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

function! s:find_project_root()
	exec "let l:projectRoot=fnamemodify(findfile('package.json','" . expand('%:p') . ";/'), ':p:h')"
	if l:projectRoot != ''
    call jobstart('find '. l:projectRoot .' -type f -iregex ".*\\.js$" -not -path "'. l:projectRoot . '/node_modules/*" -exec jsctags {} -f \; | sed "/^$/d" | LANG=C sort > '. l:projectRoot .'/tags')
	endif
endfunction

augroup MyAutoCmd

	" Automatically set read-only for files being edited elsewhere
	autocmd SwapExists * nested let v:swapchoice = 'o'

	" More eager than 'autoread'.
	autocmd WinEnter * checktime
"	autocmd WinEnter,FocusGained * checktime

	autocmd Syntax * if 5000 < line('$') | syntax sync minlines=200 | endif

	" Update filetype on save if empty
	autocmd BufWritePost * nested
		\ if &l:filetype ==# '' || exists('b:ftdetect')
		\ |   unlet! b:ftdetect
		\ |   filetype detect
		\ | endif

	" Reload Vim script automatically if setlocal autoread
	autocmd BufWritePost,FileWritePost *.vim nested
		\ if &l:autoread > 0 | source <afile> |
		\   echo 'source '.bufname('%') |
		\ endif

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	autocmd BufReadPost *
		\ if &ft !~ '^git\c' && ! &diff && line("'\"") > 0 && line("'\"") <= line("$")
		\|   exe 'normal! g`"zvzz'
		\| endif

	" Disable paste and/or update diff when leaving insert mode
	autocmd InsertLeave *
			\ if &paste | setlocal nopaste mouse=a | echo 'nopaste' | endif |
			\ if &l:diff | diffupdate | endif

	autocmd FileType help
		\ setlocal iskeyword+=: | setlocal iskeyword+=# | setlocal iskeyword+=-

	autocmd FileType crontab setlocal nobackup nowritebackup

	autocmd FileType gitcommit setlocal spell

	autocmd FileType gitcommit,qfreplace setlocal nofoldenable

	" https://webpack.github.io/docs/webpack-dev-server.html#working-with-editors-ides-supporting-safe-write
	autocmd FileType html,css,jsx,javascript,javascript.* setlocal backupcopy=yes

	autocmd FileType jsx,javascript,javascript.* setlocal foldmethod=syntax
	autocmd FileType jsx,javascript,javascript.* let &l:formatprg = "prettier --stdin-filepath " . expand("%")
	autocmd FileType json let &l:formatprg = "prettier --parser json --stdin-filepath " . expand("%")

	autocmd FileType zsh setlocal foldenable foldmethod=marker

	" Improved HTML include pattern
	autocmd FileType html
		\ setlocal includeexpr=substitute(v:fname,'^\\/','','') |
		\ setlocal path+=./;/

	autocmd BufNewFile,BufReadPost *.md set filetype=markdown

	autocmd FileType markdown
		\ setlocal spell expandtab autoindent
			\ formatoptions=tcroqn comments=n:>

	autocmd FileType apache setlocal path+=./;/

	autocmd FileType cam setlocal nonumber synmaxcol=10000

	autocmd FileType go highlight default link goErr WarningMsg |
				\ match goErr /\<err\>/

	" Open Quickfix window automatically
	autocmd QuickFixCmdPost [^l]* bel copen
		\ | wincmd p | redraw!
	autocmd QuickFixCmdPost l* bel lopen
		\ | wincmd p | redraw!

	" Fix window position of help/quickfix
	autocmd FileType help if &l:buftype ==# 'help'
		\ | wincmd L | endif

augroup END

" Internal Plugin Settings  {{{
" ------------------------

" PHP {{{
let g:PHP_removeCRwhenUnix = 0
" }}}

" Python {{{
let g:python_highlight_all = 1

let g:jedi#completions_command = ''
let g:jedi#documentation_command = 'K'
let g:jedi#use_splits_not_buffers = 'right'
let g:jedi#goto_command = '<leader>d'
let g:jedi#goto_assignments_command = '<leader>g'
let g:jedi#rename_command = '<Leader>r'
let g:jedi#usages_command = '<Leader>n'
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#show_call_signatures = 0
let g:jedi#use_tag_stack = 0
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0
let g:jedi#max_doc_height = 45
" }}}

" Vim {{{
let g:vimsyntax_noerror = 1
"let g:vim_indent_cont = 0
" }}}

" Bash {{{
let g:is_bash = 1

" }}}

" Java {{{
let g:java_highlight_functions = 'style'
let g:java_highlight_all = 1
let g:java_highlight_debug = 1
let g:java_allow_cpp_keywords = 1
let g:java_space_errors = 1
let g:java_highlight_functions = 1
" }}}

" detect flow using first line opt-on comment
" TODO detect `@flow` in a comment block, not necessarily the first line
autocmd BufRead * if getline(1) =~ '@flow' | setlocal filetype=javascript.flow | endif

" javascript.flow {{{
let g:javascript_plugin_flow = 1

let g:flow#autoclose=1
let g:flow#showquickfix=1
let g:flow#enable=0
let g:flow#omnifunc=0

let g:ale_linters['javascript.flow'] = ['eslint', 'flow']
let g:ale_fixers['javascript.flow'] = ['eslint']
" }}}

" JavaScript/JSX {{{
autocmd! User vim-jsx let g:jsx_ext_required = 1

let g:ale_linters.javascript = ['eslint', 'sentry']
let g:ale_linters['javascript.jsx'] = ['eslint', 'sentry']
let g:ale_fixers.javascript = ['eslint']
let g:ale_fixers['javascript.jsx'] = ['eslint']
" }}}

" JSON {{{
let g:ale_fixers.json = ['prettier']
" }}}

" ReasonML {{{
let g:ale_linters['reason'] = []
let g:ale_fixers['reason'] = ['refmt']
" }}}

" ocaml {{{
let g:ale_linters['ocaml'] = []
let g:ale_fixers['ocaml'] = ['ocamlformat']
" }}}

" haskell {{{
let g:haskell_classic_highlighting=1
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:necoghc_enable_detailed_browse = 1

let g:ale_linters.haskell = ['stack-ghc-mod', 'hlint', 'hdevtools', 'hfmt']
let g:ale_fixers.haskell = [{buffer -> {'command': 'hindent'}}]
" }}}

" golang {{{
let g:go_fmt_command = 'goimports'
let g:go_def_mapping_enabled = 0
let g:go_loaded_gosnippets = 1
let g:go_snippet_engine = 'ultisnips'
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
" }}}

" Markdown {{{
let g:gfm_syntax_enable_always = 0
let g:gfm_syntax_enable_filetypes = ['markdown']

let g:markdown_fenced_languages = [
	\  'css',
	\  'javascript',
	\  'js=javascript',
	\  'json=javascript',
	\  'python',
	\  'py=python',
	\  'sh',
	\  'sass',
	\  'xml',
	\  'vim',
	\  'git',
	\  'diff',
  \  'html'
	\]
" }}}

" Folding {{{
" augroup: a
" function: f
let g:vimsyn_folding = 'af'
let g:tex_fold_enabled = 1
let g:php_folding = 2
let g:php_phpdoc_folding = 1
let g:perl_fold = 1
" }}}
" }}}
" vim: set ts=2 sw=2 tw=80 noet :
