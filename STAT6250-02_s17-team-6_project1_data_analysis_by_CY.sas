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
;

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that generates analytic dataset Homicide_analytic_file;
%include '.\STAT6250-02_s17-team-6_project1_data_preparation.sas';

*
Research Question: Since 1980, has national homicide rate increased or 
decreased overall? Are there any state(s) that have trended differently from 
the national 
average?

Rationale: Nowadays there’s narrative in the media that the country is 
more dangerous than before - I would like to see if the trends shows this or 
if it is more isolated incidences/areas

Methodology: Use PROC MEANS to compute the mean number of Incidence
for Year, and output the results to a temportatry dataset. Use PROC
SORT extract and sort just the means the temporary dateset, and use PROC PRINT
to print the temporary dataset.

imitations: This methodology does not account for xxx

Possible Follow-up Steps: 
;

proc means mean noprint data=Homicide_analytic_file;
    class Year;
    var Incidence;
    output out=Homicide_analytic_file_temp;
run;

proc sort data=Homicide_analytic_file_temp;
    by ascending Year;
run;

proc print noobs data=Homicide_analytic_file_temp;
    id Year;
    var Incidence;
run;

*
Research Question: Is there any significant relationship between the weapon 
used in the homicide and other factors like age of victim or perpetrator, 
gender of victim or perpetrator, or race of victim or perpetrator.
Rationale: The nation is divided regarding the narrative of guns - I would 
like to see if there is a particular link between use of guns in homicides and 
the demographics of the perpetrator or victim to see if they are certain type 
of homicides that are more likely to involve guns
Methodolody: 
Limitations: 
Possible Follow-up Steps: 
;
* code


*
Research Question: What is the relationship between rate of crime solve 
and the race/ethnicity of the victim?
Rationale: The common narrative is regarding the high percentage of minorities 
in prison systems - I would like to know if the rate of crimes solve for 
minorities are lower or highest than that of white victims
Methodology: 
Limitations: 
Follow-up Steps: 
;
* code
