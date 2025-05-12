
d) lib btick2.util 
 util provides a set of functions that help you to manipulate tables. 
 q).import.module`util

.util.summary:{ .bt.showTrace }

d) fnc btick2.util.summary
 show configured std.out
 q) .util.summary[]

.util.setOutputTrace:{ if[not 11h = abs type x;:.bt.showTrace ]; .bt.showTrace:x; .bt.showTrace}

d) fnc btick2.util.setOutputTrace
 show configured std.out
 q) .util.setOutputTrace `rlang


.util.parsec:{ if[max("";" ")~\:x;:()];if[not 10h=type x;:x]; raze parse["select from t where ", x]2}

d) fnc btick2.util.parsec
 return the where column from a select statement
 q) .util.parsec "not null a, b=`h"

.util.parseb:{ if[not 10h=type x;:x];if[max (1b;"")~\:x;:1b]; parse["select by ",x," from t"]3}

d) fnc btick2.util.parseb
 return the by column from a select statement
 q) .util.parseb "not null a, tmp:b=`h"

.util.parsea:{ if[not 10h=type x;:x];if[""~x;:()!()]; parse["select ",x," from t"]4}

.util.parseda:{ if[not 10h=type x;:x];if[""~x;:()!()]; first parse["delete ",x," from t"]4}


d) fnc btick2.util.parsea
 return the select column from a select statement
 q) .util.parsea "not null a, tmp:b=`h"

.util.croot:{enlist[`]!enlist x}
.util.cinit:{([] sym:key x; v:value x) }

.util.untree:{
 r:raze{
  if[not 99h = type x`v;:enlist x];
  if[ 98h = type key x`v;:enlist x];
  (@[x;`v;:;::] ),([]sym: x[`sym] ,/: key x`v;v:value x`v)
 }@'x;
 delete from r where v~\:(::)
 }

.util.ctable:{
 a:.util.untree over .util.cinit .util.croot x;
 c:update sym:{1_ x}@'sym from delete from a where v~\:(::) 
 }


.util.ctablen:{[n;x]
 a:.util.untree/[n;] .util.cinit .util.croot x;
 c:update sym:{1_ x}@'sym from delete from a where v~\:(::) 
 }


.util.stable:{
 a:.util.untree over .util.cinit .util.croot x;
 c:update sym:{ ` sv 1_` vs x}@'sym from delete from a where v~\:(::)
 }

.util.tree0:{
 a:select from x where {x=max x:count@'x}sym;
 b:select from x where not {x=max x:count@'x}sym; 
 b,0!select v:raze v by sym from update sym:-1_/:sym,v:sym{ (-1 # x)!enlist y }'v from a
 }

.util.tree1:{
 if[1 >= count x;:x];
 a:select from x where {x=max x:count@'x}sym;
 b:select from x where not {x=max x:count@'x}sym; 
 b,0!select v:raze v by sym from update sym:-1_/:sym,v:sym{ (-1 # x)!enlist y }'v from a
 } 

.util.cdict:{
 r:.util.tree1 over  .util.tree0 x;
 if[not r[0;`sym] ~ 0#`; :r[0;`sym]!enlist r[0;`v] ];
 r[0;`v]
 }

.util.deepMerge:{[default;arg]
 .util.cdict delete mode from 0!select by sym from (update mode:`default from .util.ctable default),update mode:`arg from .util.ctable arg
 }

d) fnc btick2.util.deepMerge
 Function to merge two different dictionaries
 q) default:`a`b`c!(1;2;`a`b`c! (6 ; `a`b`c!5 6 7 ;8))
 q) arg:`b`c!(2;`a`b`c! (6 ; `b`c!6 7 ;18))
 q) .util.deepMerge[default]arg
 q) `a`b`c!(1j;2j;`a`c`b!(6j;18j;`a`b`c!5 6 7j))
 q) .util.deepMerge[()!()](1#`a`b)!1#1 2


.util.sleep0:()!()
/.util.sleep0[1b]:{system .bt.print["timeout %0 /nobreak"] enlist x; }
.util.sleep0["w"]:{system .bt.print["sleep %0"] enlist x; }
.util.sleep0["l"]:{system .bt.print["sleep %0"] enlist x; }

.util.sleep:{[secs] .util.sleep0[.self.os] secs }

.util.pwd0:()!()
.util.pwd0["l"]:{`$system"cd" }
.util.pwd0["w"]:{`$system"pwd" }

.util.pwd:{ .util.pwd0[.self.os][] }

.util.radnomSeed:{[x]
 seed:enlist sum "J"$9 cut reverse string .z.i + "j"$.z.P;
 if[-314159i~oseed:system"S";:system .bt.print["S %0"]seed];
 if[x~`reset;:system .bt.print["S %0"]seed];
 oseed
 }

d) fnc btick2.util.radnomSeed
 Function to set random seed
 q) .util.radnomSeed[] \ set random seed if it is not already set
 q) .util.radnomSeed[`reset] \reset the random seed

.util.posArg0:{[name;p;default;lst] enlist[(`posArg0;name;p;default)],$[not all 10h=type @'lst;lst;enlist lst] }
.util.optArg0:{[name;p;default;lst] enlist[(`optArg0;name;p;default)],$[not all 10h=type @'lst;lst;enlist lst] }

.util.arg:{[allArgs] 
 t:update pos:i from([]args: -1_allArgs);
 t:update mode:args[;0] from t;
 t:update name:args[;1] from t;
 t:update trans:{r:x 2;$[type[r] in -10 -11h;r$;r]}@'args from t;
 / t:update default:count[i]#{} from t where mode=`posArg0;
 / t:update default:{x 3}@'args from t where not mode=`posArg0;
 t:update default:{x 3}@'args from t;
 t:update print:count[i]#enlist "%name%" from t where mode=`posArg0;
 t:update print:count[i]#enlist "--%name% %default%" from t where not mode=`posArg0; 
 args:last allArgs;
 optArgs:args optInd:0 1 +/:where "-"=args[;0];
 optArgs:{(`$1_/:x)!y} .  $[0=count optArgs;(();());flip optArgs];
 posArgs:args til[ count args] except raze optInd;
 / if[not (count posArgs) = count select from t where mode=`posArg0;'`$" "sv (1#"q";string .z.f),{.bt.print[x`print ]x }@'t];
 t:update default:{[x;y]x y}'[trans;optArgs name] from t where name in key optArgs;
 t:update default:{[x;y]x y}'[trans;posArgs] from t where {[cnt;w]  w and @[count[w]#0b;;:;1b] cnt#where w}[count posArgs]  mode=`posArg0 ;
 exec name!default from t
 }

d) fnc btick2.util.arg
 Function to parse argument
 q) allArgs:
       .util.arg
       .util.posArg0[`pos1;`;`nopos1]
       .util.posArg0[`pos2;"F";3.0]
       .util.optArg0[`opt0;`;`noOpt0] 
       .util.optArg0[`opt1;`;`noOpt1] ("arg0";"-opt0";"opt0";"2.0";"-opt1";"opt1")
 q) allArgs:
       .util.arg
       .util.posArg0[`pos1;`;`nopos1]
       .util.posArg0[`pos2;"F";5.0]
       .util.optArg0[`opt0;`;`noOpt0] 
       .util.optArg0[`opt1;`;`noOpt1] ("arg0";"-opt0";"opt0";"2.0")       
 q) allArgs:
       .util.arg
       .util.posArg0[`pos1;`;`nopos1]
       .util.posArg0[`pos2;"F";3.0]
       .util.optArg0[`opt0;`;`noOpt0] 
       .util.optArg0[`opt1;`;`noOpt1] ("arg0";"-opt0";"opt0";"-opt1";"opt1")



/ .util.seed:sum "J"$9 cut reverse string .z.i + "j"$.z.P

.util.setSeed:{[x] system .bt.print["S %0"] x;system"S"}

d) fnc btick2.util.setSeed
 Function to show the path of the json file
 q) .util.setSeed 1132664680

