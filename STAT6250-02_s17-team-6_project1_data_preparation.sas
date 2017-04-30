*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

* 
This file prepares the dataset described below for analysis.
[Dataset Name] Homicide Reports, 2000-2014 (Edited)

[Experimental Units] Each agency

[Number of Observations] 236,022

[Number of Features] 24

[Data Source] The file 
https://www.kaggle.com/murderaccountability/homicide-reports.csv 
was downloaded and edited to produce file 
project1_dataset_homicide database-edited_raw.xlsx by 
deleting row 1-402432 from worksheet "homicide database"

[Data Dictionary] https://www.kaggle.com/murderaccountability/homicide-reports 

[Unique ID] Record ID
;

* environmental setup;

* create output formats;

proc format;
    value $victims_bins
        "Male"="Male"
        "Female"="Female"
    ;	

    value Perpetrator_Age;
        low-<18 = "Q1 Perpetrator_Age" 
        18-<high = "Q2 Perpetrator_Age"
    ;
run;


* setup environmental parameters;
%let inputDatasetURL =
https://github.com/stat6250/team-6_project1/blob/master/Homicide_2000-2014.xls
;


* load raw Homcidie dataset over the wire;
filename tempfile TEMP;
proc http
    method="get"
    url="&inputDatasetURL."
    out=tempfile
    ;
run;
proc import
    file=tempfile
    out=homicide_raw
    dbms=xls;
run;
filename tempfile clear;


* check raw Homicide dataset for duplicates with respect to its composite key;
proc sort nodupkey data=homicide_raw dupout=homicide_raw_dups out=_null_;
    by Record ID;
run;


* build analytic dataset from Homicide dataset with the least number of columns and
minimal cleaning/transformation needed to address research questions in
corresponding data-analysis files;
data homicide_analytic_file;
    retain
        City
        State
        Year
        Month
        Incident
        Crime Type
        Crime Solved
        Victim Sex
        Victim Age
        Victim Race
        Victim Ethnicity
        Perpetrator Sex
        Perpetrator Age
        Perpetrator Race
        Perpetrator Ethnicity
        Relationship
        Weapon
        Victim Count
        Perpetrator Count
    ;
    keep
        City
        State
        Year
        Month
        Incident
        Crime Type
        Crime Solved
        Victim Sex
        Victim Age
        Victim Race
        Victim Ethnicity
        Perpetrator Sex
        Perpetrator Age
        Perpetrator Race
        Perpetrator Ethnicity
        Relationship
        Weapon
        Victim Count
        Perpetrator Count
    ;
    set homicide_raw;
run;

* 
Methodology: Use PROC Mean to compute sum the number of Incidence
for each Year, and output the results to a temporary dataset.
Then use PROC meanto calculate the average of incidence from 2000-2014.
;


proc means data=Homicide_analytic_file;
    class Year;
    var Incidence;
    output out=Homicide_temp;
run;

proc sort data=Homicide_temp;
    by ascending Year;
    run;
    
* 
Methodology: Use Proc means to caculate the average incidence where the victim
is a male vs. female among homicides involving handguns.
;

proc means data=Homicide_temp;
    class Victim_Sex;
    var Incidence;
    output out=Homicide_mean_temp;
run;

*
Methodology: Tabulate the number of incidences where the crime is solved
and the victim's ethncity. Use Proc Mean to calculate the number of incidences
solved by ethnicity. Use Proc sort to sort from highest to lowest by the mean.
;

proc means data=Homicide_solved_temp;
    class Victim_Ethnicity;
    var Incidience;
    output out=Homicide_analytic_file_temp;
run;

proc sort data=Homicide_analytic_file_temp(where=(_STAT_="MEAN"));
    by  descending Incidence;
run;



