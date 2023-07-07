" 빔위키 설정

" 1번 위키(개인용)와 2번 위키(업무용)
let g:vimwiki_list = [
    \{
    \   'path': '~/Documents/vimwiki',
    \ 'syntax': 'markdown', 
    \   'ext' : '.md',
    \},
    \{
    \   'path': '~/Documents/vimwiki_fitpet',
    \ 'syntax': 'markdown', 
    \   'ext' : '.md',
    \ 'diary_frequency' : 'weekly',
    \},
\]

" vimwiki의 conceallevel 을 끄는 쪽이 좋다. 특수문자가 안보이게됨
let g:vimwiki_conceallevel = 0
" md 파일은 vimwiki 폴더 안에만
let g:vimwiki_global_ext = 0

let g:markdown_fenced_languages = ['html', 'js=javascript', 'ruby', 'tsx=javascript']

" vimwiki key mapping
nmap <Leader>wt :VimwikiTable<CR>
nnoremap <Leader>wf :execute "VWS /" . expand("<cword>") . "/" <Bar> :lopen<CR>
nnoremap <Leader>wr :execute "VWB" <Bar> :lopen<CR>

" 미완료 태스크 찾기
function! VimwikiFindIncompleteTasks()
  lvimgrep /- \[ \]/ %:p
  lopen
endfunction

" 미완료태스크 전체찾기
function! VimwikiFindAllIncompleteTasks()
  VimwikiSearch /- \[ \]/
  lopen
endfunction

nmap <Leader>wa :call VimwikiFindAllIncompleteTasks()<CR>
nmap <Leader>wx :call VimwikiFindIncompleteTasks()<CR> 

" 미리보기
let vim_markdown_preview_browser='Google Chrome'
let vim_markdown_preview_github=1 
let vim_markdown_preview_temp_file=1

autocmd FileType markdown nmap <buffer><silent> <leader>p :call image_paste#PasteImage()<CR>

function! NewTemplate()

    let l:wiki_directory = v:false

    for wiki in g:vimwiki_list
        if expand('%:p:h') =~ expand(wiki.path)
            let l:wiki_directory = v:true
            break
        endif
    endfor

    if !l:wiki_directory
        return
    endif

    if line("$") > 1
        return
    endif

    let l:template = []
    call add(l:template, '---')
    call add(l:template, 'layout  : wiki')
    call add(l:template, 'title   : ')
    call add(l:template, 'summary : ')
    call add(l:template, 'date    : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
    call add(l:template, 'updated : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
    call add(l:template, 'tag     : ')
    call add(l:template, 'toc     : true')
    call add(l:template, 'public  : true')
    call add(l:template, 'parent  : ')
    call add(l:template, 'latex   : false')
    call add(l:template, 'resource: ' . substitute(system("uuidgen"), '\n', '', ''))
    call add(l:template, '---')
    call add(l:template, '* TOC')
    call add(l:template, '{:toc}')
    call add(l:template, '')
    call add(l:template, '# ')
    call setline(1, l:template)
    execute 'normal! G'
    execute 'normal! $'

    echom 'new wiki page has created'
endfunction

function! NewDiaryTemplate()

    let l:wiki_directory = v:false

    for wiki in g:vimwiki_list
        if expand('%:p:h') =~ expand(wiki.path)
            let l:wiki_directory = v:true
            break
        endif
    endfor

    if !l:wiki_directory
        return
    endif

    if line("$") > 1
        return
    endif

    let l:template_dt = strftime('%Y-%m-%d')
    let l:template = []
    call add(l:template, '# ' . l:template_dt)
    call add(l:template, '')
    call add(l:template, '# Todo ')
    call add(l:template, '')
    call add(l:template, '# ')
    call setline(1, l:template)
    execute 'normal! G'
    execute 'normal! $'

    echom 'new wiki diary page ' . l:template_dt . ' has created'
endfunction

function! LastModified()
    if &modified
        " echo('markdown updated time modified')
        let save_cursor = getpos(".")
        let n = min([10, line("$")])
        keepjumps exe '1,' . n . 's#^\(.\{,10}updated\s*: \).*#\1' .
            \ strftime('%Y-%m-%d %H:%M:%S +0900') . '#e'
        call histdel('search', -1)
        call setpos('.', save_cursor)
    endif
endfunction

augroup vimwikiauto
    autocmd FileType *wiki/*.md let g:loaded_images_paste='~/Documents/vimwiki/images'
    autocmd BufWritePre *wiki/*.md call LastModified()
    autocmd BufRead,BufNewFile *diary/*.md call NewDiaryTemplate()
    autocmd BufRead,BufNewFile *wiki/*.md,!*diary/*.md call NewTemplate()
augroup END


