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
'Research Quesiton: Which state has the most number of homicides from 2000-2004?'
;

title2
'Rationale: This should reveal which state is has a murder rate problem.'
;

footnote1
'California has the most number of homicides from 2000-2004.' 
;

footnote2
'However, the number of crimes solved vs. not solved is something to note. 60% of the crimes are solved in California but only 48% of crimes in Illnois are solved.' 
;

*
Methodlogy: Use PROC PRINT to print the number of incidences by state 
from the temporary dataset created in the data-prep file.

limitations: This methodology does not take into consideration the population size of the state.

Possible Follow-up Steps: Take into consideration the size of the state population size to calculate number of homicides per 100k people.
;

proc freq data=homicide_analytic_file order=freq
    ;
    table 
        State*Crime_Solved
    ;
run;
title;
footnote;




title1 
'Research Question: How many homicides involving males vs. females uses guns as the weapon?'
;

title2
'Rationale: This should give insights to if there is a particular link between use of guns in homicides and the sex of the victim.'
;

footnote1
'The number of incidences involving a male victim and a gun is about 6x greater than number of incidences involving a female victim and a gun'
;

footnote2
'The stats is very eye-opening. A follow-up analysis would be to see if the perpetrator is more likely to be male or female when the weapon is a gun. I would hypothesis that it is likely male.'
;

footnote3
'Another follow-up question is what weapon is more prominent when it involves the female sex.'
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

proc freq data=homicide_analytic_file order=freq
    ;
    table 
       Weapon*Victim_Sex
    ;
run;
title;
footnote;



title1
'Research Question: How many crimes are solved among the different groups of victims by race/ethnicity?'
;

title2
'Rationale: This will show  if the rate of crimes solve for minorities are lower or highest than that of white victims.'
;

footnote1
'The output shows that about 80% of homicides involving victims that are white are solved while only 63% of homicides involving victims that are black are solved.'
;

footnote2
'The results shows the stark reality of racial issues in the country. A follow-up analysis would be to understand why this is. Is there any information in the data to suggest any differences other than race.'
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

proc freq data=homicide_analytic_file order=freq
    ;
    table 
        Victim_Race*Crime_Solved
    ;
run;
title;
footnote;
