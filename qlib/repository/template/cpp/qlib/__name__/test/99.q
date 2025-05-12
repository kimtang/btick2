/ name:localhost:9081::

.qtx.testSuiter[`%name%1;`repo`lib`file!`%name%`%name%`001;"test %name%"]
  .qtx.before[{.import.module`%name%}]
  .qtx.testCase[`api;"successfully loaded"][
    .qtx.shouldTrue[`0;"all loaded functions are present";{
      min {x~key x}@'exec fname from .%name%.lib.def
    }]
    .qtx.nil
    
  ]
  .qtx.testCase[`xp;"test .%name%.api.xp"][
    .qtx.shouldTrue[`0;"same pointe4d";{[a] .%name%.api.xp[a]  ~ .%name%.api.xp a}]
    .qtx.shouldTrue[`1;"different pointer";{[a;b] not .%name%.api.xp[b]  ~ .%name%.api.xp a }]
    .qtx.nil
    ]
  .qtx.testCase[`xn;"test .%name%.api.xn"][
    .qtx.shouldTrue[`0;"get length";{[d] count[d] ~ .%name%.api.xn d}]
    .qtx.nil
    ]
  .qtx.argument[`a`b`c`d!(14 9; 10; "str";(1;2;3;4f))]
  .qtx.nil
  ;

/


asd