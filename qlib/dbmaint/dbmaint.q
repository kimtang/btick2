
d)lib btick2.dbmaint 
 Library for working with the lib dbmaint
 q).import.module`dbmaint 
 q).import.module`btick2.dbmaint
 q).import.module"%btick2%/qlib/dbmaint/dbmaint.q"

.dbmaint.summary:{} 

d)fnc dbmaint.dbmaint.summary 
 Give a summary of this function
 q) dbmaint.summary[] 


.dbmaint.ls0:{[arg;n]
 if[10=abs type arg;arg:`$arg];
 if[11h=type arg;arg:`$"/"sv {(),x}@'string arg];
 if[not ":"=first string arg;arg:hsym arg];
 allFiles:$[null n;.os.tree;.os.treen[n]] arg;
 / allFiles:.os.treen arg;
 allFiles:update mode:`folder from allFiles where child in parent;
 allFiles:update mode:`file from allFiles where null mode,{x ~ key x}@'fullPath;
 allFiles:update mode:`folder from allFiles where null mode;
 allFiles	
 }

.dbmaint.ls:{[arg] .dbmaint.ls0[arg]0ni }

d)fnc dbmaint.dbmaint.ls 
 Unix ls funtion
 q) dbmaint.ls["dontcare.txt"] 
 q) dbmaint.ls["dontcare/abc.txt"]
 q) dbmaint.ls[":dontcare/abc.txt"]
 q) dbmaint.ls[`:dontcare/abc.txt]
 q) dbmaint.ls[`dontcare`abc.txt]    


.dbmaint.touch:{[arg]
 if[10h=abs type arg;arg:`$arg];
 if[11h=type arg;arg:`$"/"sv {(),x}@'string arg];
 if[not ":"=first string arg;arg:hsym arg];
 arg 0:enlist""
 }

d)fnc dbmaint.dbmaint.touch 
 Unix touch funtion
 q) dbmaint.touch["dontcare.txt"] 
 q) dbmaint.touch["dontcare/abc.txt"]
 q) dbmaint.touch[":dontcare/abc.txt"]
 q) dbmaint.touch[`:dontcare/abc.txt]
 q) dbmaint.touch[`dontcare`abc.txt]    


.dbmaint.mkdir:{[arg]
 if[10h=abs type arg;arg:`$arg];
 if[11h=type arg;arg:`$"/"sv {(),x}@'string arg];
 if[not ":"=first string arg;arg:hsym arg];
 (f:.Q.dd[arg;`dontcare]) set 1;
 hdel f;
 arg
 }


d)fnc dbmaint.dbmaint.mkdir 
 Unix mkdir funtion
 q) dbmaint.mkdir["dontcare"] 
 q) dbmaint.mkdir["dontcare/abc"]
 q) dbmaint.mkdir[":dontcare/abc"]
 q) dbmaint.mkdir[`:dontcare/abc]
 q) dbmaint.mkdir[`dontcare`abc]

.dbmaint.rm:{[arg]
 if[10h=abs type arg;arg:`$arg];
 if[11h=type arg;arg:`$"/"sv {(),x}@'string arg];
 if[not ":"=first string arg;arg:hsym arg];	
 if[()~key arg;:()];
 allFiles:.os.tree arg;
 files:select from allFiles where not child in parent;
 files:select from files where {x ~ key x}@'fullPath;
 hdel @'files`fullPath;
 folders:select from allFiles where not fullPath in files`fullPath;
 hdel @'exec fullPath from `child xdesc folders;
 allFiles
 }

d)fnc dbmaint.dbmaint.rm 
 Unix rm funtion
 q) dbmaint.rm["dontcare"] / entire folder or file
 q) dbmaint.rm["dontcare/abc"]
 q) dbmaint.rm[":dontcare/abc"]
 q) dbmaint.rm[`:dontcare/abc]
 q) dbmaint.rm[`dontcare`abc]


.dbmaint.head0:{[arg;n] / n is number of line
 if[10h=type arg;arg:`$arg];
 if[11h=type arg;arg:`$"/"sv {(),x}@'string arg];
 if[not ":"=first string arg;arg:hsym arg];
 nline:0;mcnt:hcount arg;nread:0;
 x:{[arg;x] @[;2;,;a+where("x"$"\n")=r] @[;1;+;count r] @[x;0;,;] r:read1 (arg;a:x 1;100000) }[arg]/[{[n;mcnt;x]not (mcnt<=count x 0 ) or n<=-1+count x 2 }[n;mcnt];(();0;0#0)]; 
 (x 2) cut "c"$x 0
 }

d)fnc dbmaint.dbmaint.head0 
 Unix head0 funtion
 q) dbmaint.head0[10;"dontcare.txt"] 
 q) dbmaint.head0[10;"dontcare/abc.txt"]
 q) dbmaint.head0[10;":dontcare/abc.txt"]
 q) dbmaint.head0[10;`:dontcare/abc.txt]
 q) dbmaint.head0[10;`dontcare`abc.txt]

