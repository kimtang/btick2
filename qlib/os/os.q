
d)lib btick2.os 
 Library for working with the os
 q).import.module`os 
 q).import.module`btick2.os
 q).import.module"btick2/qlib/os/os.q"

.os.treeIgnore:{[ignore;x]
 if[10h =  abs type x;x:`$x];
 t:enlist `sym`parent`child`fullPath!(x;0;0;x);
 if[11h=abs type ignore;ignore:string ignore];
 if[10h=type ignore;ignore:enlist ignore]; 
 raze .os.treeIgnore0[ignore] scan t
 } 

d)fnc btick2.os.treeIgnore 
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

d)fnc btick2.os.tree
 return all available files & folders in the root directory
 q) .os.tree `:. / show all files and folder in the current directory
 q) .os.tree `:anyFolder

.os.treeIgnoren:{[ignore;n;x]
 if[10h =  abs type x;x:`$x];
 t:enlist `sym`parent`child`fullPath!(x;0;0;x);
 if[11h=abs type ignore;ignore:string ignore];
 if[10h=type ignore;ignore:enlist ignore];  
 raze (.os.treeIgnore0[ignore])\[n;t]
 } 

.os.treen:.os.treeIgnoren[1#`]

d)fnc btick2.os.treen
 return all available files & folders up to level n
 q) .os.treen[2]`:. / show all files and folder in the current directory
 q) .os.treen[2]`:anyFolder
