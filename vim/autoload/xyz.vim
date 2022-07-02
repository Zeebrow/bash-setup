" don't spam the user when Vim is started in Vi compatibility mode
" All the cool kids have this at the top and bottom
let s:cpo_save = &cpo
set cpo&vim

let g:MyIsToggled = 1
let g:PreferredNu = &nu
let g:PreferredRnu = &rnu

function xyz#ToggleCopyable()
  if(g:MyIsToggled)
    let g:MyIsToggled = 0
    set nonu
    set nornu
  else
    let g:MyIsToggled = 1
    if(g:PreferredNu)
      set nu
    endif
    if(g:PreferredRnu)
      set rnu
    endif
  endif
endfunction

" restore Vi compatibility settings
let &cpo = s:cpo_save
unlet s:cpo_save

" https://stackoverflow.com/a/2540572/14494128
" https://devhints.io/vimscript
