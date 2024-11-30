/ name:localhost:30103::
/ name:localhost:30001::

.self.mode:`proc;
\l qlib.q

.import.require`plant;

.self.parseArg:
 .util.arg
 .util.optArg0[`json;`;`] 
 .util.optArg0[`repo;`;`]
 .util.optArg0[`plant;`;`]
 .util.optArg0[`env;`;`]
 .util.optArg0[`proc;`;`]
 @;


.self.arg:((1#`)!enlist{}),.self.parseArg .z.x;
.import.json:.self.arg`json;
.import.init[];
.self.arg[`root]:`$.import.repository.con .self.arg`repo;
.self.arg[`jfile]:`$.bt.print[":%root%/plant/%plant%.json"] .self.arg;
.self.arg[`jobj]:jobj: .j.k "c"$read1 .self.arg`jfile;

.self.process:.plant.process .self.arg;
.self.schema:.plant.schema .self.arg;
.self.proc:first select from .self.process where env=.self.arg`env,proc=.self.arg`proc;
.self.proc[`pm2File] set .self.proc, `time`zi!(.z.P;.z.i);

.self.files:select file:.bt.print["l %fileDir%/%file%"]@'.self.files from .self.files:([]file:key .self.proc`fileDir;fileDir:`$1_string .self.proc`fileDir);
/ if[not 0=count .self.files; {@[system;x;()]}@'.self.files`file ];
.import.require .self.proc`lib;

.bt.addCatch[`.action.readFiles]{[error]};
.bt.add[`.action.start;`.action.readFiles]{[files] system@'files`file;};
.bt.add[`.action.readFiles;`.action.init]{[proc]proc`arg};
.bt.action[`.action.start] `process`schema`proc`arg`files!(.self.process;.self.schema;.self.proc;.self.arg;.self.files);
