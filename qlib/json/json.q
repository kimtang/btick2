
.import.require`qlang;

d)lib btick2.json 
 Library for working with the lib json
 q).import.module`json 
 q).import.module`btick2.json
 q).import.module"%btick2%/qlib/json/json.q"

.json.summary:{} 

d)fnc json.json.summary 
 Give a summary of this function
 q) json.summary[] 


.json.nul:()!()

.json.ap:{[k;v;tail]
 d:(1#k)!enlist v;
 (1#`.ignoreMe598) _ d,tail,(1#`.ignoreMe598)!enlist{}
 }

.json.ap0:{[k;v] .json.ap[k;v;.json.nul] }

.json.kj:(abs .qlang.atoms`ind)!" GXhije  SPMDZNUVTS"

.json.j:{[json]
 json:.util.ctable json;
 json:update p:{.json.kj abs type x}@'v from json;
 .util.cdict select sym:sym{[sym;p] if[null p;:sym];(-1_sym),.Q.dd[last sym;p]  }'p,v from json 
 }

.json.k:{[json]
 json:.util.ctable json;
 json:update p:{({x!x} distinct `$/:value .json.kj) l:last x:` vs last x}@'sym from json;
 .util.cdict `sym`v#update sym:{(-1_x),` sv -1_` vs last x}@'sym, v:(raze  string p)$'v from json where not null p
 } 