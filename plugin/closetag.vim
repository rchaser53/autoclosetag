if !exists('g:loadedInsertTag') || g:loadedInsertTag == 0
  finish
endif

function! g:InsertClosingTag()
  exec "normal! \<Esc>\<Left>"
  let l:line = line('.')
  let l:col = col('.')

  let l:isOutsideTag = s:IsOutsideTag()
  if (l:isOutsideTag == 1)
    call search('>', 'b')
    let l:tagword = s:GetCurrentTagWord()
    call cursor(l:line,l:col)

    exec "normal! a</".l:tagword.">\<Esc>"
  else
    let l:tagword = s:GetCurrentTagWord()

    let l:isTagForwardEnd = s:IsTagForwardEnd()
    if (l:isTagForwardEnd == 0)
      call search('>')
    endif

    exec "normal! a</".l:tagword.">\<Esc>"
  endif

  call cursor(l:line,l:col)
endfunction

function! s:GetCurrentTagWord()
  let l:line = line('.')
  let l:col = col('.')

  let l:targetword = matchstr(getline('.'), '<\zs[^\s]\+\ze\>')
  if l:targetword == ''
    call search('<', 'b')
    let l:tagword = matchstr(getline('.'), '<\zs\w\+\ze\_s\?')
    call cursor(l:line, l:col)
    return l:tagword
  endif

  return l:targetword
endfunction

function! s:IsTagForwardEnd()
  return matchstr(getline('.'), '.', col('.')-1) == '>'
endfunction

function! s:GetCharacterPosition(word)
  let l:line = line('.')
  let l:col = col('.')

  call search(a:word, 'b')

  let l:targetWordLine = line('.')
  let l:targetWordCol = col('.')
  call cursor(l:line, l:col)

  return [ l:targetWordLine, l:targetWordCol ]
endfunction

function! s:IsOutsideTag()
  let l:openAnglePosition = s:GetCharacterPosition('<')
  let l:closeAnglePosition = s:GetCharacterPosition('>')

  if (l:openAnglePosition[0] < l:closeAnglePosition[0])
    return 1
  elseif (l:openAnglePosition[0] == l:closeAnglePosition[0])
    if (l:openAnglePosition[1] < l:closeAnglePosition[1])
      return 1
    endif
  endif

  return 0
endfunction
