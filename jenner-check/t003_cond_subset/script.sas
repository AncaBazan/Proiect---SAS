/* 3+4. Procesarea iterativa si conditionala a datelor, apoi subsetare
   (Program 1.sas, sections 3 and 4). Unmodified — the source dataset was
   already inline DATALINES in the original, so no adaptation was needed. */
data vanzari_angajati;
infile datalines dlm=' ';
input Nume $ Luna $ Vanzari;
datalines;
Ion ianuarie 5000
Maria ianuarie 7000
Mihai ianuarie 6000
Emilia ianuarie 8000
Ion februarie 9000
Maria februarie 6000
Mihai februarie 8000
Emilia februarie 7500
;
run;

data Vanzari_maxime;
set vanzari_angajati;
if Vanzari > 7000 then do;
 max_vanzari = Vanzari;
end;
run;

title "Date despre vanzarile angajatilor";
proc print data=Vanzari_maxime;
run;

data subset_vanzari;
set vanzari_angajati;
where Vanzari > 7000;
run;

title "Subsetul din Vanzari_Angajati";
proc print data=subset_vanzari;
run;
