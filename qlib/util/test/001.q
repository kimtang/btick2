.qtx.testSuiter[`util1;`repo`lib`file!`btick2`util`001;"test util"]
  .qtx.before[{.bt.md[`loadResult] .import.module`util}]
  .qtx.testCase[`util1;"test util"][
    .qtx.shouldTrue[`0;"file loaded successfully";{[loadResult]
      null loadResult`error
      }]
    .qtx.nil
    ]
  .qtx.argument[`mon`tue`wed`thu`fri`sat`sun!2025.04.21 + til 7]
  .qtx.nil
  ;


/

.import.require`repository`os`qtx; 
.util.setRandomSeed[]; / set a random seed

.qtx.testSuite[`test.btick2.util;`repo`lib`file!`btick2`util`001;"test util"]
  .qtx.testCase[`test.util.treeIgnore;"test util treeIgnore"][
    .qtx.shouldTrue[`0;"description";{[allData]
      default:`a`b`c!(1;2;`a`b`c! (6;`a`b`c!5 6 7 ;8))
      arg:`b`c!(2;`a`b`c! (6 ; `b`c!6 7 ;18))
      (`a`b`c!(1j;2j;`a`c`b!(6j;18j;`a`b`c!5 6 7j))) ~.util.deepMerge[default]arg
      }]
    .qtx.shouldTrue[`0;"description";{[allData]
      allArgs:
         .util.arg
         .util.posArg0[`pos1;`;`nopos1]
         .util.posArg0[`pos2;"F";3.0]
         .util.optArg0[`opt0;`;`noOpt0] 
         .util.optArg0[`opt1;`;`noOpt1] ("arg0";"-opt0";"opt0";"2.0";"-opt1";"opt1");
      allArgs~`pos1`pos2`opt0`opt1!(`arg0;2f;`opt0;`opt1)
      }]
    .qtx.should["description";{[allData] .qtx.out[`a`b!1 2;1b]}]
    .qtx.shouldTrue[`0;"description";{[allData] 1b}]
    .qtx.shouldTrue[`0;"description";{[allData] 1b}]
    .qtx.shouldTrue[`0;"description";{[allData] 1b}]
    .qtx.nil
    ]
  .qtx.nil;