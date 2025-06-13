args:.Q.def[`name`port!("001_dbmain.q";9083);].Q.opt .z.x

/ remove this line when using in production
/ 001_dbmain.q:localhost:9083::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9083"; } @[hopen;`:localhost:9083;0];

\l qlib.q
.import.require`repository`remote
.import.module`dbmaint

.dbmaint.rm@'`db1`db2`db3

(::)data:trade:`date`sym`time xasc([]date:10?.z.D + til 3; time:10?.z.T;sym:10?`aaa`bbb`ccc;prx:10?100.0;qty:10?100)
(::)arg0:`dir`tblName`symFile`gz!`db1`trade`sym,enlist 17 0 6
(::)arg:arg0,.bt.md[`storage]storage:`type`mode`partitionCol`partAttrCol`sortCol!`partition`auto`date`sym`time    / partition

.dbmaint.save[arg;data]

(::)allFiles:.os.treen[2]`:db1
sym~get .Q.dd[hsym arg`dir;arg`symFile]
(::)dataFolder:select from allFiles where sym=`trade 
(::)dataFolder:update data:{select from x}@'fullPath from dataFolder
count[trade]= count raze dataFolder`data
all {`p=exec a from meta[ x]`sym}@'dataFolder`data

.dbmaint.save[arg;data]

(::)allFiles:.os.treen[2]`:db1
sym~get .Q.dd[hsym arg`dir;arg`symFile]
(::)dataFolder:select from allFiles where sym=`trade 
(::)dataFolder:update data:{select from x}@'fullPath from dataFolder
(2*count trade)=count raze dataFolder`data
all {`p=exec a from meta[ x]`sym}@'dataFolder`data

