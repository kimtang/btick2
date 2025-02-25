
d)lib btick2.qtx 
 Library for testing. It supports parameter injection.
 q).import.module`qtx 
 q).import.module`btick2.qtx
 q).import.module"%btick2%/qlib/qtx/qtx.q"

.qtx.con: 1!enlist`uid`repo`lib`file`testSuite`description`after`before`argument!(`;`;`;`;`;"**";::;::;()!())
.qtx.con1:1!enlist`tuid`uid`testCase`tdescription`tafter`tbefore`targument!(`;`;`;"**";::;::;()!())
.qtx.con2:1!enlist`fuid`tuid`fdescription`testFnc`fncArg!(`;`;"**";::;()!())

.qtx.con3:enlist`guid`fuid`testSuite`repo`lib`file`fnc`stime`dtime`etime`result`error`body`arg`pass`used`heap`peak`wmax`mmap`mphy`syms`symw!(0ng;`;`;`;`;`;{x};0np;0nn;0np;();`;{x};();0b),(8#0nj)

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
 q) qtx.summary "repo=`btick2,lib=`os" 


.qtx.module:{[x]
 {@[system;;{x}] .bt.print["l %fullPath%"]x}@'.qtx.summary[x];
 .qtx.tests x
 }


d)fnc qtx.qtx.module 
 Load the given tests. We will ignore loading errors
 q) qtx.module "repo=`btick2,lib=`os" 


.qtx.toSha1:{`$ 10#raze string .Q.sha1 string x }

.qtx.testSuite:{[testSuite;description;arg]
 arg0:update uid:.qtx.toSha1 .Q.dd[repo;(lib;testSuite)] from cols[.qtx.con]#arg:(`testSuite`description`before`after`argument!(testSuite;description;::;::;()!())),arg;
 tuids: exec tuid from .qtx.con1 where uid = arg0`uid;
 delete from `.qtx.con2 where tuid in tuids;
 delete from `.qtx.con1 where uid =arg0`uid;
 delete from `.qtx.con where uid =arg0`uid;
 `.qtx.con upsert cols[.qtx.con]#arg0;
 .qtx.addTestCase0[arg0`uid]@'raze arg`testCase;
 arg0`uid
 }

d)fnc qtx.qtx.testSuite 
 Mark the testSuite of the test
 q) .qtx.testSuite[`test.qtx.0;"test qtx"] 


.qtx.addTestCase0:{[uid0;testCase0]
 arg:update tuid:.qtx.toSha1@' .Q.dd'[uid0;testCase],uid:uid0 from testCase0;
 delete from `.qtx.con2 where tuid = arg`tuid;
 `.qtx.con1 upsert 1!enlist cols[.qtx.con1]#arg;
 .qtx.addTestFnc[arg`tuid]@'reverse arg`should;
 arg`tuid
 }

.qtx.addTestCase:{[testSuite0;arg]
 uid:first exec uid from .qtx.con where testSuite=testSuite0;
 arg:update uid:uid from arg;
 .qtx.addTestCase0[arg`uid]@'raze arg`testCase;
 uid
 }

d)fnc qtx.qtx.addTestCase 
 Mark the testCase
 q) .qtx.addTestCase[`uid]  


.qtx.addTestFnc:{[tuid0;should]
  `.qtx.con2 upsert`fuid xkey enlist cols[.qtx.con2]#should,`tuid`fuid !enlist[tuid0;] fuid:.qtx.toSha1@' .Q.dd[tuid0;] count select from .qtx.con2 where tuid=tuid0;
 fuid
 }


.qtx.repo:{[repo;arg] arg,.bt.md[`repo]repo }
.qtx.file:{[file;arg] arg,.bt.md[`file]file }

d)fnc qtx.qtx.repo 
 Mark the repo of this test
 q) .qtx.repo[`btick2]

.qtx.lib:{[lib;arg] arg,.bt.md[`lib]lib }

d)fnc qtx.qtx.lib 
 Mark the lib of this test
 q) .qtx.lib[`os]

.qtx.before:{[before;arg] arg,.bt.md[`before] before }

d)fnc qtx.qtx.before 
 Mark the function to be executed before the test
 q) .qtx.before[{`a`b`c`d!3 4 5 6}]

.qtx.after:{[after;arg] arg,.bt.md[`after] after }

d)fnc qtx.qtx.after 
 Mark the function to be executed after the test
 q) .qtx.after[{`a`b`c`d!3 4 5 6}]


