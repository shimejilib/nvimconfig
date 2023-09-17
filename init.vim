execute 'source' fnamemodify(expand('<sfile>'), ':h').'/vimrc_basic'

if &compatible
  set nocompatible
endif
" Set Dein base path (required)
let s:dein_base = $HOME.'/.cache/dein'
" Set Dein source path (required)
let s:dein_src = $HOME.'/.cache/dein/repos/github.com/Shougo/dein.vim'

" Set Dein runtime path (required)
execute 'set runtimepath+=' . s:dein_src

" dein settings -----------------------------------------------------
" set cache path
let $CACHE = '~/.cache'->expand()
if !($CACHE->isdirectory())
	call mkdir($CACHE, 'p')
endif

for s:plugin in [
      \ 'Shougo/dein.vim',
      \ ]->filter({ _, val -> &runtimepath !~# '/' .. val })
  " Search from current directory
  let s:dir = 'dein.vim'->fnamemodify(':p')
  if !(s:dir->isdirectory())
    " Search from $CACHE directory
    let s:dir = $CACHE .. '/dein/repos/github.com/' .. s:plugin
    if !(s:dir->isdirectory())
      execute '!git clone https://github.com/' .. s:plugin s:dir
    endif
  endif
  execute 'set runtimepath^='
        \ .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endfor


" In Windows, auto_recache is disabled.  It is too slow.
let g:dein#auto_recache = !has('win32')

let g:dein#auto_remote_plugins = v:false
let g:dein#enable_notification = v:true
let g:dein#install_check_diff = v:true
let g:dein#install_check_remote_threshold = 24 * 60 * 60
let g:dein#install_progress_type = 'floating'
let g:dein#lazy_rplugins = v:true
let g:dein#types#git#enable_partial_clone = v:true

let $BASE_DIR = '<sfile>'->expand()->fnamemodify(':h')

let s:path = $CACHE .. '/dein'

call dein#begin(s:path, '<sfile>'->expand())
call dein#load_toml('$BASE_DIR/startup_plugins.toml', {'lazy': 0})
call dein#load_toml('$BASE_DIR/lazy_plugins.toml', {'lazy': 1})
" もしpri.tomlが存在するなら読み込む
if filereadable($BASE_DIR.'/private.toml')
	call dein#load_toml('$BASE_DIR/private.toml', {'lazy': 0})
endif
call dein#end()
call dein#save_state()
if dein#check_install()
 call dein#install()
endif
"End dein settings------------------------

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif
