*2;

proc import datafile='/folders/myfolders/sasuser.v94/smoking.csv' dbms=csv out=smoke_details replace;
run;

proc contents data=smoke_details;
run;

proc logistic data=smoke_details; 
model Smoker = risk Age Pressure;
output out=log_details;
run;quit;

ods csvall file='/folders/myfolders/sasuser.v94/Logistic_details_on_smokers.csv';
proc print data=log_details;
run;

/*CSV output for a risk value of 12 is not a smoker*/
