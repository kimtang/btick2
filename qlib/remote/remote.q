
d)lib btick2.remote 
 Library for working with the lib remote
 q).import.module`remote 
 q).import.module`btick2.remote
 q).import.module"btick2/qlib/remote/remote.q"

.import.require`util`hopen;

.remote.con:1!flip`uid`host`port`user`passwd!"ssjs*"$\:()

.bt.add[`.import.init;`.remote.init]{.remote.init[]}


.remote.init:{
 .remote.conf:0#0!.remote.con;
 if[`remote in key .import.config;.remote.conf:key[conf] {[x;y]update uid:x from y}' value conf:.import.config`remote ];
 .remote.add .remote.conf;
 }


.remote.summary:{[x]
 if[max x~/:(::;`);:0!.remote.con];
 0!select from .remote.con where uid = x
 }


d)fnc remote.remote.summary 
 Give a summary of this function
 q) remote.summary[] 

.remote.add:{[x]
  default:`host`user`passwd!(enlist`localhost;enlist`;({count[x]#enlist""};`i));
  `.remote.con upsert cols[`.remote.con]#0!![x;();1b;] (key[default]except cols x)#default;
  .remote.con
 }

 
d) fnc remote.remote.add
 Function to add a connection
 q) .remote.add `uid`host`port`user`passwd!(`kx_platform_hdb;`sgsupp01.firstderivatives.com; 23003;`;1#"")
 

.remote.query0:{[mode;proc;query]
 if[not -11h = type proc;:.remote.summary[] ];
 if[0=count select from .hopen.con where uid = proc;
   allProcs:.remote.summary proc;
   if[ not proc in allProcs`uid;'`.remote.proc_not_found ];
   .bt.action[`.hopen.add] @' `uid`host`port`user`passwd#select from allProcs where uid=proc;
 ];
 procData:first 0!select from .hopen.con where uid = proc;
 seq:3;
 while[(null procData`hdl) and seq-:1;
   .util.sleep 3; / sleep for 3 secs
   delete from `.bt.tme where null runAt ,fnc = `.bt.action,`.hopen.loop ~/:arg[;0];
   .bt.action[`.hopen.loop] ()!();
   procData:first 0!select from .hopen.con where uid = proc;
 ];

 / if[null procData`hdl;'`.remote.proc_not_connected];
 st:.z.P;
 if[null procData`hdl; : (`result`error!(();`.remote.proc_not_connected)),`st`et`proc!st,.z.P,proc  ];
 r:@[{`result`error!(x y;`)}[mode procData`hdl];query;{`result`error!(();`$x)}];
 et:.z.P;
 :r,`st`et`proc!st,et,proc
 }

.remote.query:{[proc;query] .remote.query0[(::);proc;query] }
 
d) fnc remote.remote.query
 Function to give a query of available connection
 q) .remote.query[`kx_platform_hdb] "1+3"
 f) 1+3

.remote.async:{[proc;query] .remote.query0[neg;proc;query] }
 
d) fnc remote.remote.async
 Function to give a async of available connection
 q) .remote.async[`kx_platform_hdb] "1+3"
 f) 1+3


.remote.qthrow:{[proc;query]
 r:.remote.query[proc;query];
 if[not null r`error;'r`error]; 
 r `result 
 }

 
d) fnc remote.remote.qthrow
 Function to give a query of available connection
 q) .f.proc:`kx_platform_hdb
 q) .remote.qthrow[`kx_platform_hdb] "1+3"
 f) 1+3


.remote.q:{
  r:.remote.query[;x]@'.f.proc;
  if[0<type .f.proc;:r ];
  if[not null r`error;'r`error];
  r`result
 }

d) fnc remote.remote.q
 Function to give a query of available connection
 q) .f.proc:`kx_platform_hdb
 q) .remote.q "1+3"
 f) 1+3

.remote.a:{
  r:.remote.async[;x]@'.f.proc;
  if[0<type .f.proc;:r ];
  if[not null r`error;'r`error];
  r`result
 }

d) fnc remote.remote.a
 Function to give a query of available connection
 q) .f.proc:`kx_platform_hdb
 q) .remote.a "1+3"


.f.q:{ .f.r:.remote.q x;.f.r }
.f.a:{ .f.r:.remote.a x;.f.r }
/ .f.e:{ .f.q x }

