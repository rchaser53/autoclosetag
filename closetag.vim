function Get()
  let b:line = line('.')
  let b:col = col('.')
  exec "normal! e :echo line('.')"
  let b:afterCol = col('.')
  call cursor(b:line, b:col)
  echo match(getline('.'), '.', col('.')-1, b:col-b:afterCol)
endfunction
