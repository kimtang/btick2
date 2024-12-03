args:.Q.def[`name`port!("001_dbmain.q";9083);].Q.opt .z.x

/ remove this line when using in production
/ 001_dbmain.q:localhost:9083::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9083"; } @[hopen;`:localhost:9083;0];

\l qlib.q
.import.require`repository`remote
.import.module`dbmaint


.dbmaint.ls arg:"."

(::)arg:`:./db1/obk/1/prx

/ `:./db1/par.txt 0: (string til 10000){(x,";"),(first y?y)?.Q.an}\:10000

{10#x}@'.dbmaint.head0[arg:`:./db1/par.txt;n:20] 
{20#x}@'x:.dbmaint.tail0[arg:`:./db1/par.txt;n:20] 


/

C:\edev\work\a_995_smbc_3177_cross