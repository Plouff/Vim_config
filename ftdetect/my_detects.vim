" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

autocmd BufNewFile,BufRead *.cpf set filetype=tcl
"autocmd BufNewFile,BufRead *.cpf set syntax=tcl
