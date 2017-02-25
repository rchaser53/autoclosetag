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
