#lang racket

#| I will start by defining my lists for countdown:
     #| My Random list of numbers and my Target Number between the numbers 100-199 inclusive.
     The name of my Random list is RandomList. |#
   6 of those numbers inside the list will be used to sum to a Target Number using the basic operands +. -, *, / |#

#| I have added randomisation of numbers within the list using the random function.
   However, I can only get one number generated from the list at a time so I may need to copy this function 5 more times to get the remaining numbers. |#
     #| list-ref allows me to reference the list at a given index.
     I have used (random 24) as my list has 24 numbers in it and I want to generate a random number using all 24 charactrs.
     If I wanted to use less numbers in the list and randomise them I would reduce this number. |#

(define RandomListFirstNumber (list-ref(list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100) (random 24)))
(define RandomListSecondNumber (list-ref(list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100) (random 24)))
(define RandomListThirdNumber (list-ref(list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100) (random 24)))
(define RandomListFourthNumber (list-ref(list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100) (random 24)))
(define RandomListFifthNumber (list-ref(list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100) (random 24)))
(define RandomListSixthNumber (list-ref(list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100) (random 24)))

'RandomListFirstNumber: RandomListFirstNumber
'RandomListSecondNumber: RandomListSecondNumber
'RandomListThirdNumber: RandomListThirdNumber
'RandomListFourthNumber: RandomListFourthNumber
'RandomListFifthNumber: RandomListFifthNumber
'RandomListSixthNumber: RandomListSixthNumber

; This will be my Target number between 101 and 999 generated randomly
(define TargetNumber (random 101 999))

; Calling my TargetNumber and naming it with a comment
 'TargetNumber: TargetNumber

#| I'm defining a simple function called Sum bound to RandomSixAdd to add the result of all of the Random Six numbers together.
 Checking for nulls in the first part of the if statement and if not null then add the car of the list to the cdr of the list recursively.
|#
(define(sum RandomSixAdd)
(if(null? RandomSixAdd)
   0
   (+ (car RandomSixAdd) (sum(cdr RandomSixAdd)))))

#| The function sum is now defined to recurse through a list up above and the RandomListFirstNumber...RandomListSixthNumber lists
   already pick out a random number each to display to the output window.
   Now I just have to sum the 6 random numbers together using the mechanism defined as sum. I do that below beside the comment 'AddRandomSix:
|#


'AddRandomSix: (sum(list RandomListFirstNumber RandomListSecondNumber RandomListThirdNumber RandomListFourthNumber RandomListFifthNumber RandomListSixthNumber))

; I now do the same for multiply. Note that I now use 1 instead of 0 as you cannot multiply by 0.
(define(mult RandomSixMultiply)
(if(null? RandomSixMultiply)
   1
   (* (car RandomSixMultiply) (mult(cdr RandomSixMultiply)))))

'MultiplyRandomSix: (mult(list RandomListFirstNumber RandomListSecondNumber RandomListThirdNumber RandomListFourthNumber RandomListFifthNumber RandomListSixthNumber))

#| I'm now doing the same for subtract, although, this output will now start to produce negative numbers which I don't want.
   I think I have a mechanism for dealing with negative numbers below, by printing an error message if negative.
|#

(define(subt RandomSixSubtract)
(if(null? RandomSixSubtract)
   0
   (- (car RandomSixSubtract) (subt(cdr RandomSixSubtract)))))

#| I define a function called subtneg which prints true(#t) or false (#f) if the result of subt is negative.
   Now seeing #t or #f wouldn't really make much sense to a user so I chose not to use this function, instead I use the function below called subtprint.
   Keeping subtneg incase I do need it at some stage though.
|#

(define subtneg(negative? (subt(list RandomListFirstNumber RandomListSecondNumber RandomListThirdNumber RandomListFourthNumber RandomListFifthNumber RandomListSixthNumber))))


#| Using a function defined as subtprint is where I deal with negative numbers. subtprint is just doing the same thing as the subtraction
   of the six random numbers recursively would do but the key thing is that I'm giving this function itself a name, which I didn't do
   previously with  sum and mult. Naming the function allows me to use it later on to deal with negative numbers. 
|#
'SubtractRandomSix: (define subtprint(subt(list RandomListFirstNumber RandomListSecondNumber RandomListThirdNumber RandomListFourthNumber RandomListFifthNumber RandomListSixthNumber)))

#|  Now, using subtprint defined previously, I check if subtprint is less than (<) 0, print the result.
    Else, Print a message saying "Negative Numbers are not allowed!"
|#

'subtprint:(if(< 0 subtprint)
             subtprint
             "Negative Numbers not allowed!")

; Now onto divide, which will also start causing problems as it produces fractions and I want whole numbers to be output.
(define(div RandomSixDivide)
(if(null? RandomSixDivide)
   1
   (/ (car RandomSixDivide) (div(cdr RandomSixDivide)))))

;To deal with fractions I use the 'round' function to round the fraction up to the nearest whole number which will be 0 lots of the time.
'DivideRandomSix: (define divprint (div(list(round(/ RandomListFirstNumber RandomListSecondNumber RandomListThirdNumber RandomListFourthNumber RandomListFifthNumber RandomListSixthNumber)))))

;This prints out the division to the output
divprint

