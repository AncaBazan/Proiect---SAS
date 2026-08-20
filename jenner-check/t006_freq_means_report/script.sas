/* 8. Utilizarea de proceduri pentru raportare (Program 1.sas, section 8):
   PROC FREQ, PROC MEANS, PROC REPORT. Original imports via
   PROC IMPORT DATAFILE='/home/u63371627/Proiect/Electronice_vanzari2.csv'
   DBMS=CSV; here the same 6-column layout is supplied inline via DATALINES
   with a sample drawn from the repo's own Electronice_vanzari2.xlsx, so the
   reporting procedures below run exactly as authored. */
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
;
run;

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
