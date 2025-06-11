

.qtx.testSuiter[`json1;`repo`lib`file!`btick2`json`001;"test json"]
  .qtx.before[{.bt.md[`loadResult] .import.module`json}]
  .qtx.testCase[`json1;"test json"][
    .qtx.shouldTrue[`0;"file loaded successfully";{[loadResult]
      null loadResult`error
      }]
    .qtx.nil
    ]
  .qtx.argument[`mon`tue`wed`thu`fri`sat`sun!2025.04.21 + til 7]
  .qtx.nil
  ;
