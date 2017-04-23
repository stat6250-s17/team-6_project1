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

/*
Research Question: Since 1980, has national homicide rate increased or 
decreased overall? Are there any state(s) that have trended differently from 
the national 
average?

Rationale: Nowadays there’s narrative in the media that the country is 
more dangerous than before - I would like to see if the trends shows this or 
if it is more isolated incidences/areas

Methodology: Use PROC Freq to compute sum the number of Incidence
for each Year, and output the results to a temportatry dataset. 

imitations: This methodology does not calculate the percentage change
from one year over the previous which would give us a look at the 
the trend. We should take the mean of the yearly percentage change 
to see if the trend has been positive or negative.

Possible Follow-up Steps: Write a code to calculate the percentage
change from one year over the previous from 2000-2014. Then claculate 
the average percent change.
*/

proc freq data=Homicide_analytic_file;
    tables Year;
    var Incidence;
    output out=Homicide_analytic_file_temp;
run;


/*
Research Question: Are males perpetrator more like to use guns than female
perpetrators? Are incidences involving guns more frequent in cases of 
where the perpetrator is of a certain ethnicity?

Rationale: The nation is divided regarding the narrative of guns - I would 
like to see if there is a particular link between use of guns in homicides and 
the demographics of the perpetrator or victim to see if they are certain type 
of homicides that are more likely to involve guns

Methodolody: Tabulate the number of incidences involving guns and non-guns 
among males and females. Do the same for the different ethnic groups.
*/

proc means mean noprint data=Homicide_analytic_file;
    class Victim Sex;
    var Incidence;
    output out=Homicide_analytic_file_temp;
run;


/*
Research Question: What is the relationship between rate of crime solve 
and the race/ethnicity of the victim?

Rationale: The common narrative is regarding the high percentage of minorities 
in prison systems - I would like to know if the rate of crimes solve for 
minorities are lower or highest than that of white victims

Methodology: Tabulate the number of incidences where the crime is solved
and the victim's ethncity. Use Proc Mean to calculate the number of incidences
solved by ethnicity. Use Proc sort to sort from highest to lowest by the mean.
*/

proc format;
    VALUE Crime_Solved
    1=Yes
    0=No;

run; 

proc means mean noprint data=Homicide_analytic_file;
    class Victim_Ethnicity;
    var Crime_Solved;
    output out=Homicide_analytic_file_temp;
run;

proc sort data=Homicide_analytic_file_temp(where=(_STAT_="MEAN"));
    by  descending Incidence;
run;

