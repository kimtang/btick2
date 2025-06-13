args:.Q.def[`name`port!("9_allTest.q";9082);].Q.opt .z.x

/ remove this line when using in production
/ 9_allTest.q:localhost:9082::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9082"; } @[hopen;`:localhost:9082;0];

\l qlib.q

.import.require`qtx.watchTest`remote;
.watchTest.start exec lib from .import.summary[] where repo=`btick2
/ .watchTest.start`os

.qtx.rsummary[]