
.qtx.testSuiter[`baum1;`repo`lib`file!`btick2`baum`001;"test baum"]
  .qtx.before[{.bt.md[`loadResult] .import.module`baum}]
  .qtx.testCase[`baum1;"test baum"][
    .qtx.shouldTrue[`0;"file loaded successfully";{[loadResult]
      null loadResult`error
      }]
    .qtx.shouldData[`1;"creates simple treetable";"%btick2%/qlib/baum/testData/baum1/1";{[testData]
      .baum.tbaum[testData;"A,B ~~ sum_v:sum v";()]
      }]
    .qtx.shouldData[`2;"opens specific nodes";"%btick2%/qlib/baum/testData/baum1/2";{[testData]
      .baum.tbaum[testData;"A,B ~~ sum_v:sum v"] .baum.open["A:`a"] .baum.nil
      }]
    .qtx.shouldData[`3;"sorts by aggregated values";"%btick2%/qlib/baum/testData/baum1/3";{[testData1]
      .baum.sort["sum_v:idesc"] .baum.tbaum[testData1;"A,B ~~ sum_v:sum v"] .baum.nil
      }]      
    .qtx.shouldData[`4;"handles multiple aggregation functions";"%btick2%/qlib/baum/testData/baum1/4";{[testData2]
      .baum.tbaum[testData2;"A,B ~~ sum_v:sum v,avg_w:avg w,count_rows:count v"] .baum.nil
      }]      
    .qtx.shouldData[`5;"filters paths correctly";"%btick2%/qlib/baum/testData/baum1/5";{[testData3]
      .baum.tbaum[testData3;"A,B ~~ sum_v:sum v"] .baum.open["A:`a,B:`x"] .baum.nil
      }]    
    .qtx.shouldData[`6a;"handles empty table";"%btick2%/qlib/baum/testData/baum1/6a";{[testData]
      t:0#([]A:`symbol$();B:`symbol$();v:`int$());
      .baum.tbaum[t;"A,B ~~ sum_v:sum v"] .baum.nil
      }]    
    .qtx.shouldData[`6b;"handles single row";"%btick2%/qlib/baum/testData/baum1/6b";{[testData]
      t:([]A:enlist`a;B:enlist`x;v:enlist 1);
      .baum.tbaum[t;"A,B ~~ sum_v:sum v"] .baum.nil
      }]
    .qtx.shouldFail[`7a;"fails on invalid column";`INVALID_COL;{[testData]
      t:([]A:`a`b;v:1 2);
      .baum.tbaum[t;"INVALID_COL ~~ sum_v:sum v"] .baum.nil
      }]
    .qtx.shouldFail[`7b;"fails on malformed formula";`INVALID_SYNTAX;{[testData]
      t:([]A:`a`b;v:1 2);
      .baum.tbaum[t;"A INVALID_SYNTAX v"] .baum.nil
      }]                        
    .qtx.nil
    ]
  .qtx.argument[`testData`testData1`testData2`testData3!(([]A:`a`a`b`b;B:`x`y`x`y;v:1 2 3 4);([]A:`a`a`b`b;B:`x`y`x`y;v:4 1 2 10);([]A:`a`a`b`b;B:`x`y`x`y;v:1 2 3 4;w:10 20 30 40);([]A:`a`a`b`b`c`c;B:`x`y`x`y`x`y;v:1 2 3 4 5 6))]
  .qtx.nil
  ;
