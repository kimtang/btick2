
d)lib %btick2%/qlib/pykx/pykx.q
 Library for working with the lib pykx https://kx.com/kdb-insights-sdk-personal-edition-download/
 q).import.module`pykx 
 q).import.module`btick2.pykx
 q).import.module"%btick2%/qlib/pykx/pykx.q"

.pykx.summary:{} 

d).pykx.summary 
 Give a summary of this function
 q).pykx.summary[] 

.pykx.init:{[]
 b:all `p.k`pykx.q`pykx_init.q_ in key hsym`$getenv`QHOME;if[b;:()];
 .import.require`remote;
 "b" "python -c \"import pykx;pykx.install_into_QHOME()\"";
 }

.pykx.init[];

"p" "1+1;";

.pykx.type0:.pykx.eval["lambda x: str(type(x))"]
.pykx.type:{ssr[;"'>";""] ssr[;"<class '";""] string .pykx.type0[x]`}
.pykx.None:.pykx.eval"None"
.pykx.dir0:.pykx.eval["lambda x: dir(x)"]
.pykx.dir:{ .pykx.dir0[x]`}

.pykx.list0:.pykx.eval["lambda x: list(x)"]
.pykx.list:{ .pykx.list0[x]`}

.pykx.getattr0:.pykx.eval["lambda module,element_name: getattr(module,element_name)"]
.pykx.getattr:{  .pykx.getattr0[x;y]}

/ .v.e:{t:"\n"vs x;.pykx.pyexec"\n"sv enlist[t 0],{1_x}@'1_t;.z.Z}
/ .u.e:{.u.x:x;.pykx.qeval [x]}

.pykx.rscript:{[pscript;pcmd]
 if[0>t0:type pscript;pscript:enlist pscript];
 pscript:"\n" sv{ ssr[;"ExcelEmpty";""] raze string x}@'pscript;
 .pykx.pyexec pscript;
 if[t1:0>type pcmd;pcmd:enlist pcmd];
 r:.pykx.qeval@'{ ssr[;"ExcelEmpty";""] raze string x}@'pcmd;
 if[t1;:first r];
 r
 }

.p.rspace:{{if[" "=x 0;:1_x];x }over x}

.p.pcmd:{@[;`cmd;{ "\n"sv @[;0;.p.rspace] r:"\n" vs x }] .util.pcmd x}

.p.cmd0:()!()
.p.cmd0[`pyexec]:{[a] .pykx.pyexec a`cmd}
.p.cmd0[`qeval]:{[a]
  r:.pykx.qeval a`cmd;
  if[not null a2:a`a2; a2 set r];
  r
 }
.p.cmd0[`print]:{[a] .pykx.pyexec .bt.print["print(%cmd%)"] a}
.p.cmd0[`str]:{[a] .pykx.qeval .bt.print["str(%cmd%)"] a}
.p.e:{ .p.r:r:.p.cmd0[`pyexec^a`a1]a:.p.pcmd x;.p.r}


/ { .pykx.print .pykx.eval["lambda x: type(x)"] x }


