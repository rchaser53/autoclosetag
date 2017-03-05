# insertclosetag

a vim plugin insert easily a closing tag.


<img alt="" src="https://github.com/rchaser53/insertclosetag/blob/master/insertclosingtag.gif" width="100%" >

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
