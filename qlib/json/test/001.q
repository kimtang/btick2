
.qtx.testSuiter[`json1;`repo`lib`file!`btick2`json`001;"test json"]
  .qtx.before[{.bt.md[`loadResult] .import.module`json}]  
  .qtx.testCase[`json1;"test json"][
    .qtx.shouldTrue[`0;"file loaded successfully";{[loadResult]
      null loadResult`error
      }]
    .qtx.shouldData[`1;"handles single row";"%btick2%/qlib/json/testData/json2/0";{[allData]
      .json.k `a`b.j`c.J`d.F`e.q!(1 ; 2f; "13";"13";"til 10")
      }]
    .qtx.shouldData[`2;"handles single row";"%btick2%/qlib/json/testData/json2/1";{[allData]
      .json.j  .json.k `a`b.j`c.J`d.F`e.q!(1 ; 2f; "13";"13";"til 10")
      }]      
    .qtx.nil
    ]    
  .qtx.argument[`a`b.j`c.J`d.F`e.q!(1 ; 2f; "13";"13";"til 10")]  
  .qtx.nil
  ;