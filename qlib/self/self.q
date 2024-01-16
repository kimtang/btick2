
.self.btick2:getenv`btick2
.self.os:first string .z.o
.self.getHome0:()!()
.self.getHome0["w"]:{getenv[`USERPROFILE] }
.self.getHome0["l"]:{getenv[`HOME] }
.self.getHome:{.self.getHome0[.self.os][] }
.self.home:.self.getHome[]