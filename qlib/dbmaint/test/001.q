

.qtx.testSuiter[`dbmaint1;`repo`lib`file!`btick2`dbmaint`001;"test dbmaint"]
  .qtx.before[{.bt.md[`loadResult] .import.module`dbmaint}]
  .qtx.testCase[`dbmaint1;"test loaded file"][
    .qtx.shouldTrue[`0;"file loaded successfully";{[loadResult]null loadResult`error}]
    .qtx.nil  
    ]
  .qtx.testCase[`dbmaint2;"test dbmaint"][
    .qtx.before[{
      data:`date`sym`time xasc([]date:10?.z.D + til 3; time:10?.z.T;sym:10?`aaa`bbb`ccc;prx:10?100.0;qty:10?100);
      arg:`dir`tblName`symFile`gz!`:db1`trade`sym1,enlist 17 2 6;
      arg:arg,.bt.md[`storage]`type`mode`partitionCol`partAttrCol`sortCol!`partition`auto`date`sym`time;    / partition;
      :`data`arg!(data;arg)      
      }]
    .qtx.should[`0;"create partition db";{[arg;data]
      createdFiles:.dbmaint.save[arg]data;
      :`test`return!enlist[12=count createdFiles;](1#`createdFiles)!enlist createdFiles
      }]
    .qtx.shouldTrue[`1;"Load directory and check symFile";{[arg]
      t ~ key t:.Q.dd . arg`dir`symFile
      }]
    .qtx.should[`2;"check date";{[data;arg]
      d:d where not null d:"D"$string key arg`dir;
      `test`return!(all data[`date] in d;.bt.md[`dates] d)      
      }]
    .qtx.should[`3;"check sym column";{[dates;data;arg]
      allFiles:.os.tree arg`dir;
      allFiles:select from allFiles where not child in parent;
      allFiles:select from allFiles where {x~key x}@'fullPath; 
      `return`test!enlist[.bt.md[`allFiles] allFiles;] min arg[`symFile]~'{key get x}@'exec fullPath from allFiles where sym like "*sym"
      }]
    .qtx.shouldTrue[`4;"check p attribute";{[allFiles]
      min `p~'{attr get x}@'exec fullPath from allFiles where sym like "*sym"
      }]
    .qtx.shouldTrue[`5;"check compression";{[allFiles;arg]
        t:select sym,fullPath from allFiles where fullPath like "*trade*",not sym=`.d;
        t:update compression:{(-21!x)`logicalBlockSize`algorithm`zipLevel}@'fullPath from t;
        0=sum sqrt sum s*s:arg[`gz] -/:t`compression
      }]                  
    .qtx.after[{[arg] .dbmaint.rm arg`dir}]
    .qtx.nil
    ]
  .qtx.testCase[`dbmaint3;"test dbmaint"][
    .qtx.before[{
      data:`date`sym`time xasc([]date:10?.z.D + til 3; time:10?.z.T;sym:10?`aaa`bbb`ccc;prx:10?100.0;qty:10?100);
      arg:`dir`tblName`symFile`gz!`:db2`trade`sym2,enlist 17 2 6;
      arg:arg,.bt.md[`storage] storage:`type`mode`partitionCol`partAttrCol`sortCol!`splay`auto`date`sym`time;      / splayed
      :`data`arg!(data;arg)      
      }]
    .qtx.should[`0;"create partition db";{[arg;data]
      createdFiles:.dbmaint.save[arg]data;
      :`test`return!enlist[12=count createdFiles;](1#`createdFiles)!enlist createdFiles
      }]
    .qtx.shouldTrue[`1;"Load directory and check symFile";{[arg]
      t ~ key t:.Q.dd . arg`dir`symFile
      }]
    .qtx.should[`2;"check date";{[data;arg]
      d:d where not null d:"D"$string key .Q.dd[arg`dir;`trade];
      `test`return!(all data[`date] in d;.bt.md[`dates] d)      
      }]
    .qtx.should[`3;"check sym column";{[dates;data;arg]
      allFiles:.os.tree arg`dir;
      allFiles:select from allFiles where not child in parent;
      allFiles:select from allFiles where {x~key x}@'fullPath; 
      `return`test!enlist[.bt.md[`allFiles] allFiles;] min arg[`symFile]~'{key get x}@'exec fullPath from allFiles where sym like "*sym"
      }]
    .qtx.shouldTrue[`4;"check p attribute";{[allFiles]
      min `p~'{attr get x}@'exec fullPath from allFiles where sym like "*sym"
      }]
    .qtx.shouldTrue[`5;"check compression";{[allFiles;arg]
        t:select sym,fullPath from allFiles where fullPath like "*trade*",not sym=`.d;
        t:update compression:{(-21!x)`logicalBlockSize`algorithm`zipLevel}@'fullPath from t;
        0=sum sqrt sum s*s:arg[`gz] -/:t`compression
      }]                  
    .qtx.after[{[arg] .dbmaint.rm arg`dir}]
    .qtx.nil
    ]
  .qtx.testCase[`dbmaint4;"test dbmaint"][
    .qtx.before[{
      data:`date`sym`time xasc([]date:10?.z.D + til 3; time:10?.z.T;sym:10?`aaa`bbb`ccc;prx:10?100.0;qty:10?100);
      arg:`dir`tblName`symFile`gz!`:db3`obk`sym3,enlist 17 2 6;
      arg:arg,.bt.md[`storage] storage:`type`mode`partAttrCol`sortCol!`flat`auto`sym3`time; / flat
      :`data`arg!(data;arg)      
      }]
    .qtx.should[`0;"create partition db";{[arg;data]
      createdFiles:.dbmaint.save[arg]data;
      :`test`return!enlist[1=count createdFiles;](1#`createdFiles)!enlist createdFiles
      }]
    .qtx.shouldTrue[`1;"Load directory and check symFile";{[arg]
      t ~ key t:.Q.dd . arg`dir`symFile
      }]
    .qtx.should[`2;"check table";{[arg]
      `return`test!enlist[.bt.md[`localData] localData:get t;] {x~key x} t:.Q.dd . arg`dir`tblName
      }]
    .qtx.shouldTrue[`3;"check sym column";{[arg;data;localData]
      all all (`time`sym xasc data) = localData
      }]
    .qtx.shouldTrue[`4;"check p attribute";{[localData;arg]
      arg[`symFile]~key@\:localData`sym
      }]
    .qtx.shouldTrue[`5;"check compression";{[allFiles;arg]
        z:-21! .Q.dd . arg`dir`tblName;
        0=sum sqrt sum s*s:arg[`gz] - z`logicalBlockSize`algorithm`zipLevel
      }]                  
    .qtx.after[{[arg] .dbmaint.rm arg`dir}]
    .qtx.nil
    ]
  .qtx.testCase[`dbmaint5;"test dbmaint"][
    .qtx.before[{
      data:`date`sym`time xasc([]date:10?.z.D + til 3; time:10?.z.T;sym:10?`aaa`bbb`ccc;prx:10?100.0;qty:10?100);
      arg:`dir`tblName`symFile`gz!`:db4`trade`sym,enlist 17 2 6;
      arg:arg,.bt.md[`storage]storage:`type`mode`dir`partitionCol`partAttrCol`sortCol!`par`auto`:db5`date`sym`time; / par
      :`data`arg!(data;arg)      
      }]
    .qtx.should[`0;"create partition db";{[arg;data]
      createdFiles:.dbmaint.save[arg]data;
      :`test`return!enlist[12=count createdFiles;](1#`createdFiles)!enlist createdFiles
      }]
    .qtx.shouldTrue[`1;"Load directory and check symFile";{[arg]
      t ~ key t:.Q.dd . arg`dir`symFile
      }]
    .qtx.shouldTrue[`2;"check par";{[arg]
      t~key t:.Q.dd . arg[`dir],`par.txt
      }]
    .qtx.shouldTrue[`3;"check sym column";{[arg]
      (enlist arg[`storage]`dir) ~ hsym `$read0 .Q.dd . arg[`dir],`par.txt
      }]
    .qtx.shouldTrue[`4;"check p attribute";{[arg;data]
      all data[`date]in "D"$string key arg[`storage]`dir
      }]
    .qtx.shouldTrue[`5;"check compression";{[arg;createdFiles]
      t:select from ([]fullPath:createdFiles) where not fullPath like "*.d";
      t:update compression:{(-21!x)`logicalBlockSize`algorithm`zipLevel}@'fullPath from t;
      0=sum sqrt sum s*s:arg[`gz] -/:t`compression
      }]                  
    .qtx.after[{[arg] .dbmaint.rm arg`dir}]
    .qtx.nil
    ]
  .qtx.nil
  ;

/