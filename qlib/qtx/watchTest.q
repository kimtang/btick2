
d)lib %btick2%/qlib/qtx/watchTest.q
 Library for testing. It supports parameter injection.
 q).import.module`watchTest 
 q).import.module`qtx.watchTest
 q).import.module"%btick2%/qlib/qtx/watchTest.q"
 q).import.cpath "%btick2%/qlib/qtx/watchTest.q"

.import.require`qtx`tp;

.watchTest.watchCon:1!flip`fullPath`mode`sPath`md`changed!()

.watchTest.cFile:{[module] 
 arg:.bt.md[`folderToWatch] "/" sv -1_"/"vs .import.cpath module;dignore:`;
 if[{x~ key x} ignoreFile:`$.bt.print[":%folderToWatch%/.dignore"] arg;dignore:`,{`$ssr[string x;".dignore";]@/: read0 x} ignoreFile;];
 allFiles:.os.treeIgnore[dignore] arg`folderToWatch;
 allFiles:select fullPath,mode:`lib from allFiles where not child in parent, fullPath like "*.q";
 tmp:.os.tree .bt.print["%folderToWatch%/test"] arg;
 tmp:select fullPath,mode:`test from tmp where not child in parent, fullPath like "*.q";
 allFiles,tmp
 }

.watchTest.ind:1

.bt.add[`;`.watchTest.watch.start]{}

.bt.addDelay[`.watchTest.watch.loop]{`time`tipe!(`second$2;`in)}
.bt.add[`.watchTest.watch.start`.watchTest.watch.loop;`.watchTest.watch.loop]{}

.bt.addIff[`.watchTest.watch.checkCon]{0<count .watchTest.watchCon }
.bt.add[`.watchTest.watch.loop;`.watchTest.watch.checkCon]{
 md0:{md5 "c"$read1 x}@'exec fullPath from .watchTest.watchCon;
 .watchTest.watchCon:update md:md0,changed:max@'not md=md0 from .watchTest.watchCon;
 .watchTest.ind:.watchTest.ind + 1;
 }


.bt.addIff[`.watchTest.watch.noChange]{not any exec changed from .watchTest.watchCon }
.bt.add[`.watchTest.watch.checkCon;`.watchTest.watch.noChange]{
 .tp.pub[`.watchTest.heartbeat;] (" *";"* ") .watchTest.ind mod 2;
 .tp.pub[`.watchTest.status;] (`wait;`); 
 }


.bt.addIff[`.watchTest.watch.test]{any exec changed from .watchTest.watchCon }
.bt.add[`.watchTest.watch.checkCon;`.watchTest.watch.test]{
 update changed:0b from `.watchTest.watchCon;
 r:{x,@[{`result`error!(system x;`)};;{`result`error!(();`$x)}] .bt.print["l %sPath%"]x}@'tmp:0!select from .watchTest.watchCon where mode=`test;
 .bt.md[`result] r
 }

.bt.addIff[`.watchTest.watch.test.error]{[result] any not null result`error }
.bt.add[`.watchTest.watch.test;`.watchTest.watch.test.error]{[result]
 .tp.pub[`.watchTest.heartbeat;] (" *";"* ") .watchTest.ind mod 2;	
 .tp.pub[`.watchTest.status;] enlist[`error;] `$.bt.print["Error: %file%"] ``status`file!enlist[`;`error;]first exec sPath from result where not null error;
 }

.bt.addIff[`.watchTest.watch.test.no_error]{[result] all null result`error }
.bt.add[`.watchTest.watch.test;`.watchTest.watch.test.no_error]{[result]
 r:.qtx.execute .qtx.con;
 .tp.pub[`.watchTest.heartbeat;] (" *";"* ") .watchTest.ind mod 2;	
 .tp.pub[`.watchTest.status;] enlist[`change;] `$.bt.print["Change: %file%"] ``status`file!enlist[`;`change;]first exec sPath from result where changed,not null error; 
 .tp.pub[`.watchTest.rsummary;] .qtx.rsummary0 r lj .qtx.con;
 .tp.pub[`.watchTest.details;]r;
 }

.watchTest.start:{[modules] modules:(),modules;
 fileToWatch:raze .watchTest.cFile @'modules; / global space or not? Can live in the global space
 `.watchTest.watchCon upsert r:`fullPath xkey update sPath:`$1_'string fullPath,md:{md5 ""}@'fullPath,changed:0b from fileToWatch;
 if[0<count select from .bt.tme where fnc~'`.bt.action,arg[;0]=`.watchTest.watch.loop;:r];
 .bt.action[`.watchTest.watch.start]()!();
 r
 }
