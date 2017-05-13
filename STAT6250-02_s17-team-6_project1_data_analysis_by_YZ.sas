*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding homicide incidences in the US from 2000-2004.

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




title1
'Research Question: How does the distribution of Perpetrator age for male perpetrators compare to that of female?'
;

title2
'Rationale: This would help to determine the relationship between the age group of male perpetrators and female perpetrators.'
;

footnote1
'Based on the above output, it shows that in the similar age range, there are more male perpetrators than female perpetrators.'
;

footnote2
'We can conclude that there are more perpetrators at the age in the range of .'
;

footnote3
"In addition, more analysis is needed for the group with value 'N/A'."
;

*
Methodology: Compute five-number summaries by perpetrator_age variable
Limitations: This methodology does not account for perpetrator sex with missing data.

Possible Follow-up Steps: More carefully clean the values of the variable
Perpetrator_age so that the statistics computed do not include any
possible illegal values, and better handle missing data, e.g., by using a
previous year's data or a rolling average of previous years' data as a proxy.
;

proc means
        min q1 median q3 max
        data=Homicide_analytic_file_temp
    ;
    class
        Perpetrator_Sex
    ;
    var
        Perpetrator_Age
    ;
run;
title;
footnote;




title 1
'Research Question: Does the outcome shows that the there are more white victims than the other race came across murder in some specific states?'
;

title 2
'Rational: It helps us to determine the relationship between race and state.'
;

footnote 1
'The output shows that there's correlationship between the two variables.'
;
footnote 2
'The correlationship between the two variables are positive.'
;
footnote 3
"More observation needed to be applied to the dataset to clean up the outliers."
;

*
Methodology: Compute five-number summaries 

Limitation: This methodology does not account for schools with missing data.

Possible follow-up steps: More carefully clean the values of the variable 
Homicide_analytic_file so that the statistics computed do not include any 
possible illegal values and can better handle missing data.


proc means min q1 median q3 max data=Homicide_analytic_file;
    class Incident;
    var Victim Race;
run;
title;
footnote;



title 1
'Research Question: What are the top thirty states with the highest mean values of perpetrator?'
;

title 2
'Rationale: This should help identify the relationship between the states (location) and the perpetrator count.'
;
footnote 1
'The top thirty states with the highest mean values of perpetratoes are listed in the output.'
;
footnote 2
'More observation should be applied to the missing data.'
;
footnote 3
'We need to clean out the outliers to fit the model better.'
;

*
Methodology: Use PROC MEANS to compute the mean of perpetratoes from year 
1980- 2014for State_Name to output the results to a temporary dataset. 
Use PROC SORT extract and sort just the means the temporary dateset, and use
PROC PRINT to print just the first thirty observations from the temporary 
dataset.

Limitations: This methodology does not account for states with missing data.

Possible Follow-up Steps: More carefully clean the values of the variable of 
locations.


proc print
        noobs
        data=Homicide_analytic_file_temp(obs=30)
    ;
    id
       State
    ;
    var
        Perpetrator_Count
    ;
run;
title;
footnote;


