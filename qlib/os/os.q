
d)lib %btick2%/qlib/os/os.q 
 Library for working with the os
 q).import.module`os 
 q).import.module`btick2.os
 q).import.module"%btick2%/qlib/os/os.q"

.os.treeIgnore:{[ignore;x]
 if[10h = abs type x;x:`$x];
 if[not ":"=first string x;x:hsym x]; 
 t:enlist `sym`parent`child`fullPath!(x;0;0;x);
 if[11h=abs type ignore;ignore:string ignore];
 if[10h=type ignore;ignore:enlist ignore];
 ignore:{if[0=count x;:x];if[not ":"=x 0;:":",x];x}@'ignore;
 raze .os.treeIgnore0[ignore] scan t
 }


d).os.treeIgnore 
 return all available files & folders in the root directory with an ignore list
 q) .os.treeIgnore[1#`abc] `:. / show all files and folder in the current directory and ignore abc folder
 q) .os.treeIgnore[1#`abc] `:anyFolder


.os.treeIgnore0:{[ignore;t]
 s:update ksym:key each fullPath,kparent:child from t;
 mnum:max t`child; 
 s:select from s where not fullPath ~' ksym;
 s:update knum:count@'ksym,kfullPath:fullPath{.Q.dd[x]@/:y}'ksym from s;
 s:update kchild:knum{y + til x}'(1+mnum + 0^prev sums knum ) from s;
 s:cols[t]#ungroup select sym:ksym,parent:kparent,fullPath:kfullPath,child:kchild from s;
 select from s where not max fullPath like/:ignore
 }

.os.tree:.os.treeIgnore[1#`]

d).os.tree
 return all available files & folders in the root directory
 q) .os.tree `:. / show all files and folder in the current directory
 q) .os.tree `:anyFolder

.os.treeIgnoren:{[ignore;n;x]
 if[10h =  abs type x;x:`$x];
 if[not ":"=first string x;x:hsym x]; 
 t:enlist `sym`parent`child`fullPath!(x;0;0;x);
 if[11h=abs type ignore;ignore:string ignore];
 if[10h=type ignore;ignore:enlist ignore];
 ignore:{if[not ":"=first x;:":",x];x}@'ignore;  
 raze (.os.treeIgnore0[ignore])\[n;t]
 } 

.os.treen:.os.treeIgnoren[1#`]

d).os.treen
 return all available files & folders up to level n
 q) .os.treen[2]`:. / show all files and folder in the current directory
 q) .os.treen[2]`:anyFolder


.os.hdel:{[path]
 allFiles:.os.tree path;
 hdel@'reverse allFiles`fullPath
 }

d).os.hdel
 delete the folder together with its contents
 q) .os.hdel`:anyFolder
 q) .os.hdel`anyFolder
 q) .os.hdel"anyFolder"