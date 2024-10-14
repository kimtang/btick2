
d)lib btick2.pykx 
 Library for working with the lib pykx
 q).import.module`pykx 
 q).import.module`btick2.pykx
 q).import.module"*btick2*/qlib/pykx/pykx.q"

.pykx.summary:{} 

d)fnc pykx.pykx.summary 
 Give a summary of this function
 q) pykx.summary[] 

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

.v.e:{t:"\n"vs x;.pykx.pyexec"\n"sv enlist[t 0],{1_x}@'1_t}


/ { .pykx.print .pykx.eval["lambda x: type(x)"] x }


