   proc template;
      define statgraph scatter;
         begingraph;
               layout overlayequated / equatetype=fit
               xaxisopts=(label='Canonical Variable 1')
               yaxisopts=(label='Canonical Variable 2');
               scatterplot x=Can1 y=Can2 / group=class name='seeds';
               layout gridded / autoalign=(topright);
                  discretelegend 'seeds' / border=false opaque=false;
                  endlayout;
            endlayout;
         endgraph;
      end;
   run;
   
   proc sgrender data=outcan template=scatter;
   run;
