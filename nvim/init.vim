if has('nvim')
  execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/vimrc'
else
  execute 'source' fnamemodify(expand('<sfile>'), ':h').'/.config/nvim/config/vimrc'
endif
