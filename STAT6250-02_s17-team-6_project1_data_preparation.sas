*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

* 
This file prepares the dataset described below for analysis.
[Dataset Name] Homicide Reports, 2000-2004

[Experimental Units] Each agency

[Number of Observations] 65,535

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

* setup environmental parameters;
%let inputDatasetURL =
https://github.com/stat6250/team-6_project1/blob/master/Homicide_2000-2014.xls?raw=true
;

* load raw FRPM dataset over the wire;
%macro loadDataIfNotAlreadyAvailable(dsn,url,filetype);
    %put &=dsn;
    %put &=url;
    %put &=filetype;
    %if
        %sysfunc(exist(&dsn.)) = 0
    %then
        %do;
            %put Loading dataset &dsn. over the wire now...;
            filename tempfile TEMP;
            proc http
                method="get"
                url="&url."
                out=tempfile
                ;
            run;
            proc import
                file=tempfile
                out=&dsn.
                dbms=&filetype.;
            run;
            filename tempfile clear;
        %end;
    %else
        %do;
            %put Dataset &dsn. already exists. Please delete and try again.;
        %end;
%mend;
%loadDataIfNotAlreadyAvailable(
    FRPM1516_raw,
    &inputDatasetURL.,
    xls
)

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
proc sort nodupkey data=homicide_raw
    dupout=homicide_raw_dups out=_null_;
    by Record_ID;
run;


* create output formats;

proc format;
    value $victims_bins
        "Male"="Male"
        "Female"="Female"
    ;	

    value Perpetrator_Age
        0-<18 = "Q1 Perpetrator_Age" 
        18-<99 = "Q2 Perpetrator_Age"
    ;
run;

* build analytic dataset from Homicide dataset with the least number of columns and
minimal cleaning/transformation needed to address research questions in
corresponding data-analysis files;
data homicide_analytic_file;
	set homicide_raw;
   	retain
        City
        State
        Year
        Month
        Incident
        Crime_Type
        Crime_Solved
        Victim_Sex
        Victim_Age
        Victim_Race
        Victim_Ethnicity
        Perpetrator_Sex
        Perpetrator_Age
        Perpetrator_Race
        Perpetrator_Ethnicity
        Relationship
        Weapon
        Victim_Count
        Perpetrator_Count
    ;
    keep
        City
        State
        Year
        Month
        Incident
        Crime_Type
        Crime_Solved
        Victim_Sex
        Victim_Age
        Victim_Race
        Victim_Ethnicity
        Perpetrator_Sex
        Perpetrator_Age
        Perpetrator_Race
        Perpetrator_Ethnicity
        Relationship
        Weapon
        Victim_Count
        Perpetrator_Count
    ;
run;

