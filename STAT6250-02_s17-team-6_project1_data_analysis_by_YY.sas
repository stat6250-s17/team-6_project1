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
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset Homicide_analytic_file;
%include '.\STAT6250-02_s17-team-6_project1_data_preparation.sas';



title1
'Research Question:  Are perpetrators more likely to be male or female?'
;

title2
'Rationale: Nowadays, it is widely believed that males are more dangerous than females, I would like to see the dataset shows percentages of male perpetrator. Also, is there any trend or the gender relationship between the perpetrators and the victims.'
;

footnote1
'Based on the above output, there are the number of male perpetrators, female perpetrators and unknown.'
;

footnote2
'Moreover, we can see that the percentage of male perpetrators is extremely higher than the percentage of female perpetrators that is only 0.22%.'
;
*
Methodology: We can first sort the male and female, the to see the percentage 
rate of each categories.
 
Limitations: This problem is straight forward, the only draw-back would be if 
the male/female category isn't given so we can't sort them propertly.
 
Possible Follow-up Steps: We only need to mae sure that both percentage 
column and male/female columns are given.
;
proc print
    format
        value $victims value $victims_bins
        "Male"="Male"
        "Female"="Female"
    ;	
    data 
        new_victims_data
    ;
    set 
        Homicide_analytic_file
    ;
    format 
        victims victims_bins.
    ;
    ;
proc means 
        min q1 median q3 max 
        data=new_victims_data
    ;
    class 
        victoms
    ;
    var 
        percentage_rate
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
'Moreover, we can see that the percentage of weapons uesd, the precentage of handgun is almost half of all weapons used.'  
;
*
Methodology: Use PROC SORT extract and sort the weapon from the dataset, 
and output the results to a temporary dataset. Use PROC PRINT to print 
the first three observations from the temporary dataset.

Limitations: This methodology does not account for districts with unknown 
data, nor does it attempt to validate data in any way.

Possible Follow-up Steps: More carefully clean the values of the variable.
;
proc sort 
        data=Homicide_analytic_file(where=(weapon))
    ;
    by 
        descending Percent_weapon
    ;
    output 
        out=Homicide_analytic_file_temp
    ;
proc print 
    noobs 
        data=Homicide_analytic_file(obs=3)
    ;
    id 
        weapon
    ;
    var 
        Percent_weapon
    ; 
run;
title;
footnote;



title1
'Research Question: What the percentage of the perpetrator who is less than 18 years old?'
;
title2
'Rationale: The tendency of young aged crimes committed by juveniles has become a hot topic for the media, I would like to see the overall and every decade trend to verify an increase in juvenile delinquency.'
;

footnote1
'Based on the above output, the number of perpetrators who under 18 years old and over 18 years old.'
;

footnote2
'Moreover, we can see that the precentage of perpetrators who under 18 years old is 42.63%, and the precentage of perpetrators who over 18 years old is 57.37%'
;
*
Methodology: Use PROC SORT extract and sort the Perpetrator Age from the 
dataset. Categorize the variable "Perpetrator Age" into two groups, 
"under 18" and "over 18".Use a data procedure to associate the new format with 
the variable "Perpetrator Age", and store into a new dataset. Compute 
five-number summaries by the reformatted variable consisting of two groups.

Limitations: The assumtions for this model has potential error because of the 
size of the data source being too large, for the subset
(our version of the excel), This shouldn't be a problem.

Possible follow-up steps: One thing we can do is to either use other model to 
calculate for a more efficient time complexity, or shrink the data size.
We can modify the algorithm to make it faster.
;
proc means 
        min q1 median q2 max 
        data= Homicide_analytic_file
    ;
    var 
        Perpetrator_age
    ;
run;
proc format
        value 
            Perpetrator_Age
        ;
        low-<18 = "Q1 
        Perpetrator_Age" 
        18-<high = "Q2 
        Perpetrator_Age"
        ;
run;
title;
footnote;
