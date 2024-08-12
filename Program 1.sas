 Code: Program 1.sas

/* 1. Crearea unui set de date SAS din fișiere externe*/
data Electronice_vanzari;
infile '/home/u63371627/Proiect/Electronice_vanzari2.csv' dsd firstobs=2 truncover;
input Nume_Produs $ Categorie $ Unitati_vandute Pret_pe_unitate Vanzari_totale Data_lansare mmddyy10.;
format Data_lansare date9.;
proc print data=Electronice_vanzari;
run;

/* 2. Crearea si aplicarea unui format definit de utilizator*/
proc format;
 value Vanzare
 low -< 1000 = 'Scăzute'
 1000 -< 3000 = 'Medii'
 3000 - high = 'Ridicate'
 ;
run;
data Unitati;
input Categorie$ Vanzare;
datalines;
iphone 4454.8
samsung 2316.5
sony 6377.1
lg 472.24
dell 902.6
;
title "Date despre numarul de vanzari";
proc print data=Unitati;
var Categorie Vanzare;
format Categorie $Categorie.
Vanzare Vanzare.;
 run;
 
/* 3. Procesarea iterativă și condițională a datelor*/
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
 Nume_max = Nume;
end;
title "Date despre vanzarile angajatilor";
proc print data=Vanzari_maxime;
run;

/* 4. Crearea de subseturi de date*/
data subset_vanzari;
set vanzari_angajati;
where Vanzari > 7000;
5/19/23, 2:59 PM Code: Program 1.sas
about:blank 2/4
title "Subsetul din Vanzari_Angajati";
proc print data=subset_vanzari;
run;
 
/* 5. Utilizarea de funcții SAS*/
data Functii;
infile '/home/u63371627/Proiect/Electronice_vanzari2.csv' dsd firstobs=2 truncover;
input Nume_Produs $ Categorie $ Unitati_vandute Pret_pe_unitate Vanzari_totale Data_lansare mmddyy10.;
format Data_lansare mmddyy10.;

/* Suma totală a vânzărilor */
proc sql;
 select sum(Vanzari_totale) as Suma_totala_vanzari
 from Functii;
quit;

/* Diferența în zile între data lansării și data curentă */
data dif_data;
 set Functii;
 Zile_diferenta = intck('day', Data_lansare, today());
 title "Functia intck() - diferenta de zile";
 proc print data=dif_data;
run;

/* Numărul de înregistrări pentru fiecare categorie */
proc sql;
 select Categorie, count(*) as Numar_inregistrari
 from Functii
 group by Categorie;
quit;

/* 6. Combinarea seturilor de date prin proceduri specifice SAS și SQL*/
data Functii;
infile '/home/u63371627/Proiect/Electronice_vanzari2.csv' dsd firstobs=2 truncover;
input Nume_Produs $ Categorie $ Unitati_vandute Pret_pe_unitate Vanzari_totale Data_lansare mmddyy10.;
format Data_lansare mmddyy10.;
run;

/* Setul de date rezultat din combinația utilizând procedura SQL */
proc sql;
 create table CombinedData as
 select A.*, B.Numar_inregistrari
 from Functii A
 left join
 (
 select Categorie, count(*) as Numar_inregistrari
 from Functii
 group by Categorie
 ) B
 on A.Categorie = B.Categorie;
quit;
proc print data=CombinedData;
run;

/* 7. Utilizarea de masive*/
data Masive;
infile '/home/u63371627/Proiect/Electronice_vanzari2.csv' dsd firstobs=2 truncover;
input Nume_Produs $ Categorie $ Unitati_vandute Pret_pe_unitate Vanzari_totale Data_lansare mmddyy10.;
format Data_lansare date9.;
run;

/* Calcularea sumei totale a vânzărilor */
data sum_masiv;
5/19/23, 2:59 PM Code: Program 1.sas
about:blank 3/4
 set Masive;
 sum_vanzari + Vanzari_totale;
run;

/* Calcularea mediei prețului pe unitate pentru fiecare categorie */
proc sql;
 create table Medii_preturi as
 select Categorie, mean(Pret_pe_unitate) as Medie_pret_unitate
 from Masive
 group by Categorie;
quit;
title "Suma totală a vânzărilor";
proc print data=sum_masiv;
run;
title "Media prețului pe unitate pentru fiecare categorie";
proc print data=Medii_preturi;
run;

/* 8. Utilizarea de proceduri pentru raportare*/
PROC IMPORT DATAFILE='/home/u63371627/Proiect/Electronice_vanzari2.csv'
 OUT=work.raport
 DBMS=CSV;
RUN;
PROC FREQ DATA=work.raport;
 TABLES Categorie;
RUN;
PROC MEANS DATA=work.raport;
 VAR Unitati_vandute Pret_pe_unitate Vanzari_totale;
RUN;
PROC REPORT DATA=work.raport;
 COLUMN Categorie Vanzari_totale;
 DEFINE Categorie / GROUP;
 DEFINE Vanzari_totale / ANALYSIS SUM;
RUN;

/* 9. Folosirea de proceduri statistice*/
PROC IMPORT DATAFILE='/home/u63371627/Proiect/Electronice_vanzari2.csv'
 OUT=work.raport
 DBMS=CSV;
RUN;

/* medie*/
PROC MEANS DATA=work.raport SUM;
 VAR Vanzari_totale;
 CLASS Categorie;
 OUTPUT OUT=Suma_vanzari_per_categorie SUM=Suma_vanzari;
RUN;
PROC SORT DATA=Suma_vanzari_per_categorie;
 BY descending Suma_vanzari;
RUN;
DATA Categorie_max_vanzari;
 SET Suma_vanzari_per_categorie;
 IF _N_ = 1; /* IF FIRST.Categorie; */
RUN;
PROC PRINT DATA=Categorie_max_vanzari;
RUN;

/* corelatie*/
PROC CORR DATA=work.raport;
5/19/23, 2:59 PM Code: Program 1.sas
about:blank 4/4
 VAR Unitati_vandute Pret_pe_unitate Vanzari_totale;
RUN;

/* regresie*/
PROC REG DATA=work.raport;
 MODEL Vanzari_totale = Unitati_vandute Pret_pe_unitate;
RUN;

/* 10. Generarea de grafice*/
PROC IMPORT DATAFILE='/home/u63371627/Proiect/Electronice_vanzari2.csv'
 OUT=work.raport
 DBMS=CSV;
RUN;

/* Histograma */
PROC SGPLOT DATA=work.raport;
 HISTOGRAM Vanzari_totale;
RUN;

/* Diagrama de dispersie */
PROC SGPANEL DATA=work.raport;
 PANELBY Categorie;
 SCATTER x=Pret_pe_unitate y=Vanzari_totale;
RUN;
