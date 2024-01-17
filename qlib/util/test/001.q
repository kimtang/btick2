
.import.require`repository`os`qtx 
.util.setRandomSeed[] / set a random seed

.qtx.testSuite[`test.btick2.util;"test util"]
  .qtx.repo[`btick2]
  .qtx.lib[`util]
  .qtx.before[{}]
  .qtx.after[{}]  
  .qtx.testCase[`test.util.treeIgnore;"test util treeIgnore"][
    .qtx.should["description";{[allData] .qtx.out[`a`b!1 2;1b]}]
    .qtx.shouldTrue["description";{[allData] 1b}]
    .qtx.shouldTrue["description";{[allData] 1b}]
    .qtx.shouldTrue["description";{[allData] 1b}]
    .qtx.shouldTrue["description";{[allData] 1b}]
    .qtx.shouldTrue["description";{[allData] 1b}]
    .qtx.nil
    ]
  .qtx.nil