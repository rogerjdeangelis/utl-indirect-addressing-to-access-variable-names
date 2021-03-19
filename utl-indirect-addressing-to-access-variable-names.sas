
Indirect addressing to access variable names

GitHub
https://tinyurl.com/nn6ayjje
https://github.com/rogerjdeangelis/utl-indirect-addressing-to-access-variable-names

I need tpo create a list of students taking various subjects, but I don't
have student names in the table. Only column headings contain the student names.

We use the position in an array of column names to get the column name into the data.
I think this type of addressing is underused in sas.

Inspired by
https://tinyurl.com/jxvcpek
https://communities.sas.com/t5/SAS-Programming/How-can-i-can-concatnate-Variable-according-to-their-values/m-p/727662

PeterClemmensen
https://communities.sas.com/t5/user/viewprofilepage/user-id/31304


PROBLEM
=======

WORK.HAVE total obs=3

  SUBJECT    ROGER    MARY    MIKE    MARK

  Math         1        1       1       1
  History      1        1       .       .
  Music        .        .       .       1


WANT
====

 WORK.WANT total obs=3                    |   RULES
                                          |
 SUBJECT    ROGER    MARY    MIKE    MARK |   CONCAT                  TOTAL
                                          |
 Math         1        1       1       1  |   ROGER,MARY,MIKE,MARK      4
 History      1        1       .       .  |   ROGER,MARY                2
 Music        .        .       .       1  |   MARK                      1

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

data have;
   input Subject$   roger  mary mike mark;
cards4;
Math        1      1    1    1
History     1      1    .    .
Music       .      .    .    1
;;;;
run;quit;

*
 _ __  _ __ ___   ___ ___  ___ ___
| '_ \| '__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
;


data want;
  set have;
  length class_list $30;
  array avars{4} ROGER MARY MIKE MARK;
  do i=1 to dim(avars);
    if avars{i} ne . then class_list=catx(",",class_list,vname(avars{i}));
  end;
  total=sum(of avars{*});
  drop i;
run;quit;

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

Up to 40 obs from WANT total obs=3

 SUBJECT    ROGER    MARY    MIKE    MARK    CLASS_LIST              TOTAL

 Math         1        1       1       1     ROGER,MARY,MIKE,MARK      4
 History      1        1       .       .     ROGER,MARY                2
 Music        .        .       .       1     MARK                      1






