
d)lib btick2.xml 
 Library for working with the lib xml
 q).import.module`xml 
 q).import.module`btick2.xml
 q).import.module"btick2/qlib/xml/xml.q"

.xml.summary:{} 

d)fnc xml.xml.summary 
 Give a summary of this function
 q) xml.summary[] 

/ translated from https://a.kx.com/a/k/examples/xml.k
/ xml: (tag;data|xml+;(attr;value)*)  dtd: element(,|?+*) attlist entity

\d .xml

L:"<";W:"\t\r\n",B:" ";S:"/";R:">";

ct:{$[count y;count[x]_'ss[y;x]_y:x,y;()]};
/join:{count[x]_(0#x),/x,/:y}

oc:{1 rotate";&#",`char$48+8 8 8 vs `int$x} / octal from char, e.g. oc"a"
co:{`char$8 sv -48+`int$3_-1 rotate x} / char from octal, e.g. co"&#141;"
/ in k2, ssr can have a monad as final arg - ssr2 is designed to emulate this
ssr2:{[x;y;z]
	if[100h=type z;
		if["*" in y;'`length];
		/ get length of matched search string, [...] will match one char
		c:sum 0=sums 1 -1"[]"?y;
		/ find all matching strings, run monad on them & then use ssr to substitute in result
		:ssr/[x;y;raze each z@'y:distinct x ss[x;y]+\:til c];
	];
	:ssr[x;y;z];
	};
xc:ssr2/[;"&<>'",enlist"[\200-\377]";("&amp;";"&lt;";"&gt;";"&apos;";oc)]	/ xml from char
cx:ssr2/[;("&amp;";"&lt;";"&gt;";"&apos;";"&#???;");"&<>'",co]		/ char from xml

ex:{(where b&1=(+\)(b:b&not e)-(c&1 rotate R=x)|e:(b:L=x)&1 rotate c:S=x)_ x} / element from xml
dx:{[x]
	/ trim to end of XML tag & remove tabs/returns/newlines
	s:ssr/[(n:x?R)#x;W;B];
	/ break into tag & attributes
	a:(1+m:s?B)_s;
	/ remove trailing slash if present
	a:(neg S=last a)_a;
	/ n is end of XML tag, so check if the element contains data and extract it if so
	x:$[count except[x:(1+n)_x;W];(neg m+1)_(first i)_(last i:where not x in\:W)#x;""];
	/ iterate through each element, build return of (tag;contents)
	r:(`$1_m#s;$[L=first x;.z.s each ex x;cx x]);
	/ check for presence of attributes in XML tag, if they exist parse them & add as third element
	:r,$[not count a@:where 0<count each a:ct[B]a;a;enlist{(`$n#x;-1_(2+n:x?"=")_x)}'[a]];
	}


\d .




/

/ example usage
d:dx x:"<g><f a='2'/><h>34</h><i b='3' c='asdf'>asdf</i></g>"