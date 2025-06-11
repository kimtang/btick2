.qtx.testSuiter[`remote1;`repo`lib`file!`btick2`remote`001;"test remote"]
  .qtx.before[{.bt.md[`loadResult] .import.module`remote}]
  .qtx.testCase[`remote1;"test remote"][
    .qtx.shouldTrue[`0;"file loaded successfully";{[loadResult]
      null loadResult`error
      }]
    .qtx.nil
    ]
  .qtx.argument[`mon`tue`wed`thu`fri`sat`sun!2025.04.21 + til 7]
  .qtx.nil
  ;