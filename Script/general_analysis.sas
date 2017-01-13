proc import datafile="Seeds.csv" out=seeds (rename=(VAR1=area VAR2=perimeter VAR3=AP VAR4=length VAR5=width VAR6=coff VAR7=groove VAR8=class)) dbms=csv replace; getnames=no; run;
proc print data  =  seeds noobs; * var memname nobs nvar; run;

															/*Data Visualization*/
PROC MEANS DATA=seeds; run;
proc capability data=seeds NORMALTEST; qqplot area perimeter AP length width coff groove ; run;
proc corr data=seeds nomiss plots=matrix(histogram NVAR=all); var area perimeter AP length width coff groove ; run;
proc corr data=seeds nomiss plots(MAXPOINTS=10000000)=matrix(histogram NVAR=all); var area perimeter AP length width coff groove ; run;
/*proc univariate data=seeds; var VAR1 VAR2 VAR3 VAR4 VAR5 VAR6 VAR7 ; histogram; run;*/
proc capability data=seeds noprint; histogram area perimeter AP length width coff groove ; run;
/*proc capability data=seeds noprint; histogram VAR1 ; run;*/
/*proc sgplot data=seeds;  histogram VAR1;  xaxis type=log10; run;*/



																/*Data Grouping*/
PROC CAPABILITY DATA=seeds NORMALTEST; BY class; QQPLOT area perimeter AP length width coff groove; RUN;
PROC CORR DATA=seeds nomiss plots=matrix(histogram NVAR=all); BY class;  var area perimeter AP length width coff groove; run;
PROC GLM;  CLASS class;  MODEL area perimeter AP length width coff groove = class;  MANOVA H=class/PRINTE PRINTH MSTAT=EXACT;	RUN;


proc candisc data=seeds ncan=3 out=outcan; class class; var area perimeter AP length width coff groove; run;
PROC STEPDISC STEPWISE SIMPLE STDMEAN TCORR WCORR;  CLASS class;  *TITLE 'EXAMPLE 8.9 STEPWISE'; RUN;
PROC DISCRIM LIST CROSSVALIDATE POOL=TEST; CLASS class;   VAR area perimeter coff groove width; RUN;
PROC DISCRIM LIST CROSSVALIDATE POOL=TEST; CLASS class;   VAR prin1 prin2; RUN;

															/*Variable grouping*/
PROC PRINCOMP COV OUT=RESULTS; /* for correlation matrix, leave out "COV" option */ VAR area perimeter AP length width coff groove;
PROC PRINCOMP OUT=RESULTS; VAR area perimeter AP length width coff groove;
PROC PLOT; PLOT PRIN2*PRIN2; run;



PROC FACTOR METHOD=PRIN  PROPORTION=0.8 CORR SCREE EV RESIDUALS PLOT;  /*Use COV option if you would like to perform*/  VAR area perimeter AP length width coff groove; RUN;
PROC FACTOR METHOD=PRIN  PROPORTION=0.8 ROTATE=VARIMAX CORR SCREE EV RESIDUALS PLOT; VAR area perimeter AP length width coff groove; RUN;




proc anom summary=jobquant; boxchart q*job / nolimits boxwidth= 4 haxis=axis3 vaxis=axis4 nolegend serifs;
run; 


proc boxplot data=seeds; plot area*coff; run;
