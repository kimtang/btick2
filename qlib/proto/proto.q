
d)lib btick2.proto 
 Library for working with the lib proto
 q).import.module`proto 
 q).import.module`btick2.proto
 q).import.module"%btick2%/qlib/proto/proto.q"

.proto.summary:{} 
.import.module "%btick2%/qlib/proto/unparse.q";

.proto.operator0:1!update tipe:type@'e,fnc:e from update e:{first first .[parse;enlist x;x]}@'e from ("*s";"\t ") 0: `$.import.cpath ":%btick2%/qlib/proto/proto.csv"

.proto.operator0,:`e`nme`tipe`fnc!(":";`Return;type":";::);

.proto.atom0:1!update fnc:(::) from{`num xasc x,update num:abs num,tipe:`${(upper x[0]),1_x}@'string tipe from x} {select from x where not null tipe} update tipe:{ @[{ key x$() };x;`] }each "h"$abs num from ([]num:neg til 20)

.proto.qkey:`while`if,key[ .q] except `

.proto.untree:{{update ind:i,p:(ind!i) p from raze {if[1=count x`e;:enlist x];if[(not t in -11 -10h) and 100h>t:type first x`e;:enlist x]; update p:(p[0],1 _ ind) from ungroup enlist x} @'x}/[([]ind:til count x;p:0;e:x)]}

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
 tmp:.proto.operator0 lj t:([nme:key o]fnc:value o);
 tmp:tmp,1!select e:nme,nme,tipe:-11h,fnc from t where not nme in exec nme from .proto.operator0; 
 o:{if[not y in (0!x)`e;:y ] ;x[y;`fnc]} tmp;
 update e:o@'e from u where (99h<type@'e) or -11h=type@'e 
 }

.proto.udata:{[o;data;e;r]o:(`nme xkey .proto.operator0 lj([nme:key o]fnc:value o)) ;if[not o[`Colon;`fnc]~e 0;:data];data[e 1]:r;data}

.proto.eval1:{[x] 0 x }

.proto.eval0:{[e]if[1=count e;:first e];.proto.eval1 e}

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

.proto.getb0:{[f]
 exn:-1 _ 1 _ last f;
 exn:$["["~exn 0;(1+first where "]"=exn) _ exn;exn];
 `arg`exn`proj!(f 1;exn;()!())
 }

.proto.getb:{
 f0:get x;
 if[4h=type first f0;:.proto.getb0 f0];
 r:.proto.getb0 get f0 0;
 proj:r[`arg]!count[r`arg]#(1_f0),count[r`arg]#(::);
 proj:(where {not x~(::)}@'proj)#proj;
 r:@[r;`proj;:;proj];
 r:@[r;`arg;{x except y};]key proj;
 r
 }

