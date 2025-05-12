args:.Q.def[`name`port!("99.q";8065);].Q.opt .z.x

/ remove this line when using in production
/ 99.q:localhost:8065::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 8065"; } @[hopen;`:localhost:8065;0];

\l qlib.q

.import.require`qtx.watchTest;
.watchTest.start`%name%;



/