function GetWordsUntilEndLine()
  let b:line = line('.')
  let b:col = col('.')
  exec "normal! $"
  let b:afterCol = col('.')
  call cursor(b:line, b:col)
  let b:length = b:afterCol-b:col
  let b:minusLength = b:col-b:afterCol
  return matchstr(getline('.'), '.\{'.b:length.'}', col('.')-1, b:minusLength)
endfunction

function! s:Insert(arg)
  exec "normal! i</".a:arg.">\<Esc>"
endfunction

function! s:GetCurrentLineTagWord()
  return matchstr(getline('.'), '<\zs[^\/][^>]\+\ze>')
endfunction

function! g:InsertTag()
  let s:tagword = s:GetCurrentLineTagWord()

  let b:line = line('.')
  let b:col = col('.')

  call search('>')
  exec "normal! a \<Esc>"
  call s:Insert(s:tagword)
  call cursor(b:line,b:col)
endfunction

function GetTag()
  let b:wholeTag = matchstr(getline('.'), '\(<\(\w\|-\)*>\)\{1}')
  let b:removeForward = substitute(b:wholeTag, '<', '', '')
  return substitute(b:removeForward, '>', '', '')
endfunction

function JoinStrArray(array)
  let b:length = len(a:array)
  let b:index = 0
  let s:tempStr = ""
  while b:index < b:length
    let s:tempStr = s:tempStr.a:array[b:index]
    let b:index += 1
  endwhile

  return s:tempStr
endfunction

function GetBackwardTargetLine(targetStr)
  let b:currentLine = line('.')
  let b:currentCol = col('.')
  call search(a:targetStr, 'b')
  let b:targetLine = line('.')
  call cursor(b:currentLine, b:currentCol)

  return b:targetLine
endfunction

function Tagsword()
  "let b:nyan = GetBackwardTargetLine('<')
  call search('<', 'b')
  let b:wordsUntilEnd = GetWordsUntilEndLine()
endfunction
