
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

.bt.add[`;`.watchTest.watch.start]{
 .watchTest.con.heartbeat:(" *";"* ") .watchTest.ind mod 2;
 .watchTest.con.status:`init;
 .watchTest.con.message:`;
 .watchTest.con.rsummary:2!flip`sha`uid`cnt`pass`pass_ratio`stime`dtime!();
 .watchTest.con.details:();
 }

.bt.addDelay[`.watchTest.watch.loop]{`time`tipe!(`second$2;`in)}
.bt.add[`.watchTest.watch.start`.watchTest.watch.loop;`.watchTest.watch.loop]{
 @[system;;{}] .bt.print["c %0 %1"] .conem.windowSize[];
 }

.bt.addIff[`.watchTest.watch.checkCon]{0<count .watchTest.watchCon }
.bt.add[`.watchTest.watch.loop;`.watchTest.watch.checkCon]{
 md0:{md5 "c"$read1 x}@'exec fullPath from .watchTest.watchCon;
 .watchTest.watchCon:update md:md0,changed:max@'not md=md0 from .watchTest.watchCon;
 .watchTest.ind:.watchTest.ind + 1;
 }

.watchTest.msg:{[s;m] m,(max 0,s[1] - count m)#" " }

.watchTest.screen:{[con]
 s:.conem.windowSize[];
 b:.conem.blankScreen[];
 lst:2#b;
 lst:lst,enlist .watchTest.msg[s] .bt.print["%heartbeat% %status%"] con;
 lst:lst,enlist .watchTest.msg[s] .bt.print["message: %message%"] con;
 lst:lst,.Q.s2 con`rsummary;
 lst:lst,.conem.blankScreen[];
 s[0]#lst	
 }

.bt.addIff[`.watchTest.watch.noChange]{not any exec changed from .watchTest.watchCon }
.bt.add[`.watchTest.watch.checkCon;`.watchTest.watch.noChange]{
 .watchTest.con.heartbeat: (" *";"* ") .watchTest.ind mod 2;
 .watchTest.con.status:`wait;
 .watchTest.con.message:`;
 }


.bt.add[`.watchTest.watch.noChange;`.watchTest.watch.noChange.pub]{
 .tp.pub[`.watchTest.heartbeat;] .watchTest.con.heartbeat;
 .tp.pub[`.watchTest.status;] .watchTest.con`status`message; 
 }


.bt.add[`.watchTest.watch.noChange;`.watchTest.watch.noChange.screen]{
 -1 .watchTest.screen .watchTest.con;
 }


.bt.addIff[`.watchTest.watch.test]{any exec changed from .watchTest.watchCon }
.bt.add[`.watchTest.watch.checkCon;`.watchTest.watch.test]{
 update changed:0b from `.watchTest.watchCon;
 r:{x,@[{`result`error!(system x;`)};;{`result`error!(();`$x)}] .bt.print["l %sPath%"]x}@'tmp:0!select from .watchTest.watchCon where mode=`test;
 .bt.md[`result] r
 }


.bt.addIff[`.watchTest.watch.test.error]{[result] any not null result`error }
.bt.add[`.watchTest.watch.test;`.watchTest.watch.test.error]{[result]
 .watchTest.con.heartbeat:(" *";"* ") .watchTest.ind mod 2;	
 .watchTest.con.status:`error;
 .watchTest.con.message:.bt.print["Error: %file%"] ``status`file!enlist[`;`error;]first exec sPath from result where not null error;	
 }


.bt.add[`.watchTest.watch.test.error;`.watchTest.watch.test.error.pub]{
 .tp.pub[`.watchTest.heartbeat;] .watchTest.con.heartbeat;	
 .tp.pub[`.watchTest.status;] .watchTest.con`status`message;
 }

.bt.add[`.watchTest.watch.test.error;`.watchTest.watch.test.error.screen]{
 -1 .watchTest.screen .watchTest.con;
 }


.bt.addIff[`.watchTest.watch.test.no_error]{[result] all null result`error }
.bt.add[`.watchTest.watch.test;`.watchTest.watch.test.no_error]{[result]
 r:.qtx.execute .qtx.con;
 .watchTest.con.heartbeat: (" *";"* ") .watchTest.ind mod 2;
 .watchTest.con.status:`change;
 .watchTest.con.message: `$.bt.print["Change: %file%"] ``status`file!enlist[`;`change;]first exec sPath from result where changed,not null error; 
 .watchTest.con.rsummary: .qtx.rsummary0 r lj .qtx.con;
 .watchTest.con.details:r; 
 }


.bt.add[`.watchTest.watch.test.no_error;`.watchTest.watch.test.no_error.pub]{[result;r]
 .tp.pub[`.watchTest.heartbeat;] .watchTest.con.heartbeat;	
 .tp.pub[`.watchTest.status;] .watchTest.con`status`message; 
 .tp.pub[`.watchTest.rsummary;] .watchTest.con`rsummary;
 .tp.pub[`.watchTest.details;] .watchTest.con`details;
 }

.bt.add[`.watchTest.watch.test.no_error;`.watchTest.watch.test.no_error.screen]{
  -1 .watchTest.screen .watchTest.con;
 }


.watchTest.start:{[modules] modules:(),modules;
 fileToWatch:raze .watchTest.cFile @'modules; / global space or not? Can live in the global space
 `.watchTest.watchCon upsert r:`fullPath xkey update sPath:`$1_'string fullPath,md:{md5 ""}@'fullPath,changed:0b from fileToWatch;
 if[0<count select from .bt.tme where fnc~'`.bt.action,arg[;0]=`.watchTest.watch.loop;:r];
 .bt.action[`.watchTest.watch.start]()!();
 r
 }
