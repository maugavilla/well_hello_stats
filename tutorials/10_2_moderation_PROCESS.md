Moderation analysis using the PROCESS macro
================
Mauricio Garnier-Villarreal, Joris M. Schröder & Joseph Charles Van
Matre
01 September, 2022

-   <a href="#what-is-moderation-analysis"
    id="toc-what-is-moderation-analysis">What is moderation analysis?</a>
-   <a href="#setup-the-r-session" id="toc-setup-the-r-session">Setup the R
    session</a>
-   <a href="#installing-the-process-macro"
    id="toc-installing-the-process-macro">Installing the PROCESS macro</a>
-   <a href="#import-the-data-set" id="toc-import-the-data-set">Import the
    data set</a>
    -   <a href="#prepare-the-data-set" id="toc-prepare-the-data-set">Prepare
        the data set</a>
        -   <a href="#create-composite-scores"
            id="toc-create-composite-scores">Create composite scores</a>
        -   <a href="#recoding-sex-variable" id="toc-recoding-sex-variable">Recoding
            sex variable</a>
        -   <a href="#select-variables-for-analysis"
            id="toc-select-variables-for-analysis">Select variables for analysis</a>
-   <a href="#moderation-analysis-steps"
    id="toc-moderation-analysis-steps">Moderation analysis steps</a>
-   <a href="#categorical-moderator"
    id="toc-categorical-moderator">Categorical moderator</a>
    -   <a href="#main-effects" id="toc-main-effects">Main effects</a>
        -   <a href="#interpretation" id="toc-interpretation">Interpretation</a>
    -   <a href="#interaction-model" id="toc-interaction-model">Interaction
        model</a>
        -   <a href="#effect-size" id="toc-effect-size">Effect size</a>
        -   <a href="#probing" id="toc-probing">Probing</a>
        -   <a href="#interpretation-1" id="toc-interpretation-1">Interpretation</a>
-   <a href="#continuous-moderator" id="toc-continuous-moderator">Continuous
    moderator</a>
    -   <a href="#main-effects-1" id="toc-main-effects-1">Main effects</a>
        -   <a href="#interpretation-2" id="toc-interpretation-2">Interpretation</a>
    -   <a href="#interaction-model-1" id="toc-interaction-model-1">Interaction
        model</a>
        -   <a href="#effect-size-1" id="toc-effect-size-1">Effect size</a>
        -   <a href="#probing-1" id="toc-probing-1">Probing</a>
        -   <a href="#interpretation-3" id="toc-interpretation-3">Interpretation</a>
    -   <a href="#visualizing-interactions"
        id="toc-visualizing-interactions">Visualizing interactions</a>
-   <a href="#process-models" id="toc-process-models">PROCESS models</a>
-   <a href="#references" id="toc-references">References</a>

# What is moderation analysis?

With moderation analysis, we are trying to find out whether the effect
or association between two variables depends on another variable. Let’s
say that we are interested in the association between *Lack of
confidence in the government* and *Perception of corruption*, but we
specifically want to know whether the association depends on the *Sex*
or the *Secular Values* of individuals. The latter two variables are
called *moderators* of the association between *Lack of confidence in
the government* and *Perception of corruption*.

# Setup the R session

When we start working in R, we always need to setup our session. For
this we need to set our working directory, in this case I am doing that
for the folder that holds the downloaded [World Values Survey
(WVS)](https://www.worldvaluessurvey.org/) `SPSS` data set

``` r
setwd("~path_to_your_file")
```

The next step for setting up our session will be to load the packages
that we will be using

``` r
library(rio)
```

# Installing the PROCESS macro

In this tutorial, we will be showing you how to do moderation analysis
using the **PROCESS** macro. To use the process macro, you first need to
download it from this website:
<https://www.processmacro.org/download.html>. You will download a zip
archive that you need to extract (using for example
[7-Zip](https://www.7-zip.org/)). The extracted folder contains a folder
*PROCESS v4.1 for R* (the latest version by the time we created this
tutorial), which contains the *process.R* script. The process macro is a
script rather than an r package, and its usage is therefore a bit
different from what you are used to. Andrew Hayes, the author of the
PROCESS macro writes:

*“PROCESS for R is a program file or “script” (process.R) that when
executed defined a function called process in the existing workspace.
Once the process script is executed (without changing the file
whatsoever), then the process function is available for use and
process.R can be closed. Have patience, as process is a large script
file and it will take a few minutes for it to execute. When it is
complete, a message in the console will appear stating that PROCESS is
ready for use. PROCESS was written in base R v3.6. PROCESS for R does
not rely on any packages and does not require the installation of any
packages prior to use. Because R is a script that defines a function
rather than a package, the process script must be executed each time you
begin an R session and intend to use the PROCESS function. To circumvent
this, save the workspace after running process.R, either using the
existing workspace name or a different one. With the workspace saved,
PROCESS will be available for use and will function much like a package
whenever using that workspace.”* (Hayes, 2022, p. 611)

In short, you need to run the full script once every time you start a
new R session (or use the approach described by Hayes above). One way to
do that is to store the *process.R* script in the same directory as your
script for analysis, and then to use `source("process.R")`, which will
run the code in the *process.R* script.

``` r
source("process.R")
```

    ## 
    ## ********************** PROCESS for R Version 4.1 ********************** 
    ##  
    ##            Written by Andrew F. Hayes, Ph.D.  www.afhayes.com              
    ##    Documentation available in Hayes (2022). www.guilford.com/p/hayes3   
    ##  
    ## *********************************************************************** 
    ##  
    ## PROCESS is now ready for use.
    ## Copyright 2022 by Andrew F. Hayes ALL RIGHTS RESERVED
    ## Workshop schedule at http://haskayne.ucalgary.ca/CCRAM
    ## 

# Import the data set

Here we will be importing the `.sav` WVS data set

``` r
dat <- import("WVS_Cross-National_Wave_7_sav_v2_0.sav")
dim(dat)
```

    ## [1] 76897   548

We are calling our data set **dat** and asking to see the dimension of
it. We see that the data set has 76897 subjects, and 548 columns.

## Prepare the data set

In cases with large data sets like this we might want to select a subset
of variables that we want to work with, since it is not easy to keep an
overview of 548 variables. We first identify the variables that we want
to work with. The variables we will use here are:

-   Q260: sex, 1 = Male, 2 = Female
-   Q262: age in years
-   Y001: post-materialism index
-   SACSECVAL: secular values
-   Q112-Q120: Corruption Perception Index
-   Q65-Q73: Lack of Confidence in the government

We first create the vector **vars** containing the variable names of the
variables that we want to keep. Next, we create a new data set **dat2**
with only these 17 variables, and make sure we did it correctly by
looking at the the dimension of the data `dim(dat2)`. We also look at
the first 6 rows: `head(dat2)`. These are quick checks that we have
created the new data correctly.

``` r
vars <- c("Q260","Q262", "Y001", "SACSECVAL", "Q112", "Q113", "Q114", "Q115", "Q116", "Q117", "Q118", "Q119", "Q120", "Q65", "Q69", "Q71", "Q72", "Q73")
dat2 <- dat[,vars]
dim(dat2)
```

    ## [1] 76897    18

``` r
head(dat2)
```

    ##   Q260 Q262 Y001 SACSECVAL Q112 Q113 Q114 Q115 Q116 Q117 Q118 Q119 Q120 Q65 Q69
    ## 1    2   60    0  0.287062    2   NA   NA   NA   NA   NA    1    2    6  NA   1
    ## 2    1   47    2  0.467525   10    3    3    3    3    3    1    3    2  NA   3
    ## 3    1   48    4  0.425304    7    2    2    2    2    2    1    2    7  NA   2
    ## 4    2   62    2  0.556170    5    3    3    3    3    2    1    4    7  NA   3
    ## 5    1   49    1  0.458949    5    2    2    2    2    1    1    3    7  NA   2
    ## 6    2   51    3  0.210111    6    2    2    2    2    2    1    4    2  NA   1
    ##   Q71 Q72 Q73
    ## 1   1   1   1
    ## 2   4   4   4
    ## 3   3   3   3
    ## 4   3   3   3
    ## 5   2   3   2
    ## 6   2   2   2

### Create composite scores

We will be using the composite scores for *Corruption Perception Index*
and *Lack of Confidence in the government* instead of their single
items. So, we first need to compute them, we will use the mean across
all items for each of these indices.

``` r
dat2$Corrup <- rowMeans(dat2[,c("Q112", "Q113", "Q114", "Q115", "Q116", "Q117", "Q118", "Q119", "Q120")], na.rm=T)
dat2$LCGov <- rowMeans(dat2[,c("Q65", "Q69", "Q71", "Q72", "Q73")], na.rm=T)
head(dat2)
```

    ##   Q260 Q262 Y001 SACSECVAL Q112 Q113 Q114 Q115 Q116 Q117 Q118 Q119 Q120 Q65 Q69
    ## 1    2   60    0  0.287062    2   NA   NA   NA   NA   NA    1    2    6  NA   1
    ## 2    1   47    2  0.467525   10    3    3    3    3    3    1    3    2  NA   3
    ## 3    1   48    4  0.425304    7    2    2    2    2    2    1    2    7  NA   2
    ## 4    2   62    2  0.556170    5    3    3    3    3    2    1    4    7  NA   3
    ## 5    1   49    1  0.458949    5    2    2    2    2    1    1    3    7  NA   2
    ## 6    2   51    3  0.210111    6    2    2    2    2    2    1    4    2  NA   1
    ##   Q71 Q72 Q73   Corrup LCGov
    ## 1   1   1   1 2.750000  1.00
    ## 2   4   4   4 3.444444  3.75
    ## 3   3   3   3 3.000000  2.75
    ## 4   3   3   3 3.444444  3.00
    ## 5   2   3   2 2.777778  2.25
    ## 6   2   2   2 2.555556  1.75

We compute the mean across the specified variables for each subject with
`rowmeans()`. Remember to include the `na.rm=T` argument, so the missing
values are ignored. In this way, the mean score represents the mean for
all of the items that the respondents did answer. Otherwise, you get a
missing value for every individual that has a missing value on at least
*one* of the items.

Note that the PROCESS macro does not work with variables that are
designated as factors. Categorical variables to be used in moderator
analysis should therefore not be designated as factor variables when you
are working with the PROCESS macro. In our data set this is not the
case, so we can proceed.

### Recoding sex variable

We recode the variable “Sex” (Q260) with values 1 and 2 to having the
values 0 and 1. The value 0 now means *male*, and 1 means *female*. When
creating this type of variable, is recommended to name the variable by
the category with the value of 1, in this case we will named of variable
*Female*

``` r
dat2$Female <- dat2$Q260-1
head(dat2)
```

    ##   Q260 Q262 Y001 SACSECVAL Q112 Q113 Q114 Q115 Q116 Q117 Q118 Q119 Q120 Q65 Q69
    ## 1    2   60    0  0.287062    2   NA   NA   NA   NA   NA    1    2    6  NA   1
    ## 2    1   47    2  0.467525   10    3    3    3    3    3    1    3    2  NA   3
    ## 3    1   48    4  0.425304    7    2    2    2    2    2    1    2    7  NA   2
    ## 4    2   62    2  0.556170    5    3    3    3    3    2    1    4    7  NA   3
    ## 5    1   49    1  0.458949    5    2    2    2    2    1    1    3    7  NA   2
    ## 6    2   51    3  0.210111    6    2    2    2    2    2    1    4    2  NA   1
    ##   Q71 Q72 Q73   Corrup LCGov Female
    ## 1   1   1   1 2.750000  1.00      1
    ## 2   4   4   4 3.444444  3.75      0
    ## 3   3   3   3 3.000000  2.75      0
    ## 4   3   3   3 3.444444  3.00      1
    ## 5   2   3   2 2.777778  2.25      0
    ## 6   2   2   2 2.555556  1.75      1

### Select variables for analysis

Now, we will select only the variables of interest in a separate data
set, excluding the individual items of the mean scores.

``` r
dat2 <- na.omit(dat2[,c("Female", "Q262", "Y001", "SACSECVAL", "Corrup", "LCGov")])
head(dat2)
```

    ##   Female Q262 Y001 SACSECVAL   Corrup LCGov
    ## 1      1   60    0  0.287062 2.750000  1.00
    ## 2      0   47    2  0.467525 3.444444  3.75
    ## 3      0   48    4  0.425304 3.000000  2.75
    ## 4      1   62    2  0.556170 3.444444  3.00
    ## 5      0   49    1  0.458949 2.777778  2.25
    ## 6      1   51    3  0.210111 2.555556  1.75

``` r
dim(dat2)
```

    ## [1] 71633     6

The new **dat2** data set only include the 5 continuous variables of
interest, and 1 binary variable. With the `na.omit()` function we are
excluding all cases with some missing values.

# Moderation analysis steps

Moderation is split into multiple steps, (a)

-   Estimate the *main effects* model that includes only the predictors
    as a *normal* multiple regression.
-   Estimate the *interaction* model that now also includes the
    interactions between predictors.
-   Compare the models: the *p-value* test the Null hypothesis of the
    two predictors being independent, and the change in $R^2$ represents
    the effect size magnitude of the interaction
-   Probe the interaction: estimate the simple slopes, the slope for the
    focal predictor at fixed values of the moderator predictor.
-   Plot the simple slopes

The first three steps test the Null Hypothesis of the interaction (with
the respective effect size), while the last two steps seek to explain
*how does the moderator affects the focal relation?*, and help interpret
these conditional relations.

We will see how to implement these steps for the two common scenarios
with a categorical or a continuous moderator.

# Categorical moderator

For the categorical predictor model, we will have *Lack of confidence in
the government* as the focal predictor of *Perception of corruption*,
and *Sex* as the categorical moderator.

## Main effects

The main effects model presents both the effects of each predictor on
the outcome.

``` r
main_cat <- lm(Corrup ~ LCGov + Female, data=dat2)
summary(main_cat)
```

    ## 
    ## Call:
    ## lm(formula = Corrup ~ LCGov + Female, data = dat2)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -3.8269 -0.4807 -0.0487  0.4309  7.0961 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  2.558014   0.010946 233.704  < 2e-16 ***
    ## LCGov        0.369207   0.003967  93.072  < 2e-16 ***
    ## Female      -0.023369   0.005824  -4.013 6.01e-05 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.7787 on 71630 degrees of freedom
    ## Multiple R-squared:  0.1081, Adjusted R-squared:  0.1081 
    ## F-statistic:  4341 on 2 and 71630 DF,  p-value: < 2.2e-16

### Interpretation

-   We reject the null hypothesis of both predictors being equally good
    predictors as the mean model, $F(2, 71630) = 4341, p < .001$.
-   Both predictors explained 11% of the variance in the outcome
    ($R^2 = 0.108$).
-   The average outcome score for *Male* with 0 *Lack of confidence in
    the government* is 2.55 ($b_0 = 2.55, SE = 0.01, p < .001$)
-   As *Lack of confidence in the government* increase by 1 unit,
    *Perception of corruption* increases by 0.36
    ($b_1 = 0.36, SE = 0.004, p < .001$), holding *Sex* constant.
-   As *Sex* changes, *Perception of corruption* decreases by 0.023 for
    *Female* ($b_2 = -0.023, SE = 0.006, p < .001$), holding *Lack of
    confidence in the government* constant.

## Interaction model

The code for a simple moderation model using the PROCESS macro is
`process (data = my_data_frame, y = "dependent_variable", x = "independent_variable", w ="moderator_variable", model = 1)`.

*my_data_frame* is a place holder for the name of the data frame with
the data that we want to use, and we have to replace the placeholder
variable names with the actual variable names from our data set. We
additionally add the option `intprobe=1` to already get the results for
probing the interaction.

``` r
process(data = dat2, y = "Corrup", x = "LCGov", w = "Female", model = 1, intprobe=1)
```

    ## 
    ## ********************** PROCESS for R Version 4.1 ********************** 
    ##  
    ##            Written by Andrew F. Hayes, Ph.D.  www.afhayes.com              
    ##    Documentation available in Hayes (2022). www.guilford.com/p/hayes3   
    ##  
    ## *********************************************************************** 
    ##               
    ## Model : 1     
    ##     Y : Corrup
    ##     X : LCGov 
    ##     W : Female
    ## 
    ## Sample size: 71633
    ## 
    ## 
    ## *********************************************************************** 
    ## Outcome Variable: Corrup
    ## 
    ## Model Summary: 
    ##           R      R-sq       MSE         F       df1        df2         p
    ##      0.3288    0.1081    0.6064 2894.5944    3.0000 71629.0000    0.0000
    ## 
    ## Model: 
    ##              coeff        se         t         p      LLCI      ULCI
    ## constant    2.5476    0.0150  169.3458    0.0000    2.5181    2.5771
    ## LCGov       0.3733    0.0057   65.8471    0.0000    0.3622    0.3844
    ## Female     -0.0030    0.0210   -0.1422    0.8869   -0.0442    0.0382
    ## Int_1      -0.0080    0.0079   -1.0094    0.3128   -0.0236    0.0075
    ## 
    ## Product terms key:
    ## Int_1  :  LCGov  x  Female      
    ## 
    ## Test(s) of highest order unconditional interaction(s):
    ##       R2-chng         F       df1        df2         p
    ## X*W    0.0000    1.0190    1.0000 71629.0000    0.3128
    ## ----------
    ## Focal predictor: LCGov (X)
    ##       Moderator: Female (W)
    ## 
    ## Conditional effects of the focal predictor at values of the moderator(s):
    ##      Female    effect        se         t         p      LLCI      ULCI
    ##      0.0000    0.3733    0.0057   65.8471    0.0000    0.3622    0.3844
    ##      1.0000    0.3653    0.0056   65.7842    0.0000    0.3544    0.3762
    ## 
    ## ******************** ANALYSIS NOTES AND ERRORS ************************ 
    ## 
    ## Level of confidence for all confidence intervals in output: 95

The PROCESS macro named the interaction term `Int_1`. The *p-value* for
this term tests the Null Hypothesis that the 2 predictors are
independent. In our example, the coefficient for the interaction term is
-0.008 and the *p-value* is 0.313.

### Effect size

To assess the effect size of the interaction, we can look at this as the
change in $R^2$ when the interaction is added. The output is shown under
the header *Test(s) of highest order unconditional interaction(s):*, and
we can see that the change in the explained variance is 0
($\Delta R^2 = 0.000$), given by *R2-chng*.

### Probing

Probing the interaction means to estimate the dependent focal
regressions at specific levels of the moderator. When using the
`intprobe` option, the PROCESS macro also shows the output for probing
the interactions. When we use the option `intprobe = x`, x defines the
alpha level of interactions that you want to see probed. With
`intprobe = .05`, all interactions are probed that meet the standard .05
alpha level of statistical significance. With `intprobe = 1` we set the
alpha level to 1 so that all interactions are probed regardless of their
level of statistical significance.

The output for probing the interactions is shown under the heading
*Conditional effects of the focal predictor at values of the
moderator(s):*. Here we see that for the *Male* participants, the slope
between *lack of confidence in the government* and *Perception of
corruption* is 0.373 ($b_{1M} = 0.373, SE = 0.006, p < .001$), and for
the *Female* participants it is 0.365
($b_{1F} = 0.365, SE = 0.006, p < .001$).

The difference in the slopes for women rather than men is -0.008
(0.3733 - 0.3653), which is exactly the slope for the interaction term
`Int_1`.

### Interpretation

-   We fail fail to reject the null hypothesis of the 2 predictors being
    independent ($b_{*} = -0.008, SE = 0.008, p = 0.313$).
-   The slope between *lack of confidence in the government* and
    *Perception of corruption* for female participants is 0.008 points
    lower than the slope for male participants
    ($b_{*} = -0.008, SE = 0.008, p = 0.313$).
-   For *Male* participants, the slope between *lack of confidence in
    the government* and *Perception of corruption* is 0.373
    ($b_{1M} = 0.373, SE = 0.006, p < .001$).
-   For *Female* participants, the slope between *lack of confidence in
    the government* and *Perception of corruption* is 0.365
    ($b_{1F} = 0.365, SE = 0.006, p < .001$).
-   The addition of the interaction does not improve the model’s
    predictive accuracy ($\Delta R^2 = 0.000$).

# Continuous moderator

For the continuous predictor model, we have *Lack of confidence in the
government* as the focal predictor of *Perception of corruption*, and
*Secular values* as the continuous moderator.

## Main effects

The main effects model presents both the effects of each predictor on
the outcome. With a continuous predictor, the main effects model is just
a multiple regression model, nothing special yet

``` r
main_cont <- lm(Corrup ~ LCGov + SACSECVAL, data=dat2)
summary(main_cont)
```

    ## 
    ## Call:
    ## lm(formula = Corrup ~ LCGov + SACSECVAL, data = dat2)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -3.8443 -0.4577 -0.0257  0.4175  6.9258 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  2.725457   0.010578  257.65   <2e-16 ***
    ## LCGov        0.456142   0.004081  111.76   <2e-16 ***
    ## SACSECVAL   -1.111479   0.017134  -64.87   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.7569 on 71630 degrees of freedom
    ## Multiple R-squared:  0.1574, Adjusted R-squared:  0.1574 
    ## F-statistic:  6691 on 2 and 71630 DF,  p-value: < 2.2e-16

### Interpretation

-   We reject the null hypothesis of both predictors being equally good
    predictors as the mean model (a model including only the intercept
    but no predictors), $F(2, 71630) = 6691, p < .001$.
-   Both predictors explained 16% of the variance in the outcome
    ($R^2 = 0.157$).
-   The average outcome score for *Perception of corruption*, when both
    predictors are equal to 0 is 2.73
    ($b_0 = 2.73, SE = 0.01, p < .001$)
-   As *Lack of confidence in the government* increase by 1 unit,
    *Perception of corruption* increases by 0.46 points
    ($b_1 = 0.46, SE = 0.004, p < .001$), holding *Secular Values*
    constant.
-   As *Secular Value* increases by 1 unit, *Perception of corruption*
    decreases by -1.11 points ($b_2 = -1.11, SE = 0.017, p < .001$),
    holding *Lack of confidence in the government* constant.

## Interaction model

The interaction model is an extension of the main effects model, that
includes an interaction term between *Lack of confidence in the
government* and *Secular Values*.

In comparison to the model with *Sex* as a categorical moderator, we
simply replace *Female* with the variable name for *Secular values*,
namely *SACSECVAL*. Again, we want to get the output for probing the
interactions, so we specify `intprobe=1`. As we have seen in the example
with a categorical moderator above, probing the interaction means to
estimate the dependent focal regressions at specific levels of the
moderator. With a categorical moderator, there are only two levels of
the moderator that we can use. With a continuous moderator, however, it
is not immediately clear for which values of the moderator we would like
to see the slopes. With a continuous moderator we therefore need to
choose values of interest of the moderator to estimate the simple
slopes. Ideally, there are meaningful values for you to choose. Another
common option is to use the mean, the value at 1 standard deviation (SD)
below the mean, and the value one SD above the mean, to represents
average, low, and high values of the moderator. With the PROCESS macro,
we simply include the `moments=1` option, to probe the interaction for
these values of the moderator.

``` r
process(data = dat2, y = "Corrup", x = "LCGov", w = "SACSECVAL", model = 1, intprobe=1, moments=1)
```

    ## 
    ## ********************** PROCESS for R Version 4.1 ********************** 
    ##  
    ##            Written by Andrew F. Hayes, Ph.D.  www.afhayes.com              
    ##    Documentation available in Hayes (2022). www.guilford.com/p/hayes3   
    ##  
    ## *********************************************************************** 
    ##                  
    ## Model : 1        
    ##     Y : Corrup   
    ##     X : LCGov    
    ##     W : SACSECVAL
    ## 
    ## Sample size: 71633
    ## 
    ## 
    ## *********************************************************************** 
    ## Outcome Variable: Corrup
    ## 
    ## Model Summary: 
    ##           R      R-sq       MSE         F       df1        df2         p
    ##      0.3987    0.1589    0.5719 4511.7954    3.0000 71629.0000    0.0000
    ## 
    ## Model: 
    ##               coeff        se         t         p      LLCI      ULCI
    ## constant     2.5161    0.0212  118.6314    0.0000    2.4746    2.5577
    ## LCGov        0.5401    0.0084   64.0714    0.0000    0.5236    0.5567
    ## SACSECVAL   -0.4778    0.0582   -8.2029    0.0000   -0.5919   -0.3636
    ## Int_1       -0.2427    0.0213  -11.3833    0.0000   -0.2845   -0.2009
    ## 
    ## Product terms key:
    ## Int_1  :  LCGov  x  SACSECVAL      
    ## 
    ## Test(s) of highest order unconditional interaction(s):
    ##       R2-chng         F       df1        df2         p
    ## X*W    0.0015  129.5804    1.0000 71629.0000    0.0000
    ## ----------
    ## Focal predictor: LCGov (X)
    ##       Moderator: SACSECVAL (W)
    ## 
    ## Conditional effects of the focal predictor at values of the moderator(s):
    ##   SACSECVAL    effect        se         t         p      LLCI      ULCI
    ##      0.1858    0.4950    0.0053   93.0586    0.0000    0.4846    0.5055
    ##      0.3606    0.4526    0.0041  110.6768    0.0000    0.4446    0.4606
    ##      0.5353    0.4102    0.0057   71.5070    0.0000    0.3990    0.4215
    ## 
    ## ******************** ANALYSIS NOTES AND ERRORS ************************ 
    ## 
    ## Level of confidence for all confidence intervals in output: 95
    ## 
    ## W values in conditional tables are the mean and +/- SD from the mean.

In the output, we see that the interaction term `Int_1`, and the
*p-value* for this term testing the Null Hypothesis that the 2
predictors are independent.

### Effect size

To assess the effect size of the interaction, we can look at this as the
change in $R^2$ when the interaction is added. The output is shown under
the header *Test(s) of highest order unconditional interaction(s):*, and
we can see that the change in the explained variance is
$\Delta R^2 = 0.0015$, as given by *R2-chng*.

### Probing

If we go back to the coefficient for the interaction term, you can see
that it is -0.243. This coefficient tells the change in the slope is
when the moderator increases by 1 unit. Unless you have very clear
metric of the moderator, this parameter is hard to interpret. It is
therefore useful to probe the interaction by looking at the slope for
specific values of the moderator.

The output shows that that for the low *Secular Values*, the slope
between *lack of confidence in the government* and *Perception of
corruption* is 0.495 ($b_{LSV} = 0.495, SE = 0.005, p < .001$), for
average *Secular Values* it is 0.453
($b_{MSV} = 0.453, SE = 0.004, p < .001$), and for high *Secular Values*
it is 0.410 ($b_{HSV} = 0.410, SE = 0.006, p < .001$). Keep in mind that
high and low values of the moderator are represented by values one SD
above or below the mean.

This way we see a a general trend, as *Secular Values* increases, the
focal regression decreases strength.

Another option with a continuous moderator is to estimate simple slopes
for a long array of moderator values. A recommendation would be to test
across a large number of possible values between the minimum and maximum
of values for the moderator. With the PROCESS macro, we can do that
using the `wmodval` option.

We first create a vector with the values at which we want to probe the
interactions. In this case, we use steps of 0.1 between the minimum and
the maximum of the SACSECVAL variable.

``` r
vals <- seq(from=min(dat2$SACSECVAL, na.rm=T), to=max(dat2$SACSECVAL, na.rm=T), by=.1)
vals
```

    ##  [1] 0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9

Then we provide the `vals` vector to the `wmodval` option:

``` r
process(data = dat2, y = "Corrup", x = "LCGov", w = "SACSECVAL", model = 1, intprobe=1, wmodval = vals)
```

    ## 
    ## ********************** PROCESS for R Version 4.1 ********************** 
    ##  
    ##            Written by Andrew F. Hayes, Ph.D.  www.afhayes.com              
    ##    Documentation available in Hayes (2022). www.guilford.com/p/hayes3   
    ##  
    ## *********************************************************************** 
    ##                  
    ## Model : 1        
    ##     Y : Corrup   
    ##     X : LCGov    
    ##     W : SACSECVAL
    ## 
    ## Sample size: 71633
    ## 
    ## 
    ## *********************************************************************** 
    ## Outcome Variable: Corrup
    ## 
    ## Model Summary: 
    ##           R      R-sq       MSE         F       df1        df2         p
    ##      0.3987    0.1589    0.5719 4511.7954    3.0000 71629.0000    0.0000
    ## 
    ## Model: 
    ##               coeff        se         t         p      LLCI      ULCI
    ## constant     2.5161    0.0212  118.6314    0.0000    2.4746    2.5577
    ## LCGov        0.5401    0.0084   64.0714    0.0000    0.5236    0.5567
    ## SACSECVAL   -0.4778    0.0582   -8.2029    0.0000   -0.5919   -0.3636
    ## Int_1       -0.2427    0.0213  -11.3833    0.0000   -0.2845   -0.2009
    ## 
    ## Product terms key:
    ## Int_1  :  LCGov  x  SACSECVAL      
    ## 
    ## Test(s) of highest order unconditional interaction(s):
    ##       R2-chng         F       df1        df2         p
    ## X*W    0.0015  129.5804    1.0000 71629.0000    0.0000
    ## ----------
    ## Focal predictor: LCGov (X)
    ##       Moderator: SACSECVAL (W)
    ## 
    ## Conditional effects of the focal predictor at values of the moderator(s):
    ##   SACSECVAL    effect        se         t         p      LLCI      ULCI
    ##      0.0000    0.5401    0.0084   64.0714    0.0000    0.5236    0.5567
    ##      0.1000    0.5159    0.0066   77.6364    0.0000    0.5028    0.5289
    ##      0.2000    0.4916    0.0051   95.8111    0.0000    0.4815    0.5016
    ##      0.3000    0.4673    0.0042  111.4161    0.0000    0.4591    0.4755
    ##      0.4000    0.4430    0.0042  104.5663    0.0000    0.4347    0.4514
    ##      0.5000    0.4188    0.0052   79.9972    0.0000    0.4085    0.4290
    ##      0.6000    0.3945    0.0068   58.1994    0.0000    0.3812    0.4078
    ##      0.7000    0.3702    0.0086   43.1601    0.0000    0.3534    0.3870
    ##      0.8000    0.3460    0.0105   32.9393    0.0000    0.3254    0.3665
    ##      0.9000    0.3217    0.0125   25.7448    0.0000    0.2972    0.3462
    ## 
    ## ******************** ANALYSIS NOTES AND ERRORS ************************ 
    ## 
    ## Level of confidence for all confidence intervals in output: 95

We can now see that the slope of interest changes from 0.54 to 0.32 from
the lowest and highest values. And for every one of them we reject the
null hypothesis of each simple slope being equal to 0

### Interpretation

-   We reject the null hypothesis of the 2 predictors being independent
    ($b_{*} = -0.243, SE = 0.021, p < .001$).
-   As the moderator *Secular Values* increase by 1 unit, the focal
    regression (`Corrup ~ LCGov`) decreases by 0.243 points
    ($b_{*} = -0.243, SE = 0.021, p < .001$)
-   For low *Secular Values*, the slope between *lack of confidence in
    the government* and *Perception of corruption* is 0.495
    ($b_{LSV} = 0.495, SE = 0.005, p < .001$)
-   For average *Secular Values* it is 0.453
    ($b_{MSV} = 0.453, SE = 0.004, p < .001$)
-   For high *Secular Values* it is 0.410
    ($b_{HSV} = 0.410, SE = 0.006, p < .001$).
-   In the general trend we see that the focal slope goes from 0.54 at
    the minimum observed *Secular Values* to 0.32 at the maximum
    observed *Secular values* score.
-   The addition of the interaction increases the model’s predictive
    accuracy by 0.15% ($\Delta R^2 = 0.0015$).

## Visualizing interactions

Unfortunately, the PROCESS macro is not very useful for plotting an
interaction. To generate plots of interactions, you can instead use the
method described in the *Moderation analysis with lm()* tutorial. If you
want to stick with the process macro, you can request the data necessary
to generate a plot from the PROCESS macro using the `plot = 2` option,
but you then have to create a graph manually.

# PROCESS models

When working with the PROCESS macro, the argument `model` specifies the
type of model. Such as moderation, mediation, serial, parallel,
conditional processes. In this tutorial we showed the simple moderation
example. The other numbered models in PROCESS are available in Appendix
A of *Introduction to Mediation, Moderation, and Conditional Process
Analysis* (Hayes, 2022)

# References

Hayes, Andrew F. (2022). Introduction to mediation, moderation, and
conditional process analysis: A regression-based approach (Third
edition, Vol. 1–1 online resource (xx, 732 pages) : illustrations.). The
Guilford Press.
