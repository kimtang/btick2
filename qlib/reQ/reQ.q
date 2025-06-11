
d)lib btick2.reQ 
 HTTP requests library in kdb+/q; modified from https://github.com/jonathonmcmurray/reQ
 q).import.module`reQ 
 q).import.module`btick2.reQ
 q).import.module"%btick2%/qlib/reQ/reQ.q"

.reQ.summary:{} 

d)fnc reQ.reQ.summary 
 Give a summary of this function
 q) reQ.summary[] 

.import.require"%btick2%/qlib/reQ/ext/os.q";
.import.require"%btick2%/qlib/reQ/url.q";
.import.require"%btick2%/qlib/reQ/cookie.q";
.import.require"%btick2%/qlib/reQ/b64.q";
.import.require"%btick2%/qlib/reQ/status.q";
.import.require"%btick2%/qlib/reQ/reqmain.q";
.import.require"%btick2%/qlib/reQ/auth.q";
.import.require"%btick2%/qlib/reQ/multipart.q";