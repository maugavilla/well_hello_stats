Moderation with lm()
================
Mauricio Garnier-Villarreal, Joris M. Schröder & Joseph Charles Van
Matre
01 April, 2026

- [1 What is moderation analysis?](#1-what-is-moderation-analysis)
- [2 Setup the R session](#2-setup-the-r-session)
- [3 Import the data set](#3-import-the-data-set)
  - [3.1 Prepare the data set](#31-prepare-the-data-set)
    - [3.1.1 Create composite scores](#311-create-composite-scores)
    - [3.1.2 Transform categorical variables to
      `factor()`](#312-transform-categorical-variables-to-factor)
    - [3.1.3 Set variables for
      analysis](#313-set-variables-for-analysis)
- [4 Moderation analysis steps](#4-moderation-analysis-steps)
- [5 Categorical moderator](#5-categorical-moderator)
  - [5.1 Main effects](#51-main-effects)
    - [5.1.1 Interpretation](#511-interpretation)
  - [5.2 Interaction model](#52-interaction-model)
    - [5.2.1 Compare models](#521-compare-models)
    - [5.2.2 Effect size](#522-effect-size)
    - [5.2.3 Probing](#523-probing)
    - [5.2.4 Plotting](#524-plotting)
    - [5.2.5 Interpretation](#525-interpretation)
- [6 Continuous moderator](#6-continuous-moderator)
  - [6.1 Main effects](#61-main-effects)
    - [6.1.1 Interpretation](#611-interpretation)
  - [6.2 Interaction model](#62-interaction-model)
    - [6.2.1 Compare models](#621-compare-models)
    - [6.2.2 Effect size](#622-effect-size)
    - [6.2.3 Probing](#623-probing)
    - [6.2.4 Plotting](#624-plotting)
    - [6.2.5 Interpretation](#625-interpretation)
- [7 References](#7-references)

# 1 What is moderation analysis?

With moderation analysis, we are trying to find out whether the effect
or association between two variables depends on another variable. Let’s
say that we are interested in the association between *Lack of
confidence in the government* and *Perception of corruption*, but we
specifically want to know whether the association depends on the *Sex*
or the *Secular Values* of individuals. The latter two variables are
called *moderators* of the association between *Lack of confidence in
the government* and *Perception of corruption*.

# 2 Setup the R session

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
library(effectsize)
library(marginaleffects)
library(ggplot2)
library(parameters)
library(car)
```

# 3 Import the data set

Here we will be importing the `.sav` WVS data set

``` r
dat <- import("WVS_Cross-National_Wave_7_sav_v2_0.sav")
dim(dat)
```

    ## [1] 76897   548

Here we are calling our data set **dat** and asking to see the dimension
of it. We see that the data set has 76897 subjects, and 548 columns.

## 3.1 Prepare the data set

In cases with large data sets like this we might want to select a subset
of variables that we want to work with. Since it is not easy to see 548
variables.

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

Here we are first creating a vector with the variable names for the ones
I want to keep. You can see all variable names for the full data set as
well:

``` r
colnames(dat)
```

After identifying which variables we will work with, we create a new
data set **dat2** with only these 17 variables, and make sure we did it
correctly by looking at the the dimension of the data **dim(dat2)**. We
also look at the first 6 rows: **head(dat2)**. These are quick checks
that we have created the new data correctly.

The variables we will use here are:

- Q260: sex, 1 = Male, 2 = Female
- Q262: age in years
- Y001: post-materialism index
- SACSECVAL: secular values
- Q112-Q120: Corruption Perception Index
- Q65-Q73: Lack of Confidence in the government

### 3.1.1 Create composite scores

We will be using the composite scores for *Corruption Perception Index*
and *Lack of Confidence in the government* instead of their single
items. So, we first need to compute them, we will use the mean across
all items for each composite

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

With the `rowmeans()` we compute the mean across the specified
variables, for each subject. Remember to include the `na.rm=T` argument,
so the missing values are properly ignored.

### 3.1.2 Transform categorical variables to `factor()`

when we want to use categorical variables as predictors, it is
recommended to transformed them as `factor` type in `R`. In this case we
will use the *Sex* variable `Q260`, which is coded as 1 and 2 right now.

With the `factor()` function we an transform it, and change the numbers
to meaningful labels.

``` r
dat2$Sex <- factor(dat2$Q260, 
                       levels = 1:2,
                       labels = c("Male","Female") )
```

### 3.1.3 Set variables for analysis

Now, we will select only the variables of interest in a separate data
set.

``` r
dat2 <- na.omit(dat2[,c("Sex", "Q262", "Y001", "SACSECVAL", "Corrup", "LCGov")])
head(dat2)
```

    ##      Sex Q262 Y001 SACSECVAL   Corrup LCGov
    ## 1 Female   60    0  0.287062 2.750000  1.00
    ## 2   Male   47    2  0.467525 3.444444  3.75
    ## 3   Male   48    4  0.425304 3.000000  2.75
    ## 4 Female   62    2  0.556170 3.444444  3.00
    ## 5   Male   49    1  0.458949 2.777778  2.25
    ## 6 Female   51    3  0.210111 2.555556  1.75

``` r
dim(dat2)
```

    ## [1] 71633     6

The new `dat2` data set only include the 6 continuous variables of
interest, and 1 binary variable. With the `na.omit()` function we are
excluding all cases with some missing values.

# 4 Moderation analysis steps

Moderation is split into multiple steps, (a)

- Estimate the *main effects* model that includes only the predictors as
  a *normal* multiple regression.
- Estimate the *interaction* model that now also includes the
  interactions between predictors.
- Compare the models: the *p-value* test the Null hypothesis of the two
  predictors being independent, and the change in $R^2$ represents the
  effect size magnitude of the interaction
- Probe: estimate the simple slopes, the slope for the focal predictor
  at fixed values of the moderator predictor.
- Plot the simple slopes

The first three steps test the Null Hypothesis of the interaction (with
the respective effect size), while the last two steps seek to explain
*how does the moderator affects the focal relation?*, and help interpret
these conditional relations.

We will see how to implement these steps for two common interaction
scenarios, with categorical and continuous moderators

# 5 Categorical moderator

For the categorical predictor model, we will have *Lack of confidence in
the government* as the focal predictor, and *Sex* as the categorical
moderator. Having them predict the *Perception of corruption*

## 5.1 Main effects

The main effects model presents both the effects of each predictor on
the outcome. When the moderator is categorical, we strongly recommend to
set the moderator as `factor()`, as `R` will automatically know it is
categorical and make the correct plots and conditional values.

``` r
main_cat <- lm(Corrup ~ LCGov + Sex, data=dat2)
summary(main_cat)
```

    ## 
    ## Call:
    ## lm(formula = Corrup ~ LCGov + Sex, data = dat2)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -3.8269 -0.4807 -0.0487  0.4309  7.0961 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  2.558014   0.010946 233.704  < 2e-16 ***
    ## LCGov        0.369207   0.003967  93.072  < 2e-16 ***
    ## SexFemale   -0.023369   0.005824  -4.013 6.01e-05 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.7787 on 71630 degrees of freedom
    ## Multiple R-squared:  0.1081, Adjusted R-squared:  0.1081 
    ## F-statistic:  4341 on 2 and 71630 DF,  p-value: < 2.2e-16

``` r
parameters(main_cat)
```

    ## Parameter    | Coefficient |       SE |         95% CI | t(71630) |      p
    ## --------------------------------------------------------------------------
    ## (Intercept)  |        2.56 |     0.01 | [ 2.54,  2.58] |   233.70 | < .001
    ## LCGov        |        0.37 | 3.97e-03 | [ 0.36,  0.38] |    93.07 | < .001
    ## Sex [Female] |       -0.02 | 5.82e-03 | [-0.03, -0.01] |    -4.01 | < .001

    ## 
    ## Uncertainty intervals (equal-tailed) and p-values (two-tailed) computed
    ##   using a Wald t-distribution approximation.

### 5.1.1 Interpretation

- We reject the null hypothesis of both predictors being equally good
  predictors as the mean model, $F(2, 71630) = 4341, p < .001$.
- Both predictors explained 11% of the variance in the outcome
  ($R^2 = 0.108$).
- The average outcome score for *Male* with 0 *Lack of confidence in the
  government* is 2.55 ($b_0 = 2.55, SE = 0.01, p < .001$)
- As *Lack of confidence in the government* increase by 1 unit,
  *Perception of corruption* increases by 0.36
  ($b_1 = 0.36, SE = 0.004, p < .001$), holding *Sex* constant.
- As *Sex* changes, *Perception of corruption* decreases by 0.023 for
  *Female* ($b_2 = -0.023, SE = 0.006, p < .001$), holding *Lack of
  confidence in the government* constant.

## 5.2 Interaction model

The interaction model is an extension from the main effects, we can add
the interaction between predictors as a new term in the formula as
`predictor1*predictor2`

``` r
int_cat <- lm(Corrup ~ LCGov + Sex + LCGov*Sex, data=dat2)
summary(int_cat)
```

    ## 
    ## Call:
    ## lm(formula = Corrup ~ LCGov + Sex + LCGov * Sex, data = dat2)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -3.8231 -0.4817 -0.0442  0.4295  7.0901 
    ## 
    ## Coefficients:
    ##                  Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)      2.547596   0.015044 169.346   <2e-16 ***
    ## LCGov            0.373295   0.005669  65.847   <2e-16 ***
    ## SexFemale       -0.002988   0.021014  -0.142    0.887    
    ## LCGov:SexFemale -0.008010   0.007936  -1.009    0.313    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.7787 on 71629 degrees of freedom
    ## Multiple R-squared:  0.1081, Adjusted R-squared:  0.1081 
    ## F-statistic:  2895 on 3 and 71629 DF,  p-value: < 2.2e-16

``` r
parameters(int_cat)
```

    ## Parameter            | Coefficient |       SE |        95% CI | t(71629) |      p
    ## ---------------------------------------------------------------------------------
    ## (Intercept)          |        2.55 |     0.02 | [ 2.52, 2.58] |   169.35 | < .001
    ## LCGov                |        0.37 | 5.67e-03 | [ 0.36, 0.38] |    65.85 | < .001
    ## Sex [Female]         |   -2.99e-03 |     0.02 | [-0.04, 0.04] |    -0.14 | 0.887 
    ## LCGov × Sex [Female] |   -8.01e-03 | 7.94e-03 | [-0.02, 0.01] |    -1.01 | 0.313

    ## 
    ## Uncertainty intervals (equal-tailed) and p-values (two-tailed) computed
    ##   using a Wald t-distribution approximation.

We see the interaction term `LCGov:SexFemale` (`LCGov × Sex [Female]`).
The *p-value* for this terms tests of the Null Hypothesis of the 2
predictors being independent.

### 5.2.1 Compare models

When comparing models, the first step is to test the equivalence. For
this we can do it as well with the `anova()` method. Notice, that when
the interaction only adds one more parameter, this null hypothesis test
will be equal to the test in the regression table.

``` r
anova(main_cat,int_cat)
```

    ## Analysis of Variance Table
    ## 
    ## Model 1: Corrup ~ LCGov + Sex
    ## Model 2: Corrup ~ LCGov + Sex + LCGov * Sex
    ##   Res.Df   RSS Df Sum of Sq     F Pr(>F)
    ## 1  71630 43440                          
    ## 2  71629 43439  1   0.61795 1.019 0.3128

In this case, we would fail to reject the null hypothesis of the 2
predictors being independent.

### 5.2.2 Effect size

The next way to compare the models relates to the effect size of the
interaction, we can look at this as the change in $R^2$ when the
interaction is added

``` r
summary(int_cat)$r.squared - summary(main_cat)$r.squared
```

    ## [1] 1.268749e-05

We see that in this case the change in the explained variance is down to
the fifth decimal, so a negligible effect size. We can see this effect
size also as the $\eta^2$ of the interaction term, as this is the
proportion of explained variance uniquely by the interaction. We can get
this with `eta_squared()` function, make sure to set the argument
`partial = F` as this will ask for the full $\eta^2$ instead of the
partial. And we use the `Anova()` function to use the type 2 sum of of
squares

``` r
eta_squared(Anova(int_cat,type=2), partial = F)
```

    ## # Effect Size for ANOVA (Type II)
    ## 
    ## Parameter |     Eta2 |       95% CI
    ## -----------------------------------
    ## LCGov     |     0.11 | [0.10, 1.00]
    ## Sex       | 2.00e-04 | [0.00, 1.00]
    ## LCGov:Sex | 1.27e-05 | [0.00, 1.00]
    ## 
    ## - One-sided CIs: upper bound fixed at [1.00].

### 5.2.3 Probing

Probing the interaction means to estimate the dependent focal
regressions at specific levels of the moderator. To see and test the
respective regressions. Before here we can talk about the 2 predictors
being independent without stating which is the moderator and which is
the focal predictor. When we probing and plotting the interactions, we
need to choose a moderator and focal predictor. Notice that the model
does not know which predictor is which, you have to decide this.

When including a categorical variable, most likely this one will be the
moderator, so in our case *Sex* will be treated as the moderator.

We can test this with the `avg_slopes` function from the
`marginaleffects` package. Here we first need to specify the `lm()`
model that includes the interaction, then we can ask for the confidence
interval, and lastly we need to define our focal and moderator
predictors. In the `variable` argument we specify the focal predictor,
and in the `by` argument we specify the moderator. With categorical
moderators will ask for the regression of interest for each category of
the moderator by default.

``` r
avg_slopes(int_cat, conf_level = 0.95, 
           variables=c("LCGov"),by="Sex")
```

    ## 
    ##     Sex Estimate Std. Error    z Pr(>|z|)   S 2.5 % 97.5 %
    ##  Male      0.373    0.00567 65.8   <0.001 Inf 0.362  0.384
    ##  Female    0.365    0.00555 65.8   <0.001 Inf 0.354  0.376
    ## 
    ## Term: LCGov
    ## Type: response
    ## Comparison: dY/dX

Here we see that for the *Male* participants, the slope between *lack of
confidence in the government* and *Perception of corruption* is 0.373
($b_{1M} = 0.373, SE = 0.006, p < .001$), and for the *Female*
participants it is 0.365 ($b_{1F} = 0.365, SE = 0.006, p < .001$)

If we back to the `parameters()` output, you will see that the slope for
the interaction term `LCGov:SexFemale` is -0.008, which is the slope
difference between mean and women (0.3733 - 0.3653), this is an ease of
interpretation when the moderator is categorical.

``` r
parameters(int_cat)
```

### 5.2.4 Plotting

A last part is to plot the interactions, here we will show how to plot
the interactions with the `marginaleffects` package

In the `marginaleffects` package, we have to first specify on `lm()`
model that includes the interaction, we are plotting the *conditional*
relation, and the same scale as the outcome variable in the *y-axis*.
Then we need to specify our focal and moderator predictor in the `by`
argument, the function will see the first variable as the focal one and
the second one as the moderator.

``` r
plot_predictions(int_cat,
                 by = c("LCGov", "Sex") )
```

![](10_1_moderation_lm_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

Notice that when the moderator is a `factor()` type variable,
`plot_predictions` will automatically plot the focal regression for all
categories, and set the respective labels.

### 5.2.5 Interpretation

- We fail fail to reject the null hypothesis of the interaction and main
  effects model being equally good at predicting the outcome. Or, fail
  to reject the null hypothesis of the 2 predictors being independent
  ($F(1, 71629)=1.019, p = .313$).
- Female participants have in average a focal slope (`Corrup ~ LCGov`)
  0.008 points lower than the male participants
  ($b_{*} = -0.008, SE = 0.008, p = 0.313$).
- For *Male* participants, the slope between *lack of confidence in the
  government* and *Perception of corruption* is 0.373
  ($b_{1M} = 0.373, SE = 0.006, p < .001$).
- For *Female* participants, the slope between *lack of confidence in
  the government* and *Perception of corruption* is 0.365
  ($b_{1F} = 0.365, SE = 0.006, p < .001$).
- The addition of the interaction increases the model’s predictive
  accuracy by 0.0013% ($\eta^2 = 0.000013$).
- In the plots, we see that both groups slopes are close to each other.

# 6 Continuous moderator

For the continuous predictor model, we will have *Lack of confidence in
the government* as the focal predictor, and *Secular Values* as the
continuous moderator. Having them predict the *Perception of corruption*

## 6.1 Main effects

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

``` r
parameters(main_cont)
```

    ## Parameter   | Coefficient |       SE |         95% CI | t(71630) |      p
    ## -------------------------------------------------------------------------
    ## (Intercept) |        2.73 |     0.01 | [ 2.70,  2.75] |   257.65 | < .001
    ## LCGov       |        0.46 | 4.08e-03 | [ 0.45,  0.46] |   111.76 | < .001
    ## SACSECVAL   |       -1.11 |     0.02 | [-1.15, -1.08] |   -64.87 | < .001

    ## 
    ## Uncertainty intervals (equal-tailed) and p-values (two-tailed) computed
    ##   using a Wald t-distribution approximation.

### 6.1.1 Interpretation

- We reject the null hypothesis of both predictors being equally good
  predictors as the mean model, $F(2, 71630) = 6691, p < .001$.
- Both predictors explained 16% of the variance in the outcome
  ($R^2 = 0.157$).
- The average outcome score for *Perception of corruption*, when both
  predictors are equal to 0 is 2.73 ($b_0 = 2.73, SE = 0.01, p < .001$)
- As *Lack of confidence in the government* increase by 1 unit,
  *Perception of corruption* increases by 0.46 points
  ($b_1 = 0.46, SE = 0.004, p < .001$), holding *Secular Values*
  constant.
- As *Secular Value* increases by 1 unit, *Perception of corruption*
  decreases by -1.11 points ($b_2 = -1.11, SE = 0.017, p < .001$),
  holding *Lack of confidence in the government* constant.

## 6.2 Interaction model

The interaction model is an extension from the main effects, we can add
the interaction between predictors as a new term in the formula as
`predictor1*predictor2`

``` r
int_cont <- lm(Corrup ~ LCGov + SACSECVAL + LCGov*SACSECVAL, data=dat2)
summary(int_cont)
```

    ## 
    ## Call:
    ## lm(formula = Corrup ~ LCGov + SACSECVAL + LCGov * SACSECVAL, 
    ##     data = dat2)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -3.8362 -0.4573 -0.0270  0.4190  7.0134 
    ## 
    ## Coefficients:
    ##                 Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)      2.51613    0.02121 118.631  < 2e-16 ***
    ## LCGov            0.54013    0.00843  64.071  < 2e-16 ***
    ## SACSECVAL       -0.47776    0.05824  -8.203 2.38e-16 ***
    ## LCGov:SACSECVAL -0.24271    0.02132 -11.383  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.7562 on 71629 degrees of freedom
    ## Multiple R-squared:  0.1589, Adjusted R-squared:  0.1589 
    ## F-statistic:  4512 on 3 and 71629 DF,  p-value: < 2.2e-16

``` r
parameters(int_cont)
```

    ## Parameter         | Coefficient |       SE |         95% CI | t(71629) |      p
    ## -------------------------------------------------------------------------------
    ## (Intercept)       |        2.52 |     0.02 | [ 2.47,  2.56] |   118.63 | < .001
    ## LCGov             |        0.54 | 8.43e-03 | [ 0.52,  0.56] |    64.07 | < .001
    ## SACSECVAL         |       -0.48 |     0.06 | [-0.59, -0.36] |    -8.20 | < .001
    ## LCGov × SACSECVAL |       -0.24 |     0.02 | [-0.28, -0.20] |   -11.38 | < .001

    ## 
    ## Uncertainty intervals (equal-tailed) and p-values (two-tailed) computed
    ##   using a Wald t-distribution approximation.

We see the interaction term `LCGov:SACSECVAL` (`LCGov × SACSECVAL`). The
*p-value* for this terms tests of the Null Hypothesis of the 2
predictors being independent.

### 6.2.1 Compare models

When comparing models, the first step is to test the equivalence. For
this we can do it as well with the `anova()` method. Notice, that when
the interaction only adds one more parameter, this null hypothesis test
will be equal to the test in the regression table.

``` r
anova(main_cont,int_cont)
```

    ## Analysis of Variance Table
    ## 
    ## Model 1: Corrup ~ LCGov + SACSECVAL
    ## Model 2: Corrup ~ LCGov + SACSECVAL + LCGov * SACSECVAL
    ##   Res.Df   RSS Df Sum of Sq      F    Pr(>F)    
    ## 1  71630 41039                                  
    ## 2  71629 40965  1    74.107 129.58 < 2.2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

In this case, we would reject the null hypothesis of the 2 predictors
being independent.

### 6.2.2 Effect size

The next way to compare the models relates to the effect size of the
interaction, we can look at this as the change in $R^2$ when the
interaction is added

``` r
summary(int_cont)$r.squared - summary(main_cont)$r.squared
```

    ## [1] 0.001521532

We see that in this case the change in the explained variance is
$\Delta R^2 = 0.0015$. We can see this effect size also as the $\eta^2$
of the interaction term, as this is the proportion of explained variance
uniquely by the interaction. We can get this with `eta_squared()`
function, make sure to set the argument `partial = F` as this will ask
for the full $\eta^2$ instead of the partial.

``` r
eta_squared(Anova(int_cont, type=2), partial = F)
```

    ## # Effect Size for ANOVA (Type II)
    ## 
    ## Parameter       |     Eta2 |       95% CI
    ## -----------------------------------------
    ## LCGov           |     0.14 | [0.14, 1.00]
    ## SACSECVAL       |     0.05 | [0.05, 1.00]
    ## LCGov:SACSECVAL | 1.46e-03 | [0.00, 1.00]
    ## 
    ## - One-sided CIs: upper bound fixed at [1.00].

### 6.2.3 Probing

Probing the interaction means to estimate the dependent focal
regressions at specific levels of the moderator. To see and test the
respective regressions. Before here we can talk about the 2 predictors
being independent without stating which is the moderator and which is
the focal predictor. When we probing and plotting the interactions, we
need to choose a moderator and focal predictor. Notice that the model
does not know which predictor is which, you have to decide this.

Here we are choosing to treat *Secular Values* as the moderator variable

We can test this with the `avg_slopes` function from the
`marginaleffects` package. Here we first need to specify the `lm()`
model that includes the interaction, then we can ask for the confidence
interval, and lastly we need to define our moderator predictor in the
`by` argument.

With a continuous moderator we need to choose values of interest of the
moderator to estimate the simple slopes. Ideally, there are meaningful
values for you to choose. Otherwise, the most common is to use the mean,
mean minus 1 SD, and mean + 1 SD. This represents average, low, and
high.

Here is an example on how to save the needed values for simple slopes

``` r
vals <- c(mean(dat2$SACSECVAL, na.rm=T)-sd(dat2$SACSECVAL, na.rm=T),
          mean(dat2$SACSECVAL, na.rm=T),
          mean(dat2$SACSECVAL, na.rm=T)+sd(dat2$SACSECVAL, na.rm=T))
vals <- round(vals, 3)
vals
```

    ## [1] 0.186 0.361 0.535

Then we can provide the saved values as the levels for the moderator in
the `newdata = datagrid(SACSECVAL = vals)` argument

``` r
avg_slopes(int_cont, conf_level = 0.95, 
           newdata = datagrid(SACSECVAL = vals),
           variables=c("LCGov"),by="SACSECVAL" )
```

    ## 
    ##  SACSECVAL Estimate Std. Error     z Pr(>|z|)   S 2.5 % 97.5 %
    ##      0.186    0.495    0.00532  93.1   <0.001 Inf 0.485  0.505
    ##      0.361    0.453    0.00409 110.6   <0.001 Inf 0.444  0.461
    ##      0.535    0.410    0.00573  71.6   <0.001 Inf 0.399  0.422
    ## 
    ## Term: LCGov
    ## Type: response
    ## Comparison: dY/dX

Here we see that for the low *Secular Values*, the slope between *lack
of confidence in the government* and *Perception of corruption* is 0.495
($b_{LSV} = 0.495, SE = 0.005, p < .001$), for average *Secular Values*
it is 0.453 ($b_{MSV} = 0.453, SE = 0.004, p < .001$), and for high
*Secular Values* it is 0.410 ($b_{HSV} = 0.410, SE = 0.006, p < .001$).

This way we see a a general trend, as *Secular Values* increases, the
focal regression decreases strength.

If we back to the `parameters()` output, you will see that the slope for
the interaction term `LCGov:SACSECVAL` is -0.243, which is the change in
the slope when the moderator increases by 1 unit. This is a harder
parameter to interpret, unless you have very clear metric of the
moderator, otherwise it is easier to interpret that change with simple
slopes

``` r
parameters(int_cont)
```

Another option with a continuous moderator is to estimate simple slopes
for a long array of moderator values. A recommendation would be to test
across a large number of possible values, get the minimum and maximum of
values for the moderator

``` r
c(min(dat2$SACSECVAL, na.rm=T), max(dat2$SACSECVAL, na.rm=T))
```

    ## [1] 0.000000 0.971667

Then create a sequence of values going from the minimum, to the maximum,
increasing by a small value (choose something that make sense for the
metric of the moderator). In this case an increase every 0.1 points
makes sense.

``` r
vals2 <- seq(from=min(dat2$SACSECVAL, na.rm=T), to=max(dat2$SACSECVAL, na.rm=T), by=.1)
vals2
```

    ##  [1] 0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9

Now we can add the new set of testing values to the `avg_slopes`
function. This way we can see the change in the slope of interest at
smaller steps of change of the moderator.

``` r
avg_slopes(int_cont, conf_level = 0.95, 
           newdata = datagrid(SACSECVAL = vals2),
           variables=c("LCGov"),by="SACSECVAL" )
```

    ## 
    ##  SACSECVAL Estimate Std. Error     z Pr(>|z|)     S 2.5 % 97.5 %
    ##        0.0    0.540    0.00843  64.1   <0.001   Inf 0.524  0.557
    ##        0.1    0.516    0.00665  77.6   <0.001   Inf 0.503  0.529
    ##        0.2    0.492    0.00512  95.9   <0.001   Inf 0.482  0.502
    ##        0.3    0.467    0.00419 111.4   <0.001   Inf 0.459  0.476
    ##        0.4    0.443    0.00423 104.7   <0.001   Inf 0.435  0.451
    ##        0.5    0.419    0.00524  80.0   <0.001   Inf 0.409  0.429
    ##        0.6    0.395    0.00678  58.2   <0.001   Inf 0.381  0.408
    ##        0.7    0.370    0.00858  43.2   <0.001   Inf 0.353  0.387
    ##        0.8    0.346    0.01050  33.0   <0.001 788.8 0.325  0.367
    ##        0.9    0.322    0.01250  25.7   <0.001 482.8 0.297  0.346
    ## 
    ## Term: LCGov
    ## Type: response
    ## Comparison: dY/dX

Here we see that the slope of interest changes from 0.54 to 0.32 from
the lowest and highest values. And for every one of them we reject the
null hypothesis of each simple slope being equal to 0

### 6.2.4 Plotting

The only new argument we need to add is `newdata`, where we define which
values of the moderator do we wish to plot, and all observed values for
the focal predictor. We already have same these from probing simple
slopes

``` r
plot_predictions(int_cont, 
                 newdata = datagrid(LCGov=unique(dat2$LCGov),
                                    SACSECVAL = vals),
                 by = c("LCGov", "SACSECVAL"))
```

![](10_1_moderation_lm_files/figure-gfm/unnamed-chunk-28-1.png)<!-- -->

We can also plot the simple slopes for a larger number of of test
values, like the larger sequence set we created. For that we simply use
the larger values we created before. This plot allow us to see the
changes in greater detail.

``` r
plot_predictions(int_cont, 
                 newdata = datagrid(LCGov=unique(dat2$LCGov),
                                    SACSECVAL = vals2),
                 by = c("LCGov", "SACSECVAL"))
```

![](10_1_moderation_lm_files/figure-gfm/unnamed-chunk-29-1.png)<!-- -->

### 6.2.5 Interpretation

- We reject the null hypothesis of the interaction and main effects
  model being equally good at predicting the outcome. Or, reject the
  null hypothesis of the 2 predictors being independent
  ($F(1, 71629)= 74.107, p < .001$).
- As the moderator *Secular Values* increase by 1 unit, the focal
  regression (`Corrup ~ LCGov`) decreases by 0.243 points
  ($b_{*} = -0.243, SE = 0.021, p < .001$)
- For low *Secular Values*, the slope between *lack of confidence in the
  government* and *Perception of corruption* is 0.495
  ($b_{LSV} = 0.495, SE = 0.005, p < .001$)
- For average *Secular Values* it is 0.453
  ($b_{MSV} = 0.453, SE = 0.004, p < .001$)
- For high *Secular Values* it is 0.410
  ($b_{HSV} = 0.410, SE = 0.006, p < .001$).
- In the general trend we see that the focal slope goes from 0.54 at the
  minimum observed *Secular Values* to 0.32 at the maximum observed
  *Secular values* score.
- The addition of the interaction increases the model’s predictive
  accuracy by 0.15% ($\eta^2 = 0.0015$).
- In the plots, we see the decrease of the slopes across a range of
  possible moderator values.

# 7 References

Hayes, Andrew F. (2022). Introduction to mediation, moderation, and
conditional process analysis: A regression-based approach (Third
edition, Vol. 1–1 online resource (xx, 732 pages) : illustrations.). The
Guilford Press.
