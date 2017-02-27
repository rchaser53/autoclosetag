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
