.qtx.testSuiter[`pm21;`repo`lib`file!`btick2`pm2`001;"test pm2"]
  .qtx.before[{.bt.md[`loadResult] .import.module`pm2}]
  .qtx.testCase[`pm21;"test pm2"][
    .qtx.shouldTrue[`0;"file loaded successfully";{[loadResult]
      null loadResult`error
      }]
    .qtx.nil
    ]
  .qtx.argument[`mon`tue`wed`thu`fri`sat`sun!2025.04.21 + til 7]
  .qtx.nil
  ;