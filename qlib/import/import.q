d) lib btick2.import
 Library to import modules into kdb+
 q) .import.summary[] / Autmatically loaded on startup

.import.repository.con:(1#`btick2)!enlist .self.btick2

.import.module1.con:enlist`arg`path`ltime0`ftime`dtime`cmd`error!({};"**";0np;0np;0nn;"**";`)

.import.module0:()!()
.import.module0[`dict]:{[x]
 x0:x,(1#`repository)!enlist .import.repository.con x`repository;
 cmd:.bt.print["l %path%"] .bt.md[`path]path:.bt.print["%repository%/qlib/%module%/%file%"] x0; 
 result:(`arg`path`ltime0`ftime`cmd`error!(x;path;.z.P;0np;cmd;`)),x0; 
 :.import.module0[`exec] result
 }
.import.module0[`symbol]:{[x]
 cnt:count x0:` vs arg:x`arg;

 if[1=cnt;
   t:first where {[x;y]x in key hsym`$y,"/qlib"}[arg]@'.import.repository.con;
   x:x,`repository`module`file!(t;arg;.bt.print["%0.q"]arg)
   ];
 if[(2=cnt) and x0[0] in key .import.repository.con;
  x:x,`repository`module`file!(x0 0;x0 1;.bt.print["%1.q"]x0)
  ];
 if[(2=cnt) and not x0[0] in key .import.repository.con;
  x:x,`repository`module`file!(`btick2;x0 0;.bt.print["%1.q"]x0)
  ];
 if[(3<=cnt) and x0[0] in key .import.repository.con;
  x:x,`repository`module`file!(x0 0;x0 1;.bt.print["%0.q"] enlist "/"sv string 2_x0)
  ];
 if[(3<=cnt) and not x0[0] in key .import.repository.con;
  x:x,`repository`module`file!(`btick2;x0 0;.bt.print["%0.q"] enlist "/"sv string 1_x0)
  ];
 :.import.module0[`dict] x
 }
.import.module0[`character]:{[x]
 cmd:.bt.print["l %path%"] .bt.md[`path] path:.bt.print[arg:x`arg] .import.repository.con;
 result:x,`path`ltime0`ftime`cmd`error!(path;.z.P;0np;cmd;`); 
 :.import.module0[`exec] result
 }
.import.module0[`exec]:{[x]
 loaded:"b"$count select from .import.module1.con where path like x`path,null error;
 if[loaded and not x`reload;:()];
 x:update dtime:ftime - ltime0 from x,(``ftime!(`;.z.P)),@[{`result`error!(system x;`)};x`cmd;{`result`error!(();`$x)}];
 `.import.module1.con insert x:cols[.import.module1.con]#x;
 x
 }

.import.module2:{[x]
 t:(99 11 10h!`dict`symbol`character) abs type x;
 :.import.module0[t] `reload`arg!(1b;x)
 }

.import.module:{[x]
 if[max x~/:(`;::);:1_.import.module1.con]; / show which file has been loaded
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
 if[max x~/:(`;::);:.import.summary[]]; / if not showing anything then return a summary of available repositories and requires.
 t:(99 11 10h!`dict`symbol`character) abs type x;
 :.import.module0[t] `reload`arg!(0b;x)
 }

.import.require:{[x]
 if[max x~/:(`;::);:1_.import.module1.con]; / show which file has been loaded
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


.import.require`os`util

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
  :select from .doc.conLib where repo =x 
 }


d)fnc btick2.import.summary 
 return all available files & folders in the root directory with an ignore list
 q) .import.summary[] / show all available modules and lib
 q) .import.summary`btick2  / show all modules in btick2 repository

if[()~key `.import.json;.import.json:`default];  / what is the default json file? Where to read it? 

.import.getConfig:{
 if[max x~/:(`;::);x:.import.json]; / give .import.json as the default file  
 `name`path!enlist[.import.json;]`$.bt.print[":%home%/.config/btick2/%cfg%.json"] ((1#`cfg)!1#x),.self
 }

d)fnc btick2.import.getConfig 
 load the config file and update the repository
 q) .import.getConfig[]  / this will load from the .import.json
 q) .import.getConfig .import.json / you can also specify a file or a repository name
 q) .import.getConfig `dontcare / you can also specify a file or a repository name


/ x:`$":C:\\Users\\kimkt/.config/btick2/default.json"
/ .import.readPath x

.import.readPath:{[x]
 config:.j.k "c"$read1 x;
 dependsOn:config`dependsOn;
 if[0=count config0:dependsOn`config;:flip`name`path!()];
 tbl:{ `name xcols update name:key x from value x } config0;
 tbl:update path:{[name] `$.bt.print[":%home%/.config/btick2/%name%.json"] .self,.bt.md[`name]name }@'name from tbl where path like"home";
 tbl 
 }

.import.init:{
 default:`$.bt.print[":%btick2%/qlib/repository/template/config/default.json"] .self;
 conf:.import.getConfig[];
 if[not{x ~ key x}conf`path;conf[`path] 1: read1 default]; 
 allConfigs:{ r:raze .import.readPath@'x`path;x,update priority:i+1+max x`priority from select from r where not path in x`path} over update priority:i from enlist conf;
 allConfigs:select from allConfigs where {x ~ key x} @'path; 
 allConfigs:update cfg:{.j.k "c"$read1 x }@'path from allConfigs ;  
 allRepositories:{`name xcols update name:key x,path:path from value x} raze { dependsOn:x . `dependsOn`repository }@'allConfigs`cfg;
 allRepositories:select from allRepositories where not {()~k:key hsym x}@'`$path; 
 .import.allConfig:allConfigs;
 .import.repository.con:((1#`btick2)!enlist .self.btick2),exec name!path from allRepositories;
 .import.config:.util.deepMerge over exec cfg from `priority xdesc allConfigs;
 .bt.action[`.import.loaded] ()!(); / notify other libs that config has been loaded. 
 }

.import.init[]  / we will init 