.util.setRandomSeed:{
 if[type[x]in -6 -7h;:.util.setSeed x];
 if[not -314159i~oldSeed:system"S";:oldSeed];
 .util.setSeed sum "J"$9 cut reverse string .z.i + "j"$.z.P
 }

d) fnc btick2.util.setRandomSeed
 Function to set the random seed. It will ignore if a seed exists.
 q) .util.setRandomSeed[]

.util.guid:{[x]x?0ng }

d) fnc btick2.util.guid
 Function to get guid
 q) .util.guid 3

.util.guid0:{ first .util.guid 1 }

d) fnc btick2.util.guid0
 Function to get one guid as atom
 q) .util.guid0 []


.util.genTmpFolder:{[arg]
 if[max arg~/:(`;::);arg:()!()]; / show which file has been loaded
 if[not 99h=type arg;arg:()!()]; / show which file has been loaded 
 arg:(.bt.md[`uid]8?.Q.an),arg;
 arg:arg,.bt.md[`tmpPath]first(.bt.print["%home%\\AppData\\Local\\Temp"] .self;"/tmp")where"wl"=.self.os;
 arg:arg,.bt.md[`path] .bt.print["%tmpPath%/%uid%"]arg;
 arg
 }

d) fnc btick2.util.genTmpFolder
 Generate a path for tmp folder. This will not generate the actual folder 
 q) .util.genTmpFolder []
 q) .util.genTmpFolder .bt.md[`uid] "asdwerfd" / you can also provide your own uid


.util.windowSize:{ reverse lst where not null lst:"J"$ " " vs system["powershell -command \"&{(get-host).ui.rawui.WindowSize;}\""] 3}

d) fnc btick2.util.windowSize
 Function to get windows size
 q) .util.windowSize[] \ set random seed


.util.pcmd:{[x] a1:`;a2:`;x:first r:"||" vs x;
 if[2=count r;
  s:"~~" vs r 1;
  a1:`$s 0;
  if[2=count s;a2:`$s 1];
 ];
 s:"~~" vs x;
 if[2=count s; a2:`$s 1];
 `cmd`a1`a2!(s 0;a1;a2)   
 }

d) fnc btick2.util.pcmd
 Function to parse command in embedded language
 q) .util.pcmd "str " 
 q) .util.pcmd "str || a1 " 
 q) .util.pcmd "str || a1 ~~  a2" 
 q) .util.pcmd "str || ~~  a2" 



