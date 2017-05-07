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
'Research Quesiton: What is the trend for the "number of national homicide" since 2000?'
;

title2
'Rationale: This should validate or refute the idea that we are living in a more dangergous society than previous decades.'
;

footnote1
'The output shows that the number of homicide incidence varies year by year. Since 2000, the number of homicides has gone up and gone down.' 
;

footnote2
'For the first half of 2000s, there was an increase of homicides but for the latter half, starting with 2007, there was a decline in homicides.'
;

footnote3
'There were a couple of standout years which saw a significant increase from the previous year. 2001, 2006, and 2010 are abnormally high years in terms of homicide counts.'
;

*
Methodlogy: Use PROC PRINT to print the number of incidences by year 
from the temporary dataset created in the data-prep file.

limitations: This methodology does not calculate the percentage change
from one year over the previous which would give us a look at the 
the trend. We should take the mean of the yearly percentage change 
to see if the trend has been positive or negative.

Possible Follow-up Steps: Write a code to calculate the percentage
change from one year over the previous from 2000-2014. Then calculate 
the average percent change.
;

proc print 
        noobs 
        data=Homicide_analytic_file
    ;
    id 
        Year
    ;
    var 
        Incidence
    ;
    title
        'Number of homicides per year'
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
'The number of incidences involving a male victim and a gun is about 7x greater than number of incidences involving a female victim and a gun'
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

proc print 
        noobs
        data=Homicide_analytic_file
    ;
    id
        Victim_Sex
    ;
    var
        Weapon
    title
        'Weapon used in homicide by victim's gender'
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

proc print 
        noobs
        data=Homicide_analytic_file
    ;
    id
        ethnicity group
    ;
    var
        Crimes_Solved
    title
        'Number of homicides solved by ethnicity'
    ;
run;
title;
footnote;
