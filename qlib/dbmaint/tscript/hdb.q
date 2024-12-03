args:.Q.def[`name`port!("hdb.q";9084);].Q.opt .z.x

/ remove this line when using in production
/ hdb.q:localhost:9084::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9084"; } @[hopen;`:localhost:9084;0];

\l db1

/ 

\l .

key obk

select from trade
select from obk.2