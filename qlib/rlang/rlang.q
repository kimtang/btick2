
d)lib %btick2%/qlib/rlang/rlang.q 
 Library for working with the lib rlang
 q).import.module`rlang 
 q).import.module`btick2.rlang
 q).import.module"%btick2%/qlib/rlang/rlang.q"

.rlang.summary:{ raze { ([]env:x;val:";"vs  getenv x) } @'`PATH`R_HOME}

d).rlang.summary
 Function to give a sumnmary of the rlang module
 q) .rlang.summary[]
 q) .rlang.summary`

.rlang.setv:{[x]
 {x[`env] setenv x[`val] } @'0!select val:";"sv val by env from x;
 .rlang.summary`
 }

d).rlang.setv
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
 "r" "Sys.setenv(TZ='GMT')";
 .rlang.source"%btick2%/qlib/rlang/ggplot2_formatter.r";
 }

d).rlang.init
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

d).rlang.Rset
 Function to set the variable
 q)tmp:([]a:1 2 3 4; b: 5 6 7 8); .rlang.Rset `tmp 
 r) View(tmp)

.rlang.Rset0: {[x;y] .rlang.rset0[x;y] }


d).rlang.Rset0
 Function to set the variable
 q).rlang.Rset0 [`tmp ] ([]a:1 2 3 4; b: 5 6 7 8)
 r) View(tmp)

.rlang.con:{distinct `$ ssr[;"`";""] each res where {x like "`*"} res:{raze y vs/:x} over enlist[enlist x]," $(,~=<-)"}

.r.default.wd:"pics"
.r.default.width:480
.r.default.height:480
.r.default.pointsize:10


.r.cmd0:()!()

.r.cmd0[`]:{[a]
 .rlang.Rset t:.rlang.con cmd:a`cmd; 
 r:.rlang.rget0 str:ssr[;"`";""] cmd;
 r
 }

.r.cmd0[`print]:{[a] .r.cmd0[`] a,.bt.md[`cmd] .bt.print["print(%cmd%)"]a}
.r.cmd0[`view]:{[a] .r.cmd0[`] a,.bt.md[`cmd] .bt.print["View(%cmd%)"]a}
.r.cmd0[`plot]:{[a] .r.cmd0[`] a,.bt.md[`cmd] .bt.print["plot(%cmd%)"]a}

.r.cmd0[`writeClipboard]:{[a]
 .r.cmd0[`] a,.bt.md[`cmd] .bt.print["tmp.writeClipboard <- %cmd%"]a;
 .r.cmd0[`] a,.bt.md[`cmd] .bt.print["writeClipboard(tmp.writeClipboard)"]a; 
 .r.cmd0[`] a,.bt.md[`cmd] .bt.print["tmp.writeClipboard"]a
 }