.dbmaint.head:{[arg] .dbmaint.head0[10;arg]}

d)fnc dbmaint.dbmaint.head 
 Unix head0 funtion
 q) dbmaint.head["dontcare.txt"] / entire folder or file
 q) dbmaint.head["dontcare/abc.txt"]
 q) dbmaint.head[":dontcare/abc.txt"]
 q) dbmaint.head[`:dontcare/abc.txt]
 q) dbmaint.head[`dontcare`abc.txt]  

.dbmaint.tail0:{[arg;n] / n is number of line
 if[10h=type arg;arg:`$arg];
 if[11h=type arg;arg:`$"/"sv {(),x}@'string arg];
 if[not ":"=first string arg;arg:hsym arg];
 nline:0;mcnt:nread:hcount arg;
 x:{[arg;x] @[;2;{y,x};a+where("x"$"\n")=r] @[;1;:;a] @[x;0;{y,x};] r:read1 (arg;a:max 0,x[1] - 100000;d:min x[1],100000) }[arg]/[{[n;mcnt;x]not (mcnt<=count x 0 ) or n<=-1+count x 2 }[n;mcnt];(();mcnt;0#0)]; 
 (x[2]-x[ 1]) cut "c"$x 0
 / (x 2) cut "c"$x 0
 }

d)fnc dbmaint.dbmaint.tail0 
 Unix tail0 funtion
 q) dbmaint.tail0[10;"dontcare.txt"] 
 q) dbmaint.tail0[10;"dontcare/abc.txt"]
 q) dbmaint.tail0[10;":dontcare/abc.txt"]
 q) dbmaint.tail0[10;`:dontcare/abc.txt]
 q) dbmaint.tail0[10;`dontcare`abc.txt]

.dbmaint.tail:{[arg] .dbmaint.tail0[10;arg]}

d)fnc dbmaint.dbmaint.tail 
 Unix tail0 funtion
 q) dbmaint.tail["dontcare.txt"] / entire folder or file
 q) dbmaint.tail["dontcare/abc.txt"]
 q) dbmaint.tail[":dontcare/abc.txt"]
 q) dbmaint.tail[`:dontcare/abc.txt]
 q) dbmaint.tail[`dontcare`abc.txt]


.dbmaint.partition:{[arg;storage;data]
 storage:(`mode`partAttrCol`sortCol!```),storage;
 data:.Q.ens[arg`dir;data;arg`symFile];
 data1:0!(storage`partitionCol) xgroup data;
 raze .dbmaint.partition0[arg;storage]@'data1
 }

