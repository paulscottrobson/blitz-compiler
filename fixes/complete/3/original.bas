0     GOTO50:REM   -VERSION 0.2-
1     SCREEN$80:A=144:B=2.25:C=20:D=.0327:    E=160:F=90:G=199:TI$="000000"
2     FORO=-ATOASTEPB:A%=.5+SQR(A*A-O*O)
3     FORI=-ATOA%:Q=SQR(I*I+O*O)*D:R=COS(Q)+COS(Q+Q)+COS(5*Q):S=R*C
4     X=I+O/B+E:Y=S-O/B+F:X1=.85*X:Y1=.9*(G-Y):IFX1<.ORY1>GTHEN6
5     PSETX1,Y1,.:LINEX1,Y1+1,X1,G,1
6     NEXT:NEXT
7     PRINT" TIME:"TI$""TAB(23)"THE PROTEUS DEMO"
8     GETKEY$:IF KEY$="" THEN8
9     SCREEN$0:COLOR1,6:CLS:LIST-9:END
10    REM         -VERSION 1.0-
11    SCREEN$80:Y=.:X=.:I=.:G=199:T=.:U=.:    J=.:C=20:D=.0327:F=90:O=.:A%=.:A=144
12    B=2.25:E=160:K=A*A:L=.5:M=-A:           TI$="000000"
13    FORO=MTOASTEPB:J=O*O:T=O/B:U=T+E:A%=L+SQR(K-J):FORI=MTOA%:X=I+U:IFX<.THEN16
14    Y=SQR(J+I*I)*D:Y=G-(C*(COS(Y)+COS(Y+Y)+COS(5*Y))-T+F)
15    IFY<GTHENLINEX,Y,X,G,1:PSETX,Y,.
16    NEXT:NEXT
17    PRINT" TIME:"TI$""TAB(23)"THE PROTEUS DEMO"
18    GET KEY$:IF KEY$="" THEN18
19    SCREEN $0:COLOR1,6:CLS:LIST10-19:END
20    REM         -VERSION 2.1-
21    X=.:Y=.:I=.:G=. :T=.:U=.:F=27:J=.:D= .0327:C=20:O=.:A%=.:A=144:B=2.25:E=160
22    K=A*A:L=.5:DIMQ%(64,A):SCREEN$80:TI$="000000":GOSUB28
23    FORO=-ATOASTEPB:T=O/B:U=T+E:A%=L+SQR(K-O*O):J=ABS(T):FORI=-ATOA%
24    X=I+U:IFX>=.THENY=G-(Q%(J,ABS(I))-T+F):IFY<GTHENLINEX,Y,X,G,1:PSETX,Y
25    NEXT:NEXT
26    PRINT" TIME:"TI$""TAB(23)"THE PROTEUS DEMO"
27    FORI=-1TO0:GETK$:I=(K$=""):NEXT:SCREEN0:COLOR1,6:CLS:LIST20-30:END
28    PRINT"*PRE-COMPUTING FAST LOOKUP TABLE*":J=D:U=C:FORT=.TO64:X=T*B:G=X*X
29    FORI=.TOA:Y=SQR(G+I*I)*J:X=COS(Y):Q%(T,I)=U*(X+COS(5*Y)+2*X*X-1):NEXT
30    X=4*T+F:RECTX,C,X+2,F,11:NEXT: SCREEN $80:G=199:F=91: RETURN
50    REM         -MENU-
51    SCREEN0:COLOR1,6:CLS:FORI=.TO9:PRINT"££££    ¯¯¯¯";:NEXT:PRINT
52    PRINTTAB(13)"*PROTEUS DEMO*":PRINT   "PLEASE SELECT:": PRINT"";
53    PRINT"'A' VERSION 0.2"TAB(32)"[SLOW]" :PRINTTAB(5)"-MINIMALLY OPTIMIZED;"
54    PRINTTAB(5)"-UGLY SCALING.":PRINT"'B' VERSION 1.0"TAB(30)"[FASTER]"
55    PRINTTAB(5)"-HIGHLY OPTIMIZED;":PRINTTAB(5)"-SCALING FIXED.":PRINT"";
56    PRINT"'C' VERSION 2.1"TAB(29)"[FASTEST]":PRINTTAB(5)"-EXTREMELY OPTIMIZED;"
57    PRINTTAB(5)"-GENERATES LOOKUP TABLE AT START."
58    PRINTTAB(5)"-NEW TRICK: COSINE DOUBLE-ANGLE"
59    PRINTTAB(6)"IDENTITY SUBSTITUTION."
60    TI=.:FORI=-1TO0:GETK$:I=(TI<3601ANDK$=""):NEXT
61    IF K$="A" THEN RUN 1
62    IF K$="B" THEN RUN 11
63    IF K$="C" OR TI>3600 THEN RUN 21
64    GOTO60
90    "----------------------------------"
91    :  * * *  THE PROTEUS DEMO  * * *  :
92    : BASED ON PLUS/4 "3D PLOTNING" IN :
93    : DANISH 'RUN' MAGAZINE, #3, 12/84 :
94    :----------------------------------:
95    : X16 CONVERSION: SNICKERS11001001 :
96    :----------------------------------:
97    ".V0.2               .VI.XXX.MMXXI."
98    ".V1.0               .VII.VI.MMXXI."
99    ".V2.1             .VIII.XXX.MMXXI."
