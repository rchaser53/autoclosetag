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

function Nyan()
  let b:aaa = ['a', 'b', 'c', 'd']
  let b:length = len(b:aaa)
  let b:index = 0
  let b:tempStr = ""
  while b:index < b:length
    let b:tempStr = b:tempStr.b:aaa[b:index]
    let b:index += 1
  endwhile

  echo b:tempStr
endfunction
