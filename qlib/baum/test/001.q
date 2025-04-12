
.import.require`baum;

.qtx.testSuite[`baum;`repo`lib`file!`btick2`baum`001;"test baum"]
  .qtx.testCase[`t1;"argument injection"][
    .qtx.shouldEq[`0;"description";0;{[a]a}]
    .qtx.should[`1;"description";{.qtx.out[`c`d!3 4;1b]}]
    .qtx.shouldEq[`2;"description";4;{[d]d}]    
    .qtx.shouldFail[`3;"description";`ifail;{'`ifail}]
    .qtx.nil
    ]
  .qtx.argument[`a`b`c!0 1 2]
  .qtx.testCase[`t2;"test baum"][
    .qtx.before[{`a`b`c`d!3 4 5 6}]
    .qtx.shouldEq[`0;"description";3;{[a]a}]
    .qtx.shouldEq[`1;"description";6;{[d]d}]    
    .qtx.nil
    ]    
  .qtx.nil;