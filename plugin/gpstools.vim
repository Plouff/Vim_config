"########################
"########################
"       DISTANCE
"########################
"########################


function! Mvdist(km, dam, start, end)
    echom "test"
    exe a:start .','. a:end .'s#Distance \(\d\+\)\.#\="Distance ".submatch(1) '
    exe a:start .','. a:end .'s#Distance 0*\(\d\+\)#\="Distance ". (submatch(1) + '. a:km .'* 100+ '. a:dam .')'
    if a:km == 0
        " Fix decimals for less than 1km
        exe a:start .','. a:end .'s# \(\d\) km# 0.0\1 km'
        exe a:start .','. a:end .'s# \(\d\d\) km# 0.\1 km'
        echo "test"
    endif

    exe a:start .','. a:end .'s#\([^.]\)\(\d\d\) km#\1.\2 km'
endfunction

function! GPXDistance(km, dam)
    call Mvdist(a:km, a:dam, 1, "$")
endfunction

function! GPXDistanceRange(km, dam, start, end)
    call Mvdist(a:km, a:dam, a:start, a:end)
endfunction



"########################
"########################
"       TIME/DATE
"########################
"########################

" ---------------
" Time increments
" ---------------

function! GPXMoveTime(hour, min, sec)
    let inc = a:hour*3600 + a:min*60 + a:sec
    " Set all times in secondes
    exe '%s#\(<time>.*T\)\(\d\+\):\(\d\+\):\(\d\+\)#\= submatch(1) . (submatch(2)*3600 + submatch(3)*60 + submatch(4))'

    " Increment
    exe '%s#\(<time>.*T\)\(\d\+\)#\=submatch(1).(submatch(2)+'. inc .')'

    " Secondes to time format
    exe '%s#\(<time>.*T\)\(\d\+\)#\=submatch(1). ((submatch(2)/3600) % 3600) .":". ((submatch(2)/60) %60) .":". (submatch(2)%60)'
    "exe a:start .','. a:end .'s#\(\d\d\) km#.\1 km'
endfunction


" --------
" Set date
" --------

function! GPXSetDate(date)
    exe '%s#<time>.*T#<time>'.a:date.'T'
endfunction



"########################
"########################
"       NAME
"########################
"########################

function! GPXMovePoint(val)
    exe '12,$s#<name>\(\d\+\)#\="<name>".(submatch(1)+'. a:val .')'
endfunction


"########################
"########################
"       ELEVATION
"########################
"########################

function! GPXMoveAlti(val)
    exe '12,$s#<ele>\(\d\+\)#\="<ele>".(submatch(1)+'. a:val .')'
endfunction

"########################
"########################
"       DEL POINTS
"########################
"########################

function! GPXoldRemovePoints()
    let pat = "<trkpt .*\\n<ele>.*\\n<speed>.*\\n<course>.*\\n<desc>.*\\n<time>.*\\n<name>[0-9]*[23456789].*\\n"
    let pat = "<trkpt .*\\n<ele>.*\\n<speed>.*\\n<course>.*\\n<desc>.*\\n<time>.*\\n<name>[0-9]*[023456789]<.*\\n</trkpt>\\n"

    exe '12,$s#'. pat .'##'
endfunction

function! GPXRemovePoints()
    let pat = "<trkpt .*\\n\\s*<ele>.*\\n\\s*<desc>.*\\n\\s*<time>.*\\n\\s*<name>[0-9]\\+[023456789]<.*\\n\\s*<sym>.*\\n\\s*</trkpt>\\n\\s*"
    exe '12,$s#'. pat .'##'
endfunction

