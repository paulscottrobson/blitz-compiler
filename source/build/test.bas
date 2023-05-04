10 dims(31):sp=0:rem ** stack for quick-sort
11 n=10:dima(n)
12 fort=0ton:a(t)=rnd(1):next
13 t1=ti:l=0:r=n:gosub100:t2=ti
14 remfort=0ton:printa(t):next
15 printt2-t1
16 end
18 :
19 rem ** bubble-sort
20 ifr<=lthenreturn
21 f=0:fort=ltor-1:ifa(t)>a(t+1)thena=a(t):a(t)=a(t+1):a(t+1)=a:f=1
22 next:iffthen21
23 return
29 :
49 rem ** quick-sort
50 ifr<=lthenreturn
51 i=l:j=r:x=a((l+r)/2)
52 ifa(i)<xtheni=i+1:goto52
53 ifa(j)>xthenj=j-1:goto53
54 ifi>jthen57
55 a=a(i):a(i)=a(j):a(j)=a
56 i=i+1:j=j-1
57 ifi<=jthen52
58 ifj-l<r-ithens(sp)=i:s(sp+1)=r:sp=sp+2:r=j:gosub50:goto60
59 s(sp)=l:s(sp+1)=j:sp=sp+2:l=i:gosub50
60 sp=sp-2:l=s(sp):r=s(sp+1):goto50
100 :
105 rem ** heapsort
110 rem 1.schritt heap bauen
115 :
120 en=n
130 rt=int((n-1)/2)
150 ifrt>=0thengosub400:rt=rt-1:goto150
165 :
170 rem 2.schritt liste erzeugen
175 :
180 rt=0
190 s=a(en):a(en)=a(0):a(0)=s
200 en=en-1:gosub400:ifen>0then190
230 return
395 :
396 rem heapsort - siftdown
397 :
400 rs=rt
410 if (rt*2+1)>en then rt=rs:return
420 ch=rt*2+1
430 if (ch+1)<=en then if a(ch)<a(ch+1)thench=ch+1
440 ifa(rt)<a(ch)thens=a(rt):a(rt)=a(ch):a(ch)=s:rt=ch:goto410
450 rt=rs:return