#| Now that I have the six random numbers and the target number set up, sum,mult,subt,div functions and a way to deal with fractions while dividing and
   negative numbers while subtracting, I need to get to the most important part: Getting all possible permutations of the list (1-10, 25, 50, 75, 100)
   against the target number (101-999) so that I can apply the sum/mult/div/subt functions to try to reach the target number. (if possible)|#


#| First I'll set up the CartesianProduct of the list containing (1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100) and the numbers from 101-999.
   This allows me to take every element of the first list, and pair it with all the possible combinations from the second list that can be done.
   This might make it handier to then apply the maths  functions to the results if I define the function for later use.
   This isn't a very optimal solution, with such large lists it takes more time to compute and is therefore not too efficient. |#
;http://www.happychild.org.uk/wks/math/key1/numbers1000.htm
(define cartesianFunction (cartesian-product '(1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100) '(101	102	103	104	105	106	107	108	109	110	111	112	113	114	115	116	117	118	119	120	121	122	123	124	125
126	127	128	129	130	131	132	133	134	135	136	137	138	139	140	141	142	143	144	145	146	147	148	149	150
151	152	153	154	155	156	157	158	159	160	161	162	163	164	165	166	167	168	169	170	171	172	173	174	175
176	177	178	179	180	181	182	183	184	185	186	187	188	189	190	191	192	193	194	195	196	197	198	199	200
201	202	203	204	205	206	207	208	209	210	211	212	213	214	215	216	217	218	219	220	221	222	223	224	225
226	227	228	229	230	231	232	233	234	235	236	237	238	239	240	241	242	243	244	245	246	247	248	249	250
251	252	253	254	255	256	257	258	259	260	261	262	263	264	265	266	267	268	269	270	271	272	273	274	275
276	277	278	279	280	281	282	283	284	285	286	287	288	289	290	291	292	293	294	295	296	297	298	299	300
301	302	303	304	305	306	307	308	309	310	311	312	313	314	315	316	317	318	319	320	321	322	323	324	325
326	327	328	329	330	331	332	333	334	335	336	337	338	339	340	341	342	343	344	345	346	347	348	349	350
351	352	353	354	355	356	357	358	359	360	361	362	363	364	365	366	367	368	369	370	371	372	373	374	375
376	377	378	379	380	381	382	383	384	385	386	387	388	389	390	391	392	393	394	395	396	397	398	399	400
401	402	403	404	405	406	407	408	409	410	411	412	413	414	415	416	417	418	419	420	421	422	423	424	425
426	427	428	429	430	431	432	433	434	435	436	437	438	439	440	441	442	443	444	445	446	447	448	449	450
451	452	453	454	455	456	457	458	459	460	461	462	463	464	465	466	467	468	469	470	471	472	473	474	475
476	477	478	479	480	481	482	483	484	485	486	487	488	489	490	491	492	493	494	495	496	497	498	499	500
501	502	503	504	505	506	507	508	509	510	511	512	513	514	515	516	517	518	519	520	521	522	523	524	525
526	527	528	529	530	531	532	533	534	535	536	537	538	539	540	541	542	543	544	545	546	547	548	549	550
551	552	553	554	555	556	557	558	559	560	561	562	563	564	565	566	567	568	569	570	571	572	573	574	575
576	577	578	579	580	581	582	583	584	585	586	587	588	589	590	591	592	593	594	595	596	597	598	599	600
601	602	603	604	605	606	607	608	609	610	611	612	613	614	615	616	617	618	619	620	621	622	623	624	625
626	627	628	629	630	631	632	633	634	635	636	637	638	639	640	641	642	643	644	645	646	647	648	649	650
651	652	653	654	655	656	657	658	659	660	661	662	663	664	665	666	667	668	669	670	671	672	673	674	675
676	677	678	679	680	681	682	683	684	685	686	687	688	689	690	691	692	693	694	695	696	697	698	699	700
701	702	703	704	705	706	707	708	709	710	711	712	713	714	715	716	717	718	719	720	721	722	723	724	725
726	727	728	729	730	731	732	733	734	735	736	737	738	739	740	741	742	743	744	745	746	747	748	749	750
751	752	753	754	755	756	757	758	759	760	761	762	763	764	765	766	767	768	769	770	771	772	773	774	775
776	777	778	779	780	781	782	783	784	785	786	787	788	789	790	791	792	793	794	795	796	797	798	799	800
801	802	803	804	805	806	807	808	809	810	811	812	813	814	815	816	817	818	819	820	821	822	823	824	825
826	827	828	829	830	831	832	833	834	835	836	837	838	839	840	841	842	843	844	845	846	847	848	849	850
851	852	853	854	855	856	857	858	859	860	861	862	863	864	865	866	867	868	869	870	871	872	873	874	875
876	877	878	879	880	881	882	883	884	885	886	887	888	889	890	891	892	893	894	895	896	897	898	899	900
901	902	903	904	905	906	907	908	909	910	911	912	913	914	915	916	917	918	919	920	921	922	923	924	925
926	927	928	929	930	931	932	933	934	935	936	937	938	939	940	941	942	943	944	945	946	947	948	949	950
951	952	953	954	955	956	957	958	959	960	961	962	963	964	965	966	967	968	969	970	971	972	973	974	975
976	977	978	979	980	981	982	983	984	985	986	987	988	989	990	991	992	993	994	995	996     997     998     999)))

;Printing out the result of the cartesianFunction:
'CartesianProduct: cartesianFunction