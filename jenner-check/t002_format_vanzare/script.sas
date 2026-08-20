/* 2. Crearea si aplicarea unui format definit de utilizator (Program 1.sas, section 2).
   Unmodified from the original except for the file path context — the PROC FORMAT
   value ranges and the inline datalines are exactly as authored. */
proc format;
 value Vanzare
 low -< 1000 = 'Scazute'
 1000 -< 3000 = 'Medii'
 3000 - high = 'Ridicate'
 ;
run;

data Unitati;
input Categorie $ Vanzare;
datalines;
iphone 4454.8
samsung 2316.5
sony 6377.1
lg 472.24
dell 902.6
;
run;

title "Date despre numarul de vanzari";
proc print data=Unitati;
var Categorie Vanzare;
format Vanzare Vanzare.;
run;
