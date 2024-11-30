args:.Q.def[`name`port!("pm2.q";9082);].Q.opt .z.x

/ remove this line when using in production
/ pm2.q:localhost:9082::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9082"; } @[hopen;`:localhost:9082;0];
 

/ remove this line when using in production
/ pm2.q:localhost:9081::

/ 
 q pm2.q -json default -repo default1 -plant default2 [info|start|stop|restart] proc[all]
 q pm2.q
\

.self.mode:`proc

\l qlib.q

.import.require`pm2`plant`remote

.pm2.parseArg:
 .util.arg
 .util.optArg0[`json;`;`] 
 .util.optArg0[`repo;`;`]
 .util.optArg0[`plant;`;`]
 .util.posArg0[`cmd;`;`info]
 .util.posArg0[`proc;`;`all]
 @;


.self.arg:.pm2.parseArg ("-cmd";"info")
if[not null .self.arg`json;.import.json:.self.arg`json;.import.init[];];

.bt.action[`.import.init] ()!()

.self.arg:((1#`)!1#{}),.pm2.parseArg1 .z.x

if[ not .self.arg[`repo] in key .import.repository.con;
  -1"\033[0;33m missing repo \033[0m";
 ];


.self.arg:update jfile:`$.bt.print[":%",string[ .self.arg`repo],"%/plant/%plant%.json"] (.self.arg,.import.repository.con) from .self.arg

if[not .self.arg[`jfile] ~ key .self.arg[`jfile];
  -1 .bt.print["\033[0;33m missing json file: %jfile% \033[0m"].self.arg;
 ];

.self.arg[`jobj]: .j.k "c"$read1 .self.arg`jfile
.self.arg[`root]:`$.import.repository.con .self.arg`repo

.bt.action[`.pm2.action] .self.arg;

/ 

(::)r:.bt.action[`.pm2.action] update proc:`all,cmd:`status from .self.arg
(::)process:r`process


(::)r:.bt.action[`.pm2.action] update env:`admin ,proc:`all,cmd:`start from .self.arg
(::)r:.bt.action[`.pm2.action] update env:`qdata ,proc:`bus,cmd:`start from .self.arg
(::)r:.bt.action[`.pm2.action] update proc:`all,cmd:`stop from .self.arg
(::)r:.bt.action[`.pm2.action] update proc:`all,cmd:`kill from .self.arg
(::)r:.bt.action[`.pm2.action] update proc:`all,cmd:`sbl from .self.arg
(::)process:r`process


\t 200
/



"b" @/:3#.pm2.process`cmd


(::)process:.pm2.addAlive .pm2.process
(::)process:update kill:.pm2.killcmd process i from  process where alive 


"b"@/:exec kill from process where alive

