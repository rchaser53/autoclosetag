if !exists('g:loadedInsertTag') || g:loadedInsertTag == 0
  finish
endif

function! g:InsertClosingTag()
  "prevent from going next line
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

  " restore col
  call cursor(l:line,l:col+1)
endfunction

function! s:GetCurrentTagWord()
  let l:tagword = '\(\w\|\-\|\.\)'
  let l:line = line('.')
  let l:col = col('.')

  if matchstr(getline('.'), '<\zs'.l:tagword.'\+\ze\>') == ''
    call search('<', 'b')
    let l:tagword = matchstr(getline('.'), '<\zs'.l:tagword.'\+\ze\_s\?')
    call cursor(l:line, l:col)
    return l:tagword
  endif

  return matchstr(s:GetNearTagPosition(), '<\zs'.l:tagword.'\+\ze\>')
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

function! s:GetNearTagPosition()
  let l:line = line('.')
  let l:col = col('.')
  call search('\zs<', 'b')
  let l:ret = s:GetWordsUntilEndLine()

  call cursor(l:line,l:col)
  return l:ret
endfunction

function s:GetWordsUntilEndLine()
  let l:line = line('.')
  let l:col = col('.')

  exec "normal! $"
  let l:afterCol = col('.')
  call cursor(l:line, l:col)

  let l:length = l:afterCol-(l:col-1)
  let l:minusLength = l:col-l:afterCol
  return matchstr(getline('.'), '.\{'.l:length.'}', col('.')-1, l:minusLength)
endfunction