.qtx.addArg:{[arg0;arg] if[`argument in key arg; arg0:arg[`argument],arg0]; arg,.bt.md[`argument] arg0 }

.qtx.nil:.bt.md[`]{}

.qtx.should0:{[r;arg]
 if[not `should in key arg;:update should:enlist r from arg]; 
 :update should:(should,enlist r) from arg  
 }

.qtx.shouldEq:{[description;expectedResult;fnc;arg]
 r:`testFnc`fdescription`fncArg!(fnc;description;`mode`expectedResult!(`shouldEq;expectedResult));
 :.qtx.should0[r;arg]
 }

.qtx.should:{[description;fnc;arg]
 r:`testFnc`fdescription`fncArg!(fnc;description;(1#`mode)!1#`should);
 :.qtx.should0[r;arg]
 }


.qtx.shouldFail:{[description;failMessage;fnc;arg]
 r:`testFnc`fdescription`fncArg!(fnc;description;(`mode`failMessage)!(`shouldFail;failMessage));
 :.qtx.should0[r;arg]
 }

.qtx.shouldTrue:{[description;fnc;arg]
 r:`testFnc`fdescription`fncArg!(fnc;description;`mode`!(`shouldTrue;()));
 :.qtx.should0[r;arg]
 }

.qtx.shouldData:{[description;dataPath;fnc;arg]
 r:`testFnc`fdescription`fncArg!(fnc;description;`mode`dataPath!(`shouldData;dataPath));
 :.qtx.should0[r;arg]
 }


.qtx.out:{[return;test]`return`test!(return;test)  }

.qtx.testCase:{[testCase;description;arg0;arg]
 r:enlist (cols[.qtx.con1],`should)#update tdescription:description,tafter:after,tbefore:before,targument:argument from (`testCase`description`before`after`argument!(testCase;description;::;::;()!())),arg0;
 if[not `testCase in key arg;:update testCase:enlist r from arg ];
 :update testCase:(testCase,enlist r) from arg
 }


.qtx.main:{[filter;arg]
 .qtx.module filter;  
 allData:.qtx.tests filter;
 .qtx.fmain0[arg]@'0!cols[.qtx.con] xgroup allData;
 .qtx.result filter
 }


.qtx.result:{[filter]
 if[max filter~/:(`;::;"";" ";"*");filter:()];
 con3:(1_.qtx.con3) lj .qtx.con2 lj .qtx.con1 lj .qtx.con;
 if[10h = type filter;filter:.util.parsec filter];
 if[0h=type filter;con3:?[con3;filter;0b;()!()];];
 if[-11h=type filter;:select guid:`$first@'"-"vs/: string guid,fuid,testSuite,repo,lib,fnc,dtime,pass,error from con3 where filter=`$first@'"-"vs/: string guid];
 `ntime xdesc select ntime:min `time$stime,xtime:`time$max etime,dtime:`second$sum dtime ,ntest:count i,npass:sum pass,ppass:100*sum[pass] % count i  by testSuite,guid:`$first@'"-"vs/: string guid from con3 where not null guid,fnc like "should*"
 }

/ t0:first 0!cols[.qtx.con] xgroup allData

.qtx.fmain0:{[arg;t0]
 guid:.bt.md[`guid] .bt.guid1[];
 lcon0:cols[.qtx.con]#t0;
 rcon0:flip(cols[.qtx.con] except `uid) _ t0;
 arg:(lcon0`argument),arg;
 fuid:.qtx.toSha1 .Q.dd[t0`uid;`before];
 r:.qtx.execute[guid,`fuid`testSuite`repo`lib`file`fnc!(fuid;lcon0`testSuite;lcon0`repo;lcon0`lib;lcon0`file;`before);lcon0`before;arg];
 if[not null r`error;:()];
 if[99h=type r`result;arg:arg,r`result];
 arg0:(,) scan .qtx.fmain1[guid,`repo`lib`file`testSuite#lcon0;arg]@'0!cols[.qtx.con1] xgroup rcon0;
 fuid:.qtx.toSha1 .Q.dd[t0`uid;`after]; 
 r:.qtx.execute[guid,`fuid`testSuite`repo`lib`file`fnc!(fuid;lcon0`testSuite;lcon0`repo;lcon0`lib;lcon0`file;`after);lcon0`after;arg];
 guid`guid
 }

