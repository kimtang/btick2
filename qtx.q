/ remove this line when using in production
/ qtx.q:localhost:9081::

/ 
 q qtx.q -config default -repo repo -lib lib -file file [info|debug|test|watch] testSuite[all]
 q qtx.q / this shows command to 
 q qtx.q -config default -repo btick2 -lib lib[all] -file file[all] [info|debug|test|watch] auid[all] / this shows command to  
 q qtx.q -lib baum info baum1.baum1.1[all]
 q qtx.q -lib baum debug baum1.baum1.1[all]
 q qtx.q -lib baum test baum1.baum1.1[all]
 q qtx.q -lib baum watch baum1.baum1.1[all]  
\

system "c 1000 1000"

.self.mode:`proc;
\l qlib.q

.qtx.parseArg:
 .util.arg
 .util.optArg0[`config;`;`default] / this points to the configuration file
 .util.optArg0[`repo;`;`all] / each repo has lib
 .util.optArg0[`lib;`;`all] / each lib has a test folder
 .util.optArg0[`file;`;`all] / test folder has a test file
 .util.posArg0[`cmd;`;`]
 .util.posArg0[`auid;`;`all]
 .util.optArg0[`exit;"B";1b]
 .util.optArg0[`port;"j";0nj]
 @;

/ .qtx.arg:@[;`repo`lib`file`auid;{`$"," vs string x}] .qtx.parseArg ("-lib";"baum";"test");
/ .qtx.arg:@[;`repo`lib`file`auid;{`$"," vs string x}] .qtx.parseArg ("-lib";"baum";"debug";"baum1.baum1.1");
/ .qtx.arg:@[;`repo`lib`file`auid;{`$"," vs string x}] .qtx.parseArg ("-lib";"baum";"watch";"all");
/ .qtx.arg:@[;`repo`lib`file`auid;{`$"," vs string x}] .qtx.parseArg ("test";"all");

.qtx.arg:@[;`repo`lib`file`auid;{`$"," vs string x}] .qtx.parseArg .z.x;

.import.json:.qtx.arg`config;.import.init[];.import.require`qtx`qtx.watchTest`conem;

.qtx.exit:{[arg]
 if[arg[`cmd] in `debug`watch;
  @[system;;{-1 "Not able to set port due to error: ",x }] .bt.print["p %1"]8012^arg`port;:();];
 if[arg`exit;exit 0];
 if[not null arg`port;system .bt.print["p %port%"]arg]; 
 }


.qtx.cmd0:()!()

.qtx.cmd0[`]:{[arg]
 -1 "No command provided. Please use the command as shown below";
 -1 "q qtx.q -config default -repo repo[all] -lib lib[all] -file file[all] [info|debug|test|watch] auid[all] -exit 1"; 
 }

.qtx.cmd0[`info]:{[arg]
 s:.qtx.summary[];
 .qtx.module0 select from s where max (`all;repo) in arg[`repo],max (`all;lib) in arg[`lib],max (`all;file) in arg[`file];
 -1 .Q.s2 select auid,repo,lib,file,info:testCase_test_desc0 from .qtx.con where max (`all;auid) in arg[`auid];  
 } 

.qtx.cmd0[`test]:{[arg0]
 s:.qtx.summary[];
 .qtx.module0 select from s where max (`all;repo) in arg0[`repo],max (`all;lib) in arg0[`lib],max (`all;file) in arg0[`file];  
 r:.qtx.execute .qtx.con;
 -1 .Q.s2 0!.qtx.rsummary0 select from ( r lj .qtx.con) where max (`all;auid) in arg0`auid;
 }

.qtx.cmd0[`debug]:{[arg0]
 s:.qtx.summary[];
 .qtx.module0 select from s where max (`all;repo) in arg0[`repo],max (`all;lib) in arg0[`lib],max (`all;file) in arg0[`file];  
 r:.qtx.execute .qtx.con;
 t:first select from r where auid in arg0`auid; / arg`auid 
 .qtx.putArg t`auid;
 -1 .Q.s2 t`body
 }

.qtx.cmd0[`watch]:{[arg0]
 s:.qtx.summary[];
 allFiles:select from s where max (`all;repo) in arg0[`repo],max (`all;lib) in arg0[`lib],max (`all;file) in arg0[`file];
 .watchTest.start exec .Q.dd'[repo;lib] from allFiles; 
 }

.qtx.cmd:{[arg] .qtx.cmd0[arg`cmd]arg}
.qtx.cmd .qtx.arg;
.qtx.exit .qtx.arg;
