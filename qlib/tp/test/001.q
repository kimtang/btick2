.qtx.testSuiter[`tp1;`repo`lib`file!`btick2`tp`001;"test tp"]
  .qtx.before[{.bt.md[`loadResult] .import.module`tp}]
  .qtx.testCase[`tp1;"test tp"][
    .qtx.shouldTrue[`0;"file loaded successfully";{[loadResult]
      null loadResult`error
      }]
    .qtx.nil
    ]
  .qtx.argument[`mon`tue`wed`thu`fri`sat`sun!2025.04.21 + til 7]
  .qtx.nil
  ;