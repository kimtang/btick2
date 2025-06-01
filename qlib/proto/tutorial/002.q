args:.Q.def[`name`port!("proto/tutorial/002.q";9090);].Q.opt .z.x

/ remove this line when using in production
/ proto/tutorial/002.q:localhost:9090::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9090"; } @[hopen;`:localhost:9090;0];

\l qlib.q

.import.summary[]
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
  .proto.odefine[`const;{[x] enlist[ x[0];] 0f }]
  .proto.nil  

(::)a1:{[x;y] y x } over enlist[ .proto.nil], .proto.adefine[;{enlist,(x;0f)}]@' `float`long`int`real


(::)g0:{[x1;x2]((1 - x1) xexp 2) + 100*(x2 - x1*x1) xexp 2}
(::)g1:{[x1;x2] a:100*(x2 - x1*x1) xexp 2;b:(1 - x1) xexp 2;a+b}
(::)g2:{[x1;x2] b:(a*(1 - x1) xexp 2)+a:100*(x2 - x1*x1) xexp 2;b+3}

(::)d:.proto.getb[g2],`a`o!(a1;o1)
d:@[d;`exn;:;.proto.exn d`exn]
(::)data:((::),d[`arg])!(::;enlist,(.4;1 0f);enlist,(.4;0 1f))
`a`o`exn`data`proj set'(d`a;d`o;d`exn;data;d`proj)

(::)exn0:exn 0
desc exec ind from exn0 where e~'(:)

(::)pind:distinct raze {[p;x]where p in x}[exn0[`p]] scan 10
select from exn0 where ind in pind
select from exn0 where not ind in pind

select from exn0 where ind in distinct raze {[p;x]where p in x}[exn0[`p]] scan 8
select from exn0 where not ind in distinct raze {[p;x]where p in x}[exn0[`p]] scan 8


(::)exn1:update e:(`x1`x2!(0.4 0.4;0.4 0.4)) e from exn0 where -11h = type@'e
(::)exn1:update e:(`x1`x2!(enlist,(0.4 ; 1 0);enlist,(0.4 ; 0 1 ))) e from exn0 where -11h = type@'e

(::)e1:.proto.tree exn1
(::)eval e1
g0[(0.4;1 0);(0.4;0 1)]
g0[(0.4 0.4);(0.4 0.4)]
\t:20000 eval e1
\t:20000 g0[(0.4;1 0);(0.4;1 0)]

enlist[tmp;]



/







