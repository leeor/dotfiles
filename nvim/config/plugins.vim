" PLUGINS
" ==========================================

" Startup
" -------
Plug 'Shougo/dein.vim'
Plug 'w0ng/vim-hybrid'
Plug 'itchyny/vim-parenmatch'
Plug 'thinca/vim-localrc'
Plug 'tpope/vim-fugitive'
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

Plug 'vim-airline/vim-airline'
if !exists("g:airline_symbols")
  let g:airline_symbols={}
  let g:airline_symbols.branch = ''
endif
let g:airline#extensions#tagbar#enabled = 1
let g:airline_theme='wombat'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 0

Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
nnoremap <silent> [unite]f  :<C-u>CtrlP<CR>
nnoremap <silent> [unite]b  :<C-u>CtrlPBuffer<CR>
let g:ctrlp_working_path_mode = 'ra'

Plug 'Shougo/vimproc.vim', {'do' : 'make'}

Plug 'haya14busa/incsearch.vim'
let g:incsearch#auto_nohlsearch = 1

map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)

map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

Plug 'haya14busa/incsearch-fuzzy.vim'
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

Plug 'scrooloose/nerdtree'
" auto open nerdtree on vim open if no files provided
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" autpmatically exit vim in the last window is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

map <silent>[unite]a :<C-u>NERDTreeFind<CR>

let NERDTreeMapActivateNode = 'l'
let NERDTreeMapCloseDir = 'h'
let NERDTreeQuitOnOpen = 1

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-unimpaired'

Plug 'w0rp/ale'
let g:ale_linters = {
    \   'haskell': ['stack-ghc', 'ghc-mod', 'hlint', 'hdevtools', 'hfmt'],
    \}
let g:ale_fixers = {}
let g:ale_fixers.haskell = [{buffer -> {'command': 'hindent'}}]
let g:ale_fixers.javascript = ['eslint']
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_error=''
let g:ale_sign_warning=''
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

Plug 'itchyny/vim-cursorword'
autocmd MyAutoCmd FileType qf let b:cursorword=0

Plug 'airblade/vim-gitgutter'
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
let g:gitgutter_map_keys = 0
let g:gitgutter_sh = $SHELL

Plug 'tpope/vim-sleuth'
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.dotfiles/nvim/snippets"
let g:ulti_expand_or_jump_res = 0 "default value, just set once

Plug 'jiangmiao/auto-pairs'
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")


" ==========================================
" Text objects
" ------------

Plug 'kana/vim-textobj-user'
Plug 'bkad/CamelCaseMotion'
nmap <silent> e <Plug>CamelCaseMotion_e
xmap <silent> e <Plug>CamelCaseMotion_e
omap <silent> e <Plug>CamelCaseMotion_e
nmap <silent> w <Plug>CamelCaseMotion_w
xmap <silent> w <Plug>CamelCaseMotion_w
omap <silent> w <Plug>CamelCaseMotion_w
nmap <silent> b <Plug>CamelCaseMotion_b
xmap <silent> b <Plug>CamelCaseMotion_b
omap <silent> b <Plug>CamelCaseMotion_b

Plug 'michaeljsmith/vim-indent-object'
Plug 'rhysd/vim-textobj-anyblock'
Plug 'tpope/vim-surround'

" ==========================================
" Operators
" ---------
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

" Languages
" ---------
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'mustache/vim-mustache-handlebars', { 'for': 'html' }
Plug 'pearofducks/ansible-vim', { 'for': 'ansible' }
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
Plug 'othree/csscomplete.vim', { 'for': 'css' }

Plug 'rhysd/vim-gfm-syntax', { 'for': 'markdown' }
let g:gfm_syntax_enable_always = 0
let g:gfm_syntax_enable_filetypes = ['markdown']

Plug 'elzr/vim-json', { 'for': 'json' }

Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'moll/vim-node', { 'for': 'javascript' }

Plug 'mxw/vim-jsx', { 'for': 'javascript' }
autocmd! User vim-jsx let g:jsx_ext_required = 0

Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
autocmd! User javascript-libraries-syntax.vim
  \ let g:used_javascript_libs = 'react,underscore,chai'

Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
let g:haskell_classic_highlighting=1
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

Plug 'eagletmt/ghcmod-vim'

Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries'}
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
let g:go_def_mapping_enabled = 0
let g:go_loaded_gosnippets = 1
let g:go_snippet_engine = 'ultisnips'
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

Plug 'tbastos/vim-lua', { 'for': 'lua' }
Plug 'mitsuhiko/vim-python-combined', { 'for': 'python' }
Plug 'raimon49/requirements.txt.vim', { 'for': 'requirements' }
Plug 'osyo-manga/vim-monster', { 'for': 'ruby' }
Plug 'vim-jp/syntax-vim-ex', { 'for': 'vim' }

