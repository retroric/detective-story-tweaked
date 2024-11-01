3 CLS
4 ' == English version by retroric <retroric48k@yahoo.fr>
5 ' == see https://github.com/retroric/detective-story-tweaked
10 GRAB:HIMEM#B3FF
15 FORI=#BBA4TO#BBA7:POKEI,32:NEXT:REM (erases "CAPS" on status line) [retroric]: REMOVED: "PRINT CHR$(17)" to hide cursor
20 REM [retroric]: MODIFIED: better, more reliable way to hide cursor...
25 GOSUB25000:REM <-- Hides cursor
30 CLS:PAPER0:INK4:GOSUB11200
40 AX=2:IFPEEK(#FB14)<>162THENAX=AX-1
90 DIM PL$(14),M1$(15),M2$(15),M3$(15),M4$(15)
100 DIM TA%(19,28),T%(19),P$(19),NM$(17),N$(17),IN$(12),ID(12),T$(19),Y$(17)
110 DIM V$(15):PJ=1:JX=1:NT=-1:NM=2
120 DEFFNA(X)=INT(RND(1)*X)+1
130 GOSUB13000
150 FORI=0TO19 
155 FORJ=0TO28
160 READ TA%(I,J)
165 NEXTJ,I
170 FORI=0TO19:READP$(I):NEXT
175 FORI=0TO17:READNM$(I):NEXT 
180 FORI=0TO12:READIN$(I):NEXT
182 FORI=0TO14:READ M1$(I):NEXT
185 FORI=0TO14:READPL$(I):NEXT 
188 FORI=0TO14:READM2$(I):NEXT 
190 FORI=0TO14:READM3$(I):NEXT
195 FORI=0TO14:READM4$(I):NEXT
200 GOSUB12000:GOSUB11000
220 GOSUB10200 :GOSUB10500:GOSUB1060
240 FORI=0TO2:GOSUB9100:NEXT:GOSUB9200
242 GOSUB1060:WAIT100
245 CLS:Z=1:GOSUB700 
250 GOSUB8500
270 GOSUB2000:AA=L
275 FT=FT+1:IFFT>8 THENFT=FT-3:GOSUB5800 
280 GOTO270
700 PA=0:IN=4:AF=18:FE=22:BA=19:BD=23:CF=21
705 IF PEEK(#FB14)<>162THENBD=21:CT=23
720 Y=1:FORI=1TO15:PLOTAX+1,Y,VL$:PLOTAX,Y,9:Y=Y+1:NEXT
730 PAPERPA:INKIN:GOSUB1265
735 POKE48680,BD:POKE49040,BD 
740 Y=17:FORI=1TO8:PLOTAX-1,Y,2:Y=Y+1:NEXT
750 Y=1:ONZGOSUB6010,6040,6070,6100,6150,6200,6250,6300,6350
760 RETURN
1000 GETR$:Q=VAL(R$):C=ASC(R$)
1010 RETURN
1020 GETR$:C=ASC(R$):IFC=78ORC=89THENRETURN:REM (N)o or (Y)es
1025 GOTO1020
1030 GOSUB1200:PLOTAX+3,25,12:PLOTAX+4,25,RE$:GETR$:RETURN
1040 GOSUB1200:WAIT30:RETURN
1045 Q$(8)=V$(14):GOSUB1200:GOSUB1020:RETURN
1060 PLOTAX+24,Y,6 :PLOTAX+25,Y,"OK":Y=Y+1:RETURN
1150 AY=18:FORI=0TO8:PLOTAX,AY,NL$:AY=AY+1:NEXT:RETURN 
1180 GOSUB1150:Y=18:FORI=0TO6:IFQ$(I)=""THEN1184
1182 PLOTAX+1,Y,Q$(I):Q$(I)="":Y=Y+1
1184 NEXT:RETURN
1200 GOSUB1150:AY=18:FORI=0TO8:M$=Q$(I):IFM$=""THEN1220
1210 GOSUB1230:Q$(I)="":M$="":ME=FRE("")
1220 NEXT:RETURN
1230 FORJ=1TOLEN(M$):PLOTAX+J,AY,MID$(M$,J,1):WAIT5:NEXT
1235 AY=AY+1:RETURN
1241 H=1:GOTO1250
1242 H=2:GOTO1250
1243 H=3
1250 HH=HH+H:IFNRTHENHH=HH+1
1255 IFHH=>24THENHH=HH-24:JX=JX+1
1260 PL$="s":IFHH=1THENPL$="":REM unused: removed ''+" hour"+PL$'' from line 1268
1265 PLOTHX,0,"                   "
1266 HY=HH:HZ$=" a.m.":IFHY>12THENHY=HY-12:HZ$=" p.m."
1267 IFHY=0THENHY=12:REM 0 hours = midnight = 12 a.m. (see "12-hour clock" on Wikipedia)
1268 HR$=J$(JX)+","+STR$(HY)+HZ$:LH=LEN(HR$):HX=INT(39-LH)/2
1269 POKE48041,4:POKE48040,BD
1270 PLOT HX,0,HR$:HR$="":PING
1271 IFT%(XT)=COTHEN1275
1272 IF(NI=1ANDJXJX>7)OR(NI=2ANDJX>5)OR(NI=3ANDJX>3)OR(NI=4ANDJX>2)THEN9800
1275 RETURN
1300 FORI=0TONT:Q$(I)=N$(I)+"., "+T$(I)+".":NEXT:GOSUB1030:RETURN: REM [retroric]: CORRECTED ADDED MISSING ", "
1400 Z=8:POKEP+2,9:POKEP+3,4:IFP=PJTHENZ=12 
1405 POKEP-1,Z:POKEP-2,2:POKEP+1,N:POKEP-39,16:POKEP-40,CL:RETURN
2000 L=0:AS$="":GOSUB7000
2001 GOSUB1000:L=C:AS$=R$:IFAA=LTHEN2010
2002 IFL=63ORL=47THENGOSUB1300:GOSUB1150:GOSUB7022:GOTO2001:REM (?)=Suspects
2003 IFL=49ORL=33THENGOSUB1150:GOSUB2080:GOSUB1150:GOSUB7022:GOTO2001:REM (!)=Clues
2005 GOSUB5200:GOSUB1150:GOSUB7200
2010 IFL=79THENZ=7:GOSUB700:GOSUB2100:GOSUB1241:RETURN:REM (O)ffice
2011 IFL=71THENZ=1:GOSUB700:GOSUB5250:RETURN:REM (G)lady's Bar
2012 IFL=67THENZ=D%(6):GOSUB700:GOSUB2200:RETURN:REM (C)rime Scene
2014 IFNT=-1THENRETURN
2065 GOSUB2400:RETURN
2080 Q$(0)="Victim:":Q$(1)=N$(6)+"., "+T$(6):Q$(2)="Clues:"
2082 IFIY=0 THENQ$(3)="None discovered...":GOTO2090
2084 FORI=0TO2:Q$(I+3)=II$(I):NEXT
2090 GOSUB1030:RETURN
2100 IFPJ=BUTHENST=1
2101 Q$(0)="YOU ARE AT YOUR OFFICE...":PJ=BU:H=1
2102 IFLC=0ORMS=2ORST=1THENST=0:GOTO2112
2103 Q$(1)="An anonymous caller rang":Q$(2)="in your absence..."
2104 IFMS=1THENQ$(1)="A friend of the victim has been":Q$(2)="waiting for you..."
2105 Q$(3)="According to him, a person could be"
2106 Q$(4)="involved in the case:"
2108 Q$(5)=N$(NT+1)+"., "+T$(NT+1)+".":NT=NT+1:MS=MS+1
2110 GOSUB1030:GOTO2120
2112 Q$(2)="Telephone messages: NONE.":Q$(1)=" ":GOSUB1040
2120 Q$(0)="BEFORE LEAVING, WHAT WILL YOU TAKE?"
2121 Q$(2)="1- Your "+V$(0)+"."
2122 Q$(3)="2- An "+V$(1)+".":Q$(4)="3- A "+V$(2)+"."
2123 Q$(5)="4- A "+V$(3)+".":Q$(6)="  (L)eave - (I)nventory."
2124 Q$(1)= " (T)ake + (No?) - (D)rop + (No?)":GOSUB1180
2125 PLOTAX+1,25,"Exchange: (D)rop before (T)aking"
2126 GOSUB1000:IFC=13 THEN2126
2127 IFC=68THEN2142:REM (D)rop
2128 IFC=76THENRETURN:REM (L)eave 
2129 IFC=73OROB=2THENGOSUB2180:GOTO2120:REM (I)nventory
2130 IFC<>84THEN2126:REM (T)ake
2132 GOSUB1000:IFC=73THENGOSUB2180:REM (I)nventory
2134 IFC=13 ORC<49 ORC>52 OR OB=2THEN2126
2135 IF OB$(Q-1)<>""THEN 2126
2136 OB$(Q-1)=V$(Q-1):OB=OB+1:ONQGOSUB2150,2155,2160,2165
2139 IFOB=2THENGOSUB2180:GOTO2120
2140 GOTO2126
2142 GOSUB1000:IFC<49 OR C>52 OR C=13THEN2142
2143 IF C=80 OR OB$(Q-1)=""THEN2126
2144 OB=OB-1:ONQGOSUB2146,2147,2148,2149:OB$(Q-1)=""
2145 GOTO2126
2146 RV=0:RETURN
2147 MA=0:RETURN
2148 LO=0:RETURN
2149 MQ=0:RETURN
2150 RV=1:RETURN 
2155 MA=1:RETURN
2160 LO=1:RETURN
2165 MQ=1:RETURN
2180 Q$(0)="You are currently carrying:":Q$(1)=" "
2182 FORI=2TO5:Q$(I)=OB$(I-2):NEXT
2190 GOSUB1030:RETURN
2200 Q$(0)="You are now at "+V$(13)+"...":LC=1:PJ=AV:YT=VI:GOSUB1200
2210 Q$(0)="Without delay, you enter "
2230 L$="the ":GOSUB3500:REM IFLEFT$(Q$(1),1)="a"THENL$="l'"
2231 Q$(1)=""+L$+Q$(1)+" of":Q$(2)=N$(6)+"., "+T$(6)+", "
2232 Q$(3)=V$(8)+"...":GOSUB1200
2235 Q$(1)=" ":Q$(2)=QF$
2240 Q$(3)="Search for (C)lues - Inspect (P)apers"
2245 Q$(4)="Interview the (N)eighbours - "
2246 Q$(5)="Examine the (B)ody - (L)eave.........":GOSUB1180:GOSUB1000
2250 IFC=67THEN2280:REM  Search for (C)lues
2255 IFC=80THEN2290:REM  Inspect (P)apers
2260 IFC=78THEN2300:REM  Interview (N)eighbours
2265 IFC=66THEN2310:REM  Examine (B)ody
2270 IFC<>76THEN2235:REM (L)eave
2275 RETURN
2280 IFLO=0THENNB$=V$(2):GOSUB5000:IFR$="O"THENGOSUB1243:RETURN
2286 GOSUB4100:GOSUB1242:GOTO2235
2290 GOSUB3000:GOSUB1200:GOTO2235
2300 YT=VI:XT=6:NT$=V$(8):GOSUB4200:GOTO2235 
2310 REM
2315 GOSUB10800:Q$(0)="A thorough examination of "+V$(8)
2316 Q$(1)="reveals that "+N$(6)+". died":Q$(3)=AC$+"."
2318 GOSUB1030:CI=CI+1:GOTO2235
2400 REM
2405 FORI=0TONT:IFLEFT$(N$(I),1)=AS$THENYT=T%(I):XT=I:I=5:PJ=AS(XT) 
2410 NEXT
2470 Z=D%(XT):GOSUB700 
2475 Q$(0)="You stand in front of the house of"
2480 Q$(1)=N$(XT)+"., "+T$(XT)+".":Q$(2)=QF$:SV$="the suspect"
2485 Q$(4)="Interview the (S)uspect - Interview"
2486 Q$(5)="the (N)eighbours - (T)ail the suspect"
2487 Q$(6)="(A)rrest the culprit - (L)eave.":GOSUB1180:GOSUB1000
2488 IFC=83THEN2500:REM (S)uspect
2489 IFC=78THEN2515:REM (N)eighbours
2490 IFC=65THEN2520:REM (A)rrest
2491 IFC=84THEN8000:REM (T)ail
2492 IFC<>76THEN2475:REM (L)eave
2495 GOTO2530
2500 Q$(0)="You ring the bell... No reply.":Q$(1)=" ":IFFXORFUTHEN2540
2501 EY$=XM$(XT)+"lets you in "+XX$(XT):IFSTTHEN2540 
2502 IFT%(XT)=COANDTA%(CO,7)=5THENS=1:GOTO2507
2503 IFTA%(YT,28)>0THENGOSUB2950:GOTO2475
2504 IFTA%(YT,13)=5THENS=4:GOTO2507
2506 S=FNA(5)
2507 ONSGOSUB2600,2700,2800,2850,2890:GOSUB1200:ST=1
2508 IFFXTHENFX=0:GOTO2475
2509 GOSUB2980:GOSUB3950:GOSUB1200:RB=0
2510 GOSUB5500:IFFXTHENFX=0:GOTO2475
2511 GOSUB4500:GOSUB5600:GOTO2475
2515 NT$="the suspect":GOSUB4200:GOTO2475
2520 GOTO9500
2530 FX=0:OU=0:FU=0:FL=0:TB=0:IT=0:ST=0:RA=0:RETURN
2540 GOSUB1200:GOTO2475
2600 IFFLTHENFL=0:GOTO2700
2602 Q$(2)="By chance, "+N$(XT)+". just arrives..." 
2605 Q$(3)=XM$(XT)+"is on foot..."
2610 IFTA%(YT,7)=5THENQ$(3)=XM$(XT)+"parks "+XX$(XT)+"car nearby..."
2615 RETURN
2700 Q$(2)="DO YOU INSIST (Y/N)?":GOSUB1200:GETR$:IFR$="N"THENFX=1:RETURN
2710 GOSUB1241:IFFNA(4)>3THEN2720 
2712 Q$(0)="At last, "+N$(XT)+". opens up.":OU=1:FX=0:RETURN
2720 Q$(0)="NO SUCCESS!":GOSUB1200:GOTO2700
2800 Q$(0)="Without a "+V$(3)+", "+XT$(XT):Q$(1)="refuses to talk to you..."
2805 Q$(2)=" ":Q$(3)="DO YOU HAVE ONE (Y/N)?":GOSUB1200:GOSUB1020:NB$=V$(3)
2810 IFMQ=1THENRETURN
2815 IFR$="Y"THENQ$(0)="..... LIAR!":GOSUB1200
2820 GOSUB5020:IFR$="Y"THENFX=1:RETURN  
2822 Q$(0)="As a result, "+N$(XT)+". slams the door"
2825 Q$(1)="on your face...":FX=1:RETURN
2850 IFTA%(YT,13)<4THEN2700
2855 Q$(0)="Bloody cop, get out!":Q$(1)="In anger, your "+V$(11)+"threatens"
2860 Q$(2)="to do bad things to you...":GOSUB1200
2870 IFRV=0THENNB$=V$(0):GOSUB5000:IFR$="N"THENFX=1:RETURN
2875 IFRV=0THENFX=1:RETURN
2880 Q$(0)="At the sight of your "+V$(0)+",":Q$(2)=XT$(XT)+"calms down...":RETURN
2890 Q$(0)="You ring the bell. "+N$(XT)+". opens up.":RETURN
2950 Q$(3)="A neighbour tells you that "
2951 Q$(4)=JX$(XT)+N$(XT)+".":Q$(5)=L1$:Q$(6)=" "
2952 GOSUB1030:SA=1:IFN$(XT)=N$(0)THENSV$="this witness" :GOTO4340 
2954 RETURN
2980 Q$(0)=EY$:GOSUB3500:Q$(1)=Q$(1)+".":RETURN
3000 IFI0=1THENQ$(1)="You don't find anything else..":GOSUB1200:RETURN
3005 Q$(1)="You find an address book...":GOSUB1242 
3010 Q$(2)="One of the names in it intrigues you:"
3020 Q$(3)=" ":Q$(4)=N$(NT+1)+"., "+T$(NT+1):NT=NT+1:GOSUB1030:I0=1:RETURN
3025 Q$(5)=N$(NT+2)+"., "+T$(NT+2):NT=NT+2:GOSUB1030:I0=1:RETURN
3100 K=TA%(YT,1):ONKGOTO3130,3140,3150,3160,3170
3130 Q$(2)="without wealth or fixed income,":RETURN
3140 Q$(2)="apparently not very rich,":RETURN
3150 Q$(2)="of average wealth,":RETURN
3160 Q$(2)="clearly free from want,":RETURN
3170 Q$(2)="with a large wealth,":RETURN 
3200 K=TA%(YT,4):ONKGOTO3230,3240,3250,3260,3260
3230 Q$(3)="the hard-boiled bachelor type,":RETURN 
3240 Q$(3)="living a bachelor's life,":RETURN
3250 Q$(3)="divorced for 2 years,":RETURN
3260 Q$(3)="married for several years,":RETURN
3270 GOTO3260
3300 K=TA%(YT,3):ONKGOTO3330,3340,3350,3360,3370 
3330 Q$(4)="living in idleness,":RETURN
3340 Q$(4)="letting "+XX$(XT)+"life unfold,":RETURN
3350 Q$(4)="hard-working yet also enjoying life,":RETURN 
3360 Q$(4)="very absorbed by "+XX$(XT)+"job,":RETURN
3370 Q$(2)="living only for "+XX$(XT)+"work,":RETURN 
3400 SO=TA%(YT,10):TR=TA%(YT,3):MI$="":IFSO=5ANDTR>3THENMI$="but "
3410 IFSO=5THEN3440
3420 Q$(5)=MI$+"of an exemplary soberness...":RETURN
3440 Q$(5)=MI$+"drinking a lot on occasion!":RETURN
3500 K=TA%(YT,5):ONKGOTO3510,3520,3530,3540,3550
3510 Q$(1)="miserable dwelling":RETURN
3520 Q$(1)="modest dwelling":RETURN
3530 Q$(1)="spacious house":RETURN
3540 Q$(1)="comfortable flat":RETURN
3550 Q$(1)="luxuous appartment":RETURN
3600 K=TA%(YT,13):ONKGOTO3630,3640,3650,3660,3670
3630 Q$(2)="very reserved by nature,":RETURN
3640 Q$(2)="of a rather calm temperament,":RETURN
3650 Q$(2)="quite moody and unpredictable,":RETURN 
3660 Q$(2)="afflicted by a rather moody nature,":RETURN
3670 Q$(2)="of an excessive, violent nature,":RETURN
3800 H$="women":IFTA%(YT,0)=2THENH$="men" 
3820 IFTA%(YT,6)=0THENQ$(4)=XM$(XT)+"has no known love relationship.":RETURN
3825 Q$(4)="... Very attracted by "+H$+"!":RETURN
3840 RETURN
3850 IFTA%(YT,9)=5THEN3875
3860 Q$(3)="hates sweets...":RETURN
3875 Q$(3)="is quite fond of candies!":RETURN
3880 IFTA%(YT,7)=5 THENQ$(1)="owns a car...":RETURN
3890 Q$(1)="doesn't have a car...":RETURN
3900 IFTA%(YT,8)=0THENQ$(2)="doesn't smoke...":RETURN
3920 Q$(2)="smokes a lot...":RETURN
3950 Q$(2)="Immediately, you find "+N$(XT)+"."
3960 IFTA%(YT,12)=0THEN3975
3970 Q$(3)="elegant, and well-groomed...":RETURN
3975 Q$(3)="rather unkempt...":RETURN 
3980 MI$="clearly ":IFTA%(YT,13)>3THENMI$="yet "
3985 IFTA%(YT,11)=0THEN3995
3990 Q$(3)=MI$+"very learned...":RETURN
3995 Q$(3)="also quite uneducated.":RETURN
4010 Q$(4)="Finally, "+XT$(XT)+"is said to be"
4025 IFTA%(YT,2)=0THEN4040
4030 IFTA%(YT,2)=3THENQ$(5)="of a rather thrifty nature...":RETURN
4035 Q$(5)="quite greedy!":RETURN
4040 Q$(5)="generous, a spendthrift on occasion.":RETURN
4100 Q$(0)="You discover curious items"
4105 Q$(1)="next to the body...":Q$(2)=" ":IY=1
4110 FORI=0TO2:IFLO=0AND(ID(I)=15ORID(I)=19ORID(I)=25)THENGOSUB4160:GOTO4118
4115 II$(I)="- "+ID$(I):Q$(I+4)=II$(I):CI=CI+1
4118 NEXT
4119 IFCI=3THENND=ND+1
4120 GOSUB1030:IFI2$=""THENRETURN
4130 Q$(0)="Interesting! You also discover"
4135 Q$(1)=I2$:Q$(2)=" ":GOSUB1030:CI=0:RETURN
4160 II$(I)="- ?? (a magnifying glass would help!)":Q$(I+4)=II$(I):CI=0:RETURN
4200 Q$(0)="A neighbour describes "+N$(XT)+"., "
4220 H$="a man ":IFTA%(YT,0)=2THENH$="a woman "
4230 Q$(1)=NT$+", as being "+H$
4235 GOSUB3100:GOSUB3200:GOSUB3300:GOSUB3400:GOSUB1030:GOSUB1241
4240 GOSUB4400:IFR$="N"THENRETURN
4250 IFFNA(3)<2THENGOSUB4900
4253 IFTBTHENRETURN
4280 Q$(0)="According to this new witness,"
4285 MI$="would be ":IFXT=6THENMI$="was "
4286 Q$(1)=N$(XT)+". "+MI$+H$
4290 GOSUB3600:GOSUB3980:GOSUB3800:GOSUB1030:GOSUB1241
4295 GOSUB4400:IFR$="N"THENRETURN
4320 Q$(0)="You also learn that "+N$(XT)+".":GOSUB3880:GOSUB3900 
4330 GOSUB3850:GOSUB4010:GOSUB1030:GOSUB1241
4332 IFT%(XT)=COTHENND=ND+1
4333 RETURN
4335 IFN$(XT)<>N$(0)ORNN=1THENRETURN
4340 IFNNTHENRETURN
4341 Q$(0)="Interesting! At the end, "+SV$
4345 Q$(1)="gives you a name:":Q$(2)=N$(NT+1)+"., "+T$(NT+1)+", ":NT=NT+1
4350 Q$(3)="with whom the victim apparently"
4355 Q$(4)="had a relationship!":GOSUB1030:GOSUB1241:NN=1:RETURN 
4400 GOSUB1150:AY=18:PLOTAX,AY,AV$:GOSUB1000:RETURN 
4500 Q$(0)="SUBJET OF THE INTERVIEW?":Q$(1)=" "
4505 Q$(2)="1- Relationship with the victim"
4510 Q$(3)="2- Agenda at the time of the crime"
4515 Q$(4)="3- End of interview"
4520 GOSUB1180:GOSUB1000:IFQ=3THENFX=0:GOSUB4335:RA=1:RETURN
4522 IFRATHEN4880
4525 ONQGOSUB4550,4800:GOSUB1030:GOSUB1241:GOTO4500
4550 Q$(0)=N$(XT)+". tells you that"
4551 Q$(1)=N$(6)+"., "+V$(8)+", was"
4553 DE$="an old acquaintance, met"
4555 D1=TA%(YT,1):D2=TA%(VI,1):D3=TA%(YT,0):D4=TA%(VI,0)
4558 D5=TA%(YT,6):D6=TA%(VI,6):OU$="at a dancing hall...":D7=T%(XT) 
4559 IFD7=0ORD7=2ORD7=4ORD7=19 AND(VI=0ORVI=2ORVI=4ORVI=19)THEN4785
4560 IFD1>3ANDD2>3THENOU$="at a cocktail party..."
4562 IFTA%(YT,11)=5ANDTA%(VI,11)=5THEN4760
4565 IFD3<>D4THEN4770
4570 IFD1=5ANDD2=5THEN4775
4572 IFD1>3ANDD2<4THEN4780
4575 IFD1>3ANDD2>3THEN4790
4580 GOTO4780
4760 OU$="a long time ago in a museum...":GOTO4775
4770 IFD5=0ORD6=0THEN4570
4775 Q$(2)=DE$:Q$(3)=OU$:RETURN
4778 Q$(2)="..was.."+XM$(XT)+"blushes, stutters,"
4779 Q$(3)="refuses to say more...":RETURN 
4780 Q$(2)="a very vague acquaintance... "
4782 Q$(3)=XY$(6)+"death doesn't afflict "+XZ$(XT)+"much..":RETURN
4785 Q$(2)="a business relationship...":RETURN
4790 Q$(2)="a very old friend."
4792 Q$(3)=XY$(6)+"tragic ending saddens "+XZ$(XT)+"...":RETURN
4800 Q$(0)=N$(XT)+". thinks for a moment...":GOSUB1200
4802 Q$(0)="At the time of the crime, "+XT$(XT)+"was..."
4810 IFFNA(2)=1THEN4830
4820 IFTA%(YT,25)=5THEN4865 
4825 IFFNA(2)=1THEN4833
4830 IFTA%(YT,23)=5THEN4860
4833 IFTA%(YT,22)=5THEN4870
4834 IFFNA(2)=1THEN4838
4835 IFTA%(YT,20)=5THEN4850
4838 IFTA%(YT,18)=5THEN4875
4840 Q$(1)="at home. "+XM$(XT)+"had stayed in"
4845 Q$(2)="all day long...":RETURN
4850 Q$(1)="at the movies, in Broadway.":RETURN
4860 Q$(1)="in bed, following a...":Q$(2)="memorable bender!"
4861 RETURN
4865 Q$(1)="in bed, depressed after a"
4867 Q$(2)="particularly hard day.":RETURN
4870 Q$(1)="engrossed in the reading of a"
4872 Q$(2)="very thrilling crime novel.":RETURN
4875 Q$(1)="out and about, driving around":Q$(2)="Newport...":RETURN 
4880 Q$(0)=XM$(XT)+"has nothing to add to "+XX$(XT)
4882 Q$(1)="previous declarations...":GOSUB1200:RETURN
4900 Q$(0)="What now!... This witness refuses"
4902 Q$(1)="to talk...":Q$(2)=" "
4910 Q$(3)="   WHAT SHALL I DO?":Q$(4)=" "
4912 Q$(5)="1- Threaten him   2- Insist  3- Leave":GOSUB1180
4920 GOSUB1000:IFC<49ORC>51THEN4920
4925 ONQGOTO4940,4950,4970 
4940 IFFNA(8)=1THEN4980
4942 Q$(0)="Nope!...":GOSUB1200:GOTO4910
4950 IFPE=2THENPE=0:GOTO4980
4955 Q$(0)="He stares at you, his mouth sealed..."   :PE=PE+1:GOSUB1200:GOTO4910
4970 TB=1:RETURN
4980 Q$(0)="AT LAST! He talks...":GOSUB1200:RETURN
5000 Q$(0)="You have no ":Q$(1)=NB$+"."
5010 IFNB$=V$(2)THENQ$(0)=Q$(0)+NB$:Q$(1)="to be able to work efficiently."
5012 IFNB$=V$(0)THENQ$(0)=Q$(0)+NB$:Q$(1)="to impress the opponent.."
5020 Q$(3)="Do you want to go back to":Q$(4)="your office (Y/N)?"
5025 GOSUB1200:GOSUB1020:RETURN
5200 IFOT=1ORFO=1THENRETURN
5202 IFPCTHEN5700
5203 IF MPTHENGOSUB5730:RETURN
5205 Q$(0)="Will you take your (C)ar,"
5210 Q$(1)=" or will you go on (F)oot?"
5214 GOSUB1200:GOSUB1000:OT=1:IFC=70THENOT=0:MP=1:RETURN
5215 IFC<>67THEN5200
5226 MP=0:RETURN
5250 IFPJ=GLTHENST=1
5251 Q$(0)="YOU ARRIVE AT "+GB$+"...":Q$(1)=" ":PJ=GL
5252 IFHH>1ANDHH<9THEN5270
5253 Q$(2)="How much time do you stay there?":Q$(3)="  (1) hour - (2) hours?"
5254 GOSUB1180:GOSUB1000:IFQ=1THENNB$="1 hour ":H=1:GOTO5256
5255 NB$="2 hours ":H=2 
5256 IFST=1THENST=0:GOTO5274
5257 IFLC=0ORNT=5OR(Q=1ANDFNA(3)>1)ORJK=2THENGOSUB5274:RETURN
5258 Q$(1)="Lucky you! Jack-the-Snoop drops by..."
5259 Q$(2)="According to him, the victim"
5260 Q$(3)="was recently seen with a certain"
5261 Q$(4)=N$(NT+1)+"., "+T$(NT+1)+".":NT=NT+1
5262 IFJKTHENQ$(1)="The barman has a tip for you..."
5264 Q$(5)="... Thanks for the information!"
5268 JK=JK+1:GOSUB1030:GOSUB5274:RETURN
5270 Q$(2)="Absent-minded you! The bar is always"
5272 Q$(3)="closed from 2 a.m to 9 a.m...":GOSUB1030:RETURN
5274 Q$(0)=NB$+"later, you leave":Q$(1)=GB$+"..."
5276 GOSUB1200:GOSUB1250:RETURN
5500 TC$="coffee":IFTA%(YT,10)=5THENTC$="whisky"
5505 IFT%(XT)=COTHEN5515
5510 IFFNA(2)=1ORFU=1THENRETURN
5515 Q$(0)="Amiably, "+XT$(XT)+"invites you to":Q$(1)="drink a "+TC$+"."
5520 Q$(2)=" ":Q$(3)="DO YOU ACCEPT (Y/N)?"
5525 GOSUB1200:GOSUB1020:IFR$="N"THENRB=1:GOTO5560
5530 Q$(0)= "The "+TC$+" is delicious.":RB=0 
5535 Q$(1)="You sip it very slowly, while"
5536 Q$(2)="interwiewing the witness...":IFT%(XT)=COANDFNA(3)>1THEN5585
5540 GOSUB1200:GOSUB1241:RETURN
5550 Q$(0)="Are you in a bad mood, or what??":GOSUB1200:RETURN
5560 IFTA%(XT,13)<4THEN5550
5562 Q$(0)="Upset, "+XT$(XT)+"refuses to answer"
5565 Q$(1)="your questions...":Q$(2)=" "
5570 Q$(3)="Will you change your mind and accept":Q$(4)=XX$(XT)+TC$+" (Y/N)?"
5572 GOSUB1200:GOSUB1020
5575 IFR$="O"THENRB=0:GOTO5530
5577 Q$(0)="You won't get any more info then...":FX=1:FU=1:GOSUB1200:RETURN
5585 GOSUB1200
5588 Q$(0)="Oh, my, oh my! The drink contained":Q$(1)="poison..."
5590 Q$(3)="...You were at the ASSASSIN'S!!!"
5591 Q$(4)="Your career as a detective comes":Q$(5)="to a premature end!"
5595 GOSUB1030:GOSUB9560
5597 Q$(0)="You careless you! The temptress":Q$(1)="takes this opportunity to stab"
5598 Q$(2)="you in the back!":GOTO5590
5600 REM
5602 IFT%(XT)=COANDTA%(CO,0)=2THEN5615 
5605 IFTA%(YT,0)=1ORTA%(YT,6)=0THENRETURN
5610 IFRBTHENRB=0:RETURN
5615 Q$(0)="She's pretty... She is using her":Q$(1)="charms on you..." 
5620 Q$(2)=" ":Q$(3)="DO YOU ACCEPT HER ADVANCES (Y/N)?":REM or "YIELD TO..."
5625 GOSUB1200:GOSUB1020:IFR$="N"THEN5575
5628 IFT%(XT)=COTHEN5597
5630 Q$(0)="She is delighted... She now decides"
5635 Q$(1)="to confide in you... According to":Q$(2)="her, the matter seems to be"
5636 Q$(3)=CR$+"...":Q$(4)="She has very good reasons to say so."
5640 Q$(5)="... Thank you, sweetie!"  :GOSUB1243:GOSUB1030:ND=ND+1:RETURN
5700 Q$(0)="Don't forget that the tires on":Q$(1)="your car are flat."
5710 GOSUB5750:IFR$="N"THENMP=1:OT=0:RETURN
5720 H=4:GOSUB1250:MP=0:OT=1
5722 IFPC=1THENPC=0
5727 RETURN
5730 Q$(0)="You came by foot... You can go fetch"
5735 Q$(1)="your car if you like, but this will"
5736 Q$(2)="take you 2 hours...":GOSUB1045:IFR$="N"THENRETURN
5740 MP=0:OT=1:GOSUB1242:RETURN
5750 Q$(2)= RM$:GOSUB1045:RETURN 
5800 Q$(0)="At this rate, you won't last long!!"
5810 Q$(1)="Six hours rest at home would do"
5815 Q$(2)="you most good..."
5820 Q$(3)=" ":Q$(4)=V$(14):GOSUB1180:GOSUB1020
5825 IFR$="N"THENNR=1:RETURN
5830 H=6:GOSUB1250:FT=0:NR=0:CLS
5835 Q$(0)="Six hours later... You are"
5838 Q$(1)="in a great shape..."
5840 Q$(2)="You resume your investigation...":GOSUB1200:P=0:RETURN
6010 Y=1:FORI=0TO14:MH$=M1$(I)+LEFT$(M2$(I),9)
6012 PLOTAX+1,Y,MH$:Y=Y+1:NEXT 
6013 FORI=2TO5:PLOTAX+8,I,PA+16:PLOTAX+7,I,9:PLOTAX,I,12:PLOTAX+1,I,AF:NEXT
6015 PLOTAX+2,3,"COCA-":PLOTAX+2,4,"COLZA"
6016 FORI=9TO10:PLOTAX+6,I,PA+16:PLOTAX+6,I+3,PA+16 
6017 PLOTAX+1,I,FE:PLOTAX+1,I+3,FE:NEXT
6020 PLOTAX+23,15,PA+16:PLOTAX+10,15,CF
6025 FORI=12TO15:PLOTAX+33,I,FE:NEXT:PLOTAX+32,10,BA:PLOTAX+33,10,8
6026 FORI=4TO5:PLOTAX+35,I,FE:NEXT:FORI=7TO8:PLOTAX+33,I,FE:NEXT
6030 RETURN
6040 FORI=0TO14
6044 MH$=MID$(M2$(I),3,15)+MID$(M1$(I),15,13)+" "+LEFT$(M2$(I),8)
6046 PLOTAX+1,Y,MH$:Y=Y+1:NEXT
6048 FORI=12TO15:PLOTAX+10,I,PA+16:PLOTAX+3,I,FE:PLOTAX+34,I,BA:NEXT
6050 Y=10:PLOTAX+13,Y,PA+16:PLOTAX+9,Y,9:PLOTAX+3,Y,BA 
6052 PLOTAX+4,Y,8:PLOTAX+5,Y,"Luck":PLOTAX+34,Y,8:PLOTAX+35,Y,"GOO"
6053 PLOTAX+36,2,FE
6054 FORI=4TO5:PLOTAX+15,I,PA+16:PLOTAX+9,I,FE:PLOTAX+34,I,FE:NEXT 
6060 FORI=7TO8:PLOTAX+7,I,PA+16:PLOTAX+3,I,FE:NEXT:RETURN
6070 FORI=0TO14
6074 MH$= MID$(M2$(I),10,9)+" "+M2$(I)+MID$(M2$(I),10,6)
6078 PLOTAX+1,Y,MH$:Y=Y+1:NEXT
6080 FORI=12TO15:PLOTAX+23,I,PA+16:PLOTAX+15,I,FE:PLOTAX+35,I,FE:NEXT
6084 FORI=7TO8:PLOTAX+22,I,PA+16:PLOTAX+33,I,FE:PLOTAX+15,I,FE:NEXT
6087 FORI=1TO2:PLOTAX+25,I,PA+16:PLOTAX+15,I,FE:NEXT
6090 FORI=4TO5:PLOTAX+6,I,PA+16:PLOTAX+4,I,FE:PLOTAX+35,I,FE:NEXT
6095 Y=10:PLOTAX+25,Y,PA+16:PLOTAX+19,Y,9:PLOTAX+16,Y,8:PLOTAX+15,Y,BA 
6096 PLOTAX+17,Y,"OK":RETURN
6100 FORI=0TO14  
6105 MH$=MID$(M2$(I),12,7) +MID$(M1$(I),8,14)+"  "+LEFT$(M3$(I),14)
6110 PLOTAX+1,Y,MH$:Y=Y+1:NEXT
6125 FORI=1TO11:PLOTAX+26,I,FE:NEXT
6130 FORI=14TO15:PLOTAX+29,I,FE:NEXT
6135 PLOTAX+15,15,PA+16:PLOTAX+10,15,CF:RETURN
6150 FORI=0TO14 
6155 MH$=MID$(M1$(I),22,6)+MID$(M1$(I),15,7)+" "+M3$(I)+MID$(M1$(I),9,8)
6160 PLOTAX+1,Y,MH$:Y=Y+1:NEXT 
6165 PLOTAX+10,15,PA+16:PLOTAX+9,15,FE  
6170 FORI=1TO11:PLOTAX+29,I,PA+16:PLOTAX+17,I,FE:NEXT:RETURN
6180 FORI=14TO15:PLOTAX+25,I,PA+16:PLOTAX+20,I,FE:NEXT:RETURN
6200 FORI=0TO14
6210 MH$=MID$(M2$(I),19,3)+MID$(M1$(I),9,20)+MID$(M1$(I),15,15) 
6215 PLOTAX+1,Y,MH$:Y=Y+1:NEXT:D9=1:RETURN
6225 FORI=3TO4:PLOTAX+2,I,10:NEXT:PLOTAX+2,6,8:PLOTAX+2,7,8
6250 SP$="     ":NO=LEN(NF$):IFNO>12THENNF$=LEFT$(NF$,12):NO=12 
6251 PLOT0,0,BD 
6252 AN=INT((12-NO)/2)+6:FORI=1TO15:PLOTAX+2,I,0:NEXT
6253 IFAX=1THENAN=AN-1
6254 FORI=0TO14
6255 MH$=SP$+RIGHT$(M4$(I),14)+" "+MID$(M1$(I),9,13)+LEFT$(M2$(I),4)
6258 PLOTAX+1,Y,MH$:Y=Y+1:NEXT
6260 FORI=1TO15:PLOTAX+20,I,16:PLOTAX+17,I,4:PLOT0,I,22:PLOTAX+3,I,0:NEXT
6262 FORI=3TO4:PLOTAX+16,I,9:PLOTAX+2,I,10:NEXT:PLOTAX+16,6,9:PLOTAX+2,6,8
6263 PLOTAX+16,7,9:PLOTAX+2,7,8
6265 PLOTAN,3,NF$:PLOTAN,4,NF$:PLOTAX+5,6,"Licensed"
6270 PLOTAX+6,7,"Detective":RETURN
6300 NM$="NO MAN'S L":IS$="IS GOOD FO":S$="  "
6305 Y=1:FORI=0TO14
6310 MH$=LEFT$(M4$(I),6)+LEFT$(M4$(I),8)+S$+LEFT$(M2$(I),2)+LEFT$(M4$(I),19)
6320 PLOTAX+1,Y,MH$:Y=Y+1:NEXT
6325 FORJ=4TO10:PLOTAX+26,J,18:PLOTAX+27,J,10:NEXT
6330 PLOTAX+28,5,NM$:PLOTAX+28,6,NM$:PLOTAX+28,7,IS$:PLOTAX+28,8,IS$
6335 FORI=12TO15:PLOTAX+9,I,PA+16:NEXT:RETURN
6350 D9=0:FORI=0TO14
6355 MH$=LEFT$(M4$(I),8)+LEFT$(M4$(I),8)+MID$(M1$(I),7,15)+LEFT$(M4$(I),6)
6360 PLOTAX+1,Y,MH$:Y=Y+1:NEXT:RETURN
7000 CLS:GOSUB1150:INK2 
7002 BD=23:POKE48040,BD:FORI=1TO15:PLOTAX-1,I,4:NEXT
7005 GOSUB1265
7010 Y=1:FORI=0TO14:PLOTAX,Y,9:PLOTAX+1,Y,PL$(I):Y=Y+1:NEXT:POKE48680,BD
7015 P=BU:CL=22:N=79:GOSUB1400:REM Display location of (O)ffice
7016 P=GL:CL=21:N=71:GOSUB1400:REM Display location of (G)lady's Bar
7020 P=AV:CL=17:N=67:GOSUB1400:REM Display location of (C)rime Scene
7021 POKE49040,BD:PLOT1,24,4 
7022 IFNT=-1THEN7030
7025 FORI=0TONT:P=AS(I):CL=19:N=ASC(LEFT$(N$(I),1)):GOSUB1400:NEXT 
7030 PLOTAX,18,"  WHERE DO YOU WANT TO GO?"
7035 Y=19:FORI=1TO5:PLOTAX+1,Y,16:Y=Y+1:NEXT:PLOTAX+20,19,16
7040 PLOTAX,19,22:PLOTAX+2,19,"Your (O)ffice."
7045 PLOTAX+19,19,21:PLOTAX+21,19,"(G)ladys's bar."
7050 PLOTAX,20,17:PLOTAX+2,20,"(C)rime scene.":IFPJ=0 THENRETURN 
7052 IFDB=0THENDB=1:RETURN
7054 PLOTAX,25,CHR$(4)+CHR$(12)+"Blinking"+CHR$(8)+":"+CHR$(0)+"your current position.":PLOT1,25,0: REM [retroric]: added CHR$(4) for blue ink, CHR$(0) for black ink, CHR$(12) for Blinking and CHR$(8) to revert to Normal text
7055 IFNT=-1THENRETURN
7056 PLOTAX,21,19:PLOTAX+2,21,"Suspect's address:type their initial"
7057 PLOTAX,22,"  <?>:List of suspects."
7058 PLOTAX,23,"  <!>:List of physical clues."
7080 RETURN
7200 IFFNA(6)=1ANDLC=1ANDMP=0ANDFO=0THENGOSUB7400
7205 Q$(0)="You are on your way...":Z=6:IFD9=1THENZ=9
7206 IFMPTHENQ$(0)="You leave on foot..."
7207 GOSUB700:GOSUB1200:IFFO=1ORMP=1THENH=3:GOTO7212
7208 GOSUB7330
7212 Q$(0)="You get a smooth, uneventful ride...":IFMP=1ORLO=1THEN7240
7215 IFFNA(6) =1THEN7300 
7220 IFVZ=2ANDFNA(2)=1THEN7350
7240 GOSUB1200:GOSUB1250:GOSUB1150:RETURN
7300 IF EB=2THEN7240
7302 Q$(0)="Well done... You end up blocked"
7303 Q$(2)="in a gigantic traffic jam...":IFEBTHENGOSUB7320
7305 Q$(3)="Do you want to leave your car":Q$(4)="and continue on foot (Y/N)?"
7310 EB=EB+1:GOSUB1200:GOSUB1020:IFC=79THENMP=1:OT=0:H=1:GOTO7240 
7315 H=3:GOTO7240
7320 Q$(0)="Another traffic jam... It is a curse"
7325 Q$(1)="to get around in this damn city!":Q$(2)="":RETURN
7330 Q$(0)="How fast will you drive?":Q$(1)=" "
7332 Q$(3)="1- 30 mph      |   2- 60 mph ?":GOSUB1180
7334 GOSUB1000:IFC=50THENVZ=2:H=1:RETURN
7336 IFC<>49THEN7334 
7338 VZ=0:H=2:RETURN
7350 Q$(0)="Damn it! A policeman's whistle!!"
7352 Q$(1)="Speeding offense in the city..."
7354 AT$="":IFPV>0THENAT$="another " ELSE AT$="a "
7356 Q$(2)="You get "+AT$+"ticket!":PV=PV+1:REM [retroric]: inverted order of lines 7356/7358 so you really get a suspension after 3 fines (not after 4 like before!)
7358 IFPV>2THEN7380
7360 GOTO7240
7380 Q$(2)="THREE tickets in such a short time is"
7382 Q$(3)="UNACCEPTABLE! Your driver's licence"
7384 Q$(4)="is suspended for a week!":Q$(5)="You must continue on foot..."
7385 FO=1:MP=1:H=3:VZ=0:GOTO7240
7400 IF PN=3ORT%(XT)=COTHENRETURN 
7410 Q$(0)="You go to your car..."
7420 Q$(1)="How strange! Someone punctured ":Q$(2)="the tires!"
7425 Q$(3)="Looks like the culprit is trying to":Q$(4)="hamper your investigation!"
7428 IFPN>0THENGOSUB7450
7429 PN=PN+1
7430 GOSUB1040:GOSUB5750:IFR$="N"THENPC=1:H=2:OT=0:MP=1:GOSUB1200:RETURN
7440 PC=0:H=4:GOSUB1250:RETURN
7450 Q$(1)="Your tires!!!... Flat again!"
7452 IFPN=2THEN7500
7455 Q$(2)="The criminal has struck again!":Q$(3)="":Q$(4)="":RETURN
7500 Q$(2)="What a scoundrel! He insists, he":Q$(3)="is relentless!"
7510 Q$(4)="(insults...)":RETURN
8000 Z1=Z:Z=8:GOSUB700
8005 Q$(0)="You hide in an obscure alleyway,"
8010 Q$(1)="and wait for the exit of":Q$(2)="your "+V$(11)+"."
8015 Q$(3)="Time passes...":GOSUB1040:GOSUB1241
8016 IFFNA(3)>1ORTA%(YT,28)>0THEN8300
8020 Q$(0)="At last, "+N$(XT)+". leaves "+XX$(XT)
8025 Q$(1)="home. You follow "+ XZ$(XT)+"discreetly.":FL=1
8100 GOSUB1200:F1$=XM$(XT)+"enters ":F4$="then goes back home.."
8102 H=1:IFT%(XT)<>COTHENGOSUB8410:GOTO8107
8103 I=FNA(3):FI=ID(I-1)-14:ND=ND+1:IFFI>8THEN8105
8104 ONFIGOSUB8110,8115,8120,8125,8130,8135,8140,8142:GOTO8107
8105 ON(FI-8)GOSUB8145,8150,8155,8160,8160
8107 Q$(0)=F2$:Q$(1)=F3$:Q$(2)=F4$:GOSUB1200:GOSUB1250:Z=Z1:GOSUB700:GOTO2475
8110 F2$=F1$+"a nearby drugstore,":F3$="buys a pack of cigarettes,"
8111 RETURN
8115 F2$="Has " +XT$(XT)+"spotted your little game?"
8116 F3$="Suddenly, "+XT$(XT)+"turns around,":RETURN
8120 F2$=XM$(XT)+"takes the tube to Central-Park,"
8121 F3$="has a little stroll there,":RETURN
8125 F2$=XM$(XT)+"goes to "+XX$(XT)+"car,":F3$="removes the ignition key,":RETURN
8126 RETURN
8130 F2$=F1$+"a candystore,":F3$="comes out with a small packet,"
8131 RETURN
8135 F2$=F1$+"a cinema... ":F3$=XM$(XT)+"comes out 2 hours later,"
8136 H=2:RETURN
8140 F2$=F1$+"a stationery,"     :F3$="buys a pen,":RETURN
8142 F2$=F1$+"a bookshop,":F3$="buys several detective novels,":RETURN
8145 F2$=F1$+"a bar, orders several"     :F3$="alcoholic drinks,"
8146 H=2:RETURN
8150 F2$=XM$(XT)+"goes to a racetrack,"
8151 F3$="gambles and loses "+XX$(XT)+"stake,":H=4:RETURN:REM "gambles, and loses a small sum of money"
8155 F2$=F1$+"a pharmacy,"     :F3$="":RETURN
8160 F2$=F1$+"a perfume store,":F3$="makes a purchase (?),":RETURN
8300 Q$(0)="Do you want to go on waiting (Y/N)?":GOSUB1200:GOSUB1020
8305 IFR$="N"THENZ=Z1:GOSUB700:GOTO2475
8310 GOTO8015
8400 F2$=F1$+"a drugstore,":F3$="buys a few items,":RETURN
8410 IFTA%(YT,10)=5THEN8145
8412 IFTA%(YT,7)=5THEN8125
8414 IFTA%(YT,8)=5THEN8110 
8420 IFTA%(YT,1)>3THENQ$(0)=F1$+"a bank around the corner,":RETURN
8430 GOTO8400
8500 REM
8550 Q$(0)="New-York never sleeps quite"
8555 Q$(2)="peacefully... And neither does a"
8560 Q$(3)="detective living in the Big Apple...":GOSUB1200
8565 Q$(0)="At midnight, you are woken up by":Q$(1)="a phone call..."
8568 U$="a ":C$="certain "
8570 REM IFTA%(VI,0)=2THENU$="une ":C$="certaine "
8575 Q$(2)="You learn that "+U$+C$:Q$(3)=N$(6)+"., "+T$(6)+",": REM [retroric] added +","
8580 Q$(4)="was murdered"+XE$(6)+" at "+XX$(6)+"home..."
8584 REM "entrusted with" might be better than "put in charge of"...
8585 Q$(5)="You are entrusted with the case..."
8586 REM [retroric]: ADDED as game documentation: no. of days the player gets to solve the case (depends on difficulty level, see line 1272)
8587 MD=7:REM 7 days to solve the case at level 1
8588 IFNI=2THENMD=5
8589 IFNI=3THENMD=3
8590 IFNI=4THENMD=2
8591 Q$(6)="...with only"+STR$(MD)+" days to solve it!":GOSUB1030:RETURN
9100 M=INT(RND(1)*13)+15:IFTA%(CO,M)<5THEN9100
9105 FORJ=0TO2:IFID(J)=MTHENRP=1
9106 NEXTJ
9110 IFRPTHENRP=0:GOTO9100
9130 ID(I)=M:ID$(I)=IN$(M-15)
9160 RETURN
9200 FORK=0TO5:IN=0 
9205 IFT%(K)=COTHEN9250
9210 FORI=0TO2:IFTA%(T%(K),ID(I))=5 THEN IN=IN+1
9220 NEXTI 
9230 IFIN=3THENL=0:GOSUB9300
9250 NEXTK
9280 RETURN
9300 TA%(T%(K),28)=FNA(2)
9305 IFFNA(2)=1THENL1$="has been at the hospital for a week..":RETURN 
9310 L1$="has been travelling for 2 days..":RETURN
9500 IFMATHEN9505
9501 Q$(0)="YOU DON'T HAVE ANY ARREST WARRANT..":GOSUB1200:GOSUB5020
9502 RETURN
9505 Q$(0)="You have an "+V$(1)+".":Q$(1)="Caution! you cannot afford to"
9510 Q$(2)="make a mistake... You are at":Q$(3)=N$(XT)+"., "+T$(XT)+"." 
9515 Q$(4)=" ":Q$(4)="ARE YOU SURE "+XT$(XT)+"is the CULPRIT":Q$(5)="(Y/N)?":GOSUB1200:GOSUB1020
9520 IFR$="Y"THEN9530
9525 GOSUB1242:RETURN
9530 IFT%(XT)=COTHEN9600
9540 Q$(0)="............. WRONG!":Q$(1)="In fact, the "+V$(9)+"was"
9545 GOSUB9950:Q$(2)=C$:Q$(3)="Motive for the crime:":Q$(4)=CR$
9550 Q$(5)="Did you even suspect "+XZ$(RC) +"?"
9555 IFND=>2THENQ$(5)="You were not far from the truth,":Q$(6)="though!"
9556 GOSUB1200
9557 Q$(0)="WHAT A SHAME... YOU LOST!":Q$(1)=" " 
9560 Q$(2)="ANOTHER INVESTIGATION (Y/N)?"
9565 GOSUB1200:GOSUB1020:IFR$="N"THEN CLS:INK2:GOSUB26000:END:REM [retroric] REPLACED "NEW" by "CLS:...:END"
9570 RUN
9600 Q$(0)="......... WELL DONE!!!":GOSUB9950:Q$(1)=C$
9601 IFND<3THENQ$(0)=".......... NOT BAD!"
9602 Q$(2)="was indeed the murderer of" :Q$(3)=N$(6)+"., "+T$(6)+".":REM [retroric]: ADDED MISSING ", "
9610 Q$(4)="Motive for the crime:":Q$(5)=CR$
9615 IF ND<3THEN9850
9620 Q$(6)="You are a fine detective!":GOSUB1030:GOTO9560
9800 FORI=1TO6:PING:WAIT30:NEXT
9802 GOSUB9950:Q$(0)="Alas! Your time is up, it is too"
9805 Q$(1)="late!! By now, the murderer,"
9807 Q$(2)=C$:Q$(3)="has had "+XX$(XT)+"tracks covered"
9810 Q$(4)="and has ran away abroad..."
9820 GOTO9550
9850 GOSUB1200:Q$(0)="Unfortunately, I doubt that "+N$(XT)+"."
9852 Q$(1)="will finally be charged."
9854 Q$(2)="Your evidence is weak"
9856 Q$(3)="(I reviewed it). You actually"
9857 Q$(4)="were mostly lucky, weren't you??!!"
9858 Q$(5)="Will you do better next time?":GOSUB1200:GOTO9560 
9950 C$=N$(RC)+"., "+T$(RC)+", ":RETURN 
9999 REM == MASCULINE ARTICLES/PRONOUNS ==
10000 XT$(I)="he ":XM$(I)="He ":XP$(I)=" ":XL$(I)=" ":XE$(I)=" ":JX$(I)=" ":UX$(I)=" "
10005 XX$(I)="his ":XY$(I)="His ":XZ$(I)="him ":RETURN
10019 REM == FEMININE ARTICLES/PRONOUNS ==
10020 XT$(I)="she ":XM$(I)="She ":XP$(I)=" ":UX$(I)=" ":XL$(I)=" ":XE$(I)=" ":JX$(I)=" "
10025 XX$(I)="her ":XY$(I)="Her ":XZ$(I)="her ":RETURN  
10200 FORI=0TO6:J=0
10210 C=FNA(20)-1
10220 IFJ=19THEN10250
10230 IFC=T%(J)THENJ=0:GOTO10210
10240 J=J+1:GOTO10220
10250 T%(I)=C:T$(I)=P$(C)
10260 IFTA%(C,0)=1THENGOSUB10000:GOTO10280
10270 GOSUB10020
10280 NEXT:GOSUB1060
10300 FORI=0TO6:J=0
10320 N=FNA(8 ):IFTA%(T%(I),0)=2THENN=N+9
10330 IFJ=17THEN10360 
10340 IFY$(J)=NM$(N)THENJ=0:GOTO10320
10350 J=J+1:GOTO10330
10360 O=FNA(20)+64:Y$(I)=NM$(N):N$(I)=Y$(I)+" "+CHR$(O)
10370 NEXT
10380 RC=FNA(5)  :CO=T%(RC):VI=T%(6)
10385 FORI=1TO2:GOSUB1060:NEXT
10410 FORI=0TO6:Z=TA%(T%(I),1) :ONZGOSUB10420,10420,10425,10430,10435
10415 NEXT:RETURN
10420 D%(I)=2:RETURN
10425 D%(I)=3:RETURN
10430 D%(I)=4:RETURN
10435 D%(I)=5:RETURN
10500 IFTA%(CO,6)=0ORTA%(VI,6)=0THEN10540
10505 IFTA%(CO,0)=TA%(VI,0)THEN10540
10506 I2$="evidence of a violent row..."
10520 CP=1:CR$="a crime of passion.":RETURN 
10540 IFTA%(CO,1)=>TA%(VI,1)THEN10570
10542 IFTA%(VI,1)<3ORTA%(CO,1)>3THEN10570
10550 VO=1:CR$="an ill-fated robbery."
10552 I2$="the theft of a large sum of money."
10555 IFVI=2ORVI=12THENI2$="that jewellery was stolen..."
10556 IFTA%(VI,1)<4THENI2$="the theft of a petty sum of money."
10558 IFVI=2ORVI=19THENI2$="the theft of business documents..."
10560 IFVI=9ORVI=4ORVI=3THEN10565
10562 RETURN
10565 I2$="the theft of (secret ?) documents"
10566 CR$="a spying case...":RETURN
10570 REM
10572 IFTA%(CO,1)>3ANDTA%(VI,1)>3THEN10580
10574 IFTA%(CO,1)=<3ANDTA%(VI,1)=<3THEN10582
10576 IFTA%(CO,10)=5ANDTA%(CO,1)<3THEN10585
10578 GOTO10590
10580 I2$="evidence of a violent argument."
10581 CR$="a big buck business...":RETURN
10582 I2$="scattered playing cards."
10583 CR$="a fight gone awry...":RETURN
10585 I2$="several (empty) wine bottles."
10586 CR$="a drama of alcoholism...":RETURN
10590 I2$="burnt letters."
10592 CR$="a blackmail affair."
10595 RETURN
10800 I=TA%(CO,13):ONIGOTO10840,10850,10860,10870,10880
10840 AC$="of a single gunshot wound":RETURN 
10850 AC$="after being shot six times":RETURN
10860 AC$="after a violent hit to the skull":RETURN 
10870 AC$="by strangulation":RETURN
10880 AC$="of 10 stab wounds":RETURN 
11000 CLS
11010 PLOTAX,13,10:PLOTAX,14,10:NV$="   DIFFICULTY LEVEL (1 to 4)"
11012 PLOTAX+1,13,NV$:PLOTAX+1,14,NV$:GOSUB1000:NI=Q  
11014 FORI=1TO22:PRINT:NEXT
11015 REM [laurent75]: modified to show cursor for input then hide it again
11016 GOSUB26000:REM <-- Show text cursor
11018 INPUT"PLEASE ENTER YOUR NAME: ";NF$
11020 GOSUB25000:REM <-- Hide text cursor
11025 S=PEEK(#276):SS=RND(-S):CLS
11026 I$(1)="Characters:":I$(2)="Victim    :":I$(3)="Culprit   :"
11027 I$(4)="Motive    :":I$(5)="Clues     :"
11030 PLOTAX+1,6 ,"One moment please,"
11035 PLOTAX+1,7 ,"I am making up a (new) plot..."
11040 PLOTAX+14,8,"":Y=11:FORI=1TO5:PLOTAX+12,Y,I$(I)
11042 Y=Y+1:NEXT:Y=11
11050 PLOT 18,20,12:PLOT19,20,126:RETURN
11200 DY$="DETECTIVE STORY":X=8:Y=9
11202 PRINT:PRINT "    Copyright 1985 NO MAN'S LAND"
11205 PLOTX,Y,10:PLOTA,Y+1,10:PLOTX+1,Y,2:PLOTX+1,Y+1,2
11210 PLOTX+4,Y,DY$:PLOTX+4,Y+1,DY$:PLOT13,18,"Please wait a moment..."
11220 PLOT17,21,12:PLOT19,21,126:RETURN
12000 V$(0)="revolver":V$(1)="arrest warrant":V$(2)="magnifying glass"
12005 V$(3)="search warrant":V$(4)="interview ":V$(5)="examine "
12010 V$(6)="arrest ":V$(7)="search ":V$(8)="the victim "
12015 V$(9)="culprit ":V$(10)="the body ":V$(11)="suspect "
12220 V$(12)="clues ":V$(13)="the crime scene":V$(14)="OK (Y/N)?"
12225 RM$="REPAIR WILL TAKE 4 HOURS.":GB$="GLADYS'S BAR" 
12230 V$(15)="IMPOSSIBLE!":DA$="OK."
12231 RE$="                       'return'"
12235 QF$="  WHAT DO YOU DO NOW?":AV$="ANOTHER NEIGHBOUR TO INTERVIEW (Y/N)?"
12240 J$(1)="Tuesday":J$(2)="Wednesday":J$(3)="Thursday" 
12245 J$(4)="Friday":J$(5)="Saturday":J$(6)="Monday":J$(7)="Tuesday"
12246 J$(8)="Wednesday"
12250 NL$="                                      "
12252 VL$="                                     "
12260 BU=48174:GL=48489:AD(0)=48364:AD(1)=48605:AD(2)=48534:AD(3)=48261
12265 AD(4)=48235:AD(5)=48513:AD(6)=48624
12270 I=FNA(7)-1:AV=AD(I):AD(I)=0
12275 FORI=0TO5
12280 AT=FNA(7)-1:IFAD(AT)=0THEN12280
12285 AS(I)=AD(AT):AD(AT)=0:NEXT
12290 RETURN
13000 FORI=0TO36:READP
13010 FORN=0TO7:READQ:POKE47104+(P*8)+N,Q
13020 NEXTN,I
13030 DATA 85,6,6,6,7,6,6,6,6,86,0,0,0,63,0,0,0,0
13035 DATA 87,6,6,6,63,38,39,38,38,88,0,0,0,63,16,63,16,16
13040 DATA 89,38,38,39,38,38,38,63,63,90,16,16,63,16,16,16,63,63
13045 DATA 91,28,30,28,12,8,28,62,62,65,14,14,14,15,15,14,14,14
13050 DATA 66,18,18,18,63,63,18,18,18,67,28,28,28,60,60,28,28,28
13055 DATA 69,58,58,58,63,63,58,58,58,70,21,62,19,50,19,50,31,42
13060 DATA71,23,23,23,63,63,23,23,23,72,63,50,50,50,63,50,50,50
13065 DATA 73,63,19,19,19,63,19,19,19,75,63,9,9,9,9,9,63,63
13070 DATA 77,7,7,7,7,7,7,7,7,78,1,1,1,1,1,1,1,1
13075 DATA 79,32,32,32,32,32,32,32,32,80,56,56,56,56,56,56,56,56
13080 DATA 81,42,21,42,21,42,21,42,21,82,60,60,60,60,60,60,60,60
13085 DATA 83,51,51,51,51,51,51,51,51,84,15,15,15,15,15,15,15,15
13090 DATA 48,40,16,40,16,40,16,40,16,49,58,61,58,61,58,61,58,61
13100 DATA 50,32,32,48,24,12,6,3,1,51,32,48,24,12,6,3,1,1
13110 DATA 52,63,55,35,1,35,55,63,63,53,63,63,63,63,9,9,63,63
13120 DATA 54,7,7,7,7,63,63,63,63,55,56,56,56,56,63,63,63,63
13125 DATA 94,2,5,2,5,2,5,2,5
13130 DATA 35,0,1,2,5,10,21,42,21,36,32,16,40,20,42,21,42,21
13140 DATA 37,55,55,55,55,0,63,63,63,38,63,63,63,63,0,55,55,55
13150 RETURN
20000 DATA1,5,0,5,4,5,5,5,5,0,5,0,5,5,5,5,5,0,5,0,0,5,0,5,0,5,5,5,0
20001 DATA1,2,3,2,1,2,0,0,5,0,5,0,0,1,3,5,0,5,0,0,5,0,5,5,5,0,0,0,0 
20002 DATA1,5,5,4,5,4,0,5,0,5,5,5,5,3,2,0,5,0,5,5,0,5,5,5,0,5,0,5,0
20003 DATA1,3,0,3,2,3,5,0,5,0,0,5,5,4,4,5,0,5,0,0,0,5,0,0,0,0,5,5,0 
20004 DATA1,5,5,4,4,4,5,5,0,5,5,5,5,3,2,0,5,0,5,5,0,5,5,5,0,5,5,5,0 
20005 DATA1,1,0,3,2,1,5,0,5,0,0,5,0,2,4,5,0,5,0,0,5,5,0,0,5,0,0,0,0 
20006 DATA1,4,0,3,2,4,5,0,5,5,0,5,5,1,2,5,5,5,0,5,0,5,0,0,0,0,5,5,0 
20007 DATA1,2,0,2,3,2,0,5,5,0,5,0,0,5,2,5,0,0,5,0,0,0,5,5,5,0,0,0,0
20008 DATA1,4,5,4,4,4,0,5,0,5,5,0,0,5,2,0,5,0,5,5,0,0,5,5,0,0,0,0,0
20009 DATA1,4,0,4,3,4,5,5,5,5,0,5,5,3,5,5,5,0,5,5,0,5,0,0,0,5,5,5,0
20010 DATA1,4,0,1,2,4,5,5,5,0,5,0,5,5,4,5,0,0,5,0,5,0,5,5,5,0,5,5,0 
20011 DATA1,1,5,0,2,2,5,0,5,0,5,0,0,5,4,5,0,5,0,0,5,0,5,5,0,0,5,0,0
20012 DATA2,5,0,1,4,5,5,5,0,0,5,5,5,3,6,0,5,0,5,0,0,0,0,5,0,5,0,5,0 
20013 DATA2,2,3,2,4,2,5,0,0,5,0,0,5,2,4,5,0,5,0,5,5,0,5,0,5,0,5,5,0
20014 DATA2,2,5,2,2,2,5,0,0,5,5,0,5,5,2,0,0,5,0,5,5,0,5,5,5,0,5,5,0
20015 DATA2,3,3,5,4,3,5,0,0,5,0,0,5,3,4,0,5,5,0,5,5,0,5,0,5,0,5,5,0 
20016 DATA2,4,4,4,5,3,0,5,0,0,0,5,0,2,6,0,5,0,5,0,5,5,0,0,0,5,0,0,0
20017 DATA2,3,0,3,3,3,5,0,5,0,0,5,0,3,4,5,0,5,0,0,5,5,5,0,0,5,0,0,0 
20018 DATA2,5,0,3,2,4,5,5,5,0,5,0,5,5,3,5,0,0,5,0,5,5,5,5,0,5,5,5,0
20019 DATA2,4,5,5,5,5,0,5,0,5,0,5,5,2,5,0,5,0,5,5,0,5,0,0,0,0,5,5,0
20050 DATA businessman,bank clerk
20052 DATA jeweller on 5th avenue,atomic physicist
20055 DATA film producer,chemistry student,crime novelist
20056 DATA criminal investigator,arms dealer
20060 DATA senator from New York,bar owner
20062 DATA former legionary,aristocratic lady
20064 DATA unemployed typist,stripper artist
20070 DATA florist in Manhattan,physician,Chinese teacher
20080 DATA movie actress,company director
20100 DATA HENRY,ALEX,FRED,DAVID,WALTER,THOMAS,ROBERT,PETER,KARL
20101 REM [retroric]: MODIFIED: 'CAROLINE' by 'BECKY' ('C' is for '(C)rime scene)
20102 REM 'VICTORIA' by 'VERA' to avoid a bug with names > 6 chars (see CEO Mag #220 Aug 2008 p. 45)
20103 REM and 'OLIVIA' by IRINA (O is for (O)ffice)
20104 REM Note: all names must have a different initial (inc. with names line 20100)
20110 DATA EMMA,JULIE,BECKY,URSULA,NANCY,VERA,MARY,SARAH,IRINA
20250 DATA cigarette ashes,a wedding ring,a metro ticket
20260 DATA a car park ticket,a crumpled candy wrapper
20270 DATA a cinema ticket,a pen,a book (crime novel)
20275 DATA an empty cognac flask,a (losing) lottery ticket
20280 DATA an (empty) bottle of tranquilizers
20285 DATA a gift-wrapped perfume bottle,a nail file
20301 DATA"Q                     HIHI  "
20302 DATA"          67  QQ  67  HIHI  "
20303 DATA"         MHIP^QQ  HI  HIHI0 "
20304 DATA"         MHIP^HII HI  HIHI0 "
20305 DATA"         MHIP^HIINHIO ____0 " 
20306 DATA"QN2 O    HIHI^HIINHIO^HIHI0 "
20307 DATA"_N 3P   QHIHI^HIINHIO^HIHI0 "
20308 DATA"QQQQQ0  QHIHI^HIINHIO^HIHIQ " 
20309 DATA" O ON  ^QHIHIQHIINHIOQ____Q "
20310 DATA" O[ON  _____I1HIII1HIHIHIIQ "
20311 DATA"QQQQQ0NEBGHII1HIII1HIHIHII1 "
20312 DATA" OOON NEBGHII1HIII1HIHIHII1 "
20313 DATA" OOON NEBGHII1_____HIHIHII1 "
20314 DATA"QQQQQ N_5555__777__________ "
20315 DATA"QQQQQ____ UV_4__ UV__7_UV__ "
20401 DATA"      __ M____ 6HII7MHIHIP  _  HIHII "
20402 DATA"MHI  NHIOM____ HIHIIM_____ MBP HIHII "
20403 DATA"MHI  NHIO      _____M_____ MBP _____ "
20404 DATA"MHI  NHIO      _____       MBP       "
20405 DATA"HIIO NHIO M__          _P  MBP    6_7"
20406 DATA"HIIO NHIO HIIP  _     MHIO EBG__7 HII"
20407 DATA"___O MHIP HIHI MBP HI MHIO EBGHIINHII"
20408 DATA"     MHIP HIHI MBP HIOMHII EBGHIIN___"
20409 DATA"     ____ HIHI MBP HIPMHII EBGHIIN___"
20410 DATA"MHI  ____ ____ EBG HIPMHII ______    "
20411 DATA"MHI       ____ EBG HI_____        HII"
20412 DATA"MHIIP          EBG HI_HIHI        HII"
20413 DATA"_____ 6HI7     EBG _______ MHIIP  HII"
20414 DATA"      HIHIMHII EBG         HIHIIO HII"
20415 DATA"      HIHIMHII EBG      HIHIHIHIO ___"
20501 DATA"UV__ _ _Q_Q_Q_Q_     "
20502 DATA"WX__[_[_ _Q_ _Q_     "
20503 DATA"YZ______________     "
20504 DATA"UV__Q_Q_Q_Q_Q_ _Q  Q "
20505 DATA"UV__Q_Q_Q_ _ _ _Q  Q "
20506 DATA"UV______________Q ^Q0"
20507 DATA"UV__ _ _ _ _Q_ _Q ^Q0"
20508 DATA"UV__ _ _ _ _[_[_Q ^Q0"
20509 DATA"WX______________Q QQQ"
20510 DATA"YZ__  bar_____ _Q0QQQ"
20511 DATA"22___4444_______Q0QQQ"
20512 DATA" 3__ O_  ___ Q__Q0QQQ"
20513 DATA"  __ O_  ___ Q__QQQQQ"
20514 DATA"  __ O_[[___ Q__QQQQQ"
20515 DATA"  __ _______ Q__QQQQQ"
20601 DATA" _V_V_V_V_V_V_ "
20602 DATA" _V_V_V_V_V_V_ "
20603 DATA" _V_V_V_V_V_V_ "
20604 DATA" _V_V_V_V_V_V_ "
20605 DATA" _V_V_V_V_V_V_ "
20606 DATA" _V_V_V_V_V_V_ "
20607 DATA" _V_V_V_V_V_V_ " 
20608 DATA" _V_V_V_V_V_V_ " 
20609 DATA" _V_V_V_V_V_V_ " 
20610 DATA" _V_V_V_V_V_V_ "
20611 DATA" _V_V_V_V_V_V_ "
20612 DATA"M_____________1"
20613 DATA"M_____________1"
20614 DATA"M_6__ OOO __7_1" 
20615 DATA"M____ OOO ____1"
20620 DATA"&%&%&%&%&%&%&%&%&%&            QQ"
20622 DATA"%&%&%&%&%&%&%&%&%&%            QQ"
20623 DATA"&%&%&%&%&%&%&%&%&%&            QQ"
20624 DATA"%&%&%&%&                       QQ"
20625 DATA"&%&%&%&%                       QQ"
20626 DATA"%&%&%&%&                       QQ"
20627 DATA"&%&%&%&%                       QQ"
20628 DATA"%&%&%&%&                       QQ"
20629 DATA"&%&%&%&%                       QQ"
20630 DATA"%&%&%&%&            #QQQQQQ$   QQ"
20631 DATA"&%&%&%&%&%&%&%&%&%&^QQ 0^ QQ0  QQ"
20632 DATA"%&% Q&%&%&%&%&%&%&%   #QQ$  O  QQ"
20633 DATA"&%& Q%&%&%&%&%&%&%&   QQQQ  O  QQ"
20634 DATA"%&% Q&%&%&%&%&%&%&%  ^QQQQ0 O  QQ"
20635 DATA"&%& Q%&%&%&%&%&%&%&  ^QQQQ0 2  QQ"
24900 '
24910 ' === [retroric]ADDED utility subroutines ===
24920 '
24999 ' -- Hide text cursor (clear bit 0 @ #26A):
25000 POKE#26A, PEEK(#26A) AND #FE:RETURN
25001 '
25999 ' -- Show text cursor (set bit 0 @ #26A)):
26000 POKE#26A, PEEK(#26A) OR 1:RETURN
26001 '
29998 ' -- check the count of DATAs:
29999 '    (beware, this WILL raise an error)
30000 N=0
30010 READX$:N=N+1:GOTO30010
30001 ' == CHECK: THIS SHOULD BREAK WITH "?OUT OF DATA ERROR" WHEN N REACHES 1039 
30002 '(ENTER "RUN 30000", THEN "PRINT N" AFTER THE PROGRAM BREAKS WITH THE ERROR)
30003 ' NOTE: THIS CHECK TAKES A LONG TIME TO RUN - IF USING EMULATION, SET CLOCK TO 8 MHZ OR MORE TO SPEED IT UP!
