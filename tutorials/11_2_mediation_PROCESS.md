Mediation analysis using the PROCESS macro
================
Mauricio Garnier-Villarreal, Joris M. Schröder & Joseph Charles Van
Matre
01 September, 2022

-   <a href="#what-is-mediation-analysis"
    id="toc-what-is-mediation-analysis">What is mediation analysis?</a>
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
        -   <a href="#select-variables-for-analysis"
            id="toc-select-variables-for-analysis">Select variables for analysis</a>
-   <a href="#mediation-analysis-steps"
    id="toc-mediation-analysis-steps">Mediation analysis steps</a>
-   <a href="#mediation-analysis" id="toc-mediation-analysis">Mediation
    analysis</a>
    -   <a href="#mediation-analysis-with-the-process-macro"
        id="toc-mediation-analysis-with-the-process-macro">Mediation analysis
        with the PROCESS macro</a>
        -   <a href="#total-effect" id="toc-total-effect">Total effect</a>
        -   <a href="#indirect-effect" id="toc-indirect-effect">Indirect effect</a>
            -   <a href="#inference-for-the-indirect-effect"
                id="toc-inference-for-the-indirect-effect">Inference for the indirect
                effect</a>
                -   <a href="#bootstrap-nhst" id="toc-bootstrap-nhst">Bootstrap NHST</a>
                -   <a href="#monte-carlo-nhst" id="toc-monte-carlo-nhst">Monte-Carlo
                    NHST</a>
                -   <a href="#sobel-nhst" id="toc-sobel-nhst">Sobel NHST</a>
            -   <a href="#direct-effect" id="toc-direct-effect">Direct effect</a>
        -   <a href="#final-recommendations" id="toc-final-recommendations">Final
            recommendations</a>
    -   <a href="#interpretation" id="toc-interpretation">Interpretation</a>
-   <a href="#process-models" id="toc-process-models">PROCESS models</a>
-   <a href="#references" id="toc-references">References</a>

# What is mediation analysis?

With mediation analysis, we are trying to find out whether the effect or
association between an independent and a dependent variable is due to an
indirect effect through another variable (called the mediator variable).
Let’s say that we are interested in the association between *Secular
values* and *Perception of corruption*, but we specifically want to know
whether the association works through the mediator variable *Lack of
confidence in the government* of individuals (see the figure below). In
this example, *Lack of confidence in the government* is therefore our
(potential) *mediator* of the association between *Secular values* and
*Perception of corruption*.

![](images/Path_diagram_example.png)

# Setup the R session

