
.self.btick2:getenv`btick2
.self.zo:.z.o
/.self.docker:max @[system;"cat /proc/1/cgroup";{()}] like"*docker*";
.self.os:first string .self.zo
.self.getHome0:()!()
.self.getHome0["w"]:{getenv[`USERPROFILE] }
.self.getHome0["l"]:{getenv[`HOME] }
.self.getHome:{ if[not ""~btick2Home:getenv`btick2Home;:btick2Home]; .self.getHome0[.self.os][] }
.self.home:.self.getHome[]