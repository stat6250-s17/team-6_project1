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

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";
　
* load external file that generates analytic dataset Homicide_analytic_file;
%include '.\STAT6250-02_s17-team-6_project1_data_preparation.sas';
　
　
title1
'Research Question: Are victims more likely to be male or female?'
;

title2
'Rationale: Nowadays, it is widely believed that females are weaker than males, I would like to see the dataset shows the numbers of male victims and female victims. Also, is there any trend between the gender and age.'
;

footnote1
'Based on the above output, there are the number of male victims, female victims and unknown.'
;

footnote2
'Moreover, we can see that the number of male victims (that is 50,678) is extremely higher than the number of female victims (that is 14,741).'
;
*
Methodology: Compute five-number summaries by victims age indicator variable.

Limitations: This problem is straight forward, the only draw-back would be if
the male/female category isn't given so we can't sort them properly.

Possible Follow-up Steps: We only need to make sure that both age column
and male/female are given.
;
proc means 
        min q1 median q3 max
        data=homicide_analytic_file
    ;
    var 
        victim_age
    ;
run;
proc format;
        value victim_age_bin
        low-22="q1 victim age"
        23-29="q2 victim age"
        30-42="q3 victim age"
        43-high="q4 victim age"
    ;
run;
proc freq 
        data=homicide_analytic_file
    ;
    table 
        victim_sex*victim_age/norow nocol nopercent
    ;
    format 
        victim_age victim_age_bin.
    ;
run;
title;
footnote;



title1
'Research Question: What are the top three weapons used?'
;

title2
'Rationale: This should help identify the most commonly used weapon. It could help the police to strengthen risk prevention, and the weapon management and control shall be strengthened.'
;

footnote1
'Based on the above output, there are top three weapons used that are handgun, knife and blunt object.'
;

footnote2
'Moreover, we can see that the percentage of weapons used, the percentage of handgun is over half of all weapons used.'
;
*
Methodology: Use PROC SORT extract and sort the weapon from the dataset,
and output the results to a temporary dataset. Use PROC PRINT to print
the first three observations from the temporary dataset.

Limitations: This methodology does not account for districts with unknown
data, nor does it attempt to validate data in any way.

Possible Follow-up Steps: More carefully clean the values of the variable.
;
proc freq 
        data=homicide_analytic_file
    ;
    table 
        weapon/ noprint out=weapon_frequency
    ;
run;

proc sort 
        data=weapon_frequency out=weapon_sorted
    ;
    by 
        descending count;
run;
proc print
        noobs
        data=weapon_sorted(obs=3)
    ;
run;
title;
footnote;



title1
'Research Question: What the percentage of the perpetrator who is less than 18 years old?'
;

title2
'Rationale: The tendency of young aged crimes committed by juveniles has become a hot topic for the media, I would like to see the overall and trend to verify an increase in juvenile delinquency.'
;

footnote1
'Based on the above output, the number of perpetrators who under 18 years old and over 18 years old.'
;

footnote2
'Moreover, we can see that the number and percentage of perpetrators who under 18 years old (that is 2,750, 4.2%), and the number and percentage of perpetrators who over 18 years old (that is 38,541, 58.81%)'
;
*
Methodology: Compute five-number summaries by Perpetrators age indicator 
variable. Create formats to bin values of Perpetrator_Age_bin, categorize 
the variable "Perpetrator Age" into two groups, "under 18" and "over 18”. 
And use proc freq to cross-tabulate bins.

Limitations: The assumptions for this model has potential error, because the
size of the data source being too large, and too many unknown data.

Possible follow-up steps: One thing we can do is to get rid of the unknown data.
We can modify the data to make it more accurate.
;
proc means 
        min q1 median q3 max data= Homicide_analytic_file
    ;
    var
        Perpetrator_age
    ;
run;
proc format;
        value Perpetrator_Age_bin
        1-<18 = "under18"
        18-high = "over18"
    ;
run;
proc freq 
        data=homicide_analytic_file
    ;
    table 
        perpetrator_sex*perpetrator_age/nocol norow
        ;
    format 
        perpetrator_age perpetrator_age_bin.
    ;
run;
title;
footnote;
