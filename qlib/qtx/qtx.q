
d)lib btick2.qtx 
 Library for testing. It supports parameter injection.
 q).import.module`qtx 
 q).import.module`btick2.qtx
 q).import.module"%btick2%/qlib/qtx/qtx.q"


.qtx.con:1!flip`auid`repo`lib`file`uid`desc0`argument`before`after`testCase_uid`testCase_desc0`testCase_argument`testCase_before`testCase_after`testCase_test_mode`testCase_test_uid`testCase_test_desc0`testCase_test_data!();

.qtx.res:flip`sha`auid`pass`stime`etime`dtime`error`result`arg`body`used`heap`peak`wmax`mmap`mphy`syms`symw!();

.qtx.summary0:{[x]
 repo: `$.bt.print[":%path%/qlib"] .import.repository.con((1#`path)!1#x);
 allFolder:.os.treen[1]repo;
 allFolder:select from allFolder where not sym in (`.dignore,repo);
 allFolder:raze {update lib:x[`sym] from select from .os.treen[1;x`fullPath] where sym=`test}@'allFolder;
 allFolder:raze {update lib:x`lib from select from .os.treen[1;x`fullPath] where sym like "*.q"}@'allFolder;
 if[()~allFolder;:()];
 select repo:x,lib,file:{first ` vs x}@'sym,fullPath:`$1_/:string fullPath from allFolder
 }

