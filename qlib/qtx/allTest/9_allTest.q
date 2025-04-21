args:.Q.def[`name`port!("9_allTest.q";9018);].Q.opt .z.x

/ remove this line when using in production
/ 9_allTest.q:localhost:9018::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9018"; } @[hopen;`:localhost:9018;0];

\l qlib.q

.import.require`qtx.watchTest;
.watchTest.start`dbmaint;

/

.import.require`remote;

s)mkdir dontcare
s)touch dontcare/abc.txt





.dbmaint.ls["dontcare"]

(::)data:`date`sym`time xasc([]date:10?.z.D + til 3; time:10?.z.T;sym:10?`aaa`bbb`ccc;prx:10?100.0;qty:10?100)
(::)arg:`dir`tblName`symFile`gz!`db1`trade`sym,enlist 17 0 6
arg:arg,.bt.md[`storage]`type`mode`partitionCol`partAttrCol`sortCol!`partition`auto`date`sym`time    / partition
.dbmaint.save[arg]data

.dbmaint.save[arg] update date:date + 10 from trade
get `:db1/sym

.dbmaint.rm `:db1

.qtx.rsummary0 (.qtx.execute .qtx.con) lj .qtx.con 

 q) (::)arg:`dir`tblName`symFile`gz!`:db2`trade`sym,enlist 17 0 6
 q) arg:arg,.bt.md[`storage] storage:`type`mode`partitionCol`partAttrCol`sortCol!`splay`auto`date`sym`time      / splayed
 q) .dbmaint.save[arg]data
 q) (::)arg:`dir`tblName`symFile`gz!`:db3`obk`sym,enlist 17 0 6
 q) arg:arg,.bt.md[`storage] storage:`type`mode`partAttrCol`sortCol!`flat`auto`sym`time                           / flat
 q) .dbmaint.save[arg]data
 q) (::)arg:`dir`tblName`symFile`gz!`:db1`trade`sym,enlist 17 0 6
 q) (::)arg:arg,.bt.md[`storage]storage:`type`mode`dir`partitionCol`partAttrCol`sortCol!`par`auto`:db2`date`sym`time / par
 q) .dbmaint.save[arg]data
