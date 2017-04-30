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


title1
'Research Quesiton: What is the trend for the "number of national homicide" since 2000?'
;

title2:
'Rationale: This should validate or refute the idea that we are living in a more dangergous society than previous decades.'
;
*
limitations: This methodology does not calculate the percentage change
from one year over the previous which would give us a look at the 
the trend. We should take the mean of the yearly percentage change 
to see if the trend has been positive or negative.

Possible Follow-up Steps: Write a code to calculate the percentage
change from one year over the previous from 2000-2014. Then calculate 
the average percent change.
;



title1 
'Research Question: How many homicides involving males vs. females uses guns as the weapon?'
;

title2
'Rationale: This should give insights to if there is a particular link between use of guns in homicides and the sex of the victim.'
;
*
Methodolody: Use proc print to create a temp data file with homicide involving 
handguns

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

output out=Homicide_mean_temp;
run;

title1
'Research Question: How many crimes are solved among the different groups of victims by race/ethnicity?'
;

title2
'Rationale: This will show  if the rate of crimes solve for minorities are lower or highest than that of white victims.'
;
*
Methodology: Use Proc Print to print freqency of crime solved.

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


