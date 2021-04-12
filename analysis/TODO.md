# Todo

This file contains the details of your progress report. This should be
a fairly detailed description of (i) what you have done, (ii) what you
plan to do, and (iii) some ideas for what your shiny app will do. I
provide some guidance in this file, but you should use your own
words. That is, don't just fill in the blanks from what I wrote.

# Progress

In this section, detail the analyses that you have done. For example,
it could go like this:

1. Our data come from https://ofmpub.epa.gov/apex/safewater/f?p=136:102::::::.  
2. We ran some initial data explorations using the tidy_water.csv. We found:
   1. The data is rather skewed, so we anticipate using logs. 
   2. There appears to be a positive relationship between the number of site visits and the number of violations. 

# Future analysis questions:

This section should contain a detailed plan for how you will finish
the remaining parts of your final project. List out the your
ideas. For example:

So far, we have three analysis files that explore the data. The contents of these files are:

1. London_exploration_1.Rmd: We are going to examine the # of violations across the different EPA regions. This analysis will be done by London Wagner.
2. Kat_exploration.Rmd: We are going to examine the # of violations based on the primary source of the water. This analysis will be done by Kat Lee.
3. Favian_exploration.Rmd: We are going to examine the relationships between the quantitative variables, including # of violations, population, # of facilities, # of site visits. This analysis will be done by Favian Liu.

Our data explorations thus far suggest developing a linear model to explore the
relationship between # of site visits and # of violations. We intend to add more linear models for predicitions as well as run additional tests (t.test, anova, etc.) where appropriate depending on our initial findings. 


# Shiny App Ideas:

This section should contain some ideas for your Shiny application. For example:

1. One tab will allow the user to explore the association between multiple variables. This will be developed by Kat Lee.
2. One tab will make a map of # of site visits across the continential United States. This will be developed by London Wagner.
3. One tab will use a linear regression model to predict the number of violations given the users inputs. This will be developed by Favian Liu.
4. The last tab will allow users to view the data in a spreadsheet format.
