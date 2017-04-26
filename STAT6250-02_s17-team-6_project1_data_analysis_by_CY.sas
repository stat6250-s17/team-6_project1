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

* set relative file import path to current directory (using standard SAS trick);

* load external file that generates analytic dataset Homicide_analytic_file;
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that generates analytic dataset Homicide_analytic_file;
%include '.\STAT6250-02_s17-team-6_project1_data_preparation.sas';

* 
Research Question: Since 1980, has national homicide rate increased or 
decreased overall?

Rationale: Nowadays there’s narrative in the media that the country is 
more dangerous than before - I would like to see what has been the trend
from 2000-2014.

Methodology: Use PROC Mean to compute sum the number of Incidence
for each Year, and output the results to a temporary dataset.
Then use PROC meanto calculate the average of incidence from 2000-2014.

limitations: This methodology does not calculate the percentage change
from one year over the previous which would give us a look at the 
the trend. We should take the mean of the yearly percentage change 
to see if the trend has been positive or negative.

Possible Follow-up Steps: Write a code to calculate the percentage
change from one year over the previous from 2000-2014. Then calculate 
the average percent change.
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
Research Question: Are males perpetrator more like to use guns than female
perpetrators?

Rationale: The nation is divided regarding the narrative of guns - I would 
like to see if there is a particular link between use of guns in homicides and 
the sex of the victim to see if they are certain type of homicides that are 
more likely to involve guns.

Methodolody: Use proc print to create a temp data file with homicide involving 
handguns and use Proc means to caculate the average incidence where the victim
is a male vs. female among homicides involving handguns.

Limitations: This only takes into consideration handguns. However, we also
have rifles and shotguns which could be classify in the same bucket. 

Possible Follow-up Steps: Format the table so that handguns, rifles, and
shotguns are considered under firearms and then look at the gender
differences between the victim's sex (and also the perpetrator's sex).
;

proc print data=Homicide_analytic_file;
    where Weapon="Handgun";
    output out=Homicide_temp;
run;

proc means data=Homicide_temp;
    class Victim_Sex;
    var Incidence;
    output out=Homicide_mean_temp;
run;

output out=Homicide_mean_temp;
run;

*
Research Question: What is the relationship between rate of crime solve 
and the race/ethnicity of the victim?

Rationale: The common narrative is regarding the high percentage of minorities 
in prison systems - I would like to know if the rate of crimes solve for 
minorities are lower or highest than that of white victims

Methodology: Tabulate the number of incidences where the crime is solved
and the victim's ethncity. Use Proc Mean to calculate the number of incidences
solved by ethnicity. Use Proc sort to sort from highest to lowest by the mean.

Limitations: This only looks at crimes that were solved. It is also 
interesting to be able to compare crimes that were solved vs. crimes that
were not solved by ethnicity group.

Possible Follow-up Steps: A possible follow-up is to run a tabulate
that has yes and no (for crime solved) as the column and the 
ethnicity of the victim as the row with incidence calculated for 
each.
;

proc print data=Homicide_analytic_file;
    where Crime_Solved="Yes";
    output out=Homicide_solved_temp;
run;

proc means data=Homicide_solved_temp;
    class Victim_Ethnicity;
    var Incidience;
    output out=Homicide_analytic_file_temp;
run;

proc sort data=Homicide_analytic_file_temp(where=(_STAT_="MEAN"));
    by  descending Incidence;
run;