.proto.exn:{[exn]
 exn:parse exn;
 exn:$[";"~exn 0;1_exn;enlist exn];
 exn:.proto.untree@'exn;
 exn:{update e:first each e from x where ((0h=type@'e) and (1={@[count;x;0]}@'e) and (11h=abs {type first x}@'e)) or (11h=type@'e) and 1=count@'e } @'exn;
 exn	
 };

.proto.proto_:{[a;o;exn;data;proj]
 l:enlist[`data`proj!(data;proj)] , exn;
 r0:{[a;o;x;y] .proto.s[a;o]/[`proj`data`u!(x`proj;x`data;y)] }[a;o]/[l];
 res:r0[`u;0;`e];
 o:{x[y;`fnc]} .proto.operator0 lj ([nme:key o]fnc:value o);
 o[`Return] res
 }

.proto.get_path:{[x;y]x0:select from x[0] where ind in y;x:@[x;0;:;select from x[0] where not ind in 1_y];x:@[x;1;:;x[1],enlist x0];x}

.proto.colon1:{[e;s;v] e[s;v]; (1#`colon)!enlist (1#s)!enlist .proto.targ v }
.proto.colon0:{[s;v] (1#`colon)!enlist(1#s)!enlist .proto.targ v }

.proto.return1:{[e;v]e v; (1#`return)!enlist v }
.proto.return0:{[v](1#`return)!enlist v }


/ input:.kmp 0;exn1:.kmp 1

.proto.eval_ast:{[input;exn1]
 / .kmp:(input;exn1);
 if[`return in key input;:input];
 exn2:update e:{1#x}@'e from exn1 where -11h = type@'e,not e in (.proto.qkey,raze key @'input`arg`proj);
 exn3:update e:input[`arg] e from exn2 where -11h = type@'e,e in key input`arg;
 exn3:update e:input[`proj] e from exn3 where -11h = type@'e,e in key input`proj;
 exn4:update e:input[`index] ind from exn3 where ind in key input`index;
 exn5:.proto.atom[exn4;input`a];
 exn6:update nme: (exec e!nme from .proto.operator0)e from exn5;
 exn7:.proto.operator[exn6;input`o];
 exn8:update e:{.proto.colon1[x]}'[e] from exn7 where nme=`Colon,not e~'(:);
 exn8:update e:{:.proto.colon0}'[e] from exn8 where nme=`Colon,e~'(:);
 exn9:update e:{.proto.return1[x]}'[e] from exn8 where nme=`Return,not e~'":";
 exn9:update e:{:.proto.return0}'[e] from exn9 where nme=`Return,e~'":";
 nind:min exn9`ind;
 result:eval .proto.tree exn9;
 input:@[input;`val;{x, enlist y};result];
 if[not 99h=type result;:input];
 if[`colon in key result;
  input:@[input;`arg;{x,y};result`colon];
  input:@[input;`index;{x,y};((1#nind)!value result`colon)] ;
 ];
 if[`return in key result;input[`return]:result`return];
 :input
 }

.proto.proto0_:{[input]
 result:.proto.eval_exn over enlist[input],input`exn;
 if[`return in key result;:result`return];
 last result`val
 }


.proto.eval_exn:{[input;exn0]
 input:input,`index`val!(()!();());
 ind0:desc exec ind from exn0 where not ind=0,e~'(:);
 ind0:{[exn0;x] asc distinct raze{[exn0;ind00] where exn0[`p] in ind00 }[exn0] scan x}[exn0]@'ind0;
 allPath:{x[1],enlist x 0} .proto.get_path over enlist[(exn0;())],ind0;
 .proto.eval_ast over enlist[input], allPath
 }


.proto.proto0:()!()
.proto.proto0[1]:{[d;x0]data:((::),d[`arg])!(::;x0);d:@[d;`exn;:;.proto.exn d`exn];.proto.proto_[d`a;d`o;d`exn;data;d`proj]}
.proto.proto0[2]:{[d;x0;x1]data:((::),d[`arg])!(::;x0;x1);d:@[d;`exn;:;.proto.exn d`exn];.proto.proto_[d`a;d`o;d`exn;data;d`proj]}
.proto.proto0[3]:{[d;x0;x1;x2]data:((::),d[`arg])!(::;x0;x1;x2);d:@[d;`exn;:;.proto.exn d`exn];.proto.proto_[d`a;d`o;d`exn;data;d`proj]}
.proto.proto0[4]:{[d;x0;x1;x2;x3]data:((::),d[`arg])!(::;x0;x1;x2;x3);d:@[d;`exn;:;.proto.exn d`exn];.proto.proto_[d`a;d`o;d`exn;data;d`proj]}
.proto.proto0[5]:{[d;x0;x1;x2;x3;x4]data:((::),d[`arg])!(::;x0;x1;x2;x3;x4);d:@[d;`exn;:;.proto.exn d`exn];.proto.proto_[d`a;d`o;d`exn;data;d`proj]}
.proto.proto0[6]:{[d;x0;x1;x2;x3;x4;x5]data:((::),d[`arg])!(::;x0;x1;x2;x3;x4;x5);d:@[d;`exn;:;.proto.exn d`exn];.proto.proto_[d`a;d`o;d`exn;data;d`proj]}
.proto.proto0[7]:{[d;x0;x1;x2;x3;x4;x5;x6]data:((::),d[`arg])!(::;x0;x1;x2;x3;x4;x5;x6);d:@[d;`exn;:;.proto.exn d`exn];.proto.proto_[d`a;d`o;d`exn;data;d`proj]}

.proto.targ:{[x] if[not 0=type x;:x]; enlist,.z.s@'x}

.proto.proto1:()!()
.proto.proto1[1]:{[input;x0] input:@[input;`arg;:;] input[`arg]!.proto.targ@' enlist x0;.proto.proto0_[input]}
.proto.proto1[2]:{[input;x0;x1] input:@[input;`arg;:;] input[`arg]!.proto.targ@' (x0;x1);.proto.proto0_[input]}
.proto.proto1[3]:{[input;x0;x1;x2] input:@[input;`arg;:;] input[`arg]!.proto.targ@' (x0;x1;x2);.proto.proto0_[input]}
.proto.proto1[4]:{[input;x0;x1;x2;x3] input:@[input;`arg;:;] input[`arg]!.proto.targ@' (x0;x1;x2;x3);.proto.proto0_[input]}
.proto.proto1[5]:{[input;x0;x1;x2;x3;x4] input:@[input;`arg;:;] input[`arg]!.proto.targ@' (x0;x1;x2;x3;x4);.proto.proto0_[input]}
.proto.proto1[6]:{[input;x0;x1;x2;x3;x4;x5] input:@[input;`arg;:;] input[`arg]!.proto.targ@' (x0;x1;x2;x3;x4;x5);.proto.proto0_[input]}
.proto.proto1[7]:{[input;x0;x1;x2;x3;x4;x5;x6] input:@[input;`arg;:;] input[`arg]!.proto.targ@' (x0;x1;x2;x3;x4;x5;x6);.proto.proto0_[input]}


.proto.proto:{[a;o;f]d:.proto.getb[f],`a`o!(a;o);.proto.proto0[count d`arg][d]  }
.proto.prote:{[a;o;exn]d:`arg`exn`a`o!(1#`x;exn;a;o);.proto.proto0[count d`arg][d]  }


.proto.proton:{[a;o;g]
 input:.proto.getb[g],`index`val`a`o!(()!();();a;o);
 input:@[input;`exn;:;] .proto.exn input`exn ;
 .proto.proto1[count input`arg][input]
 }

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








