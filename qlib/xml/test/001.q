.qtx.testSuiter[`xml1;`repo`lib`file!`btick2`xml`001;"test xml"]
  .qtx.before[{.bt.md[`loadResult] .import.module`xml}]
  .qtx.testCase[`xml1;"test xml"][
    .qtx.shouldTrue[`0;"file loaded successfully";{[loadResult]
      null loadResult`error
      }]
    .qtx.nil
    ]
  .qtx.argument[`mon`tue`wed`thu`fri`sat`sun!2025.04.21 + til 7]
  .qtx.nil
  ;