.dbmaint.partition0:{[arg;storage;data2]
 storage[`path]:.Q.dd[arg`dir;(data2 storage`partitionCol),arg`tblName];
 if[`replace=storage`mode;.dbmaint.rm storage`path];
 k:key data3:(storage`partitionCol)_data2;
 k1:(storage[`partAttrCol`sortCol] except `) inter k ;
 if[0<count k1; ind:exec ind from k1 xasc update ind:i from flip k1!{[arg;storage;data2;k2] @[get;.Q.dd[storage`path;k2];()],data2 k2}[arg;storage;data2]@'k1];
 if[0=count k1; ind:til @[{count get x};.Q.dd[storage`path;k 0];0] +count data2 k 0];
 if[storage[`partAttrCol] in k; (p,arg`gz) set `p#(@[get;p:.Q.dd[storage`path;storage`partAttrCol];()],data3[storage`partAttrCol]) ind;];
 .Q.dd[storage`path;`.d] set k;
 .Q.dd[storage`path;`.d],{[arg;storage;ind;data2;k0] (p,arg`gz) set @[get;p:.Q.dd[storage`path;k0];()],data2 k0 }[arg;storage;ind;data2]@'k except storage`partAttrCol 
 }

.dbmaint.splayed:{[arg;storage;data]
 storage:(`mode`partitionCol`partAttrCol`sortCol!````),storage;
 data:.Q.ens[arg`dir;data;arg`symFile];
 if[not null storage`partitionCol;data1:0!(storage`partitionCol) xgroup data;];
 if[null storage`partitionCol;data1:enlist flip data;]; 
 raze .dbmaint.splayed0[arg;storage]@'data1
 }

.dbmaint.splayed0:{[arg;storage;data2]
 if[null storage`partitionCol;storage[`path]:.Q.dd[arg`dir] arg`tblName ;];
 if[not null storage`partitionCol;storage[`path]:.Q.dd[arg`dir] arg[`tblName],data2 storage`partitionCol ;]; 
 if[`replace=storage`mode;.dbmaint.rm storage`path];
 k:key data3:(storage`partitionCol)_data2;
 k1:(storage[`partAttrCol`sortCol] except `) inter k ;
 if[0<count k1; ind:exec ind from k1 xasc update ind:i from flip k1!{[arg;storage;data2;k2] @[get;.Q.dd[storage`path;k2];()],data2 k2}[arg;storage;data2]@'k1];
 if[0=count k1; ind:til @[{count get x};.Q.dd[storage`path;k 0];0] +count data2 k 0];
 if[storage[`partAttrCol] in k; (p,arg`gz) set `p#(@[get;p:.Q.dd[storage`path;storage`partAttrCol];()],data3[storage`partAttrCol]) ind;];
 .Q.dd[storage`path;`.d] set k;
 .Q.dd[storage`path;`.d],{[arg;storage;ind;data2;k0] (p,arg`gz) set @[get;p:.Q.dd[storage`path;k0];()],data2 k0 }[arg;storage;ind;data2]@'k except storage`partAttrCol 
 }

.dbmaint.flat:{[arg;storage;data]
 storage:(`mode`partitionCol`partAttrCol`sortCol!````),storage;
 data:.Q.ens[arg`dir;data;arg`symFile];
 if[not null storage`partitionCol;data1:0!(storage`partitionCol) xgroup data;];
 if[null storage`partitionCol;data1:enlist flip data;]; 
 raze .dbmaint.flat0[arg;storage]@'data1
 }

.dbmaint.flat0:{[arg;storage;data2]
 if[null storage`partitionCol;storage[`path]:.Q.dd[arg`dir] arg`tblName ;];
 if[not null storage`partitionCol;storage[`path]:.Q.dd[arg`dir] arg[`tblName],data2 storage`partitionCol ;]; 
 if[`replace=storage`mode;.dbmaint.rm storage`path];
 k:key data3:(storage`partitionCol)_data2;
 data4:flip data3;
 if[not ()~key storage`path;  data4:data4,get storage`path ];
 k1:(storage[`partAttrCol`sortCol] except `) inter k ;
 if[0<count k1; data4:k1 xasc data4];
 if[storage[`partAttrCol] in k; data4:![data4;();0b;(1#storage[`partAttrCol])!enlist (`p#;storage[`partAttrCol])] ];
 (storage[`path],arg`gz) set data4
 }

.dbmaint.par:{[arg;storage;data]
 storage:(`mode`partAttrCol`sortCol!```),storage;
 data:.Q.ens[arg`dir;data;arg`symFile];
 data1:0!(storage`partitionCol) xgroup data;
 raze .dbmaint.par0[arg;storage]@'data1
 }

.dbmaint.par0:{[arg;storage;data2]
 if[not":"=first string storage`dir; storage[`dir] : hsym storage`dir];
 storage[`path]:.Q.dd[storage`dir;(data2 storage`partitionCol),arg`tblName];
 if[`replace=storage`mode;.dbmaint.rm storage`path];
 k:key data3:(storage`partitionCol)_data2;
 k1:(storage[`partAttrCol`sortCol] except `) inter k ;
 if[0<count k1; ind:exec ind from k1 xasc update ind:i from flip k1!{[arg;storage;data2;k2] @[get;.Q.dd[storage`path;k2];()],data2 k2}[arg;storage;data2]@'k1];
 if[0=count k1; ind:til @[{count get x};.Q.dd[storage`path;k 0];0] +count data2 k 0];
 if[storage[`partAttrCol] in k; (p,arg`gz) set `p#(@[get;p:.Q.dd[storage`path;storage`partAttrCol];()],data3[storage`partAttrCol]) ind;];
 .Q.dd[storage`path;`.d] set k;
 r0:.Q.dd[storage`path;`.d],{[arg;storage;ind;data2;k0] (p,arg`gz)set @[get;p:.Q.dd[storage`path;k0];()],data2 k0 }[arg;storage;ind;data2]@'k except storage`partAttrCol;
 if[not p~key p:.Q.dd[arg`dir;`par.txt];p 0:();];
 if[not(`$s:1_string storage[`dir]) in `$r:read0 p;p 0: r,enlist s];
 r0
 }

.dbmaint.save:{[arg;data]
 if[not 99h=type arg;:(`dir`tblName`symFile`gz!`:demo1`demoTbl`sym,enlist 17 2 6),.bt.md[`storage]`type`mode`partitionCol`partAttrCol`sortCol!`partition`auto`date`sym`time];
 if[not all `dir`tblName`storage in key arg;'`.dbmaint.save.missing_arg ];
 if[not arg[`storage;`type] in  `partition`splayed`flat`par;'`.dbmaint.save.wrong_arg ];
 arg:(`symFile`gz!(`sym;17 2 6)),arg;
 if[10h = abs type arg`dir;arg:@[arg;`dir;`$]];
 if[not ":"=first string arg`dir;arg:@[arg;`dir;{`$":",string x}]];
 .dbmaint[arg[`storage]`type][arg;storage:arg`storage;data]
 } 

d)fnc dbmaint.dbmaint.save 
 Unix tail0 funtion
 q) (::)data:trade:`date`sym`time xasc([]date:10?.z.D + til 3; time:10?.z.T;sym:10?`aaa`bbb`ccc;prx:10?100.0;qty:10?100)
 q) (::)arg:`dir`tblName`symFile`gz!`db1`trade`sym,enlist 17 0 6
 q) arg:arg,.bt.md[`storage]`type`mode`partitionCol`partAttrCol`sortCol!`partition`auto`date`sym`time    / partition
 q) .dbmaint.save[arg]data
 q) (::)arg:`dir`tblName`symFile`gz!`:db2`trade`sym,enlist 17 0 6
 q) arg:arg,.bt.md[`storage] storage:`type`mode`partitionCol`partAttrCol`sortCol!`splay`auto`date`sym`time      / splayed
 q) .dbmaint.save[arg]data
 q) (::)arg:`dir`tblName`symFile`gz!`:db3`obk`sym,enlist 17 0 6
 q) arg:arg,.bt.md[`storage] storage:`type`mode`partAttrCol`sortCol!`flat`auto`sym`time                           / flat
 q) .dbmaint.save[arg]data
 q) (::)arg:`dir`tblName`symFile`gz!`:db1`trade`sym,enlist 17 0 6
 q) (::)arg:arg,.bt.md[`storage]storage:`type`mode`dir`partitionCol`partAttrCol`sortCol!`par`auto`:db2`date`sym`time /
 q) .dbmaint.save[arg]data


