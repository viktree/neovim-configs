augroup filetype_markdown
    autocmd!
    autocmd filetype markdown :iabbrev <buffer> h1 #
    autocmd FileType markdown :iabbrev <buffer> h2 ##
    autocmd FileType markdown :iabbrev <buffer> h3 ###
    autocmd FileType markdown :iabbrev <buffer> h4 ####
augroup END

let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript']
