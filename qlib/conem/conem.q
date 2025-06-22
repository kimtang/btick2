
d)lib %btick2%/qlib/conem/conem.q 
 Library for working with the lib console emulator
 q).import.module`conem 
 q).import.module`btick2.conem
 q).import.module"%btick2%/qlib/conem/conem.q"

.conem.summary:{} 

d).conem.summary 
 Give a summary of this function
 q) .conem.summary[] 

.conem.windowSize0:()!()
.conem.windowSize0["w"]:{ reverse lst where not null lst:"J"$ " " vs system["powershell -command \"&{(get-host).ui.rawui.WindowSize;}\""] 3}

/ replace this with a linux version
.conem.windowSize0["l"]:{ reverse lst where not null lst:"J"$ " " vs system["powershell -command \"&{(get-host).ui.rawui.WindowSize;}\""] 3}

.conem.windowSize:{ .conem.windowSize0[.self.os][] }

d).conem.windowSize
 Function to get windows size
 q) .conem.windowSize[]

.conem.blankScreen:{ s[1] cut (prd s:.conem.windowSize[])#" "}  

.conem.clear:{ -1 .conem.blankScreen[]; }  

d).conem.clear
 Function to get windows size
 q) .conem.clear[]