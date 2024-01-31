
.import.require`repository`os`qtx; 
.util.setRandomSeed[]; / set a random seed

.qtx.testSuite[`test.btick2.os;"test os"]
  .qtx.repo[`btick2]
  .qtx.lib[`os]
  .qtx.before[{
    r:.util.genTmpFolder[];
    r:r,.bt.md[`newFile]{x 1: "x"$"HelloWorld\nHelloWorld"}@' `$.bt.print[;r]@'(":%path%/a/b/c.q";":%path%/a/d/e.q";":%path%/f.q");
    r
    }]
  .qtx.after[{[path] @[.os.hdel;path;{}]}]  
  .qtx.testCase[`test.os.treeIgnore;"test os treeIgnore"][
    .qtx.should["description";{[path]
      r:.bt.md[`allFiles]allFiles: .os.tree path;
      .qtx.out[r;] 7=count allFiles
      }]
    .qtx.shouldTrue["description";{[allFiles] min `a`f.q`b`d`c.q`e.q in allFiles`sym }]
    .qtx.shouldTrue["description";{[allData;path] 2=count .os.treeIgnore[.bt.print["%path%/a"]allData] path }]
    .qtx.shouldTrue["description";{[path] 6=count .os.treeIgnore["*/f.q"]path }]
    .qtx.shouldTrue["description";{[path] 3=count .os.treen[1]path }]        
    .qtx.shouldTrue["description";{[path] .os.hdel path; ()~key hsym `$path}]    
    .qtx.nil
    ]
  .qtx.nil;