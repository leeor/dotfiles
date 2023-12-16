if has('nvim')
  execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/vimrc'
  lua require('init')
else
  execute 'source' fnamemodify(expand('<sfile>'), ':h').'/.dotfiles/nvim/config/vimrc'
endif
