5     LET CREAL=RND(1)*2-1
6     LET CIMAG=RND(1)*2-1
8     LET COFF=RND(1)*200
10    SCREEN$80
11    LET FX=-1.5
13    LET FY=-1.0
14    SCALE = 1
16    LET Y0=FY
20    FOR Y = 0 TO 199 STEP 2
29    LET X0=FX
30    FOR X = 0 TO 319 STEP 2
40    LET XT=X0:LET I=0
50    LET YT=Y0:LET J=0
60    LET C=0
70    LET COL=0
80    IF I*I+J*J >= 4 THEN GOTO 190
81    IF C >= 30 THEN GOTO 200
90    I=XT*XT-YT*YT+CREAL
91    J=XT*YT*2+CIMAG
92    XT=I:YT=J
93    C = C+1
100   GOTO 80
190   COL = C*2+171
200   RECT X,Y,X+1,Y+1,COL
209   X0 = X0 + 0.02 *SCALE
210   NEXT X
211   Y0 = Y0 + 0.02 *SCALE
220   NEXT Y
230   PRINT CREAL, CIMAG