(::)d:.proto.getb[g],`a`o!(a1;o1)
d:@[d;`exn;:;.proto.exn d`exn]
(::)data:((::),d[`arg])!(::;enlist,(.4;1 0f);enlist,(.4;0 1f))
`a`o`exn`data`proj set'(d`a;d`o;d`exn;data;d`proj)
l:enlist[`data`proj!(data;proj)] , exn;

x:l[0],(1#`u)!enlist l 1

.proto.s0:{[a;o;x]
 data:x`data;u:x`u;proj:x`proj;
 u:.proto.adata[u;proj];
 u0:.proto.atom[u;a];
 u1:.proto.adata[u0]data;
 u2:.proto.operator[u1;o];
 tmp:.proto.tree u2
 }

(:)~tmp 0
ds_hdb_ops_a
eval 
parse "avbc:abc:2 "

eval tmp
eval tmp . 1 1
eval tmp . 1 2

eval @[;2;1_ ]tmp 1

.proto.udata:{[o;data;e;r]o:(`nme xkey .proto.operator0 lj([nme:key o]fnc:value o)) ;if[not o[`Colon;`fnc]~e 0;:data];data[e 1]:r;data}

.proto.proto0_:{[a;o;exn;data;proj]
 l:enlist[`data`proj!(data;proj)] , exn;
 r0:{[a;o;x;y] .proto.s[a;o]/[`proj`data`u!(x`proj;x`data;y)] }[a;o]/[l];
 res:r0[`u;0;`e];
 o:{x[y;`fnc]} .proto.operator0 lj ([nme:key o]fnc:value o);
 o[`Return] res
 }


(::)o1:.proto.odefine[`Plus;{[x;y] enlist,(x[0]+y[0];x[1]+y[1])}]
  .proto.odefine[`Hyphen;{[x;y]enlist,(x[0]-y[0];x[1]-y[1])}]
  .proto.odefine[`Multiply;{[x;y]enlist,enlist[x[0]*y[0];] (x[0]*y[1])+x[1]*y[0]}]
  .proto.odefine[`Log;{[x]enlist,enlist[log x[0];]x[1] % x[0] }]
  .proto.odefine[`Sin;{[x]enlist,enlist[sin x[0];] x[1]*cos x[0] }]
  .proto.odefine[`Cos;{[x]enlist,enlist[cos x[0];] x[1]*neg sin x[0]}]
  .proto.odefine[`Procenttecken;{[x;y] enlist,enlist[x[0]%y[0];] ((x[1]*y[0]) - x[0]*y[1]) % y[0]*y[0] }]
  .proto.odefine[`Exp;{[x] enlist,enlist[exp x[0];] x[1]*exp x[0] }]
  .proto.odefine[`Xexp;{[x;y] enlist,enlist[x[0] xexp y[0];] x[1] *y[0]* x[0] xexp -1+y[0] }]
  .proto.odefine[`const;{[x] enlist,enlist[ x[0];] 0f }]
  .proto.nil  

(::)a1:{[x;y] y x } over enlist[ .proto.nil], .proto.adefine[;{enlist, (x;0f)}]@' `float`long`int`real


(::)d:.proto.getb[g],`a`o!(a;o)
d:@[d;`exn;:;.proto.exn d`exn]
(::)data:((::),d[`arg])!(::;(1f;1 0f);(2f;0 1f))
`a`o`exn`data`proj set'(d`a;d`o;d`exn;data;d`proj)


.proto.proto0[2]:{[d;x0;x1]data:((::),d[`arg])!(::;x0;x1);d:@[d;`exn;:;.proto.exn d`exn];.proto.proto_[d`a;d`o;d`exn;data;d`proj]}

x:l[0],(1#`u)!enlist l 1


.proto.s:{[a;o;x]
 data:x`data;u:x`u;proj:x`proj;
 u:.proto.adata[u;proj];
 u0:.proto.atom[u;a];
 u1:.proto.adata[u0]data;
 u2:.proto.operator[u1;o];

(::)tmp:.proto.tree u2

u3:update e:enlist@'e from u2 where ind in 3 4 5 7 10 12 13 15

eval .proto.tree u3
\t eval .proto.tree u

const:{x}


eval @[;1;enlist]tmp . 2 2 2

({1+x};1)

.proto.tree:{{select ind:ind[;0],p:p[;0],e:{$[1=count x;first x;x]}@'e from`g xgroup update g:@[ind;where p=max p;:;max p]from x}/[x] . 0,`e}

eval (+;(+;1;2);2)
eval (+;(+;1;2);2)

eval parse"1 + 2 + 2"


 e:(`g xgroup u2)[p0:max u2`p;`e];
 r:.proto.eval0 e;
 data:.proto.udata[o;data;e;r];
 u:update ind:ind[;0],p:p[;0],e:e[;0] from `g xgroup u2;
 u:delete g from update e:enlist r from u where g = p0;
 `u`data`proj!(u;data;proj)}



.proto.proto_:{[a;o;exn;data;proj]
 l:enlist[`data`proj!(data;proj)] , exn;
 r0:{[a;o;x;y] .proto.s[a;o]/[`proj`data`u!(x`proj;x`data;y)] }[a;o]/[l];
 res:r0[`u;0;`e];
 o:{x[y;`fnc]} .proto.operator0 lj ([nme:key o]fnc:value o);
 o[`Return] res
 }