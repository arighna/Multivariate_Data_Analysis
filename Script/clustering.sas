  DATA seeds_new;  SET seeds; id=_N_; RUN;
  proc print data=seeds_new noobs; run;


proc fastclus data=seeds_new radius=5 maxc=10 replace=full maxiter=10  out=Clus_out; var area perimeter AP length width coff groove; run;
proc print data=Clus_out noobs; run;

proc sort data=Clus_out; by cluster distance; run;
proc candisc data=Clus_out noprint out=ProCan(keep=country cluster Can1 Can2); class cluster; var area perimeter AP length width coff groove; run;
proc gplot data=ProCan; plot Can2*Can1=cluster /  vaxis=axis2 haxis=axis1 nolegend; axis1 label=("z1" justify=center); axis2 label=("z2" justify=center r=0 a=90); run; quit;
