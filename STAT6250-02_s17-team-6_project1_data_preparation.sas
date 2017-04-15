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


* setup environmental parameters;
%let inputDatasetURL =
https://github.com/stat6250/team-6_project1/blob/master/Project%201%20dataset
;


* load raw FRPM dataset over the wire;
filename tempfile TEMP;
proc http
    method="get"
    url="&inputDatasetURL."
    out=tempfile
    ;
run;
proc import
    file=tempfile
    out=project1_dataset_homicide_database-edited_raw
    dbms=xls;
run;
filename tempfile clear;


* check raw FRPM dataset for duplicates with respect to its composite key;
proc sort nodupkey data=dataset homicide_database-edited_raw
    dupout=dataset homicide_database-edited_raw_dups out=_null_;
    by Year State City;
run;


* build analytic dataset from FRPM dataset with the least number of columns and
minimal cleaning/transformation needed to address research questions in
corresponding data-analysis files;
data homicide_database_analytic_file;
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
    set homicide_database-edited_raw;s
run;

