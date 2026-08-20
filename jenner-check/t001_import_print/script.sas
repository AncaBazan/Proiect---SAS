/* 1. Crearea unui set de date SAS din fisiere externe (adapted from Program 1.sas,
   section 1). Original reads infile '/home/u63371627/Proiect/Electronice_vanzari2.csv';
   here the same 6-column layout (Nume_Produs Categorie Unitati_vandute Pret_pe_unitate
   Vanzari_totale Data_lansare) is supplied inline via DATALINES with a sample drawn
   from the repo's own Electronice_vanzari2.xlsx so the DATA step and PROC PRINT run
   unmodified. */
data Electronice_vanzari;
infile datalines dsd dlm=',' truncover;
input Nume_Produs $ Categorie $ Unitati_vandute Pret_pe_unitate Vanzari_totale Data_lansare mmddyy10.;
format Data_lansare date9.;
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
;
run;

proc print data=Electronice_vanzari;
run;
