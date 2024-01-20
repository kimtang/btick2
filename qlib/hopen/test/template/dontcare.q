args:.Q.def[`name`port!("dontcare.q";9082);].Q.opt .z.x

/ remove this line when using in production
/ dontcare.q:localhost:9082::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9082"; } @[hopen;`:localhost:9082;0];