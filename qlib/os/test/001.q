
.qtx.testSuiter[`os1;`repo`lib`file!`btick2`os`001;"test os"]
  .qtx.before[{
    loadResult:.import.module`os;
    tmpFolder:.util.genTmpFolder[];
    newFile:{x 1: "x"$"HelloWorld\nHelloWorld"}@' `$.bt.print[;tmpFolder]@'(":%path%/a/b/c.q";":%path%/a/d/e.q";":%path%/f.q");
    tmpFolder,`newFile`loadResult!(newFile;loadResult)
    }]
  .qtx.testCase[`os1;"test os"][
    .qtx.shouldTrue[`0;"file loaded successfully";{[loadResult]
      null loadResult`error
      }]
    .qtx.nil
    ]
  .qtx.testCase[`os2;"test os"][
    .qtx.should[`0;"description";{[path]
      r:.bt.md[`allFiles]allFiles: .os.tree path;
      `return`test!enlist[r;] 7=count allFiles
      }]
    .qtx.shouldTrue[`1;"description";{[allFiles] min `a`f.q`b`d`c.q`e.q in allFiles`sym }]
    .qtx.shouldTrue[`2;"description";{[allData;path] 2=count .os.treeIgnore[.bt.print["%path%/a"]allData] path }]
    .qtx.shouldTrue[`3;"description";{[path] 6=count .os.treeIgnore["*/f.q"]path }]
    .qtx.shouldTrue[`4;"description";{[path] 3=count .os.treen[1]path }]        
    .qtx.shouldTrue[`5;"description";{[path] .os.hdel path; ()~key hsym `$path}]    
    .qtx.nil
    ]    
  .qtx.argument[`mon`tue`wed`thu`fri`sat`sun!2025.04.21 + til 7]
  .qtx.nil
  ;

/

.qtx.rsummary[]