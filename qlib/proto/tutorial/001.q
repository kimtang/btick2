args:.Q.def[`name`port!("proto/tutorial/001.q";9089);].Q.opt .z.x

/ remove this line when using in production
/ proto/tutorial/001.q:localhost:9089::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9089"; } @[hopen;`:localhost:9089;0];

\l qlib.q

.import.require`proto

.proto.operator0
.proto.atom0

(::).proto.con:flip`stime`etime`dtime`expression`result!()

.proto.eval1:{[x] stime:.z.P; result:0 x;etime:.z.P;`.proto.con insert `stime`etime`dtime`expression`result!(stime;etime;etime - stime;x;result); result }

.proto.unp .proto.con [0]`expression
"{ norm sum {(enlist sum x) ! enlist prd y}'[key r;value r:x cross y] }[(,0)!,3;(,0)!,7]"

cns:{(til count r)!"J"$'r:reverse string x}
pnum:{(x+key y)!value y}
norm:{{sum pnum'[key x;cns@'value x]}/[x]}
plus:{norm x + y}
multiply:{ norm sum {(enlist sum x) ! enlist prd y}'[key r;value r:x cross y] }
return:{r:raze string 0^x(reverse til 1+max key x);e:@[parse;r;r];if[10h~type e;:e];$[e<0wj;e;r] }
(::)a:.proto.adefine[`float;cns] .proto.adefine[`long;cns]()!()
(::)o:.proto.odefine[`Return;return] .proto.odefine[`Plus;plus] .proto.odefine[`Multiply;multiply]()!()
p:.proto.proto[a;o]
p[{1+2*x}][1]
p[{b:a+x*2 + a:3*y;z+b+1}] . 1 7 8
p[{[a;b;c;d]b:c*a+a*2 + a:3*b;d+b+1}][1;2;3;4]
p[{2*1+x+y}][0wj - 1;0]