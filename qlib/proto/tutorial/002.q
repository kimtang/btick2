args:.Q.def[`name`port!("proto/tutorial/002.q";9090);].Q.opt .z.x

/ remove this line when using in production
/ proto/tutorial/002.q:localhost:9090::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9090"; } @[hopen;`:localhost:9090;0];

\l qlib.q

.import.require`proto

(::)o1:.proto.odefine[`Plus;{[x;y] (x[0]+y[0];x[1]+y[1])}]
  .proto.odefine[`Hyphen;{[x;y](x[0]-y[0];x[1]-y[1])}]
  .proto.odefine[`Multiply;{[x;y]enlist[x[0]*y[0];] (x[0]*y[1])+x[1]*y[0]}]
  .proto.odefine[`Log;{[x]enlist[log x[0];]x[1] % x[0] }]
  .proto.odefine[`Sin;{[x]enlist[sin x[0];] x[1]*cos x[0] }]
  .proto.odefine[`Cos;{[x]enlist[cos x[0];] x[1]*neg sin x[0]}]
  .proto.odefine[`Procenttecken;{[x;y] enlist[x[0]%y[0];] ((x[1]*y[0]) - x[0]*y[1]) % y[0]*y[0] }]
  .proto.odefine[`Exp;{[x] enlist[exp x[0];] x[1]*exp x[0] }]
  .proto.odefine[`Xexp;{[x;y] enlist[x[0] xexp y[0];] x[1] *y[0]* x[0] xexp -1+y[0] }]
  .proto.odefine[`Sqrt;{[x] enlist[sqrt x[0];] x[1] % 2f * sqrt x[0] }]    
  .proto.odefine[`const;{[x] enlist[ x[0];] 0f }]
  .proto.nil  

(::)a1:{[x;y] y x } over enlist[ .proto.nil], .proto.adefine[;{enlist,(x;0f)}]@' `float`long`int`real
(::)a2:{[x;y] y x } over enlist[ .proto.nil], .proto.adefine[;{(x;0f)}]@' `float`long`int`real


f:{[x1;x2]((1 - x1) xexp 2) + 100*(x2 - x1*x1) xexp  2}
g1:.proto.proton[a1;o1;f]
g2:.proto.proto[a2;o1;f]

\t:100 g1[(0.4 ; 1 0);(0.4 ; 0 1)]
\t:100 g2[(0.4 ; 1 0);(0.4 ; 0 1)]


g1:.proto.proton[a1;o1;f[0.3]]
g2:.proto.proto[a2;o1;f[0.3]]

\t:100 g1[(0.4 ; 1)]
\t:100 g2[(0.4 ; 1)]





