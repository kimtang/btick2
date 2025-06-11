.qtx.testSuiter[`plant1;`repo`lib`file!`btick2`plant`001;"test plant"]
  .qtx.before[{.bt.md[`loadResult] .import.module`plant}]
  .qtx.testCase[`plant1;"test plant"][
    .qtx.shouldTrue[`0;"file loaded successfully";{[loadResult]
      null loadResult`error
      }]
    .qtx.nil
    ]
  .qtx.argument[`mon`tue`wed`thu`fri`sat`sun!2025.04.21 + til 7]
  .qtx.nil
  ;