
d)lib btick2.datetime 
 Library for working with the lib datetime
 q).import.module`datetime 
 q).import.module`btick2.datetime
 q).import.module"%btick2%/qlib/datetime/datetime.q"

.datetime.summary:{} 

d)fnc btick2.datetime.summary 
 Give a summary of this function
 q) .datetime.summary[] 

.datetime.week:{(`s#0 1 2 3 4 5 6!`sat`sun`mon`tue`wed`thu`fri) x mod 7 }

d) fnc btick2.datetime.week
 Function to get the datetime db
 q).datetime.week .z.D
 q).datetime.week .z.D + til 7

.datetime.getYearStart:{[x] if[x~(::);x:.z.D]; r:`date$min@'allM @'where @'(`year$now)=`year$allM:(`month$now:(),x) -\: til 12;$[0>type x;first r;r] }

d) fnc btick2.datetime.getYearStart
 Function to get the start of the year
 q) 2022.01.01 2022.01.01 ~ .datetime.getYearStart x:2022.02.01 2022.02.01

.datetime.getYearEnd:{ -1+`date$ 12+`month$ .datetime.getYearStart x }

d) fnc btick2.datetime.getYearEnd
 Function to get the start of the year
 q) 2022.12.01 2022.01.01 ~ .datetime.getYearEnd x:2022.02.01 2022.02.01


.datetime.getSeason:{[x]if[14h=abs type x;x:`month$x]; (til[12]! 1 rotate raze 3#/:`winter`spring`summer`autum )x mod 12}

d) fnc btick2.datetime.getSeason
 Function to get the start of the year
 q) 2022.12.01 2022.01.01 ~ .datetime.getSeason 2022.02.01 2022.02.01


.datetime.eomonth:{[x] -1+`date$1+`month$x }

d) fnc btick2.datetime.eomonth
 Function to get end of month
 q) 2022.02.28 2022.01.31 ~ .datetime.eomonth 2022.02.01 2022.01.01