.dbmaint.sortOnly:{[arg;data0]
 if[not 99h=type arg;:(`dir`tblName`symFile`gz!`:demo1`demoTbl`sym,enlist 17 2 6),.bt.md[`storage]`type`mode`partitionCol`partAttrCol`sortCol!`partition`auto`date`sym`time];
 if[not all `dir`tblName`storage in key arg;'`.dbmaint.sortOnly.missing_arg ];
 if[not arg[`storage;`type] in  `partition`splayed`flat`par;'`.dbmaint.sortOnly.wrong_arg ];
 arg:(`symFile`gz!(`sym;17 2 6)),arg;
 if[10h = abs type arg`dir;arg:@[arg;`dir;`$]];
 if[not ":"=first string arg`dir;arg:@[arg;`dir;{`$":",string x}]];	
 .dbmaint.sort[arg[`storage]`type][arg;storage:arg`storage;data0]
 }

d)fnc dbmaint.dbmaint.sortOnly 
 Unix tail0 funtion
 q) (::)arg:`dir`tblName`symFile`partitionCol`partAttrCol`sortCol`gz!(`:db2;`trade;`sym;`date;`sym;`time;17 2 6)
 q) .dbmaint.sortOnly[arg] key select by date from data

.dbmaint.sort.partition:{[arg;storage;data0]
 if[any not`partitionCol`partAttrCol in key storage;'`.dbmaint.sort.partition];
 data1:distinct ?[data0;();1b;(1#storage`partitionCol)!(1#storage`partitionCol)];
 raze .dbmaint.sort.partition0[arg;storage]@'data1 
 }

.dbmaint.sort.partition0:{[arg;storage;data2]
 storage[`path]:.Q.dd[arg`dir;(data2 storage`partitionCol),arg`tblName];
 k:exec c from meta storage`path;
 k1:(storage[`partAttrCol`sortCol] except `) inter k ;
 ind:exec ind from k1 xasc update ind:i from flip k1!{[arg;storage;k2] @[get;.Q.dd[storage`path;k2];()]}[arg;storage]@'k1;
 (p,arg`gz) set `p#@[get;p:.Q.dd[storage`path;storage`partAttrCol];()] ind;
 {[arg;storage;ind;k0] (p,arg`gz) set @[get;p:.Q.dd[storage`path;k0];()] }[arg;storage;ind]@'k except storage`partAttrCol 
 }

.dbmaint.sort.splay:{[arg;storage;data0]
 if[not`partAttrCol in key storage;'`.dbmaint.sort.partition.missing_arg];	
 storage:(`partitionCol`sortCol!``),storage;
 if[not null storage`partitionCol;data1:distinct?[data0;();1b;(1#storage`partitionCol)!(1#storage`partitionCol)];];
 if[null storage`partitionCol;data1:`;]; 
 raze .dbmaint.sort.splay0[arg;storage]@'data0
 }

.dbmaint.sort.splay0:{[arg;storage;data2]
 if[null storage`partitionCol;storage[`path]:.Q.dd[arg`dir] arg`tblName ;];
 if[not null storage`partitionCol;storage[`path]:.Q.dd[arg`dir] arg[`tblName],data2 storage`partitionCol ;]; 
 k:exec c from meta storage`path;
 k1:(storage[`partAttrCol`sortCol] except `) inter k ;
 ind:exec ind from k1 xasc update ind:i from flip k1!{[arg;storage;k2] @[get;.Q.dd[storage`path;k2];()]}[arg;storage]@'k1;
 (p,arg`gz) set `p#@[get;p:.Q.dd[storage`path;storage`partAttrCol];()] ind;
 {[arg;storage;ind;k0] (p,arg`gz) set @[get;p:.Q.dd[storage`path;k0];()] }[arg;storage;ind]@'k except storage`partAttrCol 
 }

.dbmaint.sort.flat:{[arg;storage;data0]
 if[not`partAttrCol in key storage;'`.dbmaint.sort.flat.missing_arg];		
 storage:(`partAttrCol`sortCol!``),storage;
 if[not null storage`partitionCol;data1:distinct?[data0;();1b;(1#storage`partitionCol)!(1#storage`partitionCol)];];
 if[null storage`partitionCol;data1:`;]; 
 raze .dbmaint.sort.flat0[arg;storage]@'data1
 }

.dbmaint.sort.flat0:{[arg;storage;data2]
 if[null storage`partitionCol;storage[`path]:.Q.dd[arg`dir] arg`tblName ;];
 if[not null storage`partitionCol;storage[`path]:.Q.dd[arg`dir] arg[`tblName],data2 storage`partitionCol ;]; 
 k:exec c from meta data4:get storage`path;
 k1:(storage[`partAttrCol`sortCol] except `) inter k ;
 data4:k1 xasc data4;
 if[storage[`partAttrCol] in k; data4:![data4;();0b;(1#storage[`partAttrCol])!enlist (`p#;storage[`partAttrCol])] ];
 (storage[`path],arg`gz) set data4
 }

.dbmaint.sort.par:{[arg;storage;data0]
 storage:((1#`partAttrCol)!1#`),storage;
 data1:distinct?[data0;();1b;(1#storage`partitionCol)!(1#storage`partitionCol)];
 raze .dbmaint.sort.par0[arg;storage]@'data1
 }

.dbmaint.sort.par0:{[arg;storage;data2]
 if[not":"=first string storage`dir; storage[`dir] : hsym storage`dir];
 storage[`path]:.Q.dd[storage`dir;(data2 storage`partitionCol),arg`tblName];
 k:exec c from meta storage`path;
 k1:(storage[`partAttrCol`sortCol] except `) inter k ;
 ind:exec ind from k1 xasc update ind:i from flip k1!{[arg;storage;k2] @[get;.Q.dd[storage`path;k2];()] }[arg;storage]@'k1;
 (p,arg`gz) set `p#@[get;p:.Q.dd[storage`path;storage`partAttrCol];()] ind;
 {[arg;storage;ind;k0] (p,arg`gz)set @[get;p:.Q.dd[storage`path;k0];()] }[arg;storage;ind]@'k except storage`partAttrCol
 }
