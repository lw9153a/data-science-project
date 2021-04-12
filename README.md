# Analysis of EPA Drinking Water Reports

Favian Liu, Katherine Lee, and London Wagner 


# Summary 

Our repo provides insight into the data provided in the EPA's reports on drinking water.
We explore the effects of the water source on the the number of violations and the number of cite visits, as well as the effects of the location of the EPA region site on those same responsive variables. We also analyze the correlation between the quantitative variables, as the relationship between them is not necessarily clear. Our analysis also provides the results of t-tests, Poisson tests, and Quasipoissons that were conducted on select variables. We've included a Shiny App in our repo to allow you to explore the data yourself, by taking a closer look at individual variables, relationships between variables, and the distribution of certain variables across a map of the United States. 



# Shiny App

The shiny app in the "app" folder allows users to plot, map, and view the data from the EPA Drinking Water Reports by selecting variables. These are the four tabs: 

1. Univariate Analysis: Allows you to select and plot a variable into a histogram 
2. Bivariate Analysis: Allows you to select and plot two variables of choice
3. Map: Allows you to select a quantitative variable and view its distribution on a heat map of the continental United States. 
4. Prediction: Allows you to predict the number of violation by changing the values of the predictors, also shows a summary of the quasipoisson model.
5. Spreadsheet: View the variables in a spreadsheet format. 

# Analyses

This Shiny App was motivated by the analyses run in the "analysis" folder.
The analysis folder contains the following files:


- [An initial exploration of the `source` variable](./analysis/source_initial_exploration.Rmd). This file conducts an initial explores the `source` variable. It concludes that there are far more Ground Water values than Surface Water values, but Surface Water has many more violations, site visits, and tends to serve larger populations compared to the Ground Water values. 
- [A further analysis of the `source` variable](./analysis/source_exploration_tests.Rmd). This file conducts statistical tests on the `source` variable and concludes that there are strong associations between the source and the following variables: number of violations, number of site visits, and population. 
- [An analysis of the `region` variable](./analysis/region_exploration.Rmd). This file explores whether the EPA region a site is located in will have an
effect on the number of violations a site, and concludes that ______________
- [An analysis of multicollinearity](./analysis/multi_exploration.Rmd). This file explores the correlation between quantitative variables and concludes ____________
- [A Poisson analysis](./analysis/regression_modeling.Rmd). This file explores a Poisson and a Quasipoisson analysis on our data set and concludes that the estimates of the variables are not significant. 
- [An exploration of logging](./analysis/log_exploration.Rmd) This file explores the normality assumptions for the quantitative data and also explores the relationships between the explanatory variables; it concludes that the ouliers observed after the log transformations will not significantly affect the analysis of the data. 


# Running the app
To download and run the Shiny App, do the following:

1. Visit our Repository at https://github.com/data-science-fall-2020/final-project-psyduck 
2. Click the green 'Code'
3. Copy the HTTPS link by clicking the image of the clipboard 
4. Enter "git clone" and paste the HTTPS link into the Terminal of you device; hit 'Enter'
5. Our repository will appear in a folder located in your working directory entitled "final-project-psyduck"
6. Open the folder; drop down the 'app' folder and open the "app.R" file in R Studio 
7. Click "Run App" at the top right of your R Studio window 
8. Voilà!

# References

We used the following resources when building our app:

- https://ofmpub.epa.gov/apex/safewater/f?p=136:102::::::.  
- https://www.epa.gov/aboutepa/regional-and-geographic-offices 
- https://stats.idre.ucla.edu/r/dae/poisson-regression/
- https://www.dataquest.io/blog/tutorial-poisson-regression-in-r/
- https://data.princeton.edu/wws509/r/overdispersion
- https://cran.r-project.org/web/packages/bbmle/vignettes/quasi.pdf
- https://remiller1450.github.io/s230s19/Intro_maps.html
