10 cls
20 vpoke 1,$B000,42
25 vpoke 1,$B002,43
28 locate 1,4
29 print vpeek(1,$B002),vpeek(1,$B000)
40 stop