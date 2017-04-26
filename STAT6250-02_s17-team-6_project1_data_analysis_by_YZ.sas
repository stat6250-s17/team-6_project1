*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding homicide incidences in the US from 2000-2014.
Dataset Name: Homicide_analytic_file created in external file
STAT6250-02_s17-team-6_project1_data_preparation.sas, which is assumed to be
in the same directory as this file
See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that generates analytic dataset Homicide_analytic_file;
%include '.\STAT6250-02_s17-team-6_project1_data_preparation.sas';

/*
*******************************************************************************;
* Research Question: What is the relationship between where the crime take place and the rate of the solved crimes?
Rational: It helps to determine whether the geographic environment will have positive/negative impact on the case solving.
Methodology: Use PROC Freq to compute sum the number of solved crimes for each year corresponds to the cities that
the crime took place. Run a scatterplot and check assumption.
Limitation: There might exist missing data and other environmental factors that will cause bias, such as the migration rate of 
the resident.
Possible follow-up steps: Clean out the outliers in the data and ignore the "noises" in some situation. Make adjustment
to the data set and apply the abline to the output.
*******************************************************************************;
*/

proc freq data=Homicide_analytic_file;
    tables Crime Solved;
    var City;
    output out=Homicide_analytic_file_temp;
run;

proc univariate data=Homicide_analytic_file; 
		var Crime Solved City;
		run;


/*
*******************************************************************************;
Research Question: Does the outcome shows that the there are more white victims than 
the other race came across murder in some specific states? 
Rational: It helps us to determine the relationship between race and state.
Methodology: Compute five-number summaries 
Limitation: This methodology does not account for schools with missing data.
Possible follow-up steps: More carefully clean the values of the variable Homicide_analytic_file 
so that the statistics computed do not include any possible illegal values and can better handle missing data.
*******************************************************************************;
*/


proc means min q1 median q3 max data=Homicide_analytic_file;
    class Incident;
    var Victim Race;
run;

/*
*******************************************************************************;
Research Question: What are the top thirty states with the highest mean values of perpetratoes?
Rationale: This should help identify the relationship between the states (location) and the perpetratoes.
Methodology: Use PROC MEANS to compute the mean of perpetratoes from year 1980- 2014for State_Name to 
output the results to a temporary dataset. Use PROC SORT extract and sort just the means the temporary dateset, 
and use PROC PRINT to print just the first thirty observations from the temporary dataset.
Limitations: This methodology does not account for states with missing data.
Possible Follow-up Steps: More carefully clean the values of the variable of locations.
*******************************************************************************;
*/
proc means mean noprint data=Homicide_analytic_file;
    class States_Name;
    var Incidence;
    output out=Homicide_analytic_file_temp;
run;

    var Homicide_analytic_file_temp;
    output out=Homicide_analytic_file_temp;
run;

proc sort data=FRPM1516_analytic_file_temp(where=(_STAT_="MEAN"));
    by descending Incidence;
run;

proc print noobs data=Homicide_analytic_file_temp(obs=30);
    id State_Name;
    var Incidence;
run;
