
d)lib %name%.%name% 
 Library for working with qkdb internal api
 q).import.module`%name% 
 q).import.module`%name%.%name%
 q).import.module"%name0%/qlib/%name%/%name%.q"

.%name%.summary:{} 

d)fnc %name%.%name%.summary 
 Give a summary of this function
 q) .%name%.summary[] 

if[not`.%name%.lib.type~key`.%name%.lib.type;.%name%.lib.type:`Release];  / default is release

.%name%.lib.defPath:`$.bt.print[":%name0%/qlib/%name%/cpp/%name%.def"] .import.repository.con;
.%name%.lib.def:update fname:`${"." sv string x}'[flip(repo;nsp;name)] from update repo:`${".",1_first "_" vs x}@'name,nsp:`${first 1_"_" vs x}@'name,name:`${"_" sv  2_"_" vs x}@'name,orig:`$name from {select from x where not null num} flip`name`num!("*j";";") 0: read0 .%name%.lib.defPath
.%name%.lib.dll:`$.bt.print[":%name0%/qlib/%name%/cpp/bin/%os0%/%type0%/%name%"] .import.repository.con,.%name%.lib,.bt.md[`os] .z.o

{@[x`repo;x`nsp;:;](1#`)!(1#{})}@'key select by repo,nsp from .%name%.lib.def;
{.[x`repo;x`nsp`name;:;].%name%.lib.dll 2: x`orig`num }@'.%name%.lib.def;