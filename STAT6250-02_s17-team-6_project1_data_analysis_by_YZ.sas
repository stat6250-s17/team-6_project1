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
'Research Question: What is the distribution of Perpetrator age look like for male perpetrators compare to that of female?'
;

title2
'Rationale: This would help to determine the relationship between the age groups of male perpetrators and female perpetrators.'
;

footnote1
'Based on the above output, it shows that in the similar age range, there are much more male perpetrators than female perpetrators.'
;

footnote2
'At the age range from 35 to 50, it obtains the most perpetrators both for male and female .'
;

footnote3
'In addition, more analysis is needed for the group with value Unknown because it has about 31.1% counts out of the whole dateset.'
;

*
Methodology: Compute five-number summaries by perpetrator_age variable. Divide the age range into five groups and compute the counts 
corresponding to two genders at different levels.

Limitations: This methodology does not account for perpetrator sex with missing data.

Possible Follow-up Steps: More carefully clean the values of the variable
Perpetrator_age so that the statistics computed do not include any
possible illegal values, and better handle missing data, e.g., by using a
previous year's data or a rolling average of previous years' data as a proxy.
;

proc format;

value perpetrator_age_bin

low-18="Teenager perpetrator age"

19-34="Adult perpetrator age"

35-50="Midage perpetrator age"

51-high="Old perpetrator age"

;

run;

proc freq data=homicide_analytic_file;

table perpetrator_sex*perpetrator_age/norow nocol;

format perpetrator_age perpetrator_age_bin.;

run;

title;

footnote;




title1
'Research Question: What is the relationship between victim race and the number of incidents?'
;

title2
'Rational: It helps us to learn if it appears more victims in some particular races than the other.'
;

footnote1
'The output shows that there is more white victims than black victims.'
;
footnote2
'The output shows that the Native American and Alaska Native has the least victims (incidents).'
;
footnote3
'More observation needed to be applied to the dataset to analysis the missing data (unknown).'
;

*
Methodology: Compute five-number summaries 

Limitation: This methodology does not account for victims with missing data.

Possible follow-up steps: More carefully clean the values of the variable 
Homicide_analytic_file so that the statistics computed do not include any 
possible illegal values and can better handle missing data.
;

proc means min q1 median q3 max data=Homicide_analytic_file;
    class Victim_Race;
    var Incident;
run;
title;
footnote;



title1
'Research Question: What is the spread of the counts of perpetrator corresponding to each state?'
;

title2
'Rationale: This should help identify the relationship between the states (location) and the perpetrator count.'
;
footnote1
'The maximum count for perpetrator is 10 in New Jersey and Florida.'
;
footnote2
'More observation should be applied to the missing data because there are some states that have much less observations
than the other states.'
;
footnote3
'We need to clean out the outliers to fit the model better.'
;

*
Methodology: Use PROC MEANS to compute the mean of perpetrators from year 
2000- 2004for State_Name to output the results to a temporary dataset. 
Use SAS to print out the table of the spread perpetrator counts of each states.

Limitations: This methodology does not account for states with missing data.

Possible Follow-up Steps: More carefully clean the values of the variable of 
locations.
;

proc means
        min q1 median q3 max
        data=Homicide_analytic_file
    ;
    class
        State
    ;
    var
        Perpetrator_Count
    ;
run;
title;
footnote;

