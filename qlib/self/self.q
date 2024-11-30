
.self.btick2:getenv`btick2
if[() ~ key `.self.mode;.self.mode:`user];
.self.zo:.z.o
/.self.docker:max @[system;"cat /proc/1/cgroup";{()}] like"*docker*";
.self.os:first string .self.zo
.self.getHome0:()!()
.self.getHome0["w"]:{getenv[`USERPROFILE],"/.config/btick2" }
.self.getHome0["l"]:{getenv[`HOME],"/.config/btick2" }
.self.getHome:{ if[not ""~btick2Home:getenv`btick2Home;:btick2Home]; .self.getHome0[.self.os][] }

.self.getCwd0:()!()
.self.getCwd0["w"]:{system"cd" }
.self.getCwd0["l"]:{system["pwd"]0 }
.self.getCwd:{.self.getCwd0[.self.os][]}


.self.home:.self.getHome[]
.self.cwd:.self.getCwd[]
