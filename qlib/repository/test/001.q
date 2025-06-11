.qtx.testSuiter[`repository1;`repo`lib`file!`btick2`repository`001;"test repository"]
  .qtx.before[{.bt.md[`loadResult] .import.module`repository}]
  .qtx.testCase[`repository1;"test repository"][
    .qtx.shouldTrue[`0;"file loaded successfully";{[loadResult]
      null loadResult`error
      }]
    .qtx.nil
    ]
  .qtx.argument[`mon`tue`wed`thu`fri`sat`sun!2025.04.21 + til 7]
  .qtx.nil
  ;