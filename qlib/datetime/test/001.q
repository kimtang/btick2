
.qtx.testSuiter[`datetime1;`repo`lib`file!`btick2`datetime`001;"test datetime"]
  .qtx.before[{.bt.md[`loadResult] .import.module`datetime}]
  .qtx.testCase[`datetime1;"test datetime"][
    .qtx.shouldTrue[`0;"file loaded successfully";{[loadResult]
      null loadResult`error
      }]
    .qtx.shouldTrue[`1;"atom .datetime.week";{[mon] `mon=.datetime.week mon }]
    .qtx.shouldTrue[`2;"array .datetime.week";{[mon;tue] `mon`tue~.datetime.week mon,tue }]
    .qtx.shouldTrue[`3;"atom .datetime.getYearStart";{[mon] 2025.01.01 ~ .datetime.getYearStart 2025.02.20 }]
    .qtx.shouldTrue[`4;"array .datetime.getYearStart";{ 2025.01.01 2023.01.01 ~ .datetime.getYearStart 2025.02.20 2023.02.20 }]
    .qtx.shouldTrue[`5;"atom .datetime.getYearEnd";{ 2022.12.31 ~ .datetime.getYearEnd 2022.02.01 }]
    .qtx.shouldTrue[`6;"array .datetime.getYearEnd";{ 2025.12.31 2023.12.31 ~ .datetime.getYearEnd 2025.02.20 2023.02.20 }]
    .qtx.shouldTrue[`7;"array .datetime.getYearEnd";{ `winter`winter`winter`spring`spring`spring`summer`summer`summer`autum`autum`autum~ .datetime.getSeason 2021.12m + til 12 }]
    .qtx.shouldTrue[`8;"array .datetime.getYearEnd";{ `winter`winter`winter`spring`spring`spring`summer`summer`summer`autum`autum`autum~ .datetime.getSeason `date$2021.12m + til 12 }]
    .qtx.shouldTrue[`9;"array .datetime.getYearEnd";{ 2022.02.28 2022.01.31 ~ .datetime.eomonth 2022.02.01 2022.01.01 }]
    .qtx.nil
    ]
  .qtx.argument[`mon`tue`wed`thu`fri`sat`sun!2025.04.21 + til 7]
  .qtx.nil
  ;

