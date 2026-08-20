/* 9. Folosirea de proceduri statistice (Program 1.sas, section 9): PROC
   MEANS with CLASS/OUTPUT, PROC SORT, PROC CORR, PROC REG. Original imports
   via PROC IMPORT DATAFILE='/home/u63371627/Proiect/Electronice_vanzari2.csv'
   DBMS=CSV; here the same 6-column layout is supplied inline via DATALINES
   with a sample drawn from the repo's own Electronice_vanzari2.xlsx, and a
   larger 20-row sample is used so PROC REG has enough rows for a stable fit. */
data work.raport;
infile datalines dsd dlm=',' truncover;
input Nume_Produs $ Categorie $ Unitati_vandute Pret_pe_unitate Vanzari_totale Data_lansare mmddyy10.;
format Data_lansare mmddyy10.;
datalines;
Apple_iPhone_12,Telefon,20,4522.74,90454.8,01/01/2023
Samsung_Galaxy_S21,Telefon,15,4021.1,60316.5,01/03/2023
Apple_iPad_Pro_12in,Tablete,10,5237.71,52377.1,01/05/2023
Samsung_Galaxy_Tab_S7,Tablete,8,2809.03,22472.24,01/06/2023
Sony_PlayStation_5,Jocuri video,5,2220.52,11102.6,03/08/2023
Microsoft_Xbox_Series_X,Jocuri video,6,2665.45,15992.7,01/01/2023
Apple_MacBook_Air,Laptopuri,3,5237.71,15713.13,02/01/2023
Dell_XPS_13,Laptopuri,4,6053.26,24213.04,04/14/2023
Samsung_QLED_Q90T,Televizoare,2,10017.84,20035.68,01/16/2023
LG_OLED_CX,Televizoare,3,8014.27,24042.81,01/17/2023
Apple_iPhone_13,Telefon,25,3989.97,99749.25,02/01/2023
Samsung_Galaxy_Z_Flip_3,Telefon,12,5237.71,62852.52,02/03/2023
Apple_iPad_mini,Tablete,15,2094.3,31414.5,02/05/2023
Samsung_Galaxy_Tab_A7_Lite,Tablete,20,701.43,14028.6,04/06/2023
Sony_PlayStation_5,Jocuri video,10,2220.52,22205.2,02/10/2023
Microsoft_Xbox_Series_X,Jocuri video,8,2665.45,21323.6,02/11/2023
Apple_MacBook_Pro_16in,Laptopuri,2,10017.84,20035.68,02/13/2023
Dell_XPS_15,Laptopuri,3,7594.73,22784.19,02/14/2023
Samsung_QLED_Q70T,Televizoare,5,6021.05,30105.25,02/16/2023
LG_OLED_BX,Televizoare,4,5237.71,20950.84,04/17/2023
;
run;

/* medie */
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
 IF _N_ = 1;
RUN;

PROC PRINT DATA=Categorie_max_vanzari;
RUN;

/* corelatie */
PROC CORR DATA=work.raport;
 VAR Unitati_vandute Pret_pe_unitate Vanzari_totale;
RUN;

/* regresie */
PROC REG DATA=work.raport;
 MODEL Vanzari_totale = Unitati_vandute Pret_pe_unitate;
RUN;
QUIT;
