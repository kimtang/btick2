/ remove this line when using in production
/ qtx.q:localhost:9081::

/ 
 q qtx.q -config default -repo repo -lib lib -file file [info|debug|test|watch] testSuite[all]
 q qtx.q
\

system "c 1000 1000"

.self.mode:`proc;
\l qlib.q

.qtx.parseArg:
 .util.arg
 .util.optArg0[`config;`;`default]
 .util.optArg0[`repo;`;`]
 .util.optArg0[`lib;`;`]
 .util.optArg0[`file;`;`]  
 .util.posArg0[`mode;`;`]
 .util.posArg0[`uid;`;`]
 .util.optArg0[`testCase_uid;`;`]
 .util.optArg0[`testCase_test_uid;`;`]  
 .util.optArg0[`noexit;"B";0b]
 .util.optArg0[`port;"j";9081]
 @;

.qtx.exit:{[args;x]
 system .bt.print["p %port%"] args;
 if[not args`noexit;exit 0];	
 } .qtx.allArgs: .qtx.parseArg .z.x;

.import.json:.qtx.allArgs`config;.import.init[];.import.module`qtx;

allTests:.qtx.module0 .qtx.summary .qtx.filter1:{key[x]{(in;x;enlist y)}'value x} (where not null `repo`lib`file#.qtx.allArgs)#.qtx.allArgs;

1 .Q.s .qtx.rsummary[];

exit 0

/

result:`repo`lib xasc 0!select cnt:count i by repo,lib,testSuite:uid from allTests;
result:update cmd:`$.bt.print["q qtx.q -json %json% -repo %repo% -lib %lib% [info|debug|test|watch] %testSuite%[all]"]@'(.import,/:result) from result;
/ (::)result1:select testSuite:uid from allTests0:0!select from allTests where ((`all~.qtx.allArgs`testSuite) or uid=.qtx.allArgs`testSuite)

/



if[ max null .qtx.allArgs`mode`testSuite;
 1 .Q.s select repo,lib,testSuite,cmd from result;
 .qtx.exit[]
 ];

if[`info ~ .qtx.allArgs`mode;
  -1 .Q.s 0!select fuid,testSuite,`$fdescription,testFnc from allTests0;
 .qtx.exit[];
 ];

if[`debug ~ .qtx.allArgs`mode;
 if[not .qtx.allArgs[`fuid] in allTests0`fuid;
  -1"\033[0;33m missing fuid \033[0m";
  -1 .Q.s select fuid,testSuite,`$fdescription,testFnc from allTests0;
  .qtx.exit[];
  ];
 if[.qtx.allArgs[`fuid] in allTests0`fuid;
  filter1:{key[x]{(in;x;enlist y)}'value x} (where not null `repo`lib`file#.qtx.allArgs)#.qtx.allArgs;
  fuid0:first select from allTests0 where fuid in .qtx.allArgs`fuid;
  filter2:{key[x]{(in;x;enlist y)}'value x} (where not null `testSuite`testCase#fuid0)#fuid0;
  .qtx.main[filter1;filter2]()!();
  system .bt.print["p %port%"] .qtx.allArgs;
  -1 .Q.s1 .qtx.debug first select from .qtx.con3 where fuid in fuid0`fuid
  ];
 ];


if[`test ~ .qtx.allArgs`mode;
  filter1:{key[x]{(in;x;enlist y)}'value x} (where not null `repo`lib`file#.qtx.allArgs)#.qtx.allArgs;
  filter2:enlist ({(`all~y) or x=y};`testSuite;enlist .qtx.allArgs`testSuite);
  -1 .Q.s2 .qtx.main[filter1;filter2]()!();
  .qtx.exit[];
 ];


/

/ info : show summary
/ debug : run test and start debug
/ test : run test
/ watch : watch a file and rerun test