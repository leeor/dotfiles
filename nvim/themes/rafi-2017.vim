" rafi-2017 - hybrid custom
" =========================

" gVim Appearance {{{
" ---------------------------------------------------------
if has('gui_running')
	set guifont=PragmataPro:h14
	set noantialias
endif
" }}}

" UI elements {{{
" ---------------------------------------------------------
set showbreak=↪
set fillchars=vert:│,fold:─
set listchars=tab:\⋮\ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·
" }}}

" Highlights: General GUI {{{
" ---------------------------------------------------------
" highlight! Error  term=NONE cterm=NONE
" highlight! link WarningMsg  Comment
highlight! link pythonSpaceError  NONE
highlight! link pythonIndentError NONE
" highlight! link mkdLineBreak      NONE
highlight! link ExtraWhitespace  SpellBad
" }}}

" Plugin: Tagbar icons {{{
" ---------------------------------------------------------
let g:tagbar_iconchars = ['▷', '◢']
"}}}

" Plugin: Neomake icons {{{
" ---------------------------------------------------------
let g:neomake_error_sign = {'text': '◤', 'texthl': 'ErrorMsg'}
let g:neomake_warning_sign = {'text': '◸', 'texthl': 'WarningMsg'}
let g:neomake_message_sign = {'text': 's', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign = {'text': 'i', 'texthl': 'NeomakeInfoSign'}
"}}}

" Plugin: GitGutter icons {{{
" ---------------------------------------------------------
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▋'
"}}}

" Plugin: vim-gitgutter {{{
" ---------------------------------------------------------
highlight! GitGutterAdd ctermfg=22 guifg=#006000 ctermbg=NONE guibg=NONE
highlight! GitGutterChange ctermfg=58 guifg=#5F6000 ctermbg=NONE guibg=NONE
highlight! GitGutterDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
highlight! GitGutterChangeDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
" }}}

" Plugin: denite {{{
" ---------------------------------------------------------
highlight! clear WildMenu
highlight! link WildMenu CursorLine
highlight! link deniteSelectedLine Type
highlight! link deniteMatchedChar Function
highlight! link deniteMatchedRange Underlined
highlight! link deniteMode Comment
highlight! link deniteSource_QuickfixPosition qfLineNr
" }}}

" Plugin: vim-operator-flashy {{{
" ---------------------------------------------------------
highlight! link Flashy DiffText
" }}}

" Plugin: vim-bookmarks {{{
let g:bookmark_sign = '⚐'
highlight! BookmarkSign            ctermfg=12 guifg=#4EA9D7
highlight! BookmarkAnnotationSign  ctermfg=11 guifg=#EACF49
" }}}

" vim: set foldmethod=marker ts=2 sw=0 tw=80 noet :
