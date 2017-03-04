function! s:GetCurrentLineTagWord()
  return matchstr(getline('.'), '<\zs[^\/][^>]\+\ze>')
endfunction

function! s:IsTagForwardEnd()
  return matchstr(getline('.'), '.', col('.')-1) == '>'
endfunction

function! g:InsertClosingTag()
  let b:tagword = s:GetCurrentLineTagWord()

  let b:line = line('.')
  let b:col = col('.')

  let b:isOutsideTag = s:IsOutsideTag()

  if (b:isOutsideTag == 1)
    exec "normal! a</".b:tagword.">\<Esc>"
  else
    let b:isTagForwardEnd = s:IsTagForwardEnd()
    if (b:isTagForwardEnd == 0)
      call search('>')
    endif

    exec "normal! a</".b:tagword.">\<Esc>"
  endif

  call cursor(b:line,b:col)
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

function s:GetTag()
  let b:wholeTag = matchstr(getline('.'), '\(<\(\w\|-\)*>\)\{1}')
  let b:removeForward = substitute(b:wholeTag, '<', '', '')
  return substitute(b:removeForward, '>', '', '')
endfunction

function s:JoinStrArray(array)
  let b:length = len(a:array)
  let b:index = 0
  let s:tempStr = ""
  while b:index < b:length
    let s:tempStr = s:tempStr.a:array[b:index]
    let b:index += 1
  endwhile

  return s:tempStr
endfunction

function s:GetBackwardTargetLine(targetStr)
  let b:currentLine = line('.')
  let b:currentCol = col('.')
  call search(a:targetStr, 'b')
  let b:targetLine = line('.')
  call cursor(b:currentLine, b:currentCol)

  return b:targetLine
endfunction

function s:Tagsword()
  call search('<', 'b')
  let b:wordsUntilEnd = GetWordsUntilEndLine()
endfunction

function s:GetWordsUntilEndLine()
  let b:line = line('.')
  let b:col = col('.')
  exec "normal! $"
  let b:afterCol = col('.')
  call cursor(b:line, b:col)
  let b:length = b:afterCol-b:col
  let b:minusLength = b:col-b:afterCol
  return matchstr(getline('.'), '.\{'.b:length.'}', col('.')-1, b:minusLength)
endfunction
