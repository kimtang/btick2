
d)lib btick2.rlang 
 Library for working with the lib rlang
 q).import.module`rlang 
 q).import.module`btick2.rlang
 q).import.module"%btick2%/qlib/rlang/rlang.q"

.rlang.summary:{ raze { ([]env:x;val:";"vs  getenv x) } @'`PATH`R_HOME}

d) fnc rlang.rlang.summary
 Function to give a sumnmary of the rlang module
 q) .rlang.summary[]
 q) .rlang.summary`

.rlang.setv:{[x]
 {x[`env] setenv x[`val] } @'0!select val:";"sv val by env from x;
 .rlang.summary`
 }

d) fnc rlang.rlang.setv
 Function to setup path to PATH and R_HOME
 q) variable:.rlang.summary[];variable:update val:count[i]#enlist["C:\\Program Files\\R\\R-4.1.3\\bin\\i386"] from variable where val like"*R-4.1.3\\bin\\x64*"  ;.rlang.setv variable;


.rlang.init:{
 .rlang.dll:`$.bt.print[":%btick2%/qlib/rlang/r/rserver/%zo%/rserver"] .self;
 .rlang.rclose: .rlang.dll 2:(`rclose;1);
 .rlang.ropen:  .rlang.dll  2:(`ropen;1);
 .rlang.rcmd:   .rlang.dll   2:(`rcmd;1);
 .rlang.rget0:   .rlang.dll   2:(`rget;1);
 .rlang.rset0:  .rlang.dll   2:(`rset;2);
 .rlang.nsc:"kdb.";
 .rlang.i:0; / index to store the anonymous variable
 .rlang.s:.z.o;
 .rlang.calc:1b;
 if[not `.rlang.ts in  exec arg[;0] from .bt.tme where null runAt,-11h = type@'arg[;0];.bt.action[`.rlang.ts] ()!();];
 "r" "library(ggplot2)";
 "r" "Sys.setenv(TZ='GMT')";
 "r" ssr[;"\\";"/"] .bt.print["source('%btick2%/qlib/rlang/ggplot2_formatter.r')"] .self;
 }

d) fnc rlang.rlang.init
 Function to init r
 q) .rlang.init[]
 r) plot(c(1,2,3,4))
 p) c(1,2,3,4)


.bt.add[``.rlang.ts;`.rlang.ts]{.rlang.Rts[]};
.bt.addDelay[`.rlang.ts]{`tipe`time!(`in;00:00:00.400)};

.rlang.Rset_      : ()!()
.rlang.Rset_[1b] : { t:@[value;x;()];t:$[100h=type t ;();t];if[0<count t; .rlang.rset0[string x;t] ]; :x} / for symbol
.rlang.Rset_[0b] : { .rlang.rset0[n:.rlang.nsc,string .rlang.i;x];.rlang.i+:1; :`$n } / for non-symbol



.rlang.Rset: {x:$[10h=abs type x;`$x;x];:{ .rlang.Rset_[-11h=type x] x}each x }

d) fnc rlang.rlang.Rset
 Function to set the variable
 q)tmp:([]a:1 2 3 4; b: 5 6 7 8); .rlang.Rset `tmp 
 r) View(tmp)

.rlang.Rset0: {[x;y] .rlang.rset0[x;y] }


d) fnc rlang.rlang.Rset0
 Function to set the variable
 q).rlang.Rset0 [`tmp ] ([]a:1 2 3 4; b: 5 6 7 8)
 r) View(tmp)

.rlang.con:{distinct `$ ssr[;"`";""] each res where {x like "`*"} res:{raze y vs/:x} over enlist[enlist x]," $(,~=<-)"}

.r.e:{ 
 if[not .rlang.calc;:0N!"R turned off"];
 .rlang.Rset t:.rlang.con x;
 .r.r:.rlang.rget0 str:ssr[;"`";""] x;
 .r.r
 }

.u.e:{  .r.e "print(",x,")" }

.rlang.conv:()!()
.rlang.conv[`Date]:{`date$x[1]-10957}
.rlang.conv[`levels]:{ syms: `$x . 0 0; :syms x[1] - 1 }
.rlang.conv[`string]:{ `$x }
.rlang.frame_:()!()

.rlang.frame_[0h]:{r:raze {$[type[x] in (0 10h);`$x; x]} each x 0;
            r:$[10h=type r;`string;r];
            sym:first key[.rlang.conv] inter r;
             .rlang.conv[sym] x}
.rlang.frame_[99h]:{(`$x[0]`levels) -1+x 1 }
.rlang.frame_[0nh]:{x}

.rlang.Rts:{@[.rlang.rcmd;"try(system('dir', intern = FALSE, ignore.stdout = TRUE, ignore.stderr = TRUE))";()]};

.rlang.Rget:{if[-11h=type x;x:string x];x:(),x; .rlang.Rset t:.rlang.con x:$[10h=abs type x;x;string x];.rlang.rget0 ssr[;"`";""] x }

.rlang.Rframe0:{ [t]
    arg:t 0;
    nme:`$arg`names;
    rns:arg`row.names;
    mat:{ .rlang.frame_[ (0 99 0nh!0 99 0nh) type x 0]  x } each t[1];
    rns:$[count[rns]=count first mat; @[(`$);rns;rns];til count first mat];
     /(nme;rns;mat)
     flip ((`$"row_names"),nme)!enlist[rns],mat 
 }


.rlang.Rframe:{  .rlang.Rframe0 .rlang.Rget x }

d) fnc rlang.rlang.Rframe
 Function to set the variable
 q).rlang.Rframe `mpg


/ file:"rlang/ggplot2_formatter.r"
/ repo:`btick2

.rlang.source:{[file;repo]
 if[not repo in key .import.repository.con;'`.rlang.repo.not.exists'];
 arg:`file`repo!(file;.import.repository.con repo);
 cmd:.bt.md[`path] ssr[;"\\";"/"] .bt.print["%repo%/qlib/%file%"] arg;
 "r" ssr[;"\\";"/"] .bt.print["source('%path%')"] cmd;    
 }

d) fnc rlang.rlang.source
 Function to source a file
 q) .rlang.source["rlang/ggplot2_formatter.r";`btsrc]

.rlang.init[]