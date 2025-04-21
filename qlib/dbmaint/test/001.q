

.qtx.testSuiter[`dbmaint1;`repo`lib`file!`btick2`dbmaint`001;"test dbmaint"]
  .qtx.before[{.bt.md[`loadResult] .import.module`dbmaint}]
  .qtx.testCase[`dbmaint1;"test dbmaint"][
    .qtx.before[{
      data:`date`sym`time xasc([]date:10?.z.D + til 3; time:10?.z.T;sym:10?`aaa`bbb`ccc;prx:10?100.0;qty:10?100);
      arg:`dir`tblName`symFile`gz!`db1`trade`sym,enlist 17 0 6;
      arg:arg,.bt.md[`storage]`type`mode`partitionCol`partAttrCol`sortCol!`partition`auto`date`sym`time;    / partition;
      :`data`arg!(data;arg)      
      }]
    .qtx.shouldTrue[`0;"file loaded successfully";{[loadResult]
      null loadResult`error
      }]
    .qtx.should[`1;"create partition db";{[arg;data]
      createdFiles:.dbmaint.save[arg]data;
      :`test`return!enlist[12=count createdFiles;](1#`createdFiles)!enlist createdFiles
      }]
    .qtx.shouldTrue[`2;"Check directory exists";{[arg]
      not ()~key hsym arg`dir
      }]      
    .qtx.after[{[arg] .dbmaint.rm arg`dir}]
    .qtx.nil
    ]
  .qtx.nil
  ;

/

.dbmaint.rm`:db1

reverse .qtx.res
11
.kmp`arg
.kmp1`return
.kmp2 1
12
.dbmaint.rm `db1