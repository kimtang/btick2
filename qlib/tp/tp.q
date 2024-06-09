
d)lib btick2.tp 
 Library for working with the lib tp
 q).import.module`tp 
 q).import.module`btick2.tp
 q).import.module"%btick2%/qlib/tp/tp.q"

.import.require`hopen

.tp.summary:{} 

d)fnc tp.tp.summary 
 Give a summary of this function
 q) .tp.summary[] 


.tp.con:enlist`time`ftime`hdl`topic`ssel!(.z.P;.z.P;0ni;`;`)

.bt.add[`.hopen.pc;`tp.pc]{[zw] update ftime:.z.P from `.tp.con where hdl=zw,null ftime; }
.u.sub:{[x;y] `.tp.con insert `time`ftime`hdl`topic`ssel!(.z.P;0np;.z.w;x;y);} 

.t.topic:`qexcel

.tp.pub:{[topic0;data]
 hdls:exec hdl from .tp.con where topic=topic0,null ftime;
 -25!enlist[hdls;] ("upd";topic0;data)
 }

.t.e:{[x] .tp.pub[.t.topic;]  .t.r:0 x; .t.r}

/ t) ([]a:1 2 3;b: 4 5 10;c:1 2 3;d: 4 5 8)