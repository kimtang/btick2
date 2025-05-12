d) lib btick2.repository
 Library to glue different repositories together
 q) .import.module`repository 

.import.require`os;

.repository.summary:{ .import.allConfig } / we whill show all loaded config file

d)fnc btick2.repository.summary 
 give a summary of available repositories.
 q) .repository.summary[] / show all available modules

.repository.showAllRepository:{
 r:select name,cfg:{x . `dependsOn`repository }@'cfg from .import.allConfig;
 r:select from r where 0<count@'cfg;
 raze exec {[name0;cfg] update from0:name0,name:first key[cfg] from value cfg }'[name;cfg] from r 
 }

d)fnc btick2.repository.showAllRepository 
 show all available repository
 q) .repository.showAllRepository[] / show all available modules

.repository.copyTemplate:{[orig;newPath;arg]
 allFiles:.os.tree orig;
 allFiles:select from allFiles where not child in parent;
 allFiles:update destination:{[orig;newPath;fullPath] ssr[;"__";"%"] ssr[fullPath;orig;newPath] }[orig;newPath;]@'string fullPath from allFiles;
 allFiles:update destination:`${[arg;destination] .bt.print[destination] arg}[arg ]@'destination from allFiles;
 {[arg;x]x[`destination]1:"x"$.bt.print["c"$read1 x`fullPath]arg}[arg]@'allFiles;
 allFiles	
 }

.repository.createRepository:{[name;path]
 newPath:.bt.print["%path%"] arg:`name`path`name0!(name;path;"%",string[name],"%");
 .repository.copyTemplate[;newPath;arg] .bt.print[":%btick2%/qlib/repository/template/repository"] .self
 }

d)fnc btick2.repository.createRepository 
 create Repository from template
 q) .repository.createRepository[`mylib;`$":/pathtoFolder"] / show all available modules


.repository.createCpp:{[name;path]
 if[-11h=type path;path:string path];
 if[":"=first path;path:1_path];
 newPath:.bt.print["%path%"] arg:`name`path`name0`os0`type0!(name;path;"%",string[name],"%";"%os%";"%type%");
 .repository.copyTemplate[;newPath;arg] .bt.print[":%btick2%/qlib/repository/template/cpp"] .self
 }

d)fnc btick2.repository.createCpp 
 create Repository from template
 q) .repository.createCpp[`mylib;`$":/pathtoFolder"] / show all available modules

.repository.createLib:{[repo;libName]
 if[path:repo in key .import.repository.con;path:hsym`$.import.repository.con repo];
 if[()~key path;'`.repository.not.found ];
 newPath:.bt.print["%path%/qlib/%name%"] arg:`name`path`repo`repo0!(libName;path;repo;"%",string[repo],"%");
 if[not()~key hsym`$newPath;'`.repository.lib.exists];
 .repository.copyTemplate[;newPath;arg] .bt.print[":%btick2%/qlib/repository/template/lib"] .self
 }

d)fnc btick2.repository.createLib 
 create library in an existing repository. This repository needs to be registered via the config file
 q) .repository.createLib[`:pathToRepository;`nameLib] / show all available modules 
 q) .repository.createLib[`mylib;`nameLib] / show all available modules
 q) .repository.createLib[`btick2;`remote] / show all available modules

.repository.createDefaultConfig:{ .j.k"c"$read1 `$.bt.print[":%btick2%/qlib/repository/template/config/default.json"] .self}

d)fnc btick2.repository.createDefaultConfig 
 create a default config
 q) .repository.createDefaultConfig[]  / show all available modules

.repository.saveConfig:{[repoName;config;opt]
 opt:(.bt.md[`mode]`deepMerge),opt;
 if[not(mode:opt`mode)in`replace`new`deepMerge;'`.repository.mode.notfound];
 if[not 99h=type config;'`.repository.config.notDictionary];
 arg:`name`path!enlist[repoName;]`$.bt.print[":%home%/.config/btick2/%cfg%.json"] ((1#`cfg)!1#repoName),.self;
 karg:key arg`path;
 if[`new ~ mode;
   if[not ()~karg;'`.repository.mode.config.exists];
   :arg[`path] 1: "x"$.j.j config
 ]; 
 if[`replace ~ mode;:arg[`path] 1: "x"$.j.j config];
 if[()~karg;:arg[`path] 1: "x"$.j.j config];
 :arg[`path]1:"x"$.j.j .util.deepMerge[ .j.k"c"$read1 arg[`path];]config
 }

d)fnc btick2.repository.saveConfig 
 save a config file
 q) .repository.saveConfig[`repoName;.repository.createDefaultConfig[];] .bt.md[`mode]`replace   / replace existing config file
 q) .repository.saveConfig[`repoName;.repository.createDefaultConfig[];] .bt.md[`mode]`new       / only write down if it is non-existent
 q) .repository.saveConfig[`repoName;.repository.createDefaultConfig[];] .bt.md[`mode]`deepMerge / merge with the existent one
 q) .repository.saveConfig[`repoName;.repository.createDefaultConfig[];()!()]    / default to new mode