.r.cmd0[`ggsave]:{[a]
 .r.default.picPath:hsym`$.r.default.wd;
 if[()~key .r.default.picPath; .Q.dd[.r.default.picPath;`dontcare.txt] 0: ();hdel .Q.dd[.r.default.picPath;`dontcare.txt]];
 a2:(1#`filename)!enlist path:`$.bt.print["%0.png"]  f:-1+min 100,f where not null f:{"J"$ -4_string x }@'f:key .r.default.picPath;
 k:`filename`width`height`units`pointsize`bg!("\"%wd%/%filename%\"";"%width%";"%height%";"\"%units%\"";"%pointsize%";"\"%bg%\"");
 if[not null a`a2;tmp:value string a`a2;if[99h=type tmp;if[`filename in key tmp;a2:tmp];];];
 a2:.r.default,a2;
 k0:key[a2] inter key k;
 cmd:.bt.print["png(%0)"]enlist ","sv k0{string[x],"=",y }'k k0;
 .rlang.rcmd .bt.print[cmd]a2;
 .rlang.Rset t:.rlang.con cmd:.bt.print["plot(%cmd%)"]a; 
 r:.rlang.rget0 str:ssr[;"`";""] cmd;
 .rlang.rcmd "dev.off()";
 arg:.bt.md[`arg].bt.print[.bt.print["{%0}"] enlist ", "sv k0{string[x],"=",y }'k k0:k0 except `filename]a2;
 if[0=count k0;:.bt.print["  /  ![](%wd%/%filename%){width=480, height=480}"]a2];
 :.bt.print["  /  ![](%wd%/%filename%)%arg%"]a2,arg
 }

.r.cmd0[`pic]:{[a]
 .r.default.picPath:hsym`$.r.default.wd;
 if[()~key .r.default.picPath; .Q.dd[.r.default.picPath;`dontcare.txt] 0: ();hdel .Q.dd[.r.default.picPath;`dontcare.txt]];
 a2:(1#`filename)!enlist path:`$.bt.print["%0.png"]  f:-1+min 100,f where not null f:{"J"$ -4_string x }@'f:key .r.default.picPath;
 k:`filename`width`height`units`pointsize`bg!("\"%wd%/%filename%\"";"%width%";"%height%";"\"%units%\"";"%pointsize%";"\"%bg%\"");
 if[not null a`a2;tmp:value string a`a2;if[99h=type tmp;if[`filename in key tmp;a2:tmp];];];
 a2:.r.default,a2;
 k0:key[a2] inter key k;
 cmd:.bt.print["png(%0)"]enlist ","sv k0{string[x],"=",y }'k k0;
 .rlang.rcmd .bt.print[cmd]a2;
 .rlang.Rset t:.rlang.con cmd:a; 
 r:.rlang.rget0 str:ssr[;"`";""] cmd;
 .rlang.rcmd "dev.off()";
 arg:.bt.md[`arg].bt.print[.bt.print["{%0}"] enlist ", "sv k0{string[x],"=",y }'k k0:k0 except `filename]a2;
 if[0=count k0;:.bt.print["  /  ![](%wd%/%filename%){width=480, height=480}"]a2];
 :.bt.print["  /  ![](%wd%/%filename%)%arg%"]a2,arg
 }


.r.e:{
 if[not .rlang.calc;:0N!"R turned off"];
 a:.util.pcmd x;
 r:.r.cmd0[a`a1]a;
 .r.s:r;
 .r.r:@[.rlang.rget;.r.s;.r.s] ;
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


.rlang.t0:()!()
.rlang.t0[`Date]:{[x] `date$x[1]-10957 }
.rlang.t0[`yearweek]:{[x] `date$x[1]-10957 }
.rlang.t0[`yearmonth]:{[x] `date$x[1]-10957 }

.rlang.t0[`noquote]:{[x] x 1 }

/ .rlang.t0[`levels]:{ syms: `$x . 0 0; :syms x[1] - 1 }
.rlang.t0[`string]:{ `$x }

.rlang.t0[`data.frame]:{[x]
 c:(),`$x[0]`names;
 flip c!.rlang.rget @'x[1]
 }

.rlang.t0[`knitr_kable]:{[x] "\n"sv  enlist[1#"/"],x[1],enlist[1#"\\"]} 

/ .rlang.t:key .rlang.t0 / `data.frame`Date`yearweek`yearmonth

.rlang.rget:{[x] if[not (0h=type x) & 2=count x;:@[`$;x;{[x;y]x}[x]]];if[not 99h=type x 0;:x];
 c:(),`$(x0:x 0)`class; c:first c where c in key .rlang.t0;
 .rlang.t0[c] x
 }


.rlang.Rts:{@[.rlang.rcmd;"try(system('dir', intern = FALSE, ignore.stdout = TRUE, ignore.stderr = TRUE))";()]};

.rlang.get:{if[-11h=type x;x:string x];x:(),x; .rlang.Rset t:.rlang.con x:$[10h=abs type x;x;string x];.rlang.rget .rlang.rget0 ssr[;"`";""] x }

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

d).rlang.Rframe
 Function to set the variable
 q).rlang.Rframe `mpg


/ file:"rlang/ggplot2_formatter.r"
/ repo:`btick2

.rlang.source:{[file]
 cmd:.bt.md[`path] ssr[;"\\";"/"] .bt.print[file] .import.repository.con;
 "r" ssr[;"\\";"/"] .bt.print["source('%path%')"] cmd;
 }

d).rlang.source
 Function to source a file
 q) .rlang.source"%btick2%/qlib/rlang/ggplot2_formatter.r"

.rlang.init[]


/


(::)a:.util.pcmd"c(1,2,3) || ggsave ~~ `width`height`pointsize`filename!480 480 10,`01_latency.png"

b)ls ../../pics




.r.cmd0[`ggsave] a

