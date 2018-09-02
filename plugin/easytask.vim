" -------------------------- Tasks --------------------------------------------
let g:task_cancel = '✖'
let g:task_empty = '☐'
let g:task_done = '✔'

function! TaskNew()
    let tmp = @t
    let @t = g:task_empty . ' '
    let expr = 'normal "tpl'
    exec l:expr
    let @t = l:tmp
endfunction

function! s:exec(expr)
    let x = col('.')
    let y = line('.')
    exec a:expr
    call cursor(y, x)
endfunction

function! TaskDone()
    let expr = printf(':silent! s/%s/%s/',
        \ g:task_empty,
        \ g:task_done)
    call s:exec(l:expr)
endfunction

function! TaskCancel()
    let expr = printf(':silent! s/%s/%s/',
        \ g:task_empty,
        \ g:task_cancel)
    call s:exec(l:expr)
endfunction

function! TaskUndo()
    let expr = printf(':silent! s/%s\|%s/%s/',
        \ g:task_done,
        \ g:task_cancel,
        \ g:task_empty)
    call s:exec(l:expr)
endfunction

hi HgTaskDone ctermfg=DarkGreen
hi HgTaskCancel ctermfg=DarkRed

call matchadd('HgTaskDone', g:task_done)
call matchadd('HgTaskCancel', g:task_cancel)