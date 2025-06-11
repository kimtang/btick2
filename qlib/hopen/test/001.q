

.qtx.testSuiter[`hopen1;`repo`lib`file!`btick2`hopen`001;"test hopen"]
  .qtx.before[{.bt.md[`loadResult] .import.module`hopen}]
  .qtx.testCase[`hopen1;"test hopen"][
    .qtx.shouldTrue[`0;"file loaded successfully";{[loadResult]
      null loadResult`error
      }]
    .qtx.nil
    ]
  .qtx.argument[`mon`tue`wed`thu`fri`sat`sun!2025.04.21 + til 7]
  .qtx.nil
  ;
