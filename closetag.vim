function Get()
  let b:line = line('.')
  let b:col = col('.')
  exec "normal! e :echo line('.')"
  call cursor(b:line, b:col)
endfunction
