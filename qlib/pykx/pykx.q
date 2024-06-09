
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

.pykx.init[]

"p" "print(\"Hello World\")";