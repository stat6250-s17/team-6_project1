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


*
Research Question:  Are perpetrators and victims more likely to be male or female?  

Rationale: Nowadays, it is widely believed that males are more dangerous than females, 
I would like to see the dataset shows percentages of male perpetrator.
Also, is there any trend or the gender relationship between the perpetrators and the victims.

Methodology: 

Limitations:

Possible Follow-up Steps: 
;
* code


*
Research Question: What are the top three weapons used? 

Rationale: This should help identify the most commonly used weapon.
It could help the police to strengthen risk prevention,
and the weapon management and control shall be strengthened.

Methodolody: 

Limitations: 

Possible Follow-up Steps: 
;
* code


*
Research Question: What the percentage of the perpetrator who is less than 18 years old?

Rationale: The tendency of young aged crimes committed by juveniles has become a hot topic for the media, 
I would like to see the overall and every decade trend to verify an increase in juvenile delinquency.

Methodology: 

Limitations: 

Follow-up Steps: 
;
* code


