
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
