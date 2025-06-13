
d)lib %btick2%/qlib/qlang/qlang.q 
 Library for working with the lib qlang
 q).import.module`qlang 
 q).import.module`btick2.qlang
 q).import.module"%btick2%/qlib/qlang/qlang.q"

.qlang.summary:{} 

d).qlang.summary 
 Give a summary of this function
 q) qlang.summary[] 


.qlang.zeros:(0b;"G"$"";0x00;0h;0i;0j;0e;0f;" ";`;0p;`month$0;`date$0;`datetime$0;`timespan$0;`minute$0;`second$0;`time$0;`)
.qlang.ones:(1b;"G"$"";0x01;0h;1i;1j;1e;1f;" ";`;1p;`month$1;`date$1;`datetime$1;`timespan$1;`minute$1;`second$1;`time$1;`)

.qlang.atoms:{
 atoms:update ind:neg "h"$i from ([]t:.Q.t);
 atoms:select from atoms where not null t;
 atoms:update k:{key x$()}@'t from atoms;
 atoms:update n:{first x$()}@'t from atoms;
 atoms:update z:.qlang.zeros from atoms;
 atoms:update e:.qlang.ones from atoms;
 :atoms
 }[]
