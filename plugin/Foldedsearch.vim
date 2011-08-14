function! Foldsearch(search)
        normal zE          "erase all folds to begin with
        normal G$          "move to the end of the file
	let folded = 0     "flag to set when a fold is found
        let flags = "w"    "allow wrapping in the search
        let line1 =  0     "set marker for beginning of fold
        while search(a:search, flags) > 0
                let  line2 = line(".")
		"echo "pattern found at line # " line2
                if (line2 -1 > line1)
                        "echo line1 . ":" . (line2-1)
                        "echo "A fold goes here."
                        execute ":" . line1 . "," . (line2-1) . "fold"
						let folded = 1       "at least one fold has been found
                endif
                let line1 = line2     "update marker
                let flags = "W"       "turn off wrapping
        endwhile
		" Now create the last fold which goes to the end of the file.
        normal $G
        let  line2 = line(".")
		"echo "end of file found at line # " line2
        if (line2  > line1 && folded == 1)
                "echo line1 . ":" . line2
                "echo "A fold goes here."
                execute ":". line1 . "," . line2 . "fold"
        endif
endfunction


" Command is executed as ':Fs pattern'"
command! -nargs=+ -complete=command Fs call Foldsearch(<q-args>)
" View the methods and variables in a java source file."
command! Japi Fs public\|protected\|private
