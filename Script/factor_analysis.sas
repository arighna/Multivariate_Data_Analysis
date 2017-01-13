ods graphics on;
proc factor data=seeds priors=smc msa residual rotate=promax reorder outstat=fact_all plots=(scree initloadings preloadings loadings) NFACTORS=2; VAR area perimeter AP length width coff groove; run;
ods graphics off;


ods graphics on;
proc factor data=seeds priors=smc msa residual rotate=promax reorder outstat=fact_all plots=preloadings(vector) NFACTORS=2; VAR area perimeter AP length width coff groove; run;
ods graphics off;

/*NFACTORS, PROPORTION*/

