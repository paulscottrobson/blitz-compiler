1     REM  IF A CELL IS ON AND HAS FEWER THAN 2 NEIGHBORS THAT ARE ON, IT TURNS OFF
2     REM  (DIES OF LONLYNESS)
3     REM  IF A CELL IS ON AND HAS EITHER 2 OR 3 NEIGHBORS THAT ARE ON IT
4     REM  REMAINS ON.  (STASIS)
5     REM  IF A CELL IS ON AND HAS MORE THAN 3 NEIGHBORS THAT ARE ON IT TURNS OFF.
6     REM  (OVERCROWDING)
7     REM  IF A CELL IS OFF AND HAS EXACTLY THREE NEIGHBORS THAT ARE ON, IT
8     REM  TURNS ON.  (BREEDING)
10    GOSUB 6000 : REM INIT ALL VARS
80    GOSUB 2000
130   DIM GC%(2,GX,GY)
140   GOSUB 900 : REM INITGRID
145   CG=$F2:GOSUB 2210
150   GOSUB 300 : REM DRAWGRID
155   GOSUB 400 : REM UPDATE GRID
160   GOSUB 300 : REM DRAWGRID
165   IF LL = O THEN PRINT:PRINT "NO LIVING CELLS !!! ":PRINT:PRINT:END
170   GOTO 155
199   GOTO 8000
200   COLOR 1,0:CLS:COLOR 1,15
202   FOR I=2 TO 6:LOCATE I,2:PRINT "                   ":NEXT I
204   COLOR 6,15:LOCATE 3,2:PRINT " INITIALIZING";
205   FOR Y = 1 TO  GY
208   COLOR 6,15:LOCATE 5,2:PRINT " ROW:";:COLOR 7:PRINT Y;
210   FOR X = 1 TO GX
211   COLOR 6,15
215   LOCATE 5,11:PRINT "COL:";
218   COLOR 7:PRINT X;:COLOR 1
220   GC%(P1,X,Y)= 0
230   J = INT(RND(1)*10)
240   IF J < 2 THEN GC%(P1,X,Y)= 1
250   NEXT X
260   NEXT Y
270   COLOR 1,0:CLS:RETURN
299   REM DRAWGRID
300   IF SK=1 THEN SK=0:RETURN
302   CLS:COLOR 1:LOCATE 29,3:PRINT "DRAWING THE GRID";
305   FOR Y = 1 TO GY
310   FOR X = 1 TO GX
320   IF GC%(P1,X,Y) = 1 THEN CC = C1
330   IF GC%(P1,X,Y) = 0 THEN CC = C2
340   X1 = (X*XS)-XS:Y1=(Y*YS)-YS
345   PSET X1+2,Y1+2,7
350   RECT X1+1,Y1+1,X1+XS-1,Y1+YS-1,CC
360   NEXT X
370   NEXT Y
375   CLS
380   RETURN
400   LL = 0
405   CLS:LOCATE 3,2:PRINT "UPDATING CORNER CELLS"
410   S = GC%(P1,2,1) + GC%(P1,1,2) + GC%(P1,2,2)
430   IF  S<2 THEN GC%(P2,1,1)=0:GOTO 470
435   IF S=3 THEN GC%(P2,GX,1)=1:LL=LL+1:GOTO 470
440   IF GC%(P1,1,1) = 1 AND S=2 THEN GC%(P2,1,1)=1:LL=LL+1:GOTO 470
445   GC%(P2,1,1)=0
470   S = GC%(P1,GX-1,1) + GC%(P1,GX-1,2) + GC%(P1,GX,2)
480   IF S<2 THEN GC%(P2,GX,1)=0:GOTO 510
490   IF S=3 THEN GC%(P2,GX,1)=1:GOTO 510
500   IF GC%(P1,GX,1) = 1 AND S=2 THEN GC%(P2,GX,1)=1:LL=LL+1:GOTO 510
505   GC%(P2,GX,1)=0
510   S = GC%(P1,2,GY) + GC%(P1,1,GY-1) + GC%(P1,2,GY-1)
515   IF X<2 THEN GC%(P2,1,GY)=0:GOTO 535
520   IF GC%(P1,1,GY) = 1 AND S=2 THEN GC%(P2,1,GY)=1:LL=LL+1:GOTO 535
525   IF S=3 THEN GC%(P2,1,GY)=1:LL=LL+1:GOTO 535
530   GC%(P2,1,GY)=0
535   S = GC%(P1,GX-1,GY) + GC%(P1,GX-1,GY-1) + GC%(P1,GX,GY-1)
540   IF GC%(P1,GX,GY) < 2 THEN GC%(P2,GX,GY)=0:GOTO 565
550   IF GC%(P1,GX,GY) = 1 AND S=2 THEN GC%(P2,GX,GY)=1:LL = LL+1:GOTO 565
555   IF S=3 THEN GC%(P2,GX,GY)=1:LL=LL+1:GOTO 565
560   GC%(P2,GX,GY)=0
565   CLS:LOCATE 3,2:PRINT "UPDATING OUTSIDE COLUMNS."
566   COLOR 1
568   LOCATE 9,4:PRINT "# LIVING CELLS:";
569   COLOR 7:PRINT LL:COLOR 1
570   X = 1
575   FOR Y = 2 TO GY - 1
580   S = GC%(P1,X,Y-1) + GC%(P1,X+1,Y-1)+GC%(P1,X+1,Y)
585   S = S + GC%(P1,X,Y+1) + GC%(P1,X+1,Y+1)
590   IF S<2 OR S>3 THEN GC%(P2,X,Y)=0:GOTO 620
595   IF S=3 THEN GC%(P2,X,Y)=1:LL=LL+1:GOTO 620
600   IF GC%(P1,X,Y) = 1 AND S=2 THEN GC%(P2,X,Y)=1:LL=LL+1:GOTO 620
610   GC%(P2,X,Y)=0
620   NEXT Y
621   LOCATE 9,4:PRINT "# LIVING CELLS:";:COLOR 7:PRINT LL;:COLOR 1
625   X = GX
630   FOR Y = 2 TO GY - 1
635   S = GC%(P1,X-1,Y-1) + GC%(P1,X,Y-1)+GC%(P1,X-1,Y)
640   S = S + GC%(P1,X-1,Y+1) + GC%(P1,X,Y+1)
645   IF S<2 OR S>3 THEN GC%(P2,X,Y)=0:GOTO 670
650   IF S=3 THEN GC%(P2,X,Y)=1:LL=LL+1:GOTO 670
660   IF S=2 AND GC%(P1,X,Y)=1 THEN GC%(P2,X,Y)=1:LL=LL+1:GOTO 670
665   GC%(P2,X,Y)=0
670   NEXT Y
685   CLS:LOCATE 9,4:PRINT "# LIVING CELLS:";:COLOR 7:PRINT LL;:COLOR 1
690   LOCATE 3,2:PRINT "UPDATING TOP AND BOTTOM ROW.";
695   Y = 1
700   FOR X = 2 TO GX - 1
705   S = GC%(P1,X-1,Y) + GC%(P1,X+1,Y)+GC%(P1,X-1,Y+1)
710   S = S + GC%(P1,X,Y+1) + GC%(P1,X+1,Y+1)
715   IF GC%(P1,X,Y)=1 AND S=2 THEN GC%(P2,X,Y)=1:LL=LL+1:GOTO 740
720   GC%(P2,X,Y)=0
725   IF S=3 THEN GC%(P2,X,Y)=1:LL=LL+1:GOTO 740
740   NEXT X
742   LOCATE 9,4:PRINT "# LIVING CELLS:";:COLOR 7:PRINT LL;:COLOR 1
745   Y = GY
750   FOR X = 2 TO GX - 1
755   S = GC%(P1,X-1,Y-1) + GC%(P1,X,Y-1)+GC%(P1,X+1,Y-1)
760   S = S + GC%(P1,X-1,Y) + GC%(P1,X+1,Y)
765   IF S<2 OR S>3 THEN GC%(P2,X,Y)=0:GOTO 790
770   IF S=3 THEN GC%(P2,X,Y)=1:LL=LL+1:GOTO 790
775   IF GC%(P1,X,Y)=1 AND S=2 THEN GC%(P2,X,Y)=1:LL=LL+1:GOTO 790
780   GC%(P2,X,Y)=0
790   NEXT X
795   CLS:LOCATE 3,2:PRINT "BORDER IS DONE"
796   LOCATE 4,2 :PRINT "UPDATING CORE GRID"
800   LOCATE 9,4:PRINT "# LIVING CELLS:";:COLOR 7:PRINT LL;:COLOR 1
810   FOR Y = 2 TO GY-1
811   LOCATE 8,6:PRINT "UPDATING ROW:";:COLOR 7:PRINT Y:COLOR 1
815   FOR X = 2 TO GX - 1
820   S = GC%(P1,X-1,Y-1) + GC%(P1,X,Y-1)+GC%(P1,X+1,Y-1)+GC%(P1,X-1,Y)
830   S = S + GC%(P1,X+1,Y)+GC%(P1,X-1,Y+1)+GC%(P1,X,Y+1)+GC%(P1,X+1,Y+1)
835   IF S<2 OR S>3 THEN GC%(P2,X,Y)=0:GOTO 860
840   IF S=3 THEN GC%(P2,X,Y)=1:LL=LL+1:GOTO 860
850   IF GC%(P1,X,Y)=1 AND S=2 THEN GC%(P2,X,Y)=1:LL=LL+1:GOTO 860
855   GC%(P2,X,Y)=0
860   NEXT X
865   LOCATE 9,4:PRINT "# LIVING CELLS:";:COLOR 7:PRINT LL:COLOR 1
870   NEXT Y
871   LOCATE 9,4:PRINT "# LIVING CELLS:";:COLOR 7:PRINT LL:COLOR 1
872   SLEEP 5
874   REM SWAP MY BUFFERS.   P3 ONLY EXISTS FOR THE SWAP PTR PROCESS
875   P3 = P1
880   P1 = P2
885   P2 = P3
890   CLS:RETURN
900   GOSUB 2500:REM GRAPHICS CLS
905   COLOR 7,0:CLS:S=1
910   LOCATE 2,2:PRINT "1.";:COLOR 5:PRINT " RANDOM FILL OF CELLS";:COLOR 7
915   LOCATE 4,2:PRINT "2.";:COLOR 5:PRINT " USER SELECTION";:COLOR 7
916   LOCATE 7,2:PRINT "<";:COLOR 5: PRINT "ARROWS TO CHOOSE";:COLOR 7:PRINT ">";
917   LOCATE 9,2:COLOR 7:PRINT "<";:COLOR 5:PRINT "ENTER TO PROCEED";:COLOR 7
918   PRINT ">";
920   X = 4:GOTO 922
921   FRAME X,Y,X+200,Y + 11,$10
922   IF S=3 THEN S=1:IF S=0 THEN S=2
925   IF S = 2  THEN Y = 21
930   IF S = 1  THEN Y =  6
935   FRAME X,Y,X+200,Y + 11,1
940   GET K$:IF K$="" THEN 940
950   K = ASC(K$)
960   IF K=49 THEN S = 1:GOTO 921
970   IF K=50 THEN S = 2:GOTO 921
980   IF K=157 OR K=17 THEN S = S + 1:GOTO 921
990   IF K=145 OR K=29 THEN S = S - 1:GOTO 921
1000  IF K=27 THEN END
1005  IF K=13 THEN GOTO 1020
1010  GOTO 940
1020  FRAME X,Y,X+200,Y + 11,$10
1025  IF S = 1 THEN:GOSUB 200:RETURN
1030  GOSUB 4000
1040  GOSUB 1800:RETURN
1800  CLS:COLOR 7
1805  LOCATE 9,4:PRINT "MAKING ALL THE CELLS DEAD";
1810  FOR Y = 1 TO GY
1820  FOR X = 1 TO GX
1821  LOCATE 12,4:PRINT "KILLING : ";
1822  COLOR 5:LOCATE 12,15:PRINT "Y:";
1823  COLOR 7:PRINT Y;:COLOR 5:PRINT " X:";:COLOR 7:PRINT X;
1829  GC%(P1,X,Y) = 0
1830  NEXT X
1840  NEXT Y
1850  LOCATE 14,4:PRINT "DONE WITH KILLING";
1851  LOCATE 15,4:PRINT "ALL CELLS ARE 0";
1852  GET X$:IF X$<>"" THEN 1851 : REM FLUSH ALL KEYBOARD INPUT
1855  SLEEP 30:CLS
1860  GOSUB 2200:MOUSE 1
1865  X=1:Y=1
1866  GOSUB 1985
1870  FRAME X1+1,Y1+1,X1+XS-1,Y1+YS-1,7
1875  GET I$
1880  IF I$<> "" THEN I = ASC(I$):GOTO 1900
1885  I=0
1886  REM CHECK FOR LEFT MOUSE BUTTON
1887  IF MB=1 THEN GOSUB 1985:XI=MX:YI=MY:GOTO 1945
1900  IF I=8 OR I=63 THEN GOSUB 4000
1901  IF I=0 THEN 1875
1903  IF I<>32 THEN 1915
1905  IF GC%(1,X,Y)=0 THEN GC%(1,X,Y)=1:GOTO 1866
1910  GC%(1,X,Y)=0:GOTO 1866
1915  IF I=145 THEN GOSUB 1985:Y=Y-1:IF Y<1 THEN Y=GY
1916  IF I=145 THEN 1866
1920  IF I=157 THEN GOSUB 1985:X=X-1:IF X<1 THEN X=GX
1921  IF I=157 THEN 1866
1925  IF I=29 THEN GOSUB 1985:X=X+1:IF X>GX THEN X=1
1926  IF I=29 THEN 1866
1930  IF I=17 THEN GOSUB 1985:Y=Y+1:IF Y>GY THEN Y=1
1931  IF I=17 THEN 1866
1935  IF I=13 THEN :GOSUB 1985:SK=1:MOUSE 0:RETURN
1936  REM CHECK FOR LEFT MOUSE BUTTON AGAIN
1937  IF MB=1 THEN GOSUB 1985:XI=MX:YI=MY:GOTO 1945
1940  GOTO 1875
1944  REM MOUSE UPDATING ROUTINE HERE
1945  X = INT(XI/XS)+1 : Y = INT(YI/YS) + 1
1950  IF GC%(1,X,Y) = 0 THEN GC%(1,X,Y) = 1:GOTO 1960
1955  GC%(1,X,Y) = 0
1960  GOSUB 1985: FRAME X1+1,Y1+1,X1+XS-1,Y1+YS-1, 7
1965  IF MB <> 0 THEN 1965  : REM WAIT FOR MOUSE RELEASE
1970  GOTO 1940
1985  X1 = (X*XS)-XS:Y1=(Y*YS)-XS
1986  IF GC%(1,X,Y)=1 THEN RECT X1+1,Y1+1,X1+XS-1,Y1+YS-1,C1:RETURN
1987  RECT X1+1,Y1+1,X1+XS-1,Y1+YS-1,C2
1990  RETURN
2000  IX = 3:COLOR 1,0:CLS
2020  IF IX > 5 THEN IX = 1
2025  IF IX < 1 THEN IX = 5
2030  IF IX = 5 THEN GX = 80:GY=60
2035  IF IX = 4 THEN GX = 64:GY=48
2040  IF IX = 3 THEN GX = 32:GY=24
2045  IF IX = 2 THEN GX = 16:GY=12
2050  IF IX = 1 THEN GX = 8:GY = 6
2055  XS = 320/GX:YS=240/GY
2060  GOSUB 2200
2100  COLOR 1,11
2105  FOR Y = 2 TO 6
2110  LOCATE Y,2:PRINT "                                   ";
2115  NEXT Y
2135  LOCATE 3,3:PRINT "CHANGE GRID DENSITY";:COLOR 7:PRINT "  <ARROW KEYS>"
2140  COLOR 1:LOCATE 4,3:PRINT "CURRENT: ";
2142  COLOR 7:PRINT GX;:COLOR 1:PRINT " X ";:COLOR 7:PRINT GY;
2145  COLOR 7:LOCATE 6,3:PRINT "<";:COLOR 1:PRINT "ENTER TO CHOOSE";:COLOR 7
2146  PRINT ">";
2150  GET K$
2155  K = ASC(K$)
2160  IF K=157 OR K=17 THEN IX = IX + 1:GOTO 2020
2165  IF K=145 OR K=29 THEN IX = IX - 1:GOTO 2020
2170  IF K=13 THEN COLOR 1,0:CLS:RETURN
2175  IF K=27 THEN SCREEN 0:PRINT:END
2180  GOTO 2150
2200  GOSUB 2500
2210  FOR X = XS TO 320-XS STEP XS
2220  LINE X,0,X,239,CG
2230  NEXT X
2240  FOR Y = YS TO 240-YS STEP YS
2250  LINE 0,Y,319,Y,CG
2260  NEXT Y
2270  RETURN
2499  REM GRAPHICS CLEAR SCREEN
2500  RECT 0,0,XLIMIT,YLIMIT,$10
2510  RETURN
4000  COLOR 6,15
4010  FOR J = 2 TO 18
4015  LOCATE J,1
4016  PRINT "                                        ";
4020  NEXT J
4035  LOCATE 3,1:PRINT " CELL SELECTION SCREEN IS MOSTLY BLANK !";
4040  LOCATE 5,1:PRINT " SELECT YOUR CELL WITH THE";:COLOR 7:PRINT" ARROW KEYS";
4045  COLOR 6:LOCATE 7,1:PRINT " TOGGLE ITS LIFE STATE WITH";:COLOR 7
4050  PRINT " SPACE BAR";
4055  COLOR 6:LOCATE 8,1 :PRINT " OR CLICK USING ";:COLOR 7:PRINT "THE MOUSE ";
4056  COLOR 6:PRINT "ON EACH CELL";
4057  COLOR 7:LOCATE 10,1:PRINT "  CTRL/H";:COLOR 6:PRINT " OR ";:COLOR 7
4058  PRINT "?";:COLOR 6:PRINT " SHOWS THIS SCREEN";
4060  COLOR 7:LOCATE 14,1:PRINT " ENTER ";:COLOR 6
4065  PRINT "PROCEEDS WITH '";:COLOR 2:PRINT "THE GAME OF LIFE";:COLOR 6
4066  PRINT "'";:LOCATE 12,1:COLOR 7
4070  PRINT "   ESC";:COLOR 6:PRINT" ABORTS PROGRAM";
4075  LOCATE 17,10:COLOR 6:PRINT "<";:COLOR 7:PRINT "ANY KEY TO CONTINUE";
4080  COLOR 6:PRINT ">";
4085  GOSUB 8000:COLOR 1,0:CLS:RETURN
6000  REM INIT ALL STATIC VARS
6010  XLIMIT=319:YLIMIT=239
6020  P1=1:P2=2:SK=0
6030  C1=$05:C2=$10:CG=15
6040  X=RND(-TI)
6050  SCREEN $80
6060  VPOKE 1,$FA0C,0 : REM CHANGE COLOR 6 TO BLACK
6070  VPOKE 1,$FA0D,0 : REM SO I CAN HAVE NON-TRANSPARENT BLACK TEXT
6100  RETURN
8000  GET X$:IF X$<>"" THEN GOTO 8000 : REM FLUSH KEYBOARD BUFFER
8010  GET X$:IF X$="" THEN GOTO 8010 : REM WAIT FOR KEY
8015  IF ASC(X$)=27 THEN SCREEN 0:END
8020  RETURN