.qtx.summary:{[x]
 if[max x~/:(`;::);x:()];
 if[10h=type x;x:.util.parsec x];
 / if[11h=type x;:raze .qtx.summary@'x];
 allFolder:raze .qtx.summary0@'key .import.repository.con;
 ?[allFolder;x;0b;()!()]
 }

d)fnc qtx.qtx.summary 
 Give a summary of this function
 q) .qtx.summary "repo=`btick2,lib=`os" 
 q) .qtx.summary[] 


.qtx.module:{[filter] .qtx.module0 .qtx.summary filter }


d)fnc qtx.qtx.module 
 Load the given tests. We will ignore loading errors
 q) .qtx.module "repo=`btick2,lib=`os" 


.qtx.module0:{[x]
 {@[system;;{x}] .bt.print["l %fullPath%"]x}@'x;
 .qtx.con
 }


.qtx.flat:{[testSuite]
 cls:`$"testCase_",/: string cols testCase:raze(delete test from  testSuite`testCase){x,/:y}'{(`$"test_",/:string cols x) xcol x}@'test:testSuite . `testCase`test;
 `auid xcols update auid:.Q.dd'[uid;flip (testCase_uid;testCase_test_uid)] from (delete testCase from testSuite),/: cls xcol testCase
 }

.qtx.testSuiter:{[uid;metaData;desc0;tail]
 r:.qtx.testSuite[uid;metaData;desc0;tail];
 .qtx.rsummary0 .qtx.execute[ r] lj 1!r
 // .qtx.rsummary[]
 }

.qtx.testSuite:{[uid;metaData;desc0;tail]
 `.qtx.con upsert r:.qtx.testSuite0[uid;metaData;desc0;tail];
 :r
 }

.qtx.testSuite0:{[uid;metaData;desc0;tail] .qtx.flat .qtx.testSuite1[uid;metaData;desc0;tail]}

.qtx.testSuite1:{[uid;metaData;desc0;tail]
 tail:flip[`type`data!(`argument`before`after;(()!();::;::))],tail;
 testCase:raze{enlist x }@' exec data from ?[tail;enlist(=;`type;enlist `testCase);0b;]();
 argument:raze exec data from ?[tail;enlist(=;`type;enlist`argument);0b;]();
 before:last exec data from ?[tail;enlist(=;`type;enlist`before);0b;](); 
 after:last exec data from ?[tail;enlist(=;`type;enlist`after);0b;]();  
 :metaData,`uid`desc0`testCase`argument`before`after!(uid;desc0;testCase;argument;before;after)
 }

.qtx.testCase:{[uid;desc0;innerTail;outerTail]
 innerTail:flip[`type`data!(`argument`before`after;(()!();::;::))],innerTail;
 test:raze{enlist x }@' exec data from ?[innerTail;enlist(=;`type;enlist `test);0b;]();
 argument:raze exec data from ?[innerTail;enlist(=;`type;enlist`argument);0b;]();
 before:last exec data from ?[innerTail;enlist(=;`type;enlist`before);0b;](); 
 after:last exec data from ?[innerTail;enlist(=;`type;enlist`after);0b;]();  
 t:`type`data!enlist[`testCase;] `uid`desc0`test`argument`before`after!(uid;desc0;test;argument;before;after); 
 enlist[t],outerTail 
 }


.qtx.nil:flip`type`data!()

/ .qtx.shouldTrue[`0;"get length";{[d] 4 ~ .kpi.api.xn d}] .qtx.nil

.qtx.shouldTrue:{[uid;desc0;fnc;tail]
 t:`type`data!enlist[`test;] `mode`uid`desc0`data!(`shouldTrue;uid;desc0;(1#`fnc)!1#fnc);
 enlist[t],tail
 }

.qtx.shouldEq:{[uid;desc0;expectedResult;fnc;tail]
 t:`type`data!enlist[`test;] `mode`uid`desc0`data!(`shouldEq;uid;desc0;`fnc`expectedResult!(fnc;expectedResult));
 enlist[t],tail
 }

.qtx.should:{[uid;desc0;fnc;tail]
 t:`type`data!enlist[`test;] `mode`uid`desc0`data!(`should;uid;desc0;(1#`fnc)!1#fnc);
 enlist[t],tail
 }


.qtx.shouldFail:{[uid;desc0;failMessage;fnc;tail]
 t:`type`data!enlist[`test;] `mode`uid`desc0`data!(`shouldFail;uid;desc0;`fnc`failMessage!(fnc;failMessage));
 enlist[t],tail
 }

.qtx.shouldData:{[uid;desc0;dataPath;fnc;tail]
 t:`type`data!enlist[`test;] `mode`uid`desc0`data!(`shouldData;uid;desc0;`fnc`dataPath!(fnc;dataPath));
 enlist[t],tail
 }

.qtx.argument:{[arg;tail]
 t:`type`data!enlist[`argument;] arg;
 enlist[t],tail  
 }

.qtx.before:{[fnc;tail]
 t:`type`data!enlist[`before;] fnc;
 enlist[t],tail    
 }

.qtx.after:{[fnc;tail]
 t:`type`data!enlist[`after;] fnc;
 enlist[t],tail    
 } 

.qtx.toSha1:{`$ 10#raze string .Q.sha1 string x }

/ .qtx.execute con:.qtx.con


.qtx.execute:{[con]
  r:.qtx.execute0[con];
  `.qtx.res insert r;
  r
 }

.qtx.execute0:{[con]
  sha:.qtx.toSha1 .z.P;
  r:raze .qtx.execute1@'0!`uid xgroup update sha from con;
  `sha`auid`pass xcols r
 }


.qtx.e:{[sha;auid;fnc;arg]
  stime:.z.P;r:.[{[fnc;arg] `result`error!(.bt.execute[fnc]arg ;`) };(fnc;arg);{`result`error!(();`$x)}];etime:.z.P;
  (`sha`auid`stime`etime`dtime`error`result`arg`body`pass!(sha;auid;stime;etime;etime - stime;r`error;r`result;arg;fnc;null r`error)),.Q.w[]
 }

.qtx.execute1:{[con0]
  con0:flip con0;m:con0 0;arg:raze m`testCase_argument`argument;r:();
  if[not (::)~fnc:m`before;r,:enlist s:.qtx.e[m`sha;.Q.dd[m`uid;`before];fnc;arg]; if[(null s`error) & 99h=type s`result;arg:s[`result],arg;];];
  r:r,raze first @'t:.qtx.execute2[;arg]@'0!`uid`testCase_uid xgroup update sha from con0;
  arg:arg,raze t[;1];
  if[not (::)~fnc:m`after;r,:enlist s:.qtx.e[m`sha;.Q.dd[m`uid;`after];fnc;arg]; if[(null s`error) & 99h=type s`result;arg:s[`result],arg;];]; 
  r 
 }


.qtx.execute2:{[con1;arg]
  con1:flip con1;m:con1 0;r:();
  if[not (::)~fnc:m`testCase_before;r,:enlist s:.qtx.e[m`sha;.Q.dd[m`uid;`testCase_before];fnc;arg]; if[(null s`error) & 99h=type s`result;arg:s[`result],arg; ]; ];  
  r:r,first t:{[x;y] r:.qtx.should_[y;arg:x 1];if[(99h=type r`result) & r`pass;
      arg:r[`result],arg]; :(x[0],enlist r;arg)  } over (enlist[(();arg)]),con1;
  arg:arg,t 1;
  if[not (::)~fnc:m`testCase_after;r,:enlist s:.qtx.e[m`sha;.Q.dd[m`uid;`testCase_after];fnc;arg]; if[(null s`error) & 99h=type s`result;arg:s[`result],arg; ]; ];
  :(r;arg)
 } 

.qtx.should_:{[con2;arg]
  :.qtx.should0[con2`testCase_test_mode][con2;arg]
 }

.qtx.should0:()!()

.qtx.should0[`should]:{[con2;arg]
 stime:.z.P;test:con2`testCase_test_data;
 r:.[{[fnc;arg] `result`error!(.bt.execute[fnc]arg ;`) };(fnc:test`fnc;arg);{`result`error!(();`$x)}];
 etime:.z.P;
 m:(`sha`auid`stime`etime`dtime`error`result`arg`body`pass!(con2`sha;con2`auid;stime;etime;etime - stime;r`error;r`result;arg .bt.getArg fnc ;fnc;0b)),.Q.w[];  
 rr:r`result;
 if[null r`error;m:@[m;`pass;:;rr`test];m:@[m;`result;:;rr`return]];
 :m
 }

.qtx.should0[`shouldFail]:{[con2;arg]
 stime:.z.P;test:con2`testCase_test_data;
 r:.[{[fnc;arg] `result`error!(.bt.execute[fnc]arg ;`) };(fnc:test`fnc;arg);{`result`error!(();`$x)}];
 etime:.z.P;
 m:(`sha`auid`stime`etime`dtime`error`result`arg`body`pass!(con2`sha;con2`auid;stime;etime;etime - stime;r`error;r`result;arg;fnc;0b)),.Q.w[];  
 if[not null r`error;m:@[m;`pass;:;]test[`failMessage] ~ r`error];
 m
 }

.qtx.should0[`shouldEq]:{[con2;arg]
 stime:.z.P;test:con2`testCase_test_data;
 r:.[{[fnc;arg] `result`error!(.bt.execute[fnc]arg ;`) };(fnc:test`fnc;arg);{`result`error!(();`$x)}];
 etime:.z.P;
 m:(`sha`auid`stime`etime`dtime`error`result`arg`body`pass!(con2`sha;con2`auid;stime;etime;etime - stime;r`error;r`result;arg;fnc;0b)),.Q.w[];  
 if[null r`error;m:@[m;`pass;:;]test[`expectedResult] ~ r`error];
 m
 }

.qtx.should0[`shouldTrue]:{[con2;arg]
 stime:.z.P;test:con2`testCase_test_data;
 r:.[{[fnc;arg] `result`error!(.bt.execute[fnc]arg ;`) };(fnc:test`fnc;arg);{`result`error!(();`$x)}];
 etime:.z.P;
 if[(null r`error) and not -1h=type r`result;r[`error]:`wrong_type];
 m:(`sha`auid`stime`etime`dtime`error`result`arg`body`pass!(con2`sha;con2`auid;stime;etime;etime - stime;r`error;r`result;arg .bt.getArg fnc;fnc;0b)),.Q.w[];  
 if[null r`error;m:@[m;`pass;:;] r`result];
 m
 }

.qtx.should0[`shouldData]:{[con2;arg]
 stime:.z.P;test:con2`testCase_test_data;
 r:.[{[fnc;arg] `result`error!(.bt.execute[fnc]arg ;`) };(fnc:test`fnc;arg);{`result`error!(();`$x)}];
 etime:.z.P;
 m:(`sha`auid`stime`etime`error`dtime`result`arg`body`pass!(con2`sha;con2`auid;stime;etime;etime - stime;r`error;r`result;arg;fnc;0b)),.Q.w[];  
 if[null r`error;
  dataPath:.import.cpath test`dataPath;
  if[not":"=dataPath 0;dataPath:":",dataPath;];
  dataPath:`$dataPath;
  if[not dataPath ~ key dataPath;(dataPath;17;2;6) set r`result];  
  m:@[m;`pass;:;](get dataPath) ~ r`result;
  ];
 m
 }


.qtx.rsummary0:{[con] `stime xdesc select cnt:count i,pass:sum pass,pass_ratio:(sum pass)%count i,stime:min stime,dtime:sum dtime by sha,uid:auid^uid from con}

.qtx.rsummary:{.qtx.rsummary0 .qtx.res lj .qtx.con}

.qtx.putArg:{[auid0]
 t0:first t:`stime xdesc select from .qtx.res where auid=auid0;
 if[0=count t;:()];
 .bt.getArg[t0`body] set' t0`arg
 }

/

.qtx.rsummary[]