/ (::)t1:first 0!cols[.qtx.con1] xgroup rcon0

/ `meta0`arg`t1 set' .kmp1

.qtx.fmain1:{[meta0;arg;t1]
 arg:(t1`targument),arg;
 lcon1:cols[.qtx.con1]#t1;
 rcon1:flip(cols[.qtx.con1] except `tuid) _ t1;
 fuid:.qtx.toSha1 .Q.dd[t1`tuid;`before];
 r:.qtx.execute[meta0,`fuid`fnc!(fuid;`before);t1`tbefore;arg];
 if[not null r`error;:()];
 if[99h=type r`result;arg:arg,r`result];
 arg0:.qtx.test[meta0;;] over 1_({};arg), rcon1;
 if[not 99h=type arg0;arg0:(,) scan arg0];
 / arg0:(,) scan .qtx.test[meta0;;] over 1_({};arg), rcon1;
 fuid:.qtx.toSha1 .Q.dd[t1`tuid;`after];
 r:.qtx.execute[meta0,`fuid`fnc!(fuid;`after);t1`tafter;arg0,arg]; 
 }


.qtx.test0:()!()

.qtx.test0[`should]:{[meta0;arg;t2]
 fncArg:t2`fncArg;
 meta0:meta0,(`stime`fuid`fnc!(.z.P;t2`fuid;`should)),`repo`lib`file#.qtx.con .qtx.con1[ t2`tuid]`uid;
 meta0:meta0,r:@[{[f;arg]`result`error!(f . arg;`) }[fnc];;{:`result`error!(()!();`$x)}] arg0:((enlist[ `allData]!enlist[arg]),arg) .bt.getArg fnc:t2`testFnc;
 meta0:meta0,.Q.w[],`etime`dtime`body`arg`pass! (.z.P;.z.P - meta0`stime;fnc;arg0;0b);
 rr:r`result;
 if[null r`error;meta0:meta0,.bt.md[`pass]rr`test];
 `.qtx.con3 insert cols[.qtx.con3]#meta0;
 if[99h=type rr`return;arg:arg,rr`return];
 arg 
 }

.qtx.test0[`shouldFail]:{[meta0;arg;t2]
 fncArg:t2`fncArg;
 meta0:meta0,(`stime`fuid`fnc!(.z.P;t2`fuid;`shouldFail)),`repo`lib`file#.qtx.con .qtx.con1[ t2`tuid]`uid;
 meta0:meta0,r:@[{[f;arg]`result`error!(f . arg;`) }[fnc];;{:`result`error!(()!();`$x)}] arg0:((enlist[ `allData]!enlist[arg]),arg) .bt.getArg fnc:t2`testFnc;
 meta0:meta0,.Q.w[],`etime`dtime`body`arg`pass! (.z.P;.z.P - meta0`stime;fnc;arg0;0b);
 if[not null r`error;meta0:meta0,.bt.md[`pass]fncArg[`failMessage] ~ r`error];
 `.qtx.con3 insert cols[.qtx.con3]#meta0;
 if[99h=type meta0`result; if[not 98h=type key meta0`result;arg:arg,meta0`result];];
 arg
 }

.qtx.test0[`shouldEq]:{[meta0;arg;t2]
 fncArg:t2`fncArg;
 meta0:meta0,(`stime`fuid`fnc!(.z.P;t2`fuid;`shouldEq)),`repo`lib`file#.qtx.con .qtx.con1[ t2`tuid]`uid;
 meta0:meta0,r:@[{[f;arg]`result`error!(f . arg;`) }[fnc];;{:`result`error!(()!();`$x)}] arg0:((enlist[ `allData]!enlist[arg]),arg) .bt.getArg fnc:t2`testFnc;
 meta0:meta0,.Q.w[],`etime`dtime`body`arg`pass! (.z.P;.z.P - meta0`stime;fnc;arg0;0b);
 if[null r`error;meta0:meta0,.bt.md[`pass]fncArg[`expectedResult] ~ r`result];
 `.qtx.con3 insert cols[.qtx.con3]#meta0;
 if[99h=type meta0`result; if[not 98h=type key meta0`result;arg:arg,meta0`result];];
 arg
 }

.qtx.test0[`shouldTrue]:{[meta0;arg;t2]
 fncArg:t2`fncArg;
 meta0:meta0,(`stime`fuid`fnc!(.z.P;t2`fuid;`shouldTrue)),`repo`lib`file#.qtx.con .qtx.con1[ t2`tuid]`uid;
 meta0:meta0,r:@[{[f;arg]`result`error!(f . arg;`) }[fnc];;{:`result`error!(()!();`$x)}] arg0:((enlist[ `allData]!enlist[arg]),arg) .bt.getArg fnc:t2`testFnc;
 meta0:meta0,.Q.w[],`etime`dtime`body`arg`pass! (.z.P;.z.P - meta0`stime;fnc;arg0;0b);
 if[null r`error;meta0:meta0,.bt.md[`pass] r`result];
 `.qtx.con3 insert cols[.qtx.con3]#meta0;
 if[99h=type meta0`result; if[not 98h=type key meta0`result;arg:arg,meta0`result];];
 arg
 }

