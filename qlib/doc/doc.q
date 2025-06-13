
.d.rspace:{[x] if[" "= first x;:.d.rspace 1_x];x }

.d.getPath:{
 g:get get x;
 if[4h=type g 0;:`$first -3#g];
 g0:get g 0;
 `$first -3#g0
 }

.d.es:{[doc]
 k:`$first " "vs .d.rspace first "\n" vs doc;
 if[k in key .doc.e0;:.doc.e0[k][`]doc];
 fullPath:@[.d.getPath;k;{`}];
 :.doc.e0[`fnc][fullPath;doc]
 }

.d.e:{[doc]  @[.d.es;doc;{'`$x}] }

.d.es1:{[fullPath;doc]
 k:`$first " "vs .d.rspace first "\n" vs doc;
 if[k in key .doc.e0;:.doc.e0[k][fullPath;doc]];
 :.doc.e0[`fnc][fullPath;doc]
 }


.d.e1:{[fullPath;doc]
 .[.d.es1;(fullPath;doc);{'`$x}]
 }

/ .d.e:{.doc.e0[`$ first " "vs .d.rspace a 0]a:"\n"vs x}
.doc.r:{[x] {if[not " " = x 0;:x];1_x } over x }

.doc.conLib:3!flip`repo`lib`file`description`example!()
.doc.conFunc:4!flip`repo`lib`file`fnc`description`example`body!()

.doc.e0:()!()
.doc.e0[`txt]:{[fullPath;doc]}

.doc.e0[`lib]:{[fullPath;doc]
 path:string `${x 1} " "vs .d.rspace first x:"\n" vs doc;
 repo:`$ssr[;"%";""] first spath:"/" vs path;
 lib:`$first 2_spath;
 file:`$"/"sv 3_spath;
 x:.doc.r@/: 1_x;
 ind:x like "?)*";
 example:"\n" sv x where ind;
 description:"\n" sv x where not ind;
 `.doc.conLib upsert `repo`lib`file`description`example!(repo;lib;file;description;example);
 }
 

.doc.e0[`fnc]:{[fullPath;doc]
 if[-11h=type fullPath;fullPath:string fullPath];
 if[":"~fullPath 0;fullPath:1_fullPath];
 con:$[`con in key `.import.repository;get `.import.repository.con; (1#`btick2)!enlist .self.btick2 ];
 repo:first where con~\: -1_ first r:"qlib" vs fullPath;
 lib:`$first s:"/" vs ssr[;"\\";"/"] 1_r[1];
 file:`$"/"sv 1_s;
 x:"\n" vs doc;
 fnc:`$x 0;
 x:.doc.r@/: 1_x;
 ind:x like "?)*";
 example:"\n" sv x where ind;
 description:"\n" sv x where not ind;
 `.doc.conFunc upsert `repo`lib`file`fnc`description`example`body!(repo;lib;file;fnc;description;example;@[{get x};fnc;{:()}]);
 }
 
d)lib %btick2%/qlib/doc/doc.q
 Library to document modules in btick2
 This is usually loaded at the beginning
 q) 

.doc.summary:{
 if[max x~/:(`;::);:.doc.conLib]; / show which file has been loaded	
 if[x~`lib;:.doc.conLib];
 if[x~`fnc;:.doc.conFunc];
 if[-11h=type x;r:0!select from .doc.conFunc where (lib = x) or fnc = x;:$[1=count r;r 0;r] ];
 if[10h=type x;r:0!select from .doc.conFunc where (lib like x) or fnc like x;:$[1=count r;r 0;r] ];
 s:0!select from .doc.conFunc where body~\:x;
 if[0<count s;:s 0];
 if[11h=type x;:.doc.summary@'x ];
 .doc.conFunc
 }

d).doc.summary
 load files from module
 q) .doc.summary[] / show all available modules 
 q) .doc.summary `lib / show all available modules 
 q) .doc.summary `fnc / show all available modules 
 q) .doc.summary .os.tree
 q) .doc.summary `os
 q) .doc.summary "os"
 q) .doc.summary `.os.tree`.os.treen
 q) .doc.summary ".os.tree"


.doc.example:{
 r:.doc.summary x;
 if[not 99h=type r;:r];
 if[not 11h=type key r;:r]; 
 r`example
 }

d).doc.example
 load files from module
 q) .doc.example[] / show all available modules 
 q) .doc.example `lib / show all available modules 
 q) .doc.example `fnc / show all available modules 
 q) .doc.example .os.tree
 q) .doc.example `os
 q) .doc.example "os"
 q) .doc.example `.os.tree`.os.treen
 q) .doc.example ".os.tree"
