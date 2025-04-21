d) lib btick2.import
 Library to import modules into kdb+
 q) .import.summary[] / Autmatically loaded on startup

.import.repository.con:(1#`btick2)!enlist .self.btick2

.import.module0.con:enlist`arg`path`ltime0`ftime`dtime`cmd`error!({};"**";0np;0np;0nn;"**";`)

.import.cpath0:()!()
.import.cpath0[`dict]:{
 x0:x,(1#`repository)!enlist .import.repository.con x`repository;
 :.bt.print["%repository%/qlib/%module%/%file%"] x0
 }

.import.cpath0[`symbol]:{
 cnt:count x0:` vs x;
 if[1=cnt;
   t:first where {[x;y]x in key hsym`$y,"/qlib"}[x]@'.import.repository.con;
   x:`repository`module`file!(t;x;.bt.print["%0.q"]x)
   ];
 if[(2=cnt) and x0[0] in k:key .import.repository.con;
  x:`repository`module`file!(x0 0;x0 1;.bt.print["%1.q"]x0)
  ];

 if[(2=cnt) and not x0[0] in k;
  t:first where {[x;y]x in key hsym`$y,"/qlib"}[x0 0]@'.import.repository.con;
  x:`repository`module`file!(t;x0 0;.bt.print["%1.q"]x0);
  ];
 if[(3<=cnt) and x0[0] in k;
  x:`repository`module`file!(x0 0;x0 1;.bt.print["%0.q"] enlist "/"sv string 2_x0)
  ];
 if[(3<=cnt) and not x0[0] in k;
  x:`repository`module`file!(`btick2;x0 0;.bt.print["%0.q"] enlist "/"sv string 1_x0)
  ];
 :.import.cpath0[`dict] x
 }

.import.cpath0[`character]:{
 :.bt.print[x] .import.repository.con
 }

.import.cpath:{
 if[max x~/:(`;::;"";" ");:.import.repository.con]; / show which file has been loaded
 t:(99 11 10h!`dict`symbol`character) abs type x;
 :.import.cpath0[t] x
 }

d)fnc btick2.import.cpath 
 return all available files & folders in the root directory with an ignore list
 q) .import.cpath`self  / Generate the path to btick2/qlib/self/self.q
 q) .import.cpath"%btick2%/qlib/self/self.q"  / load self module in btick2 repository
 q) .import.cpath`os  / load os modules in btick2 repository
 q) .import.cpath`import.repository  / load from btick2 repository
 q) .import.cpath`repository`module`file!(`btick2;`os;"os.q")
 q) .import.cpath"%btick2%/qlib/import/repository.q"  / load from btick2 repository
 q) .import.cpath `btick2.import
 q) .import.cpath `btick2.import.repository
 q) .import.cpath `import.repository.tmp

.import.loadFile:{[x]
 loaded:"b"$count select from .import.module0.con where path like x`path,null error;
 if[loaded and not x`reload;:()];
 x:update dtime:ftime - ltime0 from x,(``ftime!(`;.z.P)),@[{`result`error!(system x;`)};x`cmd;{`result`error!(();`$x)}];
 `.import.module0.con insert x:cols[.import.module0.con]#x;
 x
 }

.import.module1:{[x]
 cmd:.bt.print["l %path%"] .bt.md[`path]path: .import.cpath x`arg;
 result:(`arg`path`ltime0`ftime`cmd`error!(x;path;.z.P;0np;cmd;`)),x;
 :.import.loadFile result  
 }

.import.module2:{[x]
 / t:(99 11 10h!`dict`symbol`character) abs type x;
 :.import.module1 `reload`arg!(1b;x)
 }

.import.module:{[x]
 if[max x~/:(`;::);:1_.import.module0.con]; / show which file has been loaded
 if[10h = type x;x: enlist x];  
 :.import.module2@'x
 }

d)fnc btick2.import.module 
 load files from module
 q) .import.module[] / show all available modules
 q) .import.module`self  / load self module in btick2 repository
 q) .import.module"%btick2%/qlib/self/self.q"  / load self module in btick2 repository
 q) .import.module`os  / load os modules in btick2 repository
 q) .import.module`import.repository  / load from btick2 repository
 q) .import.module`repository`module`file!(`btick2;`os;"os.q")
 q) .import.module"%btick2%/qlib/import/repository.q"  / load from btick2 repository
 q) .import.module `os
 q) .import.module `import.repository
 q) .import.module `btick2.import
 q) .import.module `btick2.import.repository
 q) .import.module `import.repository.tmp


.import.require2:{[x]
 / t:(99 11 10h!`dict`symbol`character) abs type x;
 :.import.module1 `reload`arg!(0b;x)
 }

.import.require:{[x]  
 if[max x~/:(`;::);:1_.import.module0.con]; / show which file has been loaded
 if[10h=type x;x:enlist x];
 :.import.require2@'x
 }

d)fnc btick2.import.require 
 load files with no reload
 q) .import.require[] / show all available requires
 q) .import.require`self  / load self require in btick2 repository
 q) .import.require"%btick2%/qlib/self/self.q"  / load self require in btick2 repository
 q) .import.require`os  / load os requires in btick2 repository
 q) .import.require`import.repository  / load from btick2 repository
 q) .import.require`repository`require`file!(`btick2;`os;"os.q")
 q) .import.require"%btick2%/qlib/import/repository.q"  / load from btick2 repository
 q) .import.require `os
 q) .import.require `import.repository
 q) .import.require `btick2.import
 q) .import.require `btick2.import.repository
 q) .import.require `import.repository.tmp     

