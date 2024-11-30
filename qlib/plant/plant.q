
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
 allEnv:.util.ctable env0;
 schemas:update sym:{ x[0],2_x }@'sym from select from allEnv where sym[;1]=`schema;
 schemas:`env`tname`col`cval!/:schemas[`sym]{x,enlist y}'schemas[`v];
 schemas:update cval:`${"," vs x}@'cval from schemas where col=`column;
 default:select env,tname,col:`ocolumn,cval:cval from schemas where col=`column;
 default:default,select env,tname,col:`rattr,cval:{count[x]#"*"}@'cval from schemas where col=`column;
 default:default,select env,tname,col:`hattr,cval:{count[x]#"*"}@'cval from schemas where col=`column;
 default:default,select env,tname,col:`upd,cval:count[i]#enlist (::) from schemas where col=`column; 
 default:default,select env,tname,col:`addTime,cval:0b from schemas where col=`column;
 default:default,ungroup select env,tname,col:count[i]#enlist `tick`rdb`hdb`replay,cval:count[i]#enlist `default from schemas where col=`column;   
 schemas:select from (default,schemas) where ({x=last x};i) fby ([]env;tname;col);
 schemas:.tidyq.dcast[schemas;"env,tname";"%col% ~~ cval"];
 fnc:{[mode;env;x] @[x;;:;.Q.dd[env]mode] where `default=x:(),x};
 update tick:fnc'[`tick;env;tick],rdb:fnc'[`rdb;env;rdb],hdb:fnc'[`hdb;env;hdb],replay:fnc'[`replay;env;replay] from schemas
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