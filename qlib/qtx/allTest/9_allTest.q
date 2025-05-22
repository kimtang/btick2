args:.Q.def[`name`port!("9_allTest.q";9018);].Q.opt .z.x

/ remove this line when using in production
/ 9_allTest.q:localhost:9018::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9018"; } @[hopen;`:localhost:9018;0];

\l qlib.q

.import.require`qtx.watchTest`remote;
.watchTest.start`proto`adf;


f:{[x1;x2]((1 - x1) xexp 2) + 100*(x2 - x1*x1) xexp .adf.const2 2};
dforward:.adf.forward f;
dforward[0.4;0.4]
dbackward:.adf.backward f;
dbackward[0.4;0.4]
pforward1:.adf.forward f[0.4];
pforward2:.adf.forward f[;0.4];
pbackward1:.adf.backward f[0.4];
pbackward2:.adf.backward f[;0.4];



g:{[x1;x2]((1 - x1) xexp 2) + 100*(x2 - x1*x1) xexp const 2};



(::)o:.proto.odefine[`Plus;{[x;y](x[0]+y[0];x[1]+y[1])}]
  .proto.odefine[`Hyphen;{[x;y](x[0]-y[0];x[1]-y[1])}]
  .proto.odefine[`Multiply;{[x;y]enlist[x[0]*y[0];] (x[0]*y[1])+x[1]*y[0]}]
  .proto.odefine[`Log;{[x]enlist[log x[0];]x[1] % x[0] }]
  .proto.odefine[`Sin;{[x]enlist[sin x[0];] x[1]*cos x[0] }]
  .proto.odefine[`Cos;{[x]enlist[cos x[0];] x[1]*neg sin x[0]}]
  .proto.odefine[`Procenttecken;{[x;y] enlist[x[0]%y[0];] ((x[1]*y[0]) - x[0]*y[1]) % y[0]*y[0] }]
  .proto.odefine[`Exp;{[x] enlist[exp x[0];] x[1]*exp x[0] }]
  .proto.odefine[`Xexp;{[x;y] enlist[x[0] xexp y[0];] x[1] *y[0]* x[0] xexp -1+y[0] }]
  .proto.odefine[`const;{[x] 0N!enlist[ x[0];] 0f }]
  .proto.nil  

(::)a:{[x;y] y x } over enlist[ .proto.nil], .proto.adefine[;{(x;0f)}]@' `float`long`int`real

.proto.proto[a;o;g][(0.4;1 0f);(0.4;0 1f)]

(::)d:.proto.getb[g],`a`o!(a;o)
(::)data:((::),d[`arg])!(::;(1f;1 0f);(2f;0 1f))


`a`o`exn`data`proj set'(d`a;d`o;d`exn;data;d`proj)
 exn:parse exn;
 exn:$[";"~exn 0;1_exn;enlist exn];
 exn:.proto.untree@'exn;

 exn:{update e:first each e from x where ((0h=type@'e) and (1={@[count;x;0]}@'e) and (11h=abs {type first x}@'e)) or (11h=type@'e) and 1=count@'e } @'exn;
 l:enlist[`data`proj!(data;proj)] , exn;

(::)x:`proj`data`u!(proj;data;l[1])

.proto.s:{[a;o;x]
 data:x`data;u:x`u;proj:x`proj;
 u:.proto.adata[u;proj];
 u0:.proto.atom[u;a];
 u1:.proto.adata[u0]data;
 u2:.proto.operator[u1;o];
 e:(`g xgroup u2)[p0:max u2`p;`e];
 r:.proto.eval0 e;
 data:.proto.udata[o;data;e;r];
 u:update ind:ind[;0],p:p[;0],e:e[;0] from `g xgroup u2;
 u:delete g from update e:enlist r from u where g = p0;
 `u`data`proj!(u;data;proj)}

(::)u:u1
.proto.operator:{[u;o]
(::) tmp:.proto.operator0 lj t:([nme:key o]fnc:value o);
 tmp:tmp,1!select e:nme,nme,tipe:-11h,fnc from t where not nme in exec nme from .proto.operator0 
 o:{if[not y in (0!x)`e;:y ] ;x[y;`fnc]} tmp;
 // u:update e0:e from u;
 update e:o@'e from u where (99h<type@'e) or -11h=type@'e 
 }






.proto.proto_:{[a;o;exn;data;proj]

 r0:{[a;o;x;y] .proto.s[a;o]/[`proj`data`u!(x`proj;x`data;y)] }[a;o]/[l];
 res:r0[`u;0;`e];
 o:{x[y;`fnc]} .proto.operator0 lj ([nme:key o]fnc:value o);
 o[`Return] res
 }


/ "b" .bt.print["start cmd %btick2%/src/qlib/qtx/allTest/alltest.xlsx"] .import.repository.con

/




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