.qtx.test0[`shouldData]:{[meta0;arg;t2]
 fncArg:t2`fncArg;
 meta0:meta0,(`stime`fuid`fnc!(.z.P;t2`fuid;`shouldData)),`repo`lib`file#.qtx.con .qtx.con1[ t2`tuid]`uid;
 meta0:meta0,r:@[{[f;arg]`result`error!(f . arg;`) }[fnc];;{:`result`error!(()!();`$x)}] arg0:((enlist[ `allData]!enlist[arg]),arg) .bt.getArg fnc:t2`testFnc;
 meta0:meta0,.Q.w[],`etime`dtime`body`arg`pass! (.z.P;.z.P - meta0`stime;fnc;arg0;0b);
 if[null r`error;
  dataPath:.import.cpath fncArg`dataPath;
  if[not":"=dataPath 0;dataPath:":",dataPath;];
  dataPath:`$dataPath;
  if[not dataPath ~ key dataPath;(dataPath;17;2;6) set r`result];  
  meta0:meta0,.bt.md[`pass](get dataPath) ~ r`result;
  ];
 `.qtx.con3 insert cols[.qtx.con3]#meta0;
 if[99h=type meta0`result; if[not 98h=type key meta0`result;arg:arg,meta0`result];];
 arg
 }

.qtx.test:{[meta0;arg;t2]
 fncArg:t2`fncArg;
 r:.qtx.test0[fncArg`mode][meta0;arg;t2];
 if[99h=type r;arg:arg,r];
 arg
 }

.qtx.execute:{[meta0;fnc;arg]
 if[max fnc ~/:(::;{};{x});:meta0,`result`error!(()!();`)];
 meta0:meta0,.bt.md[`stime].z.P;
 meta0:meta0,r:@[{[f;arg]`result`error!(f . arg;`) }[fnc];;{:`result`error!(();`$x)}] arg0:((enlist[ `allData]!enlist[arg]),arg) .bt.getArg fnc;
 meta0:meta0,.Q.w[],`etime`dtime`body`arg`pass! (.z.P;.z.P - meta0`stime;fnc;arg0;1b);
 `.qtx.con3 insert cols[.qtx.con3]#meta0;
 meta0
 }

.qtx.tests:{[filter]
 allData:.qtx.con2 lj .qtx.con1 lj .qtx.con;
 if[max filter~/:(`;::;"";" ";"*");filter:()];  
 if[10h = type filter;filter:.util.parsec filter ];
 result:?[allData;filter;0b;()!()];
 select from result where not null testSuite 
 }


.qtx.fail:{ con3:(1_.qtx.con3) lj .qtx.con2 lj .qtx.con1 lj .qtx.con;`stime xdesc select from con3 where not pass}

d)fnc qtx.qtx.fail 
 Show failed test cases
 q) .qtx.fail[] 0

.qtx.debug:{[arg]
 con3:(1_.qtx.con3) lj .qtx.con2 lj .qtx.con1 lj .qtx.con;
 r0:first r:?[con3;;0b;()] `guid`fuid{enlist[=;x;y]}'(::;enlist)@'arg`guid`fuid;
 if[0=count r;'`.qtx.debug.notfound];
 .bt.getArg[r0`body] set' r0`arg;
 r0`body
 }


d)fnc qtx.qtx.debug 
 Debug the given function
 q) .qtx.debug .qtx.fail[] 0 