.import.require`os`util`json;

/ (::)x:`btick2
.import.summary:{
 if[max x~/:(`;::);x:key .import.repository.con];
 if[11h=type x;:raze .import.summary@'x];
 if[not x in key .import.repository.con;:0#.doc.conLib]; 
 repo: `$.bt.print[":%path%/qlib"] .import.repository.con((1#`path)!1#x);
 allFolder:.os.treen[3]repo;
 dignore:`,raze{`$ssr[string x;".dignore";]@/: read0 x}@'exec  fullPath from allFolder where fullPath like "*.dignore";
 allFiles:.os.treeIgnore[dignore]repo;
 {[fullPath]
   b:enlist[" "]~/:1#/:src:read0 fullPath;
   b:{x[;0]!x}value group sums neg[b] + 1+ a:"d)"~/:2#/:src;
   {get "\n" sv x}@'src b where a;    
  }@'exec fullPath from allFiles where fullPath like "*.q";
  :`repo`lib xasc select from .doc.conLib where repo =x 
 }

d)fnc btick2.import.summary 
 return all available files & folders in the root directory with an ignore list
 q) .import.summary[] / show all available modules and lib
 q) .import.summary`btick2  / show all modules in btick2 repository




if[()~key `.import.json;.import.json:`default];  / what is the default json file? Where to read it? 

.import.getConfig:{
 if[max x~/:(`;::);x:.import.json]; / give .import.json as the default file  
 `name`path!enlist[.import.json;]`$.bt.print[":%home%/%cfg%.json"] ((1#`cfg)!1#x),.self
 }

d)fnc btick2.import.getConfig 
 load the config file and update the repository
 q) .import.getConfig[]  / this will load from the .import.json
 q) .import.getConfig .import.json / you can also specify a file or a repository name
 q) .import.getConfig `dontcare / you can also specify a file or a repository name


/ x:`$":C:\\Users\\kimkt/default.json"
/ .import.readPath x

.import.readPath:{[x]
 if[not x ~ key x;:flip`name`path!()];
 config:.j.k "c"$read1 x;
 dependsOn:config`dependsOn;
 if[0=count config0:dependsOn`config;:flip`name`path!()];
 tbl:{ `name xcols update name:key x from value x } config0;
 tbl:update path:{[name] `$.bt.print[":%home%/%name%.json"] .self,.bt.md[`name]name }@'name from tbl where path like"home";
 tbl 
 }

.import.pconfig:{[config]
 tmp:.util.ctable config;  
 .util.cdict {[x] if[not (l:last x`sym) in `$'upper[t],t:.Q.t except" ";:x]; x[`sym]: -1_x`sym; x[`v]: (string[l]0)$x`v;x }@'tmp
 / param:{
 /  cnt:count s:"."vs string x;
 /  if[cnt=1;:(x;x;"*")]; 
 /  if[not any last[`$s]=/:`$'upper[t],t:.Q.t except" ";:(x;x;"*")];
 /  :(`$"." sv -1_s;x;first last s)
 /  }@'k:key config;
 / ?[config param[;0]!param[;1] ;();0b;]param[;0]!flip($;param[;2];param[;0]) 
 }

.import.init:{
 default:`$.bt.print[":%btick2%/qlib/repository/template/config/default.json"] .self;
 conf:.import.getConfig[];
 if[not{x ~ key x}conf`path;conf[`path] 1: read1 default];
 allConfigs:{ r:raze .import.readPath@'x`path;x,update priority:i+1+max x`priority from select from r where not path in x`path} over update priority:i from enlist conf;
 allConfigs:select from allConfigs where {x ~ key x} @'path; 
 allConfigs:update cfg:{.json.k .j.k "c"$read1 x }@'path from allConfigs ;  
 allRepositories:{`name xcols update name:key x,path:path from value x} raze { dependsOn:x . `dependsOn`repository }@'allConfigs`cfg;
 allRepositories:select from allRepositories where not {()~k:key hsym x}@'`$path; 
 .import.allConfig:allConfigs;
 .import.repository.con:((1#`btick2)!enlist .self.btick2),exec name!path from allRepositories;
 .import.config:.util.deepMerge over exec cfg from `priority xdesc allConfigs;
 }

.import.status:{
 a:count select from .import.module0.con where not null error;
 b:count select from .bt.history where not null error;
 `healthy`error 0<a+b
 }


if[`.doc.summary ~ key `.doc.summary;.import.doc:.doc.summary];

.bt.add[`;`.import.init_loop]{}
.bt.addDelay[`.import.init]{`tipe`time!(`in;00:00:01)}
.bt.add[`.import.init_loop;`.import.init]{}

.import.init[]  / we will init 
if[.self.mode=`user;.bt.action[`.import.init_loop] ()!()]; / delay init only if it is in user mode 



