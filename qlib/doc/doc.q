
.d.rspace:{[x] if[" "= first x;:.d.rspace 1_x];x }

.d.e:{.doc.e0[`$ first " "vs .d.rspace a 0]a:"\n"vs x}
.doc.r:{[x] {if[not " " = x 0;:x];1_x } over x }

.doc.conLib:2!flip`repo`lib`description`example!()
.doc.conFunc:3!flip`repo`lib`fnc`description`example`body!()

.doc.e0:()!()
.doc.e0[`txt]:{0N!x}

.doc.e0[`lib]:{
 lib:`$first 1_" "vs .doc.r x 0;
 x:.doc.r@/: 1_x;
 ind:x like "?)*";
 example:"\n" sv x where ind;
 description:"\n" sv x where not ind;
 `.doc.conLib upsert (`repo`lib!` vs lib),`description`example!(description;example);
 }
 
.doc.e0[`fnc]:{
 tag:`$first 1_" "vs .doc.r x 0;
 x:.doc.r@/: 1_x;
 ind:x like "?)*";
 example:"\n" sv x where ind;
 description:"\n" sv x where not ind;
 fnc:` sv `,1_tmp:` vs tag;
 `.doc.conFunc upsert `repo`lib`fnc`description`example`body!(tmp 0;tmp 1;fnc;description;example;@[get;fnc;{:()}]);
 }
 
d) lib btick2.doc
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

d)fnc btick2.doc.summary
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

d)fnc btick2.doc.example
 load files from module
 q) .doc.example[] / show all available modules 
 q) .doc.example `lib / show all available modules 
 q) .doc.example `fnc / show all available modules 
 q) .doc.example .os.tree
 q) .doc.example `os
 q) .doc.example "os"
 q) .doc.example `.os.tree`.os.treen
 q) .doc.example ".os.tree"
