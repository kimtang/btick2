
d)lib btick2.pm2 
 Library for working with the lib pm2
 q).import.module`pm2 
 q).import.module`btick2.pm2
 q).import.module"btick2/qlib/pm2/pm2.q"

.pm2.summary:{} 

d)fnc pm2.pm2.summary 
 Give a summary of this function
 q) .pm2.summary[] 

.pm2.addSchemaToFile:{[arg;env;tname;schema]
 if[not 10=abs type schema`column;schema:update column: ","sv string column from schema];
 jobj:.j.k"c"$read1 arg`jfile;
 a:((1#`)!1#{}),jobj . env,`schema;
 a[tname]:schema;
 jobj[env;`schema]:` _ a;
 (arg`jfile) 1: .j.j jobj
 }

d)fnc pm2.pm2.addSchemaToFile 
 Give a addSchemaToFile of this function
 q) .pm2.addSchemaToFile[.self.arg;`admin;`orderbook;select column:`time`sym`bqty`bprx`aprx`aqty,tipe:"psieei" from ([])] 


.pm2.addSchemaToProc:{[arg;env;tname0;schema]
 .pm2.addSchemaToFile[arg;env;tname0;schema]; 
 arg[`jobj] : .j.k "c"$read1 arg`jfile;
 process:.plant.process arg;
 schema1:.plant.schema arg;
 schema2:first select from schema1 where tname=tname0;
 process:select from process where luid in raze schema2`tick`rdb`replay;
 .remote.add p:select uid,host,port,user:`,passwd:count[i]#enlist"",luid from process; 
 .remote.query[;(".bt.action";`.tick.add.schema;schema2)]@' (p:exec luid!uid from p) schema2`tick;
 .remote.query[;(".bt.action";`.tick.add.schema;schema2)]@' p schema2`rdb;
 .remote.query[;(".bt.action";`.tick.add.schema;schema2)]@' p schema2`replay;  
 }

.pm2.removeSchemaFromFile:{[arg;env;tname]
 jobj:.j.k"c"$read1 arg`jfile;
 a:jobj . env,`schema;
 a:tname _ a;
 jobj[env;`schema]:a;
 (arg`jfile) 1: .j.j jobj 
 }


.pm2.startcmd0:()!()
.pm2.startcmd0["w"]:{[process] .bt.print["start \"%uid%\" q action.q -json %json% -repo %repo% -plant %plant% -env %env% -proc %proc% -p %port%"]@'process }
.pm2.startcmd:{[process] .pm2.startcmd0[.self.os] process }


.pm2.killcmd0:()!()
.pm2.killcmd0["w"]:{[process] .bt.print["taskkill /pid %zi% /f"]@'process }
.pm2.killcmd:{[process] .pm2.killcmd0[.self.os] process }

.pm2.addAlive0:()!()
.pm2.addAlive0["w"]:{[process]
 allPids:`uid`zi`time #/:exec get@'pm2File from process where {x ~ key x}@'pm2File;
 if[0=count allPids;allPids:flip`uid`zi`time!"sip"$\:()];
 taskList:"b" "tasklist /FO CSV";
 taskList:("*is**";", ") 0: taskList;
 taskList:(.Q.id@'cols taskList) xcol taskList;
 allPids:select uid,zi,alive,time from allPids lj 1!select zi:PID,alive:1b from taskList where ImageName like "q.exe";
 update zi:0ni from (process lj 1!allPids) where not alive
 }

.pm2.addAlive:{[process] .pm2.addAlive0[.self.os] process }

.bt.add[`;`.pm2.action]{[allData]
 process:.plant.process allData;
 process:update cmd:.pm2.startcmd process from process;
 .bt.md[`process]process
 }

.bt.addIff[`.pm2.info]{[cmd]cmd = `info}
.bt.add[`.pm2.action;`.pm2.info]{[allData;process;proc0]
 process:.pm2.addAlive process;
 if[ not null allData`env;process:select from process where env=allData`env];
 process:select from process where (proc like string[proc0]) or proc0=`all;
 1 .bt.print["\njson=%json% | repo=%repo% | plant=%plant%\n"] process 0;
 1 .Q.s select env,proc,pid:zi,cmd:.bt.print["q pm2.q -json %json% -repo %repo% -plant %plant% -env %env% status %proc%"]@'process,port,luptime:"z"$time from process where (host=.z.h) or host=`localhost;
 .bt.md[`process]process
 }

.bt.addIff[`.pm2.start]{[cmd]cmd = `start}
.bt.add[`.pm2.action`.pm2.restart;`.pm2.start]{[allData;process;proc0]
 process:.pm2.addAlive process;
 if[ not null allData`env;process:select from process where env=allData`env];
 process:select from process where (proc like string[proc0]) or proc0=`all;
 {@["b";x;()]}@'process`cmd;
 process:.pm2.addAlive process;
 / .bt.md[`process]update check:0 from process
 `process`ind!(process;0)
 }


.bt.addIff[`.pm2.start.check]{[ind;process] (not all process`alive) and ind<10}
.bt.addDelay[`.pm2.start.check]{`time`tipe!(00:00:01;`in)}

.bt.add[`.pm2.start`.pm2.start.check;`.pm2.start.check]{[process;ind]
 process:.pm2.addAlive process;
 `process`ind!(process;ind+1)
 }

.bt.add[`.pm2.start.check;`.pm2.start.check.output]{[process;ind]
 1 .bt.print["\njson=%json% | repo=%repo% | plant=%plant% | ind=%ind%\n"] (.bt.md[`ind]ind),process 0;
 1 .Q.s select env,proc,pid:zi,cmd:.bt.print["q pm2.q -json %json% -repo %repo% -plant %plant% -env %env% status %proc%"]@'process,port,luptime:"z"$time from process where (host=.z.h) or host=`localhost;
 }


.bt.addIff[`.pm2.stop]{[cmd]cmd = `stop}

.bt.add[`.pm2.action;`.pm2.stop]{[allData;process;proc0]
 process:.pm2.addAlive process;
 process:select from process where alive;
 if[ not null allData`env;process:select from process where env=allData`env];
 process:select from process where (proc like string[proc0]) or proc0=`all;
 process:update cmd:.pm2.killcmd process from process;
 {@["b";x;()]}@'process`cmd; 
 process:.pm2.addAlive process; 
 1 .bt.print["\njson=%json% | repo=%repo% | plant=%plant%\n"] process 0;
 1 .Q.s select env,proc,pid:zi,cmd:.bt.print["q pm2.q -json %json% -repo %repo% -plant %plant% -env %env% status %proc%"]@'process,port,luptime:"z"$time from process where host=.z.h 
 }

.bt.addIff[`.pm2.restart]{[cmd]cmd = `restart}

.bt.add[`.pm2.action;`.pm2.restart]{[allData;process;proc0]
 process:.pm2.addAlive process;
 process:select from process where alive;
 if[ not null allData`env;process:select from process where env=allData`env];
 process:select from process where (proc like string[proc0]) or proc0=`all;
 process:update cmd:.pm2.killcmd process from process;
 {@["b";x;()]}@'process`cmd;
 .bt.md[`cmd]`start 
 }

.bt.addIff[`.pm2.sbl]{[cmd]cmd = `sbl}
.bt.add[`.pm2.action;`.pm2.sbl]{}


.bt.addIff[`.pm2.sbl.screen]{[allData]not `path in key allData }
.bt.add[`.pm2.sbl;`.pm2.sbl.screen]{[allData;process;proc0]
 if[ not null allData`env;process:select from process where env=allData`env];
 process:select from process where (proc like string[proc0]) or proc0=`all;
 1@'.bt.print["/ %luid%:%host%:%port%::\n"]@' update host:`localhost from process
 }

.bt.addIff[`.pm2.sbl.path]{[allData] `path in key allData }
.bt.add[`.pm2.sbl;`.pm2.sbl.path]{[allData;process;proc0;path]
 if[ not null allData`env;process:select from process where env=allData`env];
 process:select from process where (proc like string[proc0]) or proc0=`all;
 (.Q.dd[hsym path;`cfg`system.sbl]) 0: .bt.print["/ %luid%:%host%:%port%::"]@' update host:`localhost from process
 }


.bt.add[`.import.init;`.pm2.init]{
 .pm2.config:.import.config`pm2;
 default:.pm2.config`default;
 .pm2.parseArg1:
   .util.arg
   .util.optArg0[`json;`;`] 
   .util.optArg0[`repo;`;default`repo]
   .util.optArg0[`plant;`;default`plant]
   .util.optArg0[`env;`;`]   
   .util.posArg0[`cmd;`;`info]
   .util.posArg0[`proc;`;`all]@; 
 }