.f.e:{ x:"||" vs x;if[1=count x;:.f.q x 0];r:.f.q .bt.print[x 0]get x 1; if[2=count x;:r]; (parse x 2) set r;r  }

.f.proc:`self

.s.mode:`batch
/ .s.mode:`pwsh

.s.batch:{system x}
.s.pwsh:{system .bt.print[ "pwsh -command \"%0\" " ] enlist ssr[;"\"";"\\\""] x  }

.s.q0:{[mode;x] (.s mode;{$[" "= x 0;1_x;x] } over x)}
.s.q:{ .s.q0[.s.mode] x }
.s.e:{
  a:.b.getArg x;
  if[`yaml~a`out;a:@[a;`cmd;{ x," || yq -o json " }];a:@[a;`out;:;`json];];
  .s.r:.f.q .s.d:.s.q r:.bt.print[a`cmd] a`arg;
  result:.s.r;
  if[a[`out] in `json`txt;result:"\n" sv result ];
  if[`json~a`out;result:.j.k result ];
  if[`tbl~a`out;result:.remote.toTbl result ];  
  result
 }

.b.getArg:{
 arg:()!();out:`;x:first r:"||" vs x;
 if[2=count r;
  s:"~~" vs r 1;
  arg:get s 0;
  if[2=count s;out:`$s 1];
 ];
 s:"~~" vs x;
 if[2=count s; out:`$s 1];
 `cmd`arg`out!(s 0;arg;out)
 }

.b.e:{ 
  a:.b.getArg x;
  if[`yaml~a`out;a:@[a;`cmd;{ x," | yq -o json " }];a:@[a;`out;:;`json];];
  .b.r:.remote.query[`self;] .b.d:.s.q r:.bt.print[a`cmd] a`arg; 
  if[not null .b.r`error;'.b.r`error ];
  result:.b.r`result;
  if[a[`out] in `json`txt;result:"\n" sv result ];
  if[`json~a`out;result:.j.k result ];
  if[`tbl~a`out;result:.remote.toTbl result ];
  .b.r[`result]:result;
  result
 }
 
.remote.toTbl:{[lst]
 mm:max count@'lst;
 lst:{[mm;x] mm# x,mm#" "}[mm]@'lst;
 header:lst 0;
 d:where 1=deltas not " "=header;
 fl:1_deltas d,mm;
 cfl:count fl;
 sheader:lower first flip (cfl#"s";fl)0: 1#lst;
 result:flip sheader!(cfl#"*";fl)0: 1_lst;
 result
 }

.remote.sbl:{[x]
 summary:.remote.summary x;
 path:.bt.md[`path]  1_ ssr[;":./";":"] string {[x] if[max key[ x] like "*sublime-project";:x]; .Q.dd[x;`..] }/[4; `:.];
 (`$.bt.print[":%path%/cfg/system.sbl"] path) 0: .bt.print["/ %uid%:%host%:%port%:%user%:%passwd%"]@'summary
 }


d) fnc remote.remote.sbl
 Function to write a config file for sbl. Path can be config in the qlib.json. "remote":{"path": "../cfg","user":"yourname","passwd":"yourpasswd"}
 q) .remote.sbl []

.remote.cfile:{[x] {file:`$.bt.print[":proc/%uid%.q"] x;cont:enlist .bt.print["/ %uid%:%host%:%port%:%user%:%passwd%"] x;if[file~key file;:file ]; file 0: cont}@'x}


d) fnc remote.remote.cfile
 Function to create procs file
 q) .remote.cfile .remote.summary

 
.remote.duplicate0:()!()
.remote.duplicate0[1]:{[fnc;arg0] .remote.q (fnc;arg0)}
.remote.duplicate0[2]:{[fnc;arg0;arg1] .remote.q (fnc;arg0;arg1)}
.remote.duplicate0[3]:{[fnc;arg0;arg1;arg2] .remote.q (fnc;arg0;arg1;arg2)}
.remote.duplicate0[4]:{[fnc;arg0;arg1;arg2;arg3] .remote.q (fnc;arg0;arg1;arg2;arg3)}
.remote.duplicate0[5]:{[fnc;arg0;arg1;arg2;arg3;arg4] .remote.q (fnc;arg0;arg1;arg2;arg3;arg4)}
.remote.duplicate0[6]:{[fnc;arg0;arg1;arg2;arg3;arg4;arg5] .remote.q (fnc;arg0;arg1;arg2;arg3;arg4;arg5)}
.remote.duplicate0[7]:{[fnc;arg0;arg1;arg2;arg3;arg4;arg5;arg6] .remote.q (fnc;arg0;arg1;arg2;arg3;arg4;arg5;arg6)}

 

