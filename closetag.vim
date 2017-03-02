function Get()
  let b:line = line('.')
  let b:col = col('.')
  exec "normal! e :echo line('.')"
  let b:afterCol = col('.')
  call cursor(b:line, b:col)
  let b:length = b:afterCol-b:col
  let b:minusLength = b:col-b:afterCol
  echo matchstr(getline('.'), '.\{'.b:length.'}', col('.')-1, b:minusLength)
endfunction

function Insert(arg)
  exec "normal! ei ".a:arg."\<Esc>"
endfunction

function GetTag()
  let b:poyo = matchstr(getline('.'), '\(<\(\w\|-\)*>\)\{1}')
  echo b:poyo
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

"echo JoinStrArray(['a', 'b', 'c'])
