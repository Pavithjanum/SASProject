*1;

proc import datafile='/folders/myfolders/sasuser.v94/smoking.csv' dbms=csv out=smoke_details replace;
run;

proc contents data=smoke_details;
run;

proc means data=smoke_details;
var Pressure;
where Smoker = 'Yes';
run;

proc means data=smoke_details;
var Pressure;
where Smoker = 'No';
run;

/*Yes, the mean of Pressure is higher for Smoker than Non Smoker*/

* For smokers only:;

data smoker_details;
set smoke_details;
where Smoker = 'Yes';
run;

proc print data=smoker_details;
run; 

proc reg data=smoker_details;
model risk=Age;
run;
quit;

/*The inference from the above regression is an age increase of 1 will results the risk increased by 0.84425.
Hence the risk increase if age increases by ten years = (0.84425 * 10) = 8.4425 =~8.5 */
/* risk = intercept + coefficent * Age i.e, risk = -25.08369 + (0.84425 * 10) *Age */

proc reg data=smoker_details;
model risk=pressure;
run;
quit;

/*The inference from the above regression is - pressure increase of 1 will results the risk increased by 0.20442.
Hence the risk increase if blood pressure increases by 10 units = (0.20442 * 10) =2.0442 =~ 2*/
/* risk = intercept + coefficent * pressure i.e, risk = 3.60257 + (0.20442 * 10) *pressure */

proc reg data=smoker_details;
model risk=pressure;
run;
quit;

/*The inference from the above regression is - pressure increase of 1 will results the risk increased by 0.20442.
Hence the risk increase if blood pressure increases by 10 % = (0.20442 * 0.1) =0.020442 */
/* risk = intercept + coefficent * pressure i.e, risk = 3.60257 + (0.20442 * 0.1) *pressure */

*For non-smokers only:;


data nonsmoker_details;
set smoke_details;
where Smoker = 'No';
run;

proc print data=nonsmoker_details;
run; 

proc reg data=nonsmoker_details;
model risk=Age;
run;
quit;

/*The inference from the above regression is an age increase of 1 will results the risk increased by 0.43768.
Hence the risk increase if age increases by ten years = (0.43768   * 10) = 4.3768 =~4 **/
/* risk = intercept + coefficent * Age i.e, risk = -11.61175 + (0.43768 * 10) *Age */


proc reg data=nonsmoker_details;
model risk=pressure;
run;
quit;

/*The inference from the above regression is - pressure increase of 1 will results the risk increased by 0.04973.
Hence the risk increase if blood pressure increases by 10 units = (0.04973 * 10) =0.4973 =~ 0.5*/
/* risk = intercept + coefficent * pressure i.e, risk = 9.55065 + (0.04973 * 10) *pressure */

proc reg data=nonsmoker_details;
model risk=pressure;
run;
quit;

/*The inference from the above regression is - pressure increase of 1 will results the risk increased by 0.04973.
Hence the risk increase if blood pressure increases by 10 % = (0.04973 * 0.1) =0.004973 =~ 0*/
/* risk = intercept + coefficent * pressure i.e, risk = 9.55065 + (0.04973 * 0.1) *pressure */



