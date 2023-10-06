10 n = 14
20 screen 3
60 print chr$(147);"Hello world !"
70 dim bx(n):dim by(n):dim bc(n)
75 dim dx(n):dim dy(n)
80 for b=0 to n
90 bx(b)=int(rnd(1)*40)*2+1
100 by(b)=int(rnd(1)*30)*256
105 bc(b)=int(rnd(1)*14)+1
106 dx(b)=int(rnd(1)*2)
108 rem dy(b)=int(rnd(1)*2)
109 dy(b)=1
110 next b
120 rem
130 fory=0to29:forx=0to39
140 q=y*256+x*2+45056
150 vpoke 1,q,81:vpoke1,q+1,0
160 nextx:next y
200 for b=1ton
210 vpoke 1,45056+by(b)+bx(b),0
230 dxb=dx(b)
240 ifdxb=0thengosub1010
250 ifdxb=1thengosub1040
255 dyb=dy(b)
260 ifdyb=0thengosub1070
270 ifdyb=1thengosub1100
280 vpoke 1,45056+by(b)+bx(b),bc(b)
290 nextb
300 goto 200
1000 rem
1010 bxb=bx(b)
1011 ifbxb=1thendx(b)=1:return
1020 bx(b)=bxb-2:return
1030 rem
1040 bxb=bx(b)
1041 ifbxb=79then bx(b)=77:dx(b)=0:return
1050 bx(b)=bxb+2:return
1060 rem
1070 byb=by(b)
1071 ifbyb=0thendy(b)=1:return
1080 by(b)=byb-256:return
1090 rem
1100 byb=by(b)
1101 ifbyb=7424thenby(b)=7168:dy(b)=0:return
1110 by(b)=byb+256:return
