# insertclosetag

a vim plugin insert easily a closing tag.

### Usage

  call InsertClosingTag() 

### Installation

* Use dein:

        call dein#add('rchaser53/insertclosetag')

    or

* Just put the file into ~/.vim/

* Set this in your vimrc:

        let g:loadedInsertTag = 1
        
### Recommended settings

I strongly recommend to call InsertClosingTag() in insert mode.
Like below.

        :inoremap <C-t> <ESC> :call InsertClosingTag()<CR>i