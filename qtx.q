/ remove this line when using in production
/ qtx.q:localhost:9081::

/ 
 q qtx.q -json default -repo repo -lib lib [info|debug|test|watch] testSuite[all]
 q qtx.q
\

.self.mode:`proc;
\l qlib.q

.qtx.parseArg:
 .util.arg
 .util.optArg0[`json;`;`default]
 .util.optArg0[`repo;`;`]
 .util.optArg0[`lib;`;`] 
 .util.posArg0[`mode;`;`]
 .util.posArg0[`testSuite;`;`]
 .util.optArg0[`fuid;`;`missing]
 .util.optArg0[`noexit;"B";0b]
 .util.optArg0[`port;"j";9081]
 @;

.qtx.exit:{[args;x]
 system .bt.print["p %port%"] args;
 if[not args`noexit;exit 0];	
 } .qtx.allArgs: .qtx.parseArg .z.x;

.import.json:.qtx.allArgs`json;

.import.init[];
.import.module`qtx;

allFiles:.qtx.summary .qtx.filter:{key[x]{(in;x;enlist y)}'value x} (where not null `repo`lib#.qtx.allArgs)#.qtx.allArgs;
allTests:.qtx.module .qtx.filter;

result:`repo`lib xasc 0!select cnt:count i by repo,lib,testSuite from allTests;
result:update cmd:`$.bt.print["q qtx.q -json %json% -repo %repo% -lib %lib% [info|debug|test|watch] %testSuite%[all]"]@'(.import,/:result) from result;
result1:select fuid,testSuite,testFnc from allTests0:0!select from allTests where ((`all~.qtx.allArgs`testSuite) or testSuite=.qtx.allArgs`testSuite);

if[ not .qtx.allArgs[`mode] in `info`debug`test`watch ;
 1 .Q.s select repo,lib,testSuite,cmd from result;
 .qtx.exit[]
 ];

if[ max null .qtx.allArgs`mode`testSuite;
 1 .Q.s select repo,lib,testSuite,cmd from result;
 .qtx.exit[]
 ];

if[`info ~ .qtx.allArgs`mode;
  -1 .Q.s 0!select fuid,testSuite,fdescription from allTests0;
 .qtx.exit[];
 ];

if[`debug ~ .qtx.allArgs`mode;
 if[not .qtx.allArgs[`fuid] in allTests0`fuid;
  -1"\033[0;33m missing fuid \033[0m";
  -1 .Q.s select fuid,fdescription,testFnc from allTests0;
  .qtx.exit[];
  ];
 if[.qtx.allArgs[`fuid] in allTests0`fuid; 
  fuid0:first select from allTests0 where fuid in .qtx.allArgs`fuid;
  filter:{key[x]{(in;x;enlist y)}'value x} (where not null `repo`lib`testSuite`testCase#fuid0)#fuid0;
  .qtx.main[filter]()!();
  system .bt.print["p %port%"] .qtx.allArgs;
  -1 .Q.s1 .qtx.debug first select from .qtx.con3 where fuid in fuid0`fuid
  ];
 ];


if[`test ~ .qtx.allArgs`mode;
  filter:{key[x]{(in;x;enlist y)}'value x} (where not null `repo`lib#.qtx.allArgs)#.qtx.allArgs;
  filter:filter,enlist ({(`all~y) or x=y};`testSuite;enlist .qtx.allArgs`testSuite);
  -1 .Q.s2 .qtx.main[filter]()!();
  .qtx.exit[];
 ];


/

/ info : show summary
/ debug : run test and start debug
/ test : run test
/ watch : watch a file and rerun test