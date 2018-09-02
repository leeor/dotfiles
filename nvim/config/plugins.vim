" PLUGINS
" ==========================================

" Startup
" -------
Plug 'w0ng/vim-hybrid'
Plug 'itchyny/vim-parenmatch'
Plug 'thinca/vim-localrc'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-conflicted'
set stl+=%{ConflictedVersion()}

"nnoremap <Leader>ggc :silent! Ggrep -i<Space>

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
if !exists("g:airline_symbols")
  let g:airline_symbols={}
  let g:airline_symbols.branch = ''
endif
let g:airline#extensions#tagbar#enabled = 1
let g:airline_theme='wombat'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1

Plug 'ryanoasis/vim-devicons'

Plug 'easymotion/vim-easymotion'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'Shougo/vimproc.vim', {'do' : 'make'}

Plug 'haya14busa/incsearch.vim'
let g:incsearch#auto_nohlsearch = 1

Plug 'haya14busa/incsearch-fuzzy.vim'

Plug 'scrooloose/nerdtree'
" automatically exit vim in the last window is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeMapActivateNode = 'l'
let NERDTreeMapCloseDir = 'h'
let NERDTreeQuitOnOpen = 1

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-unimpaired'

Plug 'w0rp/ale'
let g:ale_linters = {}
let g:ale_fixers = {}
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_error=''
let g:ale_sign_warning=''

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
let g:AutoPairsMapCR = 1

" ------------
" Text objects
" ------------

Plug 'kana/vim-textobj-user'
Plug 'bkad/CamelCaseMotion'

Plug 'michaeljsmith/vim-indent-object'
Plug 'rhysd/vim-textobj-anyblock'
Plug 'tpope/vim-surround'

" ------------
" Operators
" ------------
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'

" ------------
" Languages
" ------------

" HTML {{{
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'mustache/vim-mustache-handlebars', { 'for': 'html' }
" }}}

" CSS {{{
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
Plug 'othree/csscomplete.vim', { 'for': 'css' }
" }}}

" Markdown {{{
Plug 'rhysd/vim-gfm-syntax', { 'for': 'markdown' }
" }}}

" javascript {{{
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'moll/vim-node', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'flowtype/vim-flow', { 'for': 'javascript', 'do': 'npm install -g flow-bin' }

Plug 'mxw/vim-jsx', { 'for': 'javascript' }
" }}}

" JSON {{{
Plug 'elzr/vim-json', { 'for': 'json' }
" }}}

" Haskell {{{
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
" }}}

" purescript {{{
Plug 'purescript-contrib/purescript-vim', { 'for': 'purescript' }
Plug 'FrigoEU/psc-ide-vim', { 'for': 'purescript' }
" }}}

" golang {{{
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries'}
" }}}

" lua {{{
Plug 'tbastos/vim-lua', { 'for': 'lua' }
" }}}

" python {{{
Plug 'mitsuhiko/vim-python-combined', { 'for': 'python' }
Plug 'raimon49/requirements.txt.vim', { 'for': 'requirements' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" }}}

" ruby {{{
Plug 'osyo-manga/vim-monster', { 'for': 'ruby' }
" }}}

" vimscript {{{
Plug 'vim-jp/syntax-vim-ex', { 'for': 'vim' }
" }}}

" CSV {{{
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
" }}}

" ReasonML {{{
Plug 'reasonml-editor/vim-reason-plus', { 'for': 'reason' }
" }}}

" Misc syntax {{{
Plug 'pearofducks/ansible-vim', { 'for': 'ansible' }
Plug 'groenewege/vim-less', { 'for': 'less' }
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
" }}}

" ------------
" Commands
" ------------
Plug 'Shougo/vinarise.vim', { 'on': 'Vinarise' }

Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

Plug 'metakirby5/codi.vim', { 'on': 'Codi' }

Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

Plug 'lambdalisue/vim-gista', { 'on': 'Gista' }
autocmd! User vim-gista let g:gista#client#cache_dir = $VARPATH.'/gista/'

" ------------
" Interface
" ------------
Plug 'haya14busa/vim-asterisk'
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

Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
let g:limelight_default_coefficient=0.8

Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
autocmd! User goyo.vim source $VIMPATH/config/plugins/goyo.vim

Plug 'junegunn/vim-peekaboo'

Plug 'beloglazov/vim-online-thesaurus'
Plug 'ronakg/quickr-preview.vim'
let g:quickr_preview_keymaps = 0

" ------------
" Completion
" ------------
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {}
"let g:LanguageClient_loggingLevel = 'DEBUG'
"let g:LanguageClient_loggingFile = '/Users/leeor/tmp/languageClient.log'
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_rootMarkers = {}

"  vim: set ts=2 sw=2 tw=80 et :
