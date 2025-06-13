
.import.require`qlang;

d)lib %btick2%/qlib/json/json.q
 Library for working with the lib json
 q).import.module`json 
 q).import.module`btick2.json
 q).import.module"%btick2%/qlib/json/json.q"

.json.summary:{} 

d).json.summary 
 Give a summary of this function
 q) json.summary[] 


.json.nul:()!()

.json.ap:{[k;v;tail]
 d:(1#k)!enlist v;
 (1#`.ignoreMe598) _ d,tail,(1#`.ignoreMe598)!enlist{}
 }

.json.ap0:{[k;v] .json.ap[k;v;.json.nul] }

.json.atoms:update t:"r" from .qlang.atoms where ind=-20

/ .json.kj:(abs .qlang.atoms`ind)!" GXhije  SPMDZNUVTS"

.json.kj:(exec (-100h,abs ind)!("q",upper t) from .json.atoms),exec ind!t from .json.atoms
.json.jk: {value[x]!key x} .json.kj

.json.j:{[json]
 json:.util.ctable json;
 json:update p:{ ( ({v!v:value x} .json.kj),("Cfb"!"   ")) .json.kj type x}@'v from json;
 .util.cdict select sym:sym{[sym;p] if[null p;:sym];(-1_sym),.Q.dd[last sym;p]  }'p,v from json
 }

.json.k:{[json]
 json:.util.ctable json;
 json:update p:{({x!x} distinct `$/:value .json.kj) l:last x:` vs last x}@'sym from json;
 json0:select ind:i,sym:{(-1_x),` sv -1_` vs last x:(),x}@'sym, v:(raze  string p)$'v from json where not null p,not p in `R`r`q;
 json0:json0,select ind:i,sym:{(-1_x),` sv -1_` vs last x:(),x}@'sym, v:{reval parse x}@'v from json where p=`q;
 .util.cdict (`sym`v#json0),select sym,v from json where not i in exec ind from json0 
 } 