if !exists('g:loadedInsertTag')
  finish
endif

function! g:InsertClosingTag()
  let b:line = line('.')
  let b:col = col('.')

  let b:isOutsideTag = s:IsOutsideTag()
  if (b:isOutsideTag == 1)
    call search('>', 'b')
    let b:tagword = s:GetCurrentTagWord()
    call cursor(b:line,b:col)

    exec "normal! a</".b:tagword.">\<Esc>"
  else
    let b:tagword = s:GetCurrentTagWord()

    let b:isTagForwardEnd = s:IsTagForwardEnd()
    if (b:isTagForwardEnd == 0)
      call search('>')
    endif

    exec "normal! a</".b:tagword.">\<Esc>"
  endif

  call cursor(b:line,b:col)
endfunction

function! s:GetCurrentTagWord()
  let b:targetword = matchstr(getline('.'), '<\zs[^\/][^>]\+\ze>')

  if b:targetword == ''
    let b:line = line('.')
    let b:col = col('.')

    call search('<', 'b')
    let b:tagword = matchstr(getline('.'), '<\zs\w\+\ze\_s\?')
    call cursor(b:line, b:col)
    return b:tagword
  endif

  return b:targetword
endfunction

function! s:IsTagForwardEnd()
  return matchstr(getline('.'), '.', col('.')-1) == '>'
endfunction

function! s:GetCharacterPosition(word)
  let b:line = line('.')
  let b:col = col('.')

  call search(a:word, 'b')

  let b:targetWordLine = line('.')
  let b:targetWordCol = col('.')
  call cursor(b:line, b:col)

  return [ b:targetWordLine, b:targetWordCol ]
endfunction

function! s:IsOutsideTag()
  let b:openAnglePosition = s:GetCharacterPosition('<')
  let b:closeAnglePosition = s:GetCharacterPosition('>')

  if (b:openAnglePosition[0] < b:closeAnglePosition[0])
    return 1
  elseif (b:openAnglePosition[0] == b:closeAnglePosition[0])
    if (b:openAnglePosition[1] < b:closeAnglePosition[1])
      return 1
    endif
  endif

  return 0
endfunction
