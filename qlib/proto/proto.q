
d)lib btick2.proto 
 Library for working with the lib proto
 q).import.module`proto 
 q).import.module`btick2.proto
 q).import.module"%btick2%/qlib/proto/proto.q"

.proto.summary:{} 
.import.module "%btick2%/qlib/proto/unparse.q";

.proto.operator0:1!update tipe:type@'e,fnc:e from update e:{first first .[parse;enlist x;x]}@'e from ("*s";"\t ") 0: `$.import.cpath ":%btick2%/qlib/proto/proto.csv"

.proto.operator0,:`e`nme`tipe`fnc!(`Return;`Return;-11h;::);

.proto.atom0:1!update fnc:(::) from{`num xasc x,update num:abs num,tipe:`${(upper x[0]),1_x}@'string tipe from x} {select from x where not null tipe} update tipe:{ @[{ key x$() };x;`] }each "h"$abs num from ([]num:neg til 20)


.proto.untree:{{update ind:i,p:(ind!i) p from raze {if[1=count x`e;:enlist x];if[100h>type first x`e;:enlist x]; update p:(p[0],1 _ ind) from ungroup enlist x} @'x}/[([]ind:til count x;p:0;e:x)]}

.proto.tree:{{select ind:ind[;0],p:p[;0],e:{$[1=count x;first x;x]}@'e from`g xgroup update g:@[ind;where p=max p;:;max p]from x}/[x] . 0,`e}

.proto.addg:{[u] update g:@[ind;where p=max p;:;max p]from u}
.proto.adata:{[u;data]
 tmp:(enlist`ind`p`e`g!(-1;-1;::;-1)),.proto.addg u;
 1_update e:data e from tmp where -11h=type@'e,e in\:key data
 }
.proto.adefine:{[k;f;op] ((enlist k)!enlist f),op}

.proto.atom:{[u;a]a:{x["j"$type y;`fnc] y} .proto.atom0 lj ([tipe:key a]fnc:value a);
 update e:a@'e from u where 100h>type@'e
 }

.proto.odefine:{[k;f;op] ((enlist k)!enlist f),op}

.proto.operator:{[u;o]
 o:{if[not y in (0!.proto.operator0)`e;:y ] ;x[y;`fnc]} .proto.operator0 lj ([nme:key o]fnc:value o);
 // u:update e0:e from u;
 update e:o@'e from u where 99h<type@'e
 }




.proto.udata:{[o;data;e;r]o:(`nme xkey .proto.operator0 lj([nme:key o]fnc:value o)) ;if[not o[`Colon;`fnc]~e 0;:data];data[e 1]:r;data}

.proto.eval1:{[x] 0 x }

.proto.eval0:{[e]if[1=count e;:first e];.proto.eval1 e}

.proto.s:{[a;o;x]data:x`data;u:x`u;
 u0:.proto.atom[u;a];
 u1:.proto.adata[u0]data;
 u2:.proto.operator[u1;o];
 e:(`g xgroup u2)[p0:max u2`p;`e];
 r:.proto.eval0 e;
 data:.proto.udata[o;data;e;r];
 u:update ind:ind[;0],p:p[;0],e:e[;0] from `g xgroup u2;
 u:delete g from update e:enlist r from u where g = p0;
 `u`data!(u;data)}

.proto.getb:{exn:-1 _ 1 _ last f:get x;exn:$["["~exn 0;(1+first where "]"=exn) _ exn;exn]; `arg`exn!(f 1;exn)}

.proto.proto_:{[a;o;exn;data]
 exn:parse exn;
 exn:$[";"~exn 0;1_exn;enlist exn];
 exn:.proto.untree@'exn;
 exn:{update e:first each e from x where ((0h=type@'e) and (1={@[count;x;0]}@'e) and (11h=abs {type first x}@'e)) or (11h=type@'e) and 1=count@'e } @'exn;
 l:enlist[(enlist`data)!enlist data] , exn;
 r0:{[a;o;x;y] .proto.s[a;o]/[`data`u!(x`data;y)] }[a;o]/[l];
 res:r0[`u;0;`e];
 o:{x[y;`fnc]} .proto.operator0 lj ([nme:key o]fnc:value o);
 o[`Return] res
 }

.proto.proto0:()!()
.proto.proto0[1]:{[d;x0]data:((::),d[`arg])!(::;x0);.proto.proto_[d`a;d`o;d`exn;data]}
.proto.proto0[2]:{[d;x0;x1]data:((::),d[`arg])!(::;x0;x1);.proto.proto_[d`a;d`o;d`exn;data]}
.proto.proto0[3]:{[d;x0;x1;x2]data:((::),d[`arg])!(::;x0;x1;x2);.proto.proto_[d`a;d`o;d`exn;data]}
.proto.proto0[4]:{[d;x0;x1;x2;x3]data:((::),d[`arg])!(::;x0;x1;x2;x3);.proto.proto_[d`a;d`o;d`exn;data]}
.proto.proto0[5]:{[d;x0;x1;x2;x3;x4]data:((::),d[`arg])!(::;x0;x1;x2;x3;x4);.proto.proto_[d`a;d`o;d`exn;data]}
.proto.proto0[6]:{[d;x0;x1;x2;x3;x4;x5]data:((::),d[`arg])!(::;x0;x1;x2;x3;x4;x5);.proto.proto_[d`a;d`o;d`exn;data]}
.proto.proto0[7]:{[d;x0;x1;x2;x3;x4;x5;x6]data:((::),d[`arg])!(::;x0;x1;x2;x3;x4;x5;x6);.proto.proto_[d`a;d`o;d`exn;data]}

.proto.proto:{[a;o;f]d:.proto.getb[f],`a`o!(a;o);.proto.proto0[count d`arg][d]  }
.proto.prote:{[a;o;exn]d:`arg`exn`a`o!(1#`x;exn;a;o);.proto.proto0[count d`arg][d]  }

.proto.nil:()!()

d) fnc proto.proto.proto
 Add logging
 q){@[`.;key x;:;value x]} .proto
 q)"big numbers"
 q)cns:{(til count r)!"J"$'r:reverse string x}
 q)pnum:{(x+key y)!value y}
 q)norm:{{sum pnum'[key x;cns@'value x]}/[x]}
 q)plus:{norm x + y}
 q)multiply:{ norm sum {(enlist sum x) ! enlist prd y}'[key r;value r:x cross y] }
 q)return:{r:raze string 0^x(reverse til 1+max key x);e:@[parse;r;r];if[10h~type e;:e];$[e<0wj;e;r] }
 q)(::)a:adefine[`float;cns] adefine[`long;cns]()!()
 q)(::)o:odefine[`Return;return] odefine[`Plus;plus] odefine[`Multiply;multiply]()!()
 q)p:proto[a;o]
 q)p[{1+2*x}][1]
 q)p[{b:a+x*2 + a:3*y;z+b+1}] . 1 7 8
 q)p[{[a;b;c;d]b:c*a+a*2 + a:3*b;d+b+1}][1;2;3;4]
 q)p[{2*1+x+y}][0wj - 1;0]
 q)"Logger"
 q)(::)o:odefine[`Colon;{[x;y]show .Q.s1 (x;y);y}]()!()
 q)(::)r:proto[()!();o;{b:3+a:1+x;1+b}][1]


/

{x!@[-9!;;::]each 0x010000000a00000066,/:`byte$x}til 256
(::)monads:-9!/:0x010000000a00000065,/:"x"$til 45
(::)dyads:-9!/:0x010000000a00000066,/:"x"$til 37








