
.import.require`tidyq;

d)lib btick2.plant 
 Library for working with the lib plant
 q).import.module`plant 
 q).import.module`btick2.plant
 q).import.module"%btick2%/qlib/plant/plant.q"

.plant.summary:{} 

d)fnc plant.plant.summary 
 Give a summary of this function
 q) plant.summary[] 

.plant.process:{[arg0]
 dataDir:{[arg;x] key[x]!key[x]{[arg;x;y] (`$.bt.print["%root%/data/%plant%/%env%"] arg,.bt.md[`env]x )^y }[arg]'value x }[arg0] .plant.dataDir jobj:arg0`jobj;
 global:.json.k jobj`global;
 env0:raze{[global;x] (1#x`k)!enlist .json.k .j.k .bt.print[ .j.j x`v] global x`k }[global;]@' {([]k:key x;v:value x)} `global _ jobj;
 allEnv:.util.ctable env0;
 process:select json:.import.json,repo:arg0`repo,plant:arg0`plant,env:sym[;0],proc:sym[;2],lib:`${"," vs x}@'v from allEnv where sym[;1]=`process ,{`lib=last x}@'sym;
 process:`uid xcols update uid:.Q.dd'[json;flip(repo;plant;env;proc)],luid:.Q.dd'[env;proc] from process;
 process:update arg:{[arg;env;proc] arg . env,`process,proc,`arg }[env0]'[env;proc] from process;
 process:update port:{x[`setPort]`port}@'arg from process;
 process:update host:{[global;arg;env;proc] .util.deepMerge[global env;arg . env,`process,proc]`host }[global;env0]'[env;proc] from process;
 process:update dataDir:dataDir env from process;
 process:update pm2File:`$.bt.print[":%dataDir%/pm2/%uid%"]@'process from process; 
 process:update fileDir:`${[arg;p] .bt.print[":%root%/plant/%plant%/%env%/%proc%"] arg,p}[arg0;]@'process from process;
 process
 }

.plant.schema:{[arg0]
 global:.json.k (jobj:arg0`jobj)`global;
 env0:raze{[global;x] (1#x`k)!enlist .json.k .j.k .bt.print[ .j.j x`v] global x`k }[global;]@' {([]k:key x;v:value x)} `global _ jobj;
 allEnv:.util.ctablen[4] env0;
 schemas:update sym:{ x[0],2_x }@'sym from select from allEnv where sym[;1]=`schema;
 schemas:update v:count[i]#enlist[`type`mode`partitionCol`partAttrCol`sortCol!`partition`auto`date`sym`time] from schemas where sym[;2]=`storage,v~'`partition;
 schemas:update v:count[i]#enlist[`type`mode`partitionCol`partAttrCol`sortCol!`splay`auto`date`sym`time] from schemas where sym[;2]=`storage,v~'`splay;
 schemas:update v:count[i]#enlist[`type`mode`partAttrCol`sortCol!`flat`auto`sym`time] from schemas where sym[;2]=`storage,v~'`flat; 
 columns:select sym,cnt:{count ","vs  x}@'v,col:{`$","vs  x}@'v from schemas where sym[;2]=`column;
 default:select sym:.[sym;(::;2);:;`rattr] ,v:"*"^(`sym`time!"gs")col from columns;
 default:default,select sym:.[sym;(::;2);:;`hattr] ,v:"*"^(`sym`time!"ps")col from columns;
 default:default,select sym:.[sym;(::;2);:;`tick] ,v:count[i]#enlist `default from columns;
 default:default,select sym:.[sym;(::;2);:;`rdb] ,v:count[i]#enlist `default from columns;
 default:default,select sym:.[sym;(::;2);:;`hdb] ,v:count[i]#enlist `default from columns;
 default:default,select sym:.[sym;(::;2);:;`cdb] ,v:count[i]#enlist `default from columns;
 default:default,select sym:.[sym;(::;2);:;`replay] ,v:count[i]#enlist `default from columns;
 default:default,select sym:.[sym;(::;2);:;`upd] ,v:count[i]#(::) from columns;
 default:default,select sym:.[sym;(::;2);:;`storage] ,v:count[i]#enlist `type`mode`partitionCol`partAttrCol`sortCol!`partition`auto`date`sym`time from columns;
 schemas:.tidyq.dcast[;"env,tname";"%col% ~~ cval"] select env:sym[;0],tname:sym[;1],col:sym[;2],cval:v from 0!select by sym from default,schemas;
 fnc:{[mode;env;x] @[x;;:;.Q.dd[env]mode] where `default=x:(),x};
 schemas:update tick:fnc'[`tick;env;tick],rdb:fnc'[`rdb;env;rdb],hdb:fnc'[`hdb;env;hdb],replay:fnc'[`replay;env;replay],cdb:fnc'[`cdb;env;cdb] from schemas;
 schemas:update column:`${","vs x}@'column from schemas 
 }


.plant.dataDir:{[jobj]
 global:.json.k jobj`global;
 env0:raze{[global;x] (1#x`k)!enlist .json.k .j.k .bt.print[ .j.j x`v] global x`k }[global;]@' {([]k:key x;v:value x)} `global _ jobj;
 allEnv:.util.ctable {(enlist[`dataDir]!enlist`),x}@'env0;
 exec sym[;0]!v from allEnv where {`dataDir=last x}@'sym
 }

.plant.cFile:{[arg0]
 process:.plant.process arg0;
 files:`$.bt.print["%fileDir%/%proc%.q"]@'process;
 {x 0: enlist""}@'files
 }