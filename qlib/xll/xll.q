
d)lib %btick2%/qlib/xll/xll.q
 Library for working with the lib xll
 q).import.module`xll 
 q).import.module`btick2.xll
 q).import.module"btick2/qlib/xll/xll.q"

.xll.summary:{} 

d).xll.summary 
 Give a summary of this function
 q) xll.summary[] 


.xll.bcmd:{[num;x](min (`long$num),count r) #r:`$ "b" string x}
.xll.exec:{[fnc;arg] if[10h=type fnc;fnc:`$fnc]; farg:.bt.getArg fnc; fnc . arg farg}
.xll.qthrow:{[a1;a2] .remote.qthrow[a1;string a2] }