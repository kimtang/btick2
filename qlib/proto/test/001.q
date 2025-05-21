

.qtx.testSuiter[`proto1;`repo`lib`file!`btick2`proto`001;"test proto"]
  .qtx.before[{.bt.md[`loadResult] .import.module`proto}]
  .qtx.testCase[`proto1;"test loaded file"][
    .qtx.shouldTrue[`0;"file loaded successfully";{[loadResult]
      null loadResult`error
      }].qtx.nil  
    ]
  .qtx.testCase[`proto2;"test proto"][
    .qtx.before[{
      o:.proto.odefine[`Plus;{[x;y](x[0]+y[0];x[1]+y[1])}]
      .proto.odefine[`Hyphen;{[x;y](x[0]-y[0];x[1]-y[1])}]
      .proto.odefine[`Multiply;{[x;y]enlist[x[0]*y[0];] (x[0]*y[1])+x[1]*y[0]}]
      .proto.odefine[`Log;{[x]enlist[log x[0];]x[1] % x[0] }]
      .proto.odefine[`Sin;{[x]enlist[sin x[0];] x[1]*cos x[0] }]
      .proto.odefine[`Cos;{[x]enlist[cos x[0];] x[1]*neg sin x[0]}]
      .proto.odefine[`Procenttecken;{[x;y] enlist[x[0]%y[0];] ((x[1]*y[0]) - x[0]*y[1]) % y[0]*y[0] }]
      .proto.odefine[`Exp;{[x] enlist[exp x[0];] x[1]*exp x[0] }]
      .proto.odefine[`Xexp;{[x;y] enlist[x[0] xexp y[0];] x[1] *y[0]* x[0] xexp -1+y[0] }]
      .proto.nil;  
      a:{[x;y] y x } over enlist[ .proto.nil], .proto.adefine[;{(x;0f)}]@' `float`long`int`real;
      `a`o`g!enlist[a;o;]{[x1;x2] ((x1*x2) + log x1) - sin x2}
      }]
    .qtx.shouldData[`0;"test .proto.getb";"%btick2%/qlib/proto/testData/proto2/0";{[g]
      .proto.getb g
      }]

    .qtx.shouldData[`1;"test .proto.getb";"%btick2%/qlib/proto/testData/proto2/1";{[g]
      .proto.getb g[1]
      }]

    .qtx.shouldData[`2;"test .proto.getb";"%btick2%/qlib/proto/testData/proto2/2";{[g]
      .proto.getb g[;2]
      }]

    .qtx.shouldData[`3;"test .proto.proto";"%btick2%/qlib/proto/testData/proto2/3";{[a;o;g]
      df:.proto.proto[a;o;g];
      df[(1;1 0);(2;0 1)]
      }]

    .qtx.shouldData[`4;"test .proto.proto";"%btick2%/qlib/proto/testData/proto2/4";{[a;o;g]
      df:.proto.proto[a;o;g[1]];
      df[(2;1)]
      }]

    .qtx.shouldData[`5;"test .proto.proto";"%btick2%/qlib/proto/testData/proto2/5";{[a;o;g]
      df:.proto.proto[a;o;g[;2]];
      df[(1;1)]
      }]
    .qtx.shouldTrue[`5;"test .proto.proto";{1b}]

    .qtx.after[{}]
    .qtx.nil
    ]
  .qtx.nil
  ;

/