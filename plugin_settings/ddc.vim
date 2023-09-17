" hook_source {{{
inoremap <expr><silent><C-n> ddc#manual_complete()
" vimのデフォルトキーバインドと合わせる
inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
inoremap <expr> <C-j>
      \ pum#visible() ?
      \   '<Cmd>call pum#map#insert_relative(0, "empty")<CR>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \   '<C-j>' : ddc#map#manual_complete()
" inoremap <expr> <C-p>
"       \ pum#visible() ?
"       \   '<Cmd>call pum#map#insert_relative(-1, "empty")<CR>' :
"       \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
"       \   '<C-p>' : ddc#map#manual_complete()
call ddc#custom#patch_global('ui', 'pum')
call ddc#custom#patch_global('sources', ['nvim-lsp', 'around', 'file', 'mocword'])
call ddc#custom#patch_global('sourceOptions', #{
	\ nvim-lsp: #{
	\   mark: 'lsp',
	\   forceCompletionPattern: '\.\w*|:\w*|->\w*',
	\ },
	\ _: #{
	\   mark: '▶',
	\   matchers: ['matcher_head'],
	\   sorters: ['sorter_rank'],
	\   keywordPattern: '[a-zA-Z_]\w*',
	\ },
	\ around: #{
	\   mark: 'KW',
	\   dup: v:true,
	\ },
	\ file: #{
	\   mark: 'F',
	\   forceCompletionPattern: '\S/\S*',
	\   isVolatile: v:true,
	\ },
	\ mocword: #{
	\   mark: 'mocword',
	\   minAutoCompleteLength: 3,
	\   isVolatile: v:true,
	\ },
	\ smartCase: v:true,
	\ })
	call ddc#custom#patch_global('sourceParams', #{
	\   nvim-lsp: #{
	\     snippetEngine: denops#callback#register({
	\           body -> vsnip#anonymous(body)
	\     }),
	\     enableResolveItem: v:true,
	\     enableAdditionalTextEdit: v:true,
	\   },
	\   around: #{
	\     maxSize: 2000,
	\   },
	\ })

call ddc#enable()
" }}}