Plug 'chrisbra/csv.vim', { 'for': 'csv' }
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }
Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }
Plug 'jstrater/mpvim', { 'for': 'portfile' }
Plug 'tpope/vim-git', { 'for': [ 'gitcommit', 'gitrebase', 'gitconfig' ]}
Plug 'robbles/logstash.vim', { 'for': 'logstash' }
Plug 'andreshazard/vim-logreview', { 'for': 'logreview' }
Plug 'exu/pgsql.vim', { 'for': 'pgsql' }
Plug 'othree/nginx-contrib-vim', { 'for': 'nginx' }

" ==========================================
" Commands
" --------
Plug 'Shougo/vinarise.vim', { 'on': 'Vinarise' }
"- { repo: guns/xterm-color-table.vim, { 'on': 'XtermColorTable' } }
"- { repo: thinca/vim-prettyprint, { 'on': 'PP,' } on_func: PP }

Plug 'gregsexton/gitv', { 'on': 'Gitv' }

Plug 'metakirby5/codi.vim', { 'on': 'Codi' }

Plug 'mhinz/vim-grepper', { 'on': 'Grepper' }
nnoremap <silent> [unite]g  :<C-u>Grepper -tool ag<CR>
nnoremap <silent> <Leader>gg :<C-u>Grepper -cword -noprompt -tool ag<CR><CR>
vnoremap <silent> <Leader>gg
  \ :<C-u>call VSetSearch('/')<CR>:execute 'Grepper -noprompt -tool ag -query "'.@/.'"'<CR><CR>

Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
nnoremap <Leader>gu :MundoToggle<CR>

Plug 'lambdalisue/vim-gista', { 'on': 'Gista' }
autocmd! User vim-gista let g:gista#client#cache_dir = $VARPATH.'/gista/'

" ==========================================
" Interface
" ---------
Plug 'haya14busa/vim-asterisk'
map g*  <Plug>(incsearch-nohl)<Plug>(asterisk-g*)
map *   <Plug>(incsearch-nohl)<Plug>(asterisk-*)
map g#  <Plug>(incsearch-nohl)<Plug>(asterisk-g#)
map #   <Plug>(incsearch-nohl)<Plug>(asterisk-#)

map z*  <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)
map gz* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)
map z#  <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)
map gz# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)
let g:asterisk#keeppos = 1

Plug 'rhysd/committia.vim'
"  on_path: COMMIT_EDITMSG
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
  imap <buffer><C-d> <Plug>(committia-scroll-diff-down-half)
  imap <buffer><C-u> <Plug>(committia-scroll-diff-up-half)

  setlocal winminheight=1 winheight=1
  resize 10
endfunction
autocmd! User committia.vim let g:committia_min_window_width = 70

Plug 'Konfekt/FastFold'
autocmd! User FastFold FastFoldUpdate

Plug 'tpope/vim-dispatch', { 'on': ['Make', 'Make!', 'Dispatch', 'Focus', 'Focus!', 'Start', 'Start!' ]}
  "  hook_add:
  "    let g:dispatch_do_filetypes = [
  "      'ansible', 'python', 'php', 'ruby', 'vim', 'go', 'sh',
  "      'javascript', 'javascript.jsx', 'json', 'css', 'yaml',
  "      'markdown', 'html'
  "    ] |
  "    autocmd MyAutoCmd BufWritePost *
  "    if index(g:dispatch_do_filetypes, &filetype) > -1 && empty(&buftype)
  "    | Make
  "    | endif
  "autocmd User DispatchFinished if (empty(getloclist(0))) | lclose | endif

Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }

Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
nnoremap <Leader>G :Goyo<CR>
autocmd! User goyo.vim source $VIMPATH/config/plugins/goyo.vim

" ==========================================
" Completion
" ----------
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !git submodule update --init --recursive && ./install.py --tern-completer
  endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
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
let g:ycm_key_list_select_completion = ['<tab>', '<Down>']
let g:ycm_key_list_previous_completion = ['<s-tab>', '<Up>']
let g:ycm_complete_in_comments = 1
let g:ycm_use_ultisnips_completer = 0
let g:ycm_auto_trigger = 1

Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:ycm_semantic_triggers = {}
let g:ycm_semantic_triggers.haskell = ['.']
let g:necoghc_enable_detailed_browse = 1

Plug 'davidhalter/jedi-vim', { 'for': 'python' }
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

"  vim: set ts=2 sw=2 tw=80 et :
