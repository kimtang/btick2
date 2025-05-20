args:.Q.def[`name`port!("9_allTest.q";9018);].Q.opt .z.x

/ remove this line when using in production
/ 9_allTest.q:localhost:9018::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9018"; } @[hopen;`:localhost:9018;0];

\l qlib.q

.import.require`qtx.watchTest`remote;
.watchTest.start`proto;

(::)o:.proto.odefine[`Plus;{[x;y](x[0]+y[0];x[1]+y[1])}]
  .proto.odefine[`Hyphen;{[x;y](x[0]-y[0];x[1]-y[1])}]
  .proto.odefine[`Multiply;{[x;y]enlist[x[0]*y[0];] (x[0]*y[1])+x[1]*y[0]}]
  .proto.odefine[`Log;{[x]enlist[log x[0];]x[1] % x[0] }]
  .proto.odefine[`Sin;{[x]enlist[sin x[0];] x[1]*cos x[0] }]
  .proto.odefine[`Cos;{[x]enlist[cos x[0];] x[1]*neg sin x[0]}]
  .proto.odefine[`Procenttecken;{[x;y] enlist[x[0]%y[0];] ((x[1]*y[0]) - x[0]*y[1]) % y[0]*y[0] }]
  .proto.odefine[`Exp;{[x] enlist[exp x[0];] x[1]*exp x[0] }]
  .proto.odefine[`Xexp;{[x;y] enlist[x[0] xexp y[0];] x[1] *y[0]* x[0] xexp -1+y[0] }]
  .proto.nil  

(::)a:{[x;y] y x } over enlist[ .proto.nil], .proto.adefine[;{(x;0f)}]@' `float`long`int`real

(::)g:{[x1;x2] ((x1*x2) + log x1) - sin x2  }

(::).proto.getb[x:g]
(::).proto.getb[g[1.2]]
(::).proto.getb[g[;1.2]]


(::)df:.proto.proto[a;o;g]
(::)df[(1;1 0);(2;0 1)]


(::)df0:.proto.proto[a;o;g[1]]
(::)df0[(2;1)]

(::)df0:.proto.proto[a;o;g[;2]]
(::)df0[(1;1)]


get hsym `$.import.cpath"%btick2%/qlib/proto/testData/proto2/5"

/

select from .bt.history where action = `.watchTest.watch.test.no_error