.remote.duplicate:{[x]
 if[(not type[x] in 10 -11h) or max x~/:(`;::);:.import.doc`.remote.duplicate];
 if[10h=abs type x;x:`$x];
 result:.remote.q ({type get x};x);
 if[not 100h = result;
   x set .remote.q ({get x};x);
   :get x
   ];
 result:.remote.q ({get get x};x);
 l:count result 1;
 x set .remote.duplicate0[l][string x]
 }
 

d) fnc remote.remote.duplicate
 Function to duplicate the fnc
 q) .remote.duplicate[]  / show this doc
 q) .remote.duplicate `.bt.action

 

.remote.deepDuplicate:{[x]
 if[(not type[x] in 10 -11h) or max x~/:(`;::);:.import.doc`.remote.duplicate];
 if[10h=abs type x;x:`$x];
 result:.remote.q x;
 if[not 100h = type result;x set result;:x ];
 l:(get[ result]3) except `;
 l:l where not l like ".z*";
 l:l where 100h=.remote.q ({ {type get x} @' x};l);
 (x set result),.remote.duplicate@'l
 }

d) fnc remote.remote.deepDuplicate
 Function to deepDuplicate the fnc
 q) .remote.deepDuplicate[]  / show this doc
 q) .remote.q "`thisFunc1 set {[a;b] a + thisFunc2 b }"
 q) .remote.q "`thisFunc2 set {[b] exp b }"
 q) .remote.deepDuplicate `thisFunc2


.remote.fduplicate0:()!()
.remote.fduplicate0[1]:{[proc;fnc;arg0] r:.remote.query[;(fnc;arg0)]@'proc;if[0<type proc;:r ];if[not null r`error;'r`error];r`result}
.remote.fduplicate0[2]:{[proc;fnc;arg0;arg1] r:.remote.query[;(fnc;arg0;arg1)]@'proc;if[0<type proc;:r ];if[not null r`error;'r`error];r`result}
.remote.fduplicate0[3]:{[proc;fnc;arg0;arg1;arg2] r:.remote.query[;(fnc;arg0;arg1;arg2)]@'proc;if[0<type proc;:r ];if[not null r`error;'r`error];r`result}
.remote.fduplicate0[4]:{[proc;fnc;arg0;arg1;arg2;arg3] r:.remote.query[;(fnc;arg0;arg1;arg2;arg3)]@'proc;if[0<type proc;:r ];if[not null r`error;'r`error];r`result}
.remote.fduplicate0[5]:{[proc;fnc;arg0;arg1;arg2;arg3;arg4] r:.remote.query[;(fnc;arg0;arg1;arg2;arg3;arg4)]@'proc;if[0<type proc;:r ];if[not null r`error;'r`error];r`result}
.remote.fduplicate0[6]:{[proc;fnc;arg0;arg1;arg2;arg3;arg4;arg5] r:.remote.query[;(fnc;arg0;arg1;arg2;arg3;arg4;arg5)]@'proc;if[0<type proc;:r ];if[not null r`error;'r`error];r`result}
/ .remote.fduplicate0[7]:{[proc;fnc;arg0;arg1;arg2;arg3;arg4;arg5;arg6] r:.remote.query[proc;](fnc;arg0;arg1;arg2;arg3;arg4;arg5;arg6);if[0<type .f.proc;:r ];if[not null r`error;'r`error];r`result}

 


.remote.fduplicate1:()!()
.remote.fduplicate1[100h]:{[fnc] count fnc 1}
.remote.fduplicate1[104h]:{[fnc] f:get fnc 0;(count f 1) + 1 - count fnc }

.remote.fduplicate:{[proc;x]
 if[(not type[x] in 10 -11h) or max x~/:(`;::);:.import.doc`.remote.duplicate];
 if[10h=abs type x;x:`$x];
 r:.remote.query[proc] ({type get x};x);
 if[not null r`error;'r`error];tipe:r`result;
 if[not tipe in 100 104h ;:x ];
 r:.remote.query[proc] ({get get x};x);
 if[not null r`error;'r`error];result:r`result;
 l:.remote.fduplicate1[tipe]result;
 x set .remote.fduplicate0[l][proc;string x]
 }
 

d) fnc remote.remote.fduplicate
 Function to duplicate the fnc
 q) .remote.fduplicate[]  / show this doc
 q) .remote.fduplicate[`fixed.proc] `.bt.action


.remote.fdeepDuplicate:{[proc;x]
 if[(not type[x] in 10 -11h) or max x~/:(`;::);:.import.doc`.remote.duplicate];
 if[10h=abs type x;x:`$x];
 r:.remote.query[proc] x;
 if[not null r`error;'r`error];result:r`result;
 if[not 100h = type result;x set result;:x];
 l:(get[ result]3) except `;
 l:l where not l like ".z*";
 lr:.remote.query[proc] ({ {type get x} @' x};l);
 l:l where 100h=lr`result;
 (x set result),.remote.fduplicate[proc]@'l
 }


d) fnc remote.remote.fdeepDuplicate
 Function to duplicate the fnc
 q) .remote.fdeepDuplicate[]  / show this doc
 q) .remote.fdeepDuplicate[`fixed.proc] `.bt.action


.remote.trace.con :flip `bseq`eseq`name`zw`st`et`dt`error`arg`result`body!()
.remote.trace.con1:1!flip `name`body`nbody!()
.remote.trace.seq:0

.remote.trace.duplicate0:()!()
.remote.trace.duplicate0[1]:{[fncs;arg0] .remote.trace.duplicate1[fncs] (enlist arg0)}
.remote.trace.duplicate0[2]:{[fncs;arg0;arg1] .remote.trace.duplicate1[fncs] (arg0;arg1)}
.remote.trace.duplicate0[3]:{[fncs;arg0;arg1;arg2] .remote.trace.duplicate1[fncs] (arg0;arg1;arg2)}
.remote.trace.duplicate0[4]:{[fncs;arg0;arg1;arg2;arg3] .remote.trace.duplicate1[fncs] (arg0;arg1;arg2;arg3)}
.remote.trace.duplicate0[5]:{[fncs;arg0;arg1;arg2;arg3;arg4] .remote.trace.duplicate1[fncs] (arg0;arg1;arg2;arg3;arg4)}
.remote.trace.duplicate0[6]:{[fncs;arg0;arg1;arg2;arg3;arg4;arg5] .remote.trace.duplicate1[fncs] (arg0;arg1;arg2;arg3;arg4;arg5)}
.remote.trace.duplicate0[7]:{[fncs;arg0;arg1;arg2;arg3;arg4;arg5;arg6] .remote.trace.duplicate1[fncs] (arg0;arg1;arg2;arg3;arg4;arg5;arg6)}

.remote.trace.duplicate1:{[fncs;args]
 beg:`bseq`st`arg`zw!(.remote.trace.seq+:1;.z.P;args;.z.w);
 r:@[{ `et`result`error!(.z.P;0 x;`) };(fncs[`body],args);{`et`result`error!(.z.P;();`$x)}];
 `.remote.trace.con insert update dt:et - st from ((1#`eseq)!1#.remote.trace.seq+:1),beg,fncs,r;
 if[not null r`error;'r`error];
 :r`result
 }

.remote.trace.duplicate2:{[name]
 if[not name~key name;:()];
 if[not 100h=t:type body:get name;:()];
 fncs:`name`body!(name;body);
 l:count (gbody:get body) 1;
 if[0=count gbody 0;:()];
 name set nbody:.remote.trace.duplicate0[l][fncs];
 `.remote.trace.con1 upsert `name`body`nbody!(name;body;nbody) ;
 name
 }

.remote.trace.fduplicate:{[]
  names:system "f";
 .remote.trace.duplicate names;
 }

.remote.trace.duplicate:{[names]
 if[0>type names;names:enlist names];
 .remote.trace.duplicate2@'names
 }

.remote.trace.init:{[procs]
 if[0>type procs;procs:enlist procs];
 .remote.async[;(set;`.remote.trace;.remote.trace)] @'procs;
 }

.remote.trace.trace:{[proc;x]
 .remote.query[proc;(".remote.trace.rec";x)];
 }

.remote.trace.initTrace:{[procs;x]
 if[0>type procs;procs:enlist procs];
 .remote.trace.init[procs]; 
 .remote.query[;(set;`.remote.trace;.remote.trace)] @'procs;
 :.remote.trace.trace[;x]@'procs
 }

.remote.trace.getCon0:{[uids]
 if[max uids~/:(`;::);uids:.f.proc];
 uids:(),uids;  
 r:.remote.query[;"select bseq,eseq,name,zw,st,et,dt,error,arg,result from .remote.trace.con"]@'uids;
 `st xasc `proc xcols raze exec {[x;y] update proc:y from x }'[result;proc]from r
 }

.remote.trace.getCon1:{[uids]
 if[max uids~/:(`;::);uids:.f.proc];  
 r:.remote.query[;".remote.trace.con1"]@'uids;
 `proc xcols raze exec {[x;y]0! update proc:y from x }'[result;proc]from r
 }

.remote.trace.reduplicate:{[x]
  {x[`name] set x`nbody}@'0!.remote.trace.con1
  / n:exec name from .remote.trace.con1;
  / .remote.trace.duplicate2 @'n;
 }

.remote.trace.reset0:{[x]
  {x[`name] set x`body}@'0!.remote.trace.con1;
 }

.remote.trace.reset:{[proc].remote.async[;".remote.trace.reset0[]"]@'proc;}

.remote.trace.rec0:()!()
.remote.trace.rec0[100h]:{[x]c:count first get x ; if[0=c;:()]; .remote.trace.duplicate2 x }
.remote.trace.rec0[99h]:{[x] k:key[x];if[not 11h= type k;:()];k:k except ` ;l:.Q.dd'[x;k]; .remote.trace.rec1@'l }
.remote.trace.rec1:{if[()~key x;:()] ;if[not (t:type get x) in key .remote.trace.rec0;:()];.remote.trace.rec0[t] x }
/ .remote.trace.rec:{.remote.trace.rec1 @' (system"f"),.Q.dd'[`;]l where {2<count @'string x} l:key[`] except `z`q`Q`h`j`o`remote }

.remote.trace.rec:{[x].remote.trace.rec1 @' x }

.remote.trace.putArg0:()!()

.remote.trace.putArg0[-7h]:{
 cont:select from .remote.trace.con where bseq=x;
 if[not 1=count cont;'`.remote.trace.putArg0.nobseq];
 cont:first cont ;
 g:get cont`body;
 g[ 1] set' cont`arg;
 cont`body
 }

.remote.trace.putArg0[-11h]:{
 cont:select from .remote.trace.con where name=x;
 if[1>count cont;'`.remote.trace.putArg0.nobseq];
 cont:first cont ;
 g:get cont`body;
 g[ 1] set' cont`arg;
 cont`body
 }

.remote.trace.putArg:{[x] .remote.trace.putArg0[type x]x }


.remote.trace.summary:{[x]
 pcon:`bseq xasc update p:i,c:i from `bseq xasc select bseq,eseq,name,st,et,dt from x;
 pcon:`bseq xasc pcon lj 1!select bseq:bseq + 1,c:p from pcon;
 pcon:{[x]`bseq xasc x lj 1!select bseq:eseq + 1,c:c from x} over pcon;
 pcon
 }

.remote.trace.summary1:{[x]
 pcon:`bseq xasc update p:i,c:i from `bseq xasc select bseq,eseq,name,st,et,dt from x;
 pcon:`bseq xasc pcon lj 1!select bseq:bseq + 1,c:p from pcon;
 pcon:{[x]`bseq xasc x lj 1!select bseq:eseq + 1,c:c from x} over pcon;
 allCon:select from0:(p!name)c,t0:name  from pcon;
 allCon0:distinct allCon;
 m:1+group 1_pcon`c;
 dt0:{[x;y] @[x;y`k;-;sum x y`v] }over enlist[pcon`dt],([]k:key m;v:value m);
 pcon:update dt0 from pcon;
 dt1:sum pcon`dt0;
 summary1:0!update spdt:sums pdt from `pdt xdesc select cnt:count i,dt0:sum dt0,pdt:sum[ dt0] % dt1 by name from pcon   
 }