(::)arg1:arg0,.bt.md[`storage]storage:`type`mode`partitionCol!`partition`auto`date    / partition

.dbmaint.save[arg1;data]

(::)allFiles:.os.treen[2]`:db1
sym~get .Q.dd[hsym arg`dir;arg`symFile]
(::)dataFolder:select from allFiles where sym=`trade 
(::)dataFolder:update data:{select from x}@'fullPath from dataFolder
(3*count trade)= count raze dataFolder`data
all{`=exec a from meta[ x]`sym}@'dataFolder`data


(::)data0:dateFolder:distinct select date:"D"$string sym from allFiles where not null "D"$string sym
.dbmaint.sortOnly[arg] data0

(::)allFiles:.os.treen[2] arg`dir
sym~get .Q.dd[hsym arg`dir;arg`symFile]
(::)dataFolder:select from allFiles where sym=`trade 
(::)dataFolder:update data:{select from x}@'fullPath from dataFolder
(3*count trade)= count raze dataFolder`data
all{`p=exec a from meta[ x]`sym}@'dataFolder`data

.dbmaint.rm "db1"

(::)arg:arg,.bt.md[`storage] storage:`type`mode`partitionCol`partAttrCol`sortCol!`splayed`auto`date`sym`time / splayed

.dbmaint.save[arg;data]

(::)allFiles:.os.treen[2] arg`dir
sym~get .Q.dd[hsym arg`dir;arg`symFile]
(::)dataFolder:select from allFiles where not null "D"$string sym 
(::)dataFolder:update data:{select from x}@'fullPath from dataFolder
(count trade)= count raze dataFolder`data
all{`p=exec a from meta[ x]`sym}@'dataFolder`data

.dbmaint.save[arg;data]

(::)allFiles:.os.treen[2] arg`dir
sym~get .Q.dd[hsym arg`dir;arg`symFile]
(::)dataFolder:select from allFiles where not null "D"$string sym 
(::)dataFolder:update data:{select from x}@'fullPath from dataFolder
(2*count trade)= count raze dataFolder`data
all{`p=exec a from meta[ x]`sym}@'dataFolder`data

(::)arg:arg,.bt.md[`storage] storage:`type`mode`partitionCol`partAttrCol1`sortCol1!`splayed`auto`date`sym`time / splayed

.dbmaint.save[arg;data]

(::)allFiles:.os.treen[2] arg`dir
sym~get .Q.dd[hsym arg`dir;arg`symFile]
(::)dataFolder:select from allFiles where not null "D"$string sym 
(::)dataFolder:update data:{select from x}@'fullPath from dataFolder
(3*count trade)= count raze dataFolder`data
all{`=exec a from meta[ x]`sym}@'dataFolder`data

(::)arg:arg,.bt.md[`storage] storage:`type`mode`partitionCol`partAttrCol`sortCol!`splayed`auto`date`sym`time / splayed

.dbmaint.sortOnly[arg] select date:"D"$string sym from dataFolder

(::)allFiles:.os.treen[2] arg`dir
sym~get .Q.dd[hsym arg`dir;arg`symFile]
(::)dataFolder:select from allFiles where not null "D"$string sym 
(::)dataFolder:update data:{select from x}@'fullPath from dataFolder
(3*count trade)= count raze dataFolder`data
all{`p=exec a from meta[ x]`sym}@'dataFolder`data

.dbmaint.rm"db1"

arg:arg,.bt.md[`storage] storage:`type`mode`partAttrCol`sortCol!`flat`auto`sym`time / flat

.dbmaint.save[arg;data]

(::)allFiles:.os.treen[2] arg`dir
sym~get .Q.dd[hsym arg`dir;arg`symFile]
(::)dataFolder:select from allFiles where `trade= sym 
(::)dataFolder:update data:{select from x}@'fullPath from dataFolder
(count trade)= count raze dataFolder`data
all{`p=exec a from meta[ x]`sym}@'dataFolder`data

.dbmaint.save[arg;data]

(::)allFiles:.os.treen[2] arg`dir
sym~get .Q.dd[hsym arg`dir;arg`symFile]
(::)dataFolder:select from allFiles where `trade= sym 
(::)dataFolder:update data:{select from x}@'fullPath from dataFolder
(2*count trade)= count raze dataFolder`data
all{`p=exec a from meta[ x]`sym}@'dataFolder`data


.dbmaint.save[;data] arg:arg,.bt.md[`storage] storage:`type`mode`partAttrCol1`sortCol1!`flat`auto`sym`time / flat

(::)allFiles:.os.treen[2] arg`dir
sym~get .Q.dd[hsym arg`dir;arg`symFile]
(::)dataFolder:select from allFiles where `trade= sym 
(::)dataFolder:update data:{select from x}@'fullPath from dataFolder
(3*count trade)= count raze dataFolder`data
all{`=exec a from meta[ x]`sym}@'dataFolder`data

.dbmaint.sortOnly[;1] arg:arg,.bt.md[`storage] storage:`type`mode`partAttrCol`sortCol!`flat`auto`sym`time / flat

(::)allFiles:.os.treen[2] arg`dir
sym~get .Q.dd[hsym arg`dir;arg`symFile]
(::)dataFolder:select from allFiles where `trade= sym 
(::)dataFolder:update data:{select from x}@'fullPath from dataFolder
(3*count trade)= count raze dataFolder`data
all{`p=exec a from meta[ x]`sym}@'dataFolder`data

.dbmaint.rm "db1"


(::)arg:arg,.bt.md[`storage]storage:`type`mode`dir`partitionCol`partAttrCol`sortCol!`par`auto`:db2`date`sym`time / par

.dbmaint.save[;data] arg:arg,.bt.md[`storage]storage:`type`mode`dir`partitionCol`partAttrCol`sortCol!`par`auto`:db2`date`sym`time / par

(::)allFiles:.os.treen[2] arg`dir
sym~get .Q.dd[hsym arg`dir;arg`symFile]

(::)allFiles:.os.treen[2] storage`dir
(::)dataFolder:select from allFiles where `trade= sym 
(::)dataFolder:update data:{select from x}@'fullPath from dataFolder
(count trade)= count raze dataFolder`data
all{`p=exec a from meta[ x]`sym}@'dataFolder`data

.dbmaint.save[;data] arg:arg,.bt.md[`storage]storage:`type`mode`dir`partitionCol`partAttrCol`sortCol!`par`auto`:db2`date`sym`time / par

(::)allFiles:.os.treen[2] storage`dir
(::)dataFolder:select from allFiles where `trade= sym 
(::)dataFolder:update data:{select from x}@'fullPath from dataFolder
(2*count trade)= count raze dataFolder`data
all{`p=exec a from meta[ x]`sym}@'dataFolder`data

.dbmaint.save[;data] arg:arg,.bt.md[`storage]storage:`type`mode`dir`partitionCol`partAttrCol1`sortCol1!`par`auto`:db2`date`sym`time / par

(::)allFiles:.os.treen[2] storage`dir
(::)dataFolder:select from allFiles where `trade= sym 
(::)dataFolder:update data:{select from x}@'fullPath from dataFolder
(3*count trade)= count raze dataFolder`data
all{`=exec a from meta[ x]`sym}@'dataFolder`data

arg:arg,.bt.md[`storage]storage:`type`mode`dir`partitionCol`partAttrCol`sortCol!`par`auto`:db2`date`sym`time
.dbmaint.sortOnly[arg;] select date:"D"$string sym from allFiles where not null "D"$string sym

(::)allFiles:.os.treen[2] storage`dir
(::)dataFolder:select from allFiles where `trade= sym 
(::)dataFolder:update data:{select from x}@'fullPath from dataFolder
(3*count trade)= count raze dataFolder`data
all{`p=exec a from meta[ x]`sym}@'dataFolder`data