When we start working in R, we always need to setup our session. For
this we need to set our working directory, in this case I am doing that
for the folder that holds the downloaded [World Values Survey
(WVS)](https://www.worldvaluessurvey.org/) `SPSS` data set.

``` r
setwd("~path_to_your_file")
```

The next step for setting up our session will be to load the packages
that we will be using. In this case, only the `rio` package used to
import the data.

``` r
library(rio)
```

# Installing the PROCESS macro

In this tutorial, we will be showing you how to do mediation analysis
using the **PROCESS** macro. If you already know how to work with the
PROCESS macro in R you can skip the rest of this section and go to
[Import the data set](#import-the-data-set). Just don’t forget to run
the PROCESS script once. If you have not worked with the PROCESS macro
in R before, follow the steps below.

To use the process macro, you first need to download it from this
website: <https://www.processmacro.org/download.html>. You will download
a zip archive that you need to extract (using for example
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

We now import the WVS data set in `.sav` format.

``` r
dat <- import("WVS_Cross-National_Wave_7_sav_v2_0.sav")
dim(dat)
```

    ## [1] 76897   548

We are calling the data set **dat** and asking to see the dimension of
it. We see that the data set has 76897 subjects, and 548 columns.

## Prepare the data set

In cases with large data sets like this it is easy to loose track of all
548 variables. We therefore might want to select a subset of variables
that we want to work with. You can see all variable names for the full
data set by using:

``` r
colnames(dat)
```

To select a subset of variables, we first create a vector **vars** with
the variable names for the variables we want to keep. After identifying
which variables we will work with, we create a new data set **dat2**
with only these 17 variables, and make sure we did it correctly by
looking at the the dimension of the data `dim(dat2)`. We also look at
the first 6 rows: `head(dat2)`. These are quick checks that we have
created the new data correctly.

``` r
vars <- c("Q262", "Y001", "SACSECVAL", "Q112", "Q113", "Q114", "Q115", "Q116", "Q117", "Q118", "Q119", "Q120", "Q65", "Q69", "Q71", "Q72", "Q73")
dat2 <- dat[,vars]
dim(dat2)
```

    ## [1] 76897    17

``` r
head(dat2)
```

    ##   Q262 Y001 SACSECVAL Q112 Q113 Q114 Q115 Q116 Q117 Q118 Q119 Q120 Q65 Q69 Q71
    ## 1   60    0  0.287062    2   NA   NA   NA   NA   NA    1    2    6  NA   1   1
    ## 2   47    2  0.467525   10    3    3    3    3    3    1    3    2  NA   3   4
    ## 3   48    4  0.425304    7    2    2    2    2    2    1    2    7  NA   2   3
    ## 4   62    2  0.556170    5    3    3    3    3    2    1    4    7  NA   3   3
    ## 5   49    1  0.458949    5    2    2    2    2    1    1    3    7  NA   2   2
    ## 6   51    3  0.210111    6    2    2    2    2    2    1    4    2  NA   1   2
    ##   Q72 Q73
    ## 1   1   1
    ## 2   4   4
    ## 3   3   3
    ## 4   3   3
    ## 5   3   2
    ## 6   2   2

The variables we will use here are:

-   Q262: age in years
-   Y001: post-materialism index
-   SACSECVAL: secular values
-   Q112-Q120: Corruption Perception Index
-   Q65-Q73: Lack of Confidence in the government

### Create composite scores

We will be using the composite scores for *Corruption Perception Index*
and *Lack of Confidence in the government* instead of their single
items. So, we first need to compute them. We will use the mean across
all items to form a composite score for each construct.

``` r
dat2$Corrup <- rowMeans(dat2[,c("Q112", "Q113", "Q114", "Q115", "Q116", "Q117", "Q118", "Q119", "Q120")], na.rm=T)
dat2$LCGov <- rowMeans(dat2[,c("Q65", "Q69", "Q71", "Q72", "Q73")], na.rm=T)
head(dat2)
```

    ##   Q262 Y001 SACSECVAL Q112 Q113 Q114 Q115 Q116 Q117 Q118 Q119 Q120 Q65 Q69 Q71
    ## 1   60    0  0.287062    2   NA   NA   NA   NA   NA    1    2    6  NA   1   1
    ## 2   47    2  0.467525   10    3    3    3    3    3    1    3    2  NA   3   4
    ## 3   48    4  0.425304    7    2    2    2    2    2    1    2    7  NA   2   3
    ## 4   62    2  0.556170    5    3    3    3    3    2    1    4    7  NA   3   3
    ## 5   49    1  0.458949    5    2    2    2    2    1    1    3    7  NA   2   2
    ## 6   51    3  0.210111    6    2    2    2    2    2    1    4    2  NA   1   2
    ##   Q72 Q73   Corrup LCGov
    ## 1   1   1 2.750000  1.00
    ## 2   4   4 3.444444  3.75
    ## 3   3   3 3.000000  2.75
    ## 4   3   3 3.444444  3.00
    ## 5   3   2 2.777778  2.25
    ## 6   2   2 2.555556  1.75

With the `rowmeans()` we compute the mean across the specified
variables, subject by subject. Remember to include the `na.rm=T`
argument, so the missing values are ignored. In this way, the mean score
represents the mean for all of the items that the respondents did
answer. Otherwise, you get a missing value for every individual that has
a missing value on at least *one* of the items.

Note that the PROCESS macro does not work with variables that are
designated as factors. Categorical variables should therefore not be
designated as factor variables when you are working with the PROCESS
macro. In our data set this is not the case, so we can proceed.

### Select variables for analysis

Now, we will again create a new data set (**dat2**) that only contains
the variables we want to work with:

``` r
dat2 <- na.omit(dat2[,c("Q262", "Y001", "SACSECVAL", "Corrup", "LCGov")])
head(dat2)
```

    ##   Q262 Y001 SACSECVAL   Corrup LCGov
    ## 1   60    0  0.287062 2.750000  1.00
    ## 2   47    2  0.467525 3.444444  3.75
    ## 3   48    4  0.425304 3.000000  2.75
    ## 4   62    2  0.556170 3.444444  3.00
    ## 5   49    1  0.458949 2.777778  2.25
    ## 6   51    3  0.210111 2.555556  1.75

``` r
dim(dat2)
```

    ## [1] 71648     5

The new `dat2` data set only include the 6 continuous variables of
interest, and 1 binary variable. With the `na.omit()` function we are
excluding all cases with some missing values.

# Mediation analysis steps

Mediation analysis can be split into a few steps

-   Estimate the *total effect* model, that includes only the outcome
    and main predictor variables
-   Estimate the *mediation* model, including the 2 regressions that are
    involved (will explain this next)
-   Use either *bootstraps* or *Monte-Carlo* to make an inference about
    the mediation/indirect effect

# Mediation analysis

Mediation analysis involves several regressions in the sense that we
have multiple outcomes. Here we have all predictor(s) and mediator(s)
predicting the outcome variable, and all (main) predictor(s) predicting
the mediator(s).

In the simple mediation model with one independent variable (X), one
dependent variable (Y), and one mediator variable (M), we have the
following paths (see the figure below):

-   the *direct effect* of X on Y, denoted c’
-   the *direct effect* of X on M, denoted a
-   the *direct effect* of M on Y, denoted b

In addition, we have the *total effect*, denoted c, which is the overall
effect of X on Y. The total effect includes the direct effect and the
indirect effect through all (potential) mediators. With mediation
analysis, we are trying to partition the total effect into direct and
indirect effects.

![](images/Path_diagram_conceptual.png)

Now lets explain it with the simple mediation example from above. In
this case we are mainly interested in the effect of *Secular values* on
*Perception of corruption*. So, the *total* effect of it can be express
by the simple regression

Here we can see that it is a simple concept: the *full/maximum/total*
effect that *Secular values* has on *Perception of corruption* is $c$
(in your data set).

With mediation analysis, we will partition this effect $c$ into a
*direct* effect $c'$, and an *indirect* effect $ab$ or $c-c'$. We can do
this with 2 regressions, the first one by adding also *Lack of
confidence in the government* as a second predictor/mediator

And a second regression where the main predictor also predicts the
mediator. This way we see that the mediator is both a predictor and an
outcome at the same time

Now, from these 2 new regressions where do the *direct* and *indirect*
effects come from? The *direct* effect is simple, it is the $c`$ slope,
or the effect of the main predictor on the outcome when the mediator is
included.

While for the *indirect effect* we need to use both equations, as it is
defined as the product of $a$ and $b$ parameters from the previous
regressions $ab$, which is equal to $c-c'$ (in the case of linear
regression).

## Mediation analysis with the PROCESS macro

The general code for a simple moderation model using the PROCESS macro
is
`process (data = my_data_frame, y = "dependent_variable", x = "independent_variable", m ="mediator_variable", total = 1, stand=1, model = 4, seed = 11111)`.

In the command, the inputs for data, y, x, and m are placeholders, which
we have to replace with the names for the data set and the variable
names from our data set. By specifying `total = 1` we also request
output for the total effect. With `stand = 1` we request standardized
coefficients. `model = 4` specifies that we want to estimate a simple
mediation model with one mediator, and one outcome variable. And
finally, `seed=11111` sets the seed for the random number generator to a
specific number. This allows others to exactly reproduce your results by
setting the same seed.

``` r
process(data = dat2, y = "Corrup", x = "SACSECVAL", m = "LCGov", total = 1, stand=1, model = 4, seed = 11111)
```

    ## 
    ## ********************** PROCESS for R Version 4.1 ********************** 
    ##  
    ##            Written by Andrew F. Hayes, Ph.D.  www.afhayes.com              
    ##    Documentation available in Hayes (2022). www.guilford.com/p/hayes3   
    ##  
    ## *********************************************************************** 
    ##                  
    ## Model : 4        
    ##     Y : Corrup   
    ##     X : SACSECVAL
    ##     M : LCGov    
    ## 
    ## Sample size: 71648
    ## 
    ## Custom seed: 11111
    ## 
    ## 
    ## *********************************************************************** 
    ## Outcome Variable: LCGov
    ## 
    ## Model Summary: 
    ##           R      R-sq       MSE         F       df1        df2         p
    ##      0.3281    0.1077    0.4801 8643.9386    1.0000 71646.0000    0.0000
    ## 
    ## Model: 
    ##               coeff        se         t         p      LLCI      ULCI
    ## constant     2.0475    0.0059  344.9351    0.0000    2.0358    2.0591
    ## SACSECVAL    1.3773    0.0148   92.9728    0.0000    1.3482    1.4063
    ## 
    ## Standardized coefficients:
    ##               coeff
    ## SACSECVAL    0.3281
    ## 
    ## *********************************************************************** 
    ## Outcome Variable: Corrup
    ## 
    ## Model Summary: 
    ##           R      R-sq       MSE         F       df1        df2         p
    ##      0.3968    0.1574    0.5729 6693.3837    2.0000 71645.0000    0.0000
    ## 
    ## Model: 
    ##               coeff        se         t         p      LLCI      ULCI
    ## constant     2.7253    0.0106  257.6839    0.0000    2.7046    2.7461
    ## SACSECVAL   -1.1114    0.0171  -64.8837    0.0000   -1.1450   -1.0779
    ## LCGov        0.4562    0.0041  111.7818    0.0000    0.4482    0.4642
    ## 
    ## Standardized coefficients:
    ##               coeff
    ## SACSECVAL   -0.2355
    ## LCGov        0.4058
    ## 
    ## ************************ TOTAL EFFECT MODEL *************************** 
    ## Outcome Variable: Corrup
    ## 
    ## Model Summary: 
    ##           R      R-sq       MSE         F       df1        df2         p
    ##      0.1024    0.0105    0.6728  759.2014    1.0000 71646.0000    0.0000
    ## 
    ## Model: 
    ##               coeff        se         t         p      LLCI      ULCI
    ## constant     3.6594    0.0070  520.7868    0.0000    3.6456    3.6731
    ## SACSECVAL   -0.4832    0.0175  -27.5536    0.0000   -0.5175   -0.4488
    ## 
    ## Standardized coefficients:
    ##               coeff
    ## SACSECVAL   -0.1024
    ## 
    ## *********************************************************************** 
    ## Bootstrapping progress:
    ##   |                                                                      |                                                              |   0%  |                                                                      |                                                              |   1%  |                                                                      |>                                                             |   1%  |                                                                      |>                                                             |   2%  |                                                                      |>>                                                            |   2%  |                                                                      |>>                                                            |   3%  |                                                                      |>>                                                            |   4%  |                                                                      |>>>                                                           |   4%  |                                                                      |>>>                                                           |   5%  |                                                                      |>>>                                                           |   6%  |                                                                      |>>>>                                                          |   6%  |                                                                      |>>>>                                                          |   7%  |                                                                      |>>>>>                                                         |   7%  |                                                                      |>>>>>                                                         |   8%  |                                                                      |>>>>>                                                         |   9%  |                                                                      |>>>>>>                                                        |   9%  |                                                                      |>>>>>>                                                        |  10%  |                                                                      |>>>>>>>                                                       |  10%  |                                                                      |>>>>>>>                                                       |  11%  |                                                                      |>>>>>>>                                                       |  12%  |                                                                      |>>>>>>>>                                                      |  12%  |                                                                      |>>>>>>>>                                                      |  13%  |                                                                      |>>>>>>>>                                                      |  14%  |                                                                      |>>>>>>>>>                                                     |  14%  |                                                                      |>>>>>>>>>                                                     |  15%  |                                                                      |>>>>>>>>>>                                                    |  15%  |                                                                      |>>>>>>>>>>                                                    |  16%  |                                                                      |>>>>>>>>>>                                                    |  17%  |                                                                      |>>>>>>>>>>>                                                   |  17%  |                                                                      |>>>>>>>>>>>                                                   |  18%  |                                                                      |>>>>>>>>>>>                                                   |  19%  |                                                                      |>>>>>>>>>>>>                                                  |  19%  |                                                                      |>>>>>>>>>>>>                                                  |  20%  |                                                                      |>>>>>>>>>>>>>                                                 |  20%  |                                                                      |>>>>>>>>>>>>>                                                 |  21%  |                                                                      |>>>>>>>>>>>>>                                                 |  22%  |                                                                      |>>>>>>>>>>>>>>                                                |  22%  |                                                                      |>>>>>>>>>>>>>>                                                |  23%  |                                                                      |>>>>>>>>>>>>>>>                                               |  23%  |                                                                      |>>>>>>>>>>>>>>>                                               |  24%  |                                                                      |>>>>>>>>>>>>>>>                                               |  25%  |                                                                      |>>>>>>>>>>>>>>>>                                              |  25%  |                                                                      |>>>>>>>>>>>>>>>>                                              |  26%  |                                                                      |>>>>>>>>>>>>>>>>                                              |  27%  |                                                                      |>>>>>>>>>>>>>>>>>                                             |  27%  |                                                                      |>>>>>>>>>>>>>>>>>                                             |  28%  |                                                                      |>>>>>>>>>>>>>>>>>>                                            |  28%  |                                                                      |>>>>>>>>>>>>>>>>>>                                            |  29%  |                                                                      |>>>>>>>>>>>>>>>>>>                                            |  30%  |                                                                      |>>>>>>>>>>>>>>>>>>>                                           |  30%  |                                                                      |>>>>>>>>>>>>>>>>>>>                                           |  31%  |                                                                      |>>>>>>>>>>>>>>>>>>>>                                          |  31%  |                                                                      |>>>>>>>>>>>>>>>>>>>>                                          |  32%  |                                                                      |>>>>>>>>>>>>>>>>>>>>                                          |  33%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>                                         |  33%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>                                         |  34%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>                                         |  35%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>                                        |  35%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>                                        |  36%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>                                       |  36%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>                                       |  37%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>                                       |  38%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>                                      |  38%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>                                      |  39%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>                                      |  40%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>                                     |  40%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>                                     |  41%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>                                    |  41%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>                                    |  42%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>                                    |  43%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>                                   |  43%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>                                   |  44%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                  |  44%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                  |  45%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                  |  46%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                 |  46%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                 |  47%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                 |  48%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                |  48%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                |  49%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                               |  49%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                               |  50%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                               |  51%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                              |  51%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                              |  52%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                             |  52%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                             |  53%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                             |  54%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                            |  54%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                            |  55%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                            |  56%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                           |  56%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                           |  57%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                          |  57%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                          |  58%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                          |  59%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                         |  59%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                         |  60%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                        |  60%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                        |  61%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                        |  62%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                       |  62%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                       |  63%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                       |  64%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                      |  64%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                      |  65%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                     |  65%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                     |  66%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                     |  67%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                    |  67%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                    |  68%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                    |  69%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                   |  69%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                   |  70%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                  |  70%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                  |  71%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                  |  72%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                 |  72%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                 |  73%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                |  73%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                |  74%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                |  75%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>               |  75%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>               |  76%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>               |  77%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>              |  77%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>              |  78%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>             |  78%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>             |  79%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>             |  80%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>            |  80%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>            |  81%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>           |  81%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>           |  82%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>           |  83%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>          |  83%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>          |  84%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>          |  85%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>         |  85%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>         |  86%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>        |  86%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>        |  87%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>        |  88%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>       |  88%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>       |  89%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>       |  90%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>      |  90%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>      |  91%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     |  91%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     |  92%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     |  93%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>    |  93%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>    |  94%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   |  94%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   |  95%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   |  96%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  |  96%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  |  97%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  |  98%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> |  98%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> |  99%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>|  99%  |                                                                      |>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>| 100%
    ## 
    ## ************ TOTAL, DIRECT, AND INDIRECT EFFECTS OF X ON Y ************
    ## 
    ## Total effect of X on Y:
    ##      effect        se         t         p      LLCI      ULCI      c_cs
    ##     -0.4832    0.0175  -27.5536    0.0000   -0.5175   -0.4488   -0.1024
    ## 
    ## Direct effect of X on Y:
    ##      effect        se         t         p      LLCI      ULCI     c'_cs
    ##     -1.1114    0.0171  -64.8837    0.0000   -1.1450   -1.0779   -0.2355
    ## 
    ## Indirect effect(s) of X on Y:
    ##          Effect    BootSE  BootLLCI  BootULCI
    ## LCGov    0.6283    0.0088    0.6111    0.6454
    ## 
    ## Completely standardized indirect effect(s) of X on Y:
    ##          Effect    BootSE  BootLLCI  BootULCI
    ## LCGov    0.1331    0.0019    0.1295    0.1368
    ## 
    ## ******************** ANALYSIS NOTES AND ERRORS ************************ 
    ## 
    ## Level of confidence for all confidence intervals in output: 95
    ## 
    ## Number of bootstraps for percentile bootstrap confidence intervals: 5000

The macro provides output for each of the models described above. One
model where *Perception of corruption* is the outcome variable, and one
model where *Lack of confidence in the government* is the outcome
variable.

### Total effect

Lets first look at the total effect model. The output is given under the
heading *TOTAL EFFECT MODEL*. Here we see that the *total* effect of
*Secular values* on *Perception of corruption* is
$c = -0.483, SE = 0.018, p < .001$. This can be considered a a small
effect as the standardized slope is $\beta = -0.102$ (given under the
*Standardized coefficients* subheading), and only 1% of the variance is
explained by *Secular values* ($R^2 = .01$, given as *R-sq* under the
subheading *Model Summary*).

### Indirect effect

The output for the indirect effect is given all the way at the bottom of
the output of the PROCESS macro under the heading *TOTAL, DIRECT, AND
INDIRECT EFFECTS OF X ON Y*.

We can see that the indirect effect of *Secular values* on *Perception
of corruption* through *Lack of confidence in the government* is
$ab = 0.628, 95\% CI = [0.611, 0.645], \beta = 0.133$. We reject the
null hypothesis that *Lack of confidence in the government* has no
mediating effect between *Secular values* and *Perception of
Corruption*. Instead, we find a small positive standardized indirect
effect of 0.133. As *Secular values* increases by one unit, *Perception
of corruption* increases by 0.628 units, through the effect on *Lack of
confidence in the government*. And as *Secular values* increases by one
standard deviation, *Perception of corruption* increases by 0.133 units,
through the effect on *Lack of confidence in the government*.

#### Inference for the indirect effect

There are several ways to do inference about the statistical
significance of the indirect effect. Below, we outline three options for
Null Hypothesis Significance Testing (NHST).

The first option is the Sobel NHST. The Sobel NHST has the fundamental
assumption that the estimated parameter for the indirect effect follows
a normal distribution. This is a general assumption of regressions, and
it can be held for the direct effects $c$, $a$, $b$ and $tot$. But It is
not reasonable for the *indirect* effect $ab$ (Hayes, 2022).

Two **better options** are the *Bootstrap NHST*, and *Monte-Carlo NHST*.
Both of these fall in the family of *non-parametric* tests. They work by
simulating empirical parameter distribution for the indirect effect, and
we can use these distributions to construct confidence intervals (CI)
for the indirect effect. Because these tests rely on simulated empirical
distributions, we do not have to assume that the $ab$ parameter is
normally distributed.

In short, bootstrapping works by resampling repeatedly and randomly from
an original, initial sample, and estimating a statistic (e.g. the
indirect effect) based on this sample. All of these estimated statistics
are then used do construct an empirical parameter distribution for the
indirect effect. Ideally, we want thousands of resamples to get a
reliable parameter distribution. PROCESS uses a default of 5000
bootstrap samples (Hayes, 2022), which is fine.

Monte-Carlo NHST works by simulating several thousands of values for the
parameters $a$, $b$, and $c$ based on the estimates and their
covariance, and calculating the respective new parameters of interest
(e.g., the indirect effect $ab$). Similar to bootstrap this creates an
empirical parameter distribution, from which we will calculate
confidence intervals to make inferences.

##### Bootstrap NHST

By default, the PROCESS macro provides bootstrapped confidence
intervals. This is what we have already done above: The estimate for the
indirect effect is
$ab = 0.628, 95\% CI = [0.611, 0.645], \beta = 0.133$.

##### Monte-Carlo NHST

To use Monte-Carlo NHST, we simply add `mc = 5000` to the PROCESS
command:

``` r
process(data = dat2, y = "Corrup", x = "SACSECVAL", m = "LCGov", total = 1, stand=1, model = 4, seed=11111, mc = 5000)
```

    ## 
    ## ********************** PROCESS for R Version 4.1 ********************** 
    ##  
    ##            Written by Andrew F. Hayes, Ph.D.  www.afhayes.com              
    ##    Documentation available in Hayes (2022). www.guilford.com/p/hayes3   
    ##  
    ## *********************************************************************** 
    ##                  
    ## Model : 4        
    ##     Y : Corrup   
    ##     X : SACSECVAL
    ##     M : LCGov    
    ## 
    ## Sample size: 71648
    ## 
    ## Random seed: 501448
    ## 
    ## 
    ## *********************************************************************** 
    ## Outcome Variable: LCGov
    ## 
    ## Model Summary: 
    ##           R      R-sq       MSE         F       df1        df2         p
    ##      0.3281    0.1077    0.4801 8643.9386    1.0000 71646.0000    0.0000
    ## 
    ## Model: 
    ##               coeff        se         t         p      LLCI      ULCI
    ## constant     2.0475    0.0059  344.9351    0.0000    2.0358    2.0591
    ## SACSECVAL    1.3773    0.0148   92.9728    0.0000    1.3482    1.4063
    ## 
    ## Standardized coefficients:
    ##               coeff
    ## SACSECVAL    0.3281
    ## 
    ## *********************************************************************** 
    ## Outcome Variable: Corrup
    ## 
    ## Model Summary: 
    ##           R      R-sq       MSE         F       df1        df2         p
    ##      0.3968    0.1574    0.5729 6693.3837    2.0000 71645.0000    0.0000
    ## 
    ## Model: 
    ##               coeff        se         t         p      LLCI      ULCI
    ## constant     2.7253    0.0106  257.6839    0.0000    2.7046    2.7461
    ## SACSECVAL   -1.1114    0.0171  -64.8837    0.0000   -1.1450   -1.0779
    ## LCGov        0.4562    0.0041  111.7818    0.0000    0.4482    0.4642
    ## 
    ## Standardized coefficients:
    ##               coeff
    ## SACSECVAL   -0.2355
    ## LCGov        0.4058
    ## 
    ## ************************ TOTAL EFFECT MODEL *************************** 
    ## Outcome Variable: Corrup
    ## 
    ## Model Summary: 
    ##           R      R-sq       MSE         F       df1        df2         p
    ##      0.1024    0.0105    0.6728  759.2014    1.0000 71646.0000    0.0000
    ## 
    ## Model: 
    ##               coeff        se         t         p      LLCI      ULCI
    ## constant     3.6594    0.0070  520.7868    0.0000    3.6456    3.6731
    ## SACSECVAL   -0.4832    0.0175  -27.5536    0.0000   -0.5175   -0.4488
    ## 
    ## Standardized coefficients:
    ##               coeff
    ## SACSECVAL   -0.1024
    ## 
    ## ************ TOTAL, DIRECT, AND INDIRECT EFFECTS OF X ON Y ************
    ## 
    ## Total effect of X on Y:
    ##      effect        se         t         p      LLCI      ULCI      c_cs
    ##     -0.4832    0.0175  -27.5536    0.0000   -0.5175   -0.4488   -0.1024
    ## 
    ## Direct effect of X on Y:
    ##      effect        se         t         p      LLCI      ULCI     c'_cs
    ##     -1.1114    0.0171  -64.8837    0.0000   -1.1450   -1.0779   -0.2355
    ## 
    ## Indirect effect(s) of X on Y:
    ##          Effect     MC SE   MC LLCI   MC ULCI
    ## LCGov    0.6283    0.0089    0.6115    0.6454
    ## 
    ## Completely standardized indirect effect(s) of X on Y:
    ##          Effect     MC SE   MC LLCI   MC ULCI
    ## LCGov    0.1331    0.0019    0.1296    0.1368
    ## 
    ## ******************** ANALYSIS NOTES AND ERRORS ************************ 
    ## 
    ## Level of confidence for all confidence intervals in output: 95
    ## 
    ## Number of samples for Monte Carlo confidence intervals: 5000

In this case, the result is identical to the result obtained via
bootstrapping up to the third decimal place:
$ab = 0.628, 95\% CI = [0.611, 0.645], \beta = 0.133$. This does not
have to be the case, however, and there might slight deviations between
the results. If the results differ substantially, you should try to
figure out why that might be the case. The inference is done in the same
way as with the Bootstrap interval, what changes is how we build the
empirical distribution. So we would again reject the null hypothesis
that *Lack of confidence in the government* does not have a mediating
effect between *Secular values* and *Perception of Corruption*.

##### Sobel NHST

Although not recommended, you can request the Sobel NHST by specifying
`normal = 1` and `boot = 0` in the PROCESS macro command.

``` r
process(data = dat2, y = "Corrup", x = "SACSECVAL", m = "LCGov", total = 1, stand=1, model = 4, normal = 1, boot = 0, seed = 11111)
```

    ## 
    ## ********************** PROCESS for R Version 4.1 ********************** 
    ##  
    ##            Written by Andrew F. Hayes, Ph.D.  www.afhayes.com              
    ##    Documentation available in Hayes (2022). www.guilford.com/p/hayes3   
    ##  
    ## *********************************************************************** 
    ##                  
    ## Model : 4        
    ##     Y : Corrup   
    ##     X : SACSECVAL
    ##     M : LCGov    
    ## 
    ## Sample size: 71648
    ## 
    ## Custom seed: 11111
    ## 
    ## 
    ## *********************************************************************** 
    ## Outcome Variable: LCGov
    ## 
    ## Model Summary: 
    ##           R      R-sq       MSE         F       df1        df2         p
    ##      0.3281    0.1077    0.4801 8643.9386    1.0000 71646.0000    0.0000
    ## 
    ## Model: 
    ##               coeff        se         t         p      LLCI      ULCI
    ## constant     2.0475    0.0059  344.9351    0.0000    2.0358    2.0591
    ## SACSECVAL    1.3773    0.0148   92.9728    0.0000    1.3482    1.4063
    ## 
    ## Standardized coefficients:
    ##               coeff
    ## SACSECVAL    0.3281
    ## 
    ## *********************************************************************** 
    ## Outcome Variable: Corrup
    ## 
    ## Model Summary: 
    ##           R      R-sq       MSE         F       df1        df2         p
    ##      0.3968    0.1574    0.5729 6693.3837    2.0000 71645.0000    0.0000
    ## 
    ## Model: 
    ##               coeff        se         t         p      LLCI      ULCI
    ## constant     2.7253    0.0106  257.6839    0.0000    2.7046    2.7461
    ## SACSECVAL   -1.1114    0.0171  -64.8837    0.0000   -1.1450   -1.0779
    ## LCGov        0.4562    0.0041  111.7818    0.0000    0.4482    0.4642
    ## 
    ## Standardized coefficients:
    ##               coeff
    ## SACSECVAL   -0.2355
    ## LCGov        0.4058
    ## 
    ## ************************ TOTAL EFFECT MODEL *************************** 
    ## Outcome Variable: Corrup
    ## 
    ## Model Summary: 
    ##           R      R-sq       MSE         F       df1        df2         p
    ##      0.1024    0.0105    0.6728  759.2014    1.0000 71646.0000    0.0000
    ## 
    ## Model: 
    ##               coeff        se         t         p      LLCI      ULCI
    ## constant     3.6594    0.0070  520.7868    0.0000    3.6456    3.6731
    ## SACSECVAL   -0.4832    0.0175  -27.5536    0.0000   -0.5175   -0.4488
    ## 
    ## Standardized coefficients:
    ##               coeff
    ## SACSECVAL   -0.1024
    ## 
    ## ************ TOTAL, DIRECT, AND INDIRECT EFFECTS OF X ON Y ************
    ## 
    ## Total effect of X on Y:
    ##      effect        se         t         p      LLCI      ULCI      c_cs
    ##     -0.4832    0.0175  -27.5536    0.0000   -0.5175   -0.4488   -0.1024
    ## 
    ## Direct effect of X on Y:
    ##      effect        se         t         p      LLCI      ULCI     c'_cs
    ##     -1.1114    0.0171  -64.8837    0.0000   -1.1450   -1.0779   -0.2355
    ## 
    ## Indirect effect(s) of X on Y:
    ##          Effect
    ## LCGov    0.6283
    ## 
    ## Normal theory test for indirect effect(s):
    ##          Effect        se         Z         p
    ## LCGov    0.6283    0.0088   71.4782    0.0000
    ## 
    ## Completely standardized indirect effect(s) of X on Y:
    ##          Effect
    ## LCGov    0.1331
    ## 
    ## ******************** ANALYSIS NOTES AND ERRORS ************************ 
    ## 
    ## Level of confidence for all confidence intervals in output: 95

The PROCESS macro still provides the bootstrapped confidence interval,
but we additionally get the results from the Sobel test under the
subheading *Normal theory test for indirect effect(s)*. So using the
*Sobel test* we find that
$ab = 0.628, SE = 0.009, p < .001, \beta = 0.133$.

Notice that the main difference is that now we are making the inference
based on the *p-value* instead of confidence interval.

#### Direct effect

We always get output for the direct effect as well, which is estimated
to be $c` = -1.111, 95\% CI = [-1.145, -1.078], \beta = -0.236$.

### Final recommendations

As we discussed, there are several ways to test for the indirect
effects. You should not consider the indirect effect to follow a normal
distribution. So, make an inference based on either Bootstrap or
Monte-Carlo empirical distributions. In most cases they will get to
equivalent inferences, a major difference is the computing time as
Monte-Carlo is much faster. In addition, Monte-Carlo has less
assumptions, because it uses functions of the parameters, while the
Bootstrap assumption is that your sample is large enough to be
representative of the population of interest.

## Interpretation

For the final interpretation, we will use the **Sobel test** for the
direct effects, and the **Monte-Carlo** for the indirect effect

We see that the *total* effect of Secular values (SV) on Perception of
corruption (PC) is
$c = -0.483, SE = 0.018, p < .001, 95\% CI = [-0.518, -0.449], \beta = -0.102$.
Indicating that as SV increases by 1 unit, PC decreases by 0.483 units.
When we include the mediator of Lack of confidence in the government
(LCG), we see that the *indirect* effect of SV on PC through LCG is
$ab = 0.628, SE = 0.009, 95\% CI = [0.611, 0.645], \beta = 0.133$.
Indicating that as SV increase by 1 unit, PC increases by 0.628 units
through its effect on LCG. The *direct* effect of SV on PC is
$cp = -1.111, SE = 0.017, p < .001, 95\% CI = [-1.145, -1.078], \beta = -0.236$,
and the *direct* effect of SV on LCG is
$a = 1.377, SE = 0.015, p < .001, 95\% CI = [1.348, 1.406], \beta = 0.328$,
and the *direct* effect of LCG on PC is
$b = 0.456, SE = 0.004, p < .001, 95\% CI = [0.448, 0.464], \beta = 0.406$.
With these pattern of results, we see that as SV increases LCG
increases, and as LCG increases PC increases. While the direct effect of
SV on PC presents a negative effect.

# PROCESS models

When working with the PROCESS macro, the argument `model` specifies the
type of model. Such as moderation, mediation, serial, parallel,
conditional processes. In this tutorial we showed the simple mediation
example. The other numbered models in PROCESS are available in Appendix
A of *Introduction to Mediation, Moderation, and Conditional Process
Analysis* (Hayes, 2022)

# References

Hayes, Andrew F. (2022). Introduction to mediation, moderation, and
conditional process analysis: A regression-based approach (Third
edition, Vol. 1–1 online resource (xx, 732 pages) : illustrations.). The
Guilford Press.
