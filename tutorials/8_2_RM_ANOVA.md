# Repeated Measures ANOVA
Mauricio Garnier-Villarreal & Denise J. Roth, FSW VU Amsterdam
2026-03-31

- [<span class="toc-section-number">1</span>
  Introduction](#introduction)
- [<span class="toc-section-number">2</span> Set up the R
  Session](#set-up-the-r-session)
- [<span class="toc-section-number">3</span> Import the
  Dataset](#import-the-dataset)
  - [<span class="toc-section-number">3.1</span> Prepare the
    Dataset](#prepare-the-dataset)
  - [<span class="toc-section-number">3.2</span> Convert the Dataframe
    from Wide to Long
    Format](#convert-the-dataframe-from-wide-to-long-format)
- [<span class="toc-section-number">4</span> Perform Repeated Measure
  Analysis](#perform-repeated-measure-analysis)
  - [<span class="toc-section-number">4.1</span> Effect
    size](#effect-size)
  - [<span class="toc-section-number">4.2</span> Post-hoc pairwise
    comparisons](#post-hoc-pairwise-comparisons)
  - [<span class="toc-section-number">4.3</span> Plot group
    means](#plot-group-means)
  - [<span class="toc-section-number">4.4</span> Post-hoc planned
    comparisons](#post-hoc-planned-comparisons)
- [<span class="toc-section-number">5</span> Mixed design
  RM-ANOVA](#mixed-design-rm-anova)
  - [<span class="toc-section-number">5.1</span> Effect
    size](#effect-size-1)
  - [<span class="toc-section-number">5.2</span> Post-hoc
    comparisons](#post-hoc-comparisons)
  - [<span class="toc-section-number">5.3</span> Plot
    post-hoc](#plot-post-hoc)
  - [<span class="toc-section-number">5.4</span> Post-hoc planned
    comparisons](#post-hoc-planned-comparisons-1)
  - [<span class="toc-section-number">5.5</span>
    Interpretation](#interpretation)

# Introduction

As social scientists delving into the world of statistics, it’s
essential to grasp various statistical techniques commonly used in
research. One such technique is the Repeated Measures Analysis of
Variance (ANOVA). In this tutorial, we’ll explore what a repeated
measures ANOVA is, when to use it, and how it can be applied to analyze
data in research studies. So let’s dive in!

Repeated Measures ANOVA (RM-ANOVA) is a statistical method used to
analyze data when the same subjects or participants are measured on
multiple occasions or under different conditions. It allows researchers
to examine whether there are significant differences across these
repeated measurements or conditions while accounting for the
interdependence of the data. It is particularly useful when you have
data that involve multiple measurements taken from the same subjects or
participants. It is commonly used in various fields such as psychology,
biology, medicine, education, and social sciences. You would typically
choose a RM-ANOVA over other analysis methods when you either have a:

1.  within-subject design: This means that each participant in your
    study is measured or tested under different conditions or at
    multiple time points. For example, measuring the performance of
    students before and after an intervention or assessing the effects
    of different treatment conditions on patients’ blood pressure. Or:

2.  You want to compare the means of three or more conditions: RM-ANOVA
    is specifically designed to analyze data with three or more levels
    or conditions. If you have only two conditions, a paired t-test
    might be more appropriate.

# Set up the R Session

When we start working in R, we always need to setup our session. For
this we need to set our working directory. In this case I am doing that
for the folder that holds the downloaded dataset for this example.

``` r
setwd("YOURWORKINGDIRECTORY")
```

The next step for setting up our session will be to load the packages
that we will be using. We will use a packages like `dplyr` for data
management, as well as the `rio` package for importing our data.
Additionally, we need the `reshape2` to reshape our data. Finally, the
packages `afex`, and `marginaleffects` are used for conducting our
analyses. Note that you potentially need to install some of these
packages, however.

``` r
library(rio)
library(dplyr)
library(reshape2)
library(marginaleffects)
library(afex)
library(sjlabelled)
library(effectsize)
```

# Import the Dataset

We are importing a `.sav` file from Qualtrics. This data shows an
example from a pre-test which was setup to determine which of five
different brands (Adidas, Puma, Nike, H&M, Tommy Hilfiger) had the best
fit with two celebrity influencer couples (Beyoncé and Jay Z and Shakira
and Piqué) for the promotion of a brand on Instagram. Participants rated
the congruence of five sports brands with one of the celebrity couples
(randomized), measured using a 7-Point Likert scale ranging from one
(strongly disagree) to seven (strongly agree). Participants were also
asked their agreement level to statements such as “Adidas is a good
match with the celebrities” or “Puma is a good match with the
celebrities” etc.. The congruence was the within factor with five levels
(Adidas, Puma, Nike, H&M, Tommy Hilfiger) and the between factor was the
type of celebrity couple (Beyonce & Jay-Z versus Shakira & Piqué). In
total, 32 participants filled in the survey.

``` r
d <- import("Native advertisement - pretest wide.sav")
```

## Prepare the Dataset

For easiness, we want to change the variable name to the respective
brand name, we can see the band associated to each variable from the
attributes of the data with the `get_label()` function from the package
`sjlabelled`

``` r
get_label(d)
```

                                                                                                                                                          Cleb_Congruence_1 
            "How will the following brands match these celebrities when they promote this brand on their Instagram account? - Adidas is a good match with the celebrities." 
                                                                                                                                                          Cleb_Congruence_2 
              "How will the following brands match these celebrities when they promote this brand on their Instagram account? - Puma is a good match with the celebrities." 
                                                                                                                                                          Cleb_Congruence_3 
              "How will the following brands match these celebrities when they promote this brand on their Instagram account? - Nike is a good match with the celebrities." 
                                                                                                                                                          Cleb_Congruence_4 
               "How will the following brands match these celebrities when they promote this brand on their Instagram account? - H&M is a good match with the celebrities." 
                                                                                                                                                          Cleb_Congruence_5 
    "How will the following brands match these celebrities when they promote this brand on their Instagram account? - Tommy Hilfiger is a good match with the celebrities." 
                                                                                                                                                           Condition_Couple 
                                                                                                                                                                         "" 

From this we have the necessary information to rename them, so that the
variable name match the brand

``` r
colnames(d) <- c("Adidas","Puma","Nike","HM","Tommy_Hilfiger","Condition_Couple")
```

Then we will recode the labels of the couple variable, so that it
explicitly mentions the couple instead of using codes 0 - 1. We will do
that with `recode()` function as follows

``` r
d$Condition_Couple <- car::recode(d$Condition_Couple, 
                                  "0 = 'Beyonce & Jay-Z';
                                  1 = 'Shakira & Pique' ")
```

In these next steps, we first create a variable that contains a
participant ID and we also change the classes for some of the variables
included, as our model will ultimately need to know how to treat which
variables in its calculations.

With the `mutate()` function, we give it the data set, and then can
create a new variable `id` that represents the subject id, in function
of the data row numbers.

Then, with the same function, we can give a multiple variables within
the `across` function, and then change the data type to numeric and
factor respectively. This way, we have a clear defined user ids, and `R`
know which variables to treat as numeric and factor for future uses

``` r
d_id <- mutate(d, id = row_number())

d_id <- mutate(d_id, across(c(Adidas, Puma, 
                 Nike, HM, 
                 Tommy_Hilfiger), as.numeric))
d_id <- mutate(d_id, across(c(Condition_Couple,id), as.factor))
```

## Convert the Dataframe from Wide to Long Format

In R, data frames can be organized in two different formats: wide and
long. Each format has its advantages and is suitable for different types
of analyses. Let’s explore the differences between these formats. In the
**wide** format, each subject’s measurements or observations are
represented in a single row, and each variable or condition has its own
column. This format is often used when data is initially collected or
entered. Advantages of the wide format include simplicity and ease of
data entry. It is also suitable for certain analyses like generalized
linear models that assumed independence of observations, as each row is
independent of each other. However, for repeated measures analyses, the
long format is preferred and necessary, as the assumption of
independence of observations is violated, so we need to model it.

In the **long** format, each observation is represented in a separate
row, and a single column is used to indicate the condition or variable,
so that each subject will have as many rows as time points. This format
is particularly useful when dealing with repeated measures or
within-subjects designs. Each subject’s measurements are stacked on top
of each other, allowing for easy identification of repeated measures and
within-subjects factors. This format facilitates the analysis of
dependencies and enables appropriate statistical techniques such as
RM-ANOVA. RM-ANOVA requires a long format because it relies on the
dependence of measurements taken from the same subjects. By organizing
the data in a long format, we explicitly represent the repeated
measurements and their associated conditions. This allows the
statistical analysis to properly account for the within-subjects
variability.

In a long format, each row represents a unique measurement, and the
subject identifier ensures that the measurements are linked to the
corresponding individuals. This format provides the necessary structure
for conducting analyses that involve repeated measures, as it allows for
the identification of within-subjects factors, the calculation of
subject-specific means, and the assessment of the differences between
conditions.

By using the long format in RM-ANOVA, we can effectively examine the
effects of the within-subjects factors while accounting for the
dependency between measurements. The analysis can then yield valuable
insights into the significance of the conditions and their impact on the
measured outcome.

Let us first view what the our initially **wide** data frame looks like,
reshape it to the long format and then take a look again!

With the `melt()` function we can reshape it, first need to give the
wide format data set (`d_id`), then in the `id.vars` argument we provide
the name of the variables that do not change over time, and for the
`measure.vars` argument we give the name of the variables that change
over time. Then, in `variable.name` we give the values that the **time**
variables will have. Finally, in the `value.name` we have the name of
the variable that reports the score at each time point

``` r
head(d_id)
```

      Adidas Puma Nike HM Tommy_Hilfiger Condition_Couple id
    1      6    4    5  4              4  Beyonce & Jay-Z  1
    2      6    4    6  1              1  Beyonce & Jay-Z  2
    3      2    2    2  2              6  Beyonce & Jay-Z  3
    4      6    5    6  2              2  Beyonce & Jay-Z  4
    5      5    3    6  2              2  Beyonce & Jay-Z  5
    6      2    4    6  3              3  Shakira & Pique  6

``` r
d_long <- melt(d_id,id.vars=c("id", "Condition_Couple"),
measure.vars=c("Adidas","Puma","Nike","HM","Tommy_Hilfiger"),
          variable.name="Cleb_Congruence", 
          value.name="brand")

head(d_long)
```

      id Condition_Couple Cleb_Congruence brand
    1  1  Beyonce & Jay-Z          Adidas     6
    2  2  Beyonce & Jay-Z          Adidas     6
    3  3  Beyonce & Jay-Z          Adidas     2
    4  4  Beyonce & Jay-Z          Adidas     6
    5  5  Beyonce & Jay-Z          Adidas     5
    6  6  Shakira & Pique          Adidas     2

# Perform Repeated Measure Analysis

Now, it is time to actually perform a RM-ANOVA using functions from the
`afex` package that we loaded earlier. In addition to that, we can also
perform post-hoc tests.

First, with the `aov_ez` function we will run the RM-ANOVA. we need to
provide the long format data set (`d_long`), the dependent variable
(`brand`), the subject id (`id`), the within subject condition
(`Cleb_Congruence`).

``` r
model <- aov_ez(data=d_long,
                id = "id",
                dv = "brand",
                within = "Cleb_Congruence")
summary(model)
```


    Univariate Type III Repeated-Measures ANOVA Assuming Sphericity

                    Sum Sq num Df Error SS den Df  F value    Pr(>F)    
    (Intercept)     2528.1      1    199.1     31 393.6268 < 2.2e-16 ***
    Cleb_Congruence   57.9      4    258.9    124   6.9328 4.534e-05 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1


    Mauchly Tests for Sphericity

                    Test statistic p-value
    Cleb_Congruence        0.67041 0.22771


    Greenhouse-Geisser and Huynh-Feldt Corrections
     for Departure from Sphericity

                     GG eps Pr(>F[GG])    
    Cleb_Congruence 0.81888   0.000174 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

                       HF eps   Pr(>F[HF])
    Cleb_Congruence 0.9271222 7.779328e-05

The output `summary(model)` present different sections, first from the
`ANOVA Assuming Sphericity` section we can interpret that the mean
scores of the perceived celebrity congruence significantly differ across
the brands.

Sphericity can be evaluated using `Mauchly's test`, which examines
whether the differences between conditions have equal variances.
Consequently, if the Mauchly’s test statistic shows rejects the null
hypothesis (i.e., a probability value below an $\alpha = .05$), we
should conclude that there are noteworthy disparities in the variances
of differences, indicating a lack of sphericity.

If the data do not meet the assumption of sphericity, there are various
adjustments available to ensure the F-ratio remains valid. The
frequently employed corrections rely on the sphericity estimates
proposed by Greenhouse and Geisser and Huynh-Feldt. These estimates
result in a correction factor that is applied to the degrees of freedom
used for evaluating the observed F-ratio.

Second, from the test of Mauchly Tests for Sphericity section we can
interpret that we fail to reject the null hypothesis for the Mauchly’s
test statistic (i.e., $p > .05$) which means that it is reasonable to
conclude that the variances of differences are not significantly
different (i.e., they are roughly equal).

And third, for the `Greenhouse-Geisser and Huynh-Feldt` Corrections
correction section, these statistics are interpreted whenever the
Mauchly Tests for Sphericity is significant.

## Effect size

We also need to describe the results in function of measures of effect
size. For ANOVA family of analysis, we recommend to use $\eta^2_f$ and
$\omega^2_f$. These measures estimate the proportion of variance
explained by each predictor (similar to $R^2$). Where $\eta^2_f$ is more
positively bias (similar to $R^2$), and $\omega^2_f$ is a more
conservative measure.

When you have multiple predictors, you will also see the **partial**
version of these measures ($\eta^2_p$ and $\omega^2_p$). These will most
commonly present higher effect sizes, as they are the proportion of
explained variance **that is not predicted by any other predictors**.
So, will show higher effect sizes because they are not in function of
the total variance of the outcome, but the residual variance.

To estimate these measure we will use the `effectsize` package
functions, just provide the RM-ANOVA model to the respective functions,
notice that we set `partial = FALSE` to estimate the full measure
instead of partial one.

``` r
eta_squared(model, partial = FALSE)
```

    # Effect Size for ANOVA (Type III)

    Parameter       | Eta2 |       95% CI
    -------------------------------------
    Cleb_Congruence | 0.11 | [0.02, 1.00]

    - One-sided CIs: upper bound fixed at [1.00].

``` r
omega_squared(model, partial = FALSE)
```

    # Effect Size for ANOVA (Type III)

    Parameter       | Omega2 |       95% CI
    ---------------------------------------
    Cleb_Congruence |   0.09 | [0.01, 1.00]

    - One-sided CIs: upper bound fixed at [1.00].

When the model has only one predictor, these measures are equivalent to
the model $R^2$. In this case the show that around an 11%
($\eta^2_f = 0.11$) of the variance is explained by the `Cleb_Conguence`
variable, or conservatively 9% ($\omega^2_f = 0.09$)

## Post-hoc pairwise comparisons

We can start by looking at the estimated means for each group, we can do
this with the `avg_predictions` function. We need to provide it with the
model, and for which predictor in the model you wish to see predicted
means with the `by` argument

``` r
avg_predictions(model, by = c("Cleb_Congruence"))
```


     Cleb_Congruence Estimate Std. Error     z Pr(>|z|)     S 2.5 % 97.5 %
      Adidas             4.69      0.306 15.32   <0.001 173.6  4.09   5.29
      Puma               3.94      0.277 14.24   <0.001 150.4  3.40   4.48
      Nike               4.56      0.287 15.88   <0.001 186.3  4.00   5.13
      HM                 3.06      0.317  9.65   <0.001  70.8  2.44   3.68
      Tommy_Hilfiger     3.62      0.329 11.01   <0.001  91.3  2.98   4.27

    Type: response

Once we have established an overall model effect, we would be interested
in testing specific comparisons, such as **Where do we see specific mean
differences?**. We will do the post-hoc tests with the
`marginalleffects` package, this will tell you how the values of the
outcome predicted by the model change when we manipulate the predictors
(and their pairwise combinations)

For this function, we provide the RM-ANOVA object (`model`), the group
variable we want to estimate (`list(Cleb_Congruence = "pairwise")`) as
well as specifying that we are requesting the pairwise comparisons. . We
are specifying the degrees of freedom so the function uses the $t-test$
instead of the $z-test$, we get these from the handy function
`insight::get_df()` which requires the RN-ANOVA object. Additionally, we
are requesting the `fdr` false discovery rate $p$-value correction in th
`hypotheses` function with the `multcomp` argument, asking for the tests
and CI to be presented for the 95% confidence level

``` r
acmp <- avg_comparisons(model,
                       variables = list(Cleb_Congruence = "pairwise"), 
                       conf_level = 0.95,
                       df = insight::get_df(model))

acmp
```


                    Contrast Estimate Std. Error      t Pr(>|t|)    S   2.5 %
     HM - Adidas               -1.625      0.401 -4.053   <0.001 11.6 -2.4428
     HM - Nike                 -1.500      0.339 -4.425   <0.001 13.1 -2.1914
     HM - Puma                 -0.875      0.320 -2.735   0.0102  6.6 -1.5274
     Nike - Adidas             -0.125      0.361 -0.346   0.7317  0.5 -0.8619
     Nike - Puma                0.625      0.268  2.328   0.0266  5.2  0.0775
     Puma - Adidas             -0.750      0.336 -2.232   0.0330  4.9 -1.4353
     Tommy_Hilfiger - Adidas   -1.063      0.466 -2.278   0.0298  5.1 -2.0139
     Tommy_Hilfiger - HM        0.563      0.333  1.690   0.1010  3.3 -0.1163
     Tommy_Hilfiger - Nike     -0.938      0.381 -2.462   0.0196  5.7 -1.7142
     Tommy_Hilfiger - Puma     -0.313      0.371 -0.841   0.4066  1.3 -1.0701
      97.5 % Df
     -0.8072 31
     -0.8086 31
     -0.2226 31
      0.6119 31
      1.1725 31
     -0.0647 31
     -0.1111 31
      1.2413 31
     -0.1608 31
      0.4451 31

    Term: Cleb_Congruence
    Type: response

``` r
hypotheses(acmp, multcomp = "fdr")
```


     Estimate Std. Error      z Pr(>|z|)    S  2.5 %   97.5 %
       -1.625      0.401 -4.053   <0.001 11.9 -2.712 -0.53824
       -1.500      0.339 -4.425   <0.001 13.3 -2.419 -0.58123
       -0.875      0.320 -2.735   0.0208  5.6 -1.742 -0.00807
       -0.125      0.361 -0.346   0.7294  0.5 -1.104  0.85423
        0.625      0.268  2.328   0.0366  4.8 -0.103  1.35262
       -0.750      0.336 -2.232   0.0366  4.8 -1.661  0.16067
       -1.063      0.466 -2.278   0.0366  4.8 -2.327  0.20181
        0.563      0.333  1.690   0.1137  3.1 -0.339  1.46449
       -0.938      0.381 -2.462   0.0346  4.9 -1.970  0.09465
       -0.313      0.371 -0.841   0.4447  1.2 -1.319  0.69423

    Term: Cleb_Congruence

From these post-host, we can interpret that we reject the null
hypothesis of equal means over conditions for the comparisons with an
adjusted $p-value < .05$, as the most commonly use $\alpha$ level.

Notice we are using `fdr` $p$-value correcting, instead of more
conservative ones like Bonferroni.

## Plot group means

Then we can visualize these difference by plotting the means across
conditions. We can do this with the visualization conditions of the
`marginaeffects` package.

First, we can see the model prediction, the average predictions based on
our model, across the condition of interest, with the
`avg_predictions()` function

Here we see the mode predicted means for each condition, as well as the
measure of variability (SE)

``` r
p <- avg_predictions(model, by = "Cleb_Congruence")
p
```


     Cleb_Congruence Estimate Std. Error     z Pr(>|z|)     S 2.5 % 97.5 %
      Adidas             4.69      0.306 15.32   <0.001 173.6  4.09   5.29
      Puma               3.94      0.277 14.24   <0.001 150.4  3.40   4.48
      Nike               4.56      0.287 15.88   <0.001 186.3  4.00   5.13
      HM                 3.06      0.317  9.65   <0.001  70.8  2.44   3.68
      Tommy_Hilfiger     3.62      0.329 11.01   <0.001  91.3  2.98   4.27

    Type: response

Then we can plot it with the function `plot_predictions`, based on the
model, and the error bars representing the variability

``` r
plot_predictions(model, by = "Cleb_Congruence")
```

![](8_2_RM_ANOVA_files/figure-commonmark/unnamed-chunk-14-1.png)

The visualizations can be helpful to understand trends, and be clear on
the direction of the differences.

Note that this plot is a `ggplot2` type of plot, so you can edit it
accordingly.

## Post-hoc planned comparisons

In many cases you will not be interested in all pairwise comparisons,
but on planned comparisons, or specific contrasts tests. For this we can
use the `hypotheses()` function. First we can ask for how is the
function naming the relevant parameters

``` r
hypotheses(model)
```


                           Term Estimate Std. Error     z Pr(>|z|)     S 2.5 %
     Adidas_(Intercept)             4.69      0.306 15.32   <0.001 173.6  4.09
     Puma_(Intercept)               3.94      0.277 14.24   <0.001 150.4  3.40
     Nike_(Intercept)               4.56      0.287 15.88   <0.001 186.3  4.00
     HM_(Intercept)                 3.06      0.317  9.65   <0.001  70.8  2.44
     Tommy_Hilfiger_(Intercept)     3.62      0.329 11.01   <0.001  91.3  2.98
     97.5 %
       5.29
       4.48
       5.13
       3.68
       4.27

Here we see that the model extracts the mean for each of the five
groups, and we see that this match the factor variable

``` r
coef(model$lm)
```

                Adidas   Puma   Nike     HM Tommy_Hilfiger
    (Intercept) 4.6875 3.9375 4.5625 3.0625          3.625

Now, given the type of brands, we can think of comparing **sports**
(Adidas, Puma, Nike) brands against **casual** (H&M, Tommy Hilfiger)
brands. Here we will show hoe to do this in two ways.

In the first approach we will write up the formula to compare the groups
in function of the parameters from `hypotheses(model)`. Here we average
the group mean for sporty and casual brands

``` r
hypotheses(model, "(b1+b2+b3)/3 = (b4+b5)/2")
```

    Warning: 
    It is essential to check the order of estimates when specifying hypothesis tests using positional indices like b1, b2, etc. The indices of estimates can change depending on the order of rows in the original dataset, user-supplied arguments, model-fitting package, and version of `marginaleffects`.

    It is also good practice to use assertions that ensure the order of estimates is consistent across different runs of the same code. Example:

    ```r
    mod <- lm(mpg ~ am * carb, data = mtcars)

    # assertion for safety
    p <- avg_predictions(mod, by = 'carb')
    stopifnot(p$carb[1] == 1, p$carb[2] == 2)

    # hypothesis test
    avg_predictions(mod, by = 'carb', hypothesis = 'b1 - b2 = 0')
    ```

    Disable this warning with: `options(marginaleffects_safe = FALSE)`
     This warning appears once per session.


                 Hypothesis Estimate Std. Error    z Pr(>|z|)    S 2.5 % 97.5 %
     (b1+b2+b3)/3=(b4+b5)/2     1.05      0.289 3.64   <0.001 11.8 0.485   1.62

In the second method, we will write the hypothesis with the commonly use
**weights**, where we set group parameters based on the sign of the
weights. So the first 3 groups will be set as one, and the last 2 will
be grouped together. This way positive weights will be compared agaiant
negative weights.

``` r
hypotheses(model, hypothesis = c(1/3,1/3,1/3,-1/2,-1/2))
```


     Estimate Std. Error    z Pr(>|z|)    S 2.5 % 97.5 %
         1.05      0.289 3.64   <0.001 11.8 0.485   1.62

    Term: custom

Here we reject the null hypothesis of sporty and casual brands to have
the same level of congruence.

You can also build a matrix with multiple contrasts, to test more than
one hypothesis at the time. For this example, We are adding a hypothesis
for each type of brand mean being equal to 0, and then the comparison
between them (previous example)

Note that for the matrix, each column represents a different hypothesis
and each row represents a group

``` r
cont_mat <- cbind(c(1/3,1/3,1/3,0,0),
                  c(0,0,0,1/2,1/2),
                  c(1/3,1/3,1/3,-1/2,-1/2))
colnames(cont_mat) <- c("Sport=0","Casual=0","Sport=Casual")
cont_mat
```

           Sport=0 Casual=0 Sport=Casual
    [1,] 0.3333333      0.0    0.3333333
    [2,] 0.3333333      0.0    0.3333333
    [3,] 0.3333333      0.0    0.3333333
    [4,] 0.0000000      0.5   -0.5000000
    [5,] 0.0000000      0.5   -0.5000000

``` r
hypotheses(model, hypothesis = cont_mat)
```


             Term Estimate Std. Error     z Pr(>|z|)     S 2.5 % 97.5 %
     Sport=0          4.40      0.222 19.83   <0.001 288.2 3.961   4.83
     Casual=0         3.34      0.277 12.06   <0.001 108.9 2.800   3.89
     Sport=Casual     1.05      0.289  3.64   <0.001  11.8 0.485   1.62

Note that for contrast weights, if you want the means in the metric of
the observed variable, you need to make sure the weights sum up to 1.
Otherwise the interpretation will be in another metric.

# Mixed design RM-ANOVA

A common next step in RM-ANOVA, is to also include a between subject
predictor, this way accounting for both within and between condition
differences. As we have within conditions, still requires to account for
the observations dependencies.

For this we will extend the use of the `aov_ez` function, will start
with the same arguments as before. The only difference is that we are
adding a between subject predictor (`Condition_Couple`) in the `between`
argument. This by default will include the interaction by within and
between variables.

``` r
model2 <- aov_ez(data=d_long,
                id = "id",
                dv = "brand",
                within = "Cleb_Congruence", 
                between = "Condition_Couple")
```

    Contrasts set to contr.sum for the following variables: Condition_Couple

``` r
summary(model2)
```


    Univariate Type III Repeated-Measures ANOVA Assuming Sphericity

                                      Sum Sq num Df Error SS den Df  F value
    (Intercept)                      2528.10      1   198.47     30 382.1287
    Condition_Couple                    0.63      1   198.47     30   0.0945
    Cleb_Congruence                    57.90      4   253.15    120   6.8615
    Condition_Couple:Cleb_Congruence    5.75      4   253.15    120   0.6814
                                        Pr(>F)    
    (Intercept)                      < 2.2e-16 ***
    Condition_Couple                    0.7607    
    Cleb_Congruence                  5.225e-05 ***
    Condition_Couple:Cleb_Congruence    0.6062    
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1


    Mauchly Tests for Sphericity

                                     Test statistic p-value
    Cleb_Congruence                         0.64328 0.18542
    Condition_Couple:Cleb_Congruence        0.64328 0.18542


    Greenhouse-Geisser and Huynh-Feldt Corrections
     for Departure from Sphericity

                                      GG eps Pr(>F[GG])    
    Cleb_Congruence                  0.81077  0.0002079 ***
    Condition_Couple:Cleb_Congruence 0.81077  0.5765634    
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

                                       HF eps   Pr(>F[HF])
    Cleb_Congruence                  0.920655 9.310028e-05
    Condition_Couple:Cleb_Congruence 0.920655 5.944389e-01

The output `summary(model2)` present different sections, first from the
`ANOVA Assuming Sphericity` section we can interpret that:

**Condition_Couple**: This is the effect of the between-subjects factor
“Condition_Couple” on the “brand” variable. The
$F(1, 30) = 0.0945, p = 0.7607$. This suggests that we fail to reject
the null hypothesis of “Condition_Couple” effect on “brand.”
**Cleb_Congruence**: This is the effect of the within-subjects factor
“Cleb_Congruence” on the “brand” variable. The
$F(4,120) = 6.8615, p < .001$, indicating that we reject the null
hypothesis of the effect of “Cleb_Congruence” on “brand.”
**Condition_Couple:Cleb_Congruence** (Interaction): This represents the
interaction effect between the between-subjects factor
“Condition_Couple” and the within-subjects factor “Cleb_Congruence” on
the “brand” variable. The $F(4, 120) = 0.6814, p < .6062$. This suggests
that we fail to reject the null hypothesis of the interaction effect
between these two factors on “brand.” For both “Cleb_Congruence” and
“Condition_Couple:Cleb_Congruence,”

Second from the test of `Mauchly Tests for Sphericity` section we can
interpret that both “Cleb_Congruence” and
“Condition_Couple:Cleb_Congruence,” the Mauchly test statistics have
$p > 0.05$ (p = 0.18542), indicating that the assumption of sphericity
is not significantly violated for these variables.

And third, for the `Greenhouse-Geisser and Huynh-Feldt` Corrections
correction section, these statistics are interpretated whenever the
Mauchly Tests for Sphericity is significant.

## Effect size

Rememeber that when you have multiple predictors, you will also see the
**partial** version of these measures ($\eta^2_p$ and $\omega^2_p$).
These will most commonly present higher effect sizes, as they are the
proportion of explained variance **that is not predicted by any other
predictors**. So, will show higher effect sizes because they are not in
function of the total variance of the outcome, but the residual
variance.

To estimate these measure we will use the `effectsize` package
functions, just provide the RM-ANOVA model to the respective functions,
notice that we set `partial = FALSE` to estimate the full measure
instead of partial one.

``` r
eta_squared(model2, partial = FALSE)
```

    # Effect Size for ANOVA (Type III)

    Parameter                        |     Eta2 |       95% CI
    ----------------------------------------------------------
    Condition_Couple                 | 1.21e-03 | [0.00, 1.00]
    Cleb_Congruence                  |     0.11 | [0.02, 1.00]
    Condition_Couple:Cleb_Congruence |     0.01 | [0.00, 1.00]

    - One-sided CIs: upper bound fixed at [1.00].

``` r
omega_squared(model2, partial = FALSE)
```

    # Effect Size for ANOVA (Type III)

    Parameter                        | Omega2 |       95% CI
    --------------------------------------------------------
    Condition_Couple                 |   0.00 | [0.00, 1.00]
    Cleb_Congruence                  |   0.09 | [0.01, 1.00]
    Condition_Couple:Cleb_Congruence |   0.00 | [0.00, 1.00]

    - One-sided CIs: upper bound fixed at [1.00].

In this case the show that around an 11% ($\eta^2_f = 0.11$) of the
variance is explained by the `Cleb_Conguence` variable, or
conservatively 9% ($\omega^2_f = 0.09$). And the variable
`Condition_Couple` and the interaction functionally have no effect.

You can estimate the partial measures with the argument `partial=TRUE`

``` r
eta_squared(model2, partial = TRUE)
```

    # Effect Size for ANOVA (Type III)

    Parameter                        | Eta2 (partial) |       95% CI
    ----------------------------------------------------------------
    Condition_Couple                 |       3.14e-03 | [0.00, 1.00]
    Cleb_Congruence                  |           0.19 | [0.07, 1.00]
    Condition_Couple:Cleb_Congruence |           0.02 | [0.00, 1.00]

    - One-sided CIs: upper bound fixed at [1.00].

``` r
omega_squared(model2, partial = TRUE)
```

    # Effect Size for ANOVA (Type III)

    Parameter                        | Omega2 (partial) |       95% CI
    ------------------------------------------------------------------
    Condition_Couple                 |             0.00 | [0.00, 1.00]
    Cleb_Congruence                  |             0.10 | [0.01, 1.00]
    Condition_Couple:Cleb_Congruence |             0.00 | [0.00, 1.00]

    - One-sided CIs: upper bound fixed at [1.00].

In this case the show that around an 19% ($\eta^2_f = 0.19$) of the
variance that is not explained by other predictors is explained by the
`Cleb_Conguence` variable, or conservatively 10% ($\omega^2_f = 0.10$).
And the variable `Condition_Couple` and the interaction functionally
have no effect.

## Post-hoc comparisons

Now, the post-hocs can be done in 3 ways, first for the within variable,
second for the between variable, and third with the interaction between
them

First, we can estimate the pairwise comparisons (ignoring the
interactions)by including both the between and within variables in the
`variables` argument and asking for the pairwise comparisons.

``` r
acmp_1 <- avg_comparisons(model2,
                          variables = list(Cleb_Congruence = "pairwise", Condition_Couple = "pairwise"),
                          conf_level = 0.95,
                          df = insight::get_df(model2))

acmp_1
```


                 Term                          Contrast Estimate Std. Error      t
     Cleb_Congruence  HM - Adidas                         -1.625      0.404 -4.026
     Cleb_Congruence  HM - Nike                           -1.500      0.342 -4.392
     Cleb_Congruence  HM - Puma                           -0.875      0.323 -2.706
     Cleb_Congruence  Nike - Adidas                       -0.125      0.367 -0.341
     Cleb_Congruence  Nike - Puma                          0.625      0.261  2.395
     Cleb_Congruence  Puma - Adidas                       -0.750      0.329 -2.279
     Cleb_Congruence  Tommy_Hilfiger - Adidas             -1.063      0.469 -2.264
     Cleb_Congruence  Tommy_Hilfiger - HM                  0.563      0.338  1.664
     Cleb_Congruence  Tommy_Hilfiger - Nike               -0.938      0.383 -2.448
     Cleb_Congruence  Tommy_Hilfiger - Puma               -0.313      0.377 -0.829
     Condition_Couple Shakira & Pique - Beyonce & Jay-Z    0.125      0.407  0.307
     Pr(>|t|)    S   2.5 %  97.5 % Df
       <0.001 11.5 -2.4493 -0.8007 30
       <0.001 12.9 -2.1976 -0.8024 30
       0.0111  6.5 -1.5354 -0.2146 30
       0.7359  0.4 -0.8747  0.6247 30
       0.0231  5.4  0.0921  1.1579 30
       0.0300  5.1 -1.4222 -0.0778 30
       0.0309  5.0 -2.0208 -0.1042 30
       0.1066  3.2 -0.1280  1.2530 30
       0.0204  5.6 -1.7195 -0.1555 30
       0.4136  1.3 -1.0822  0.4572 30
       0.7607  0.4 -0.7056  0.9556 30

    Type: response

``` r
hypotheses(acmp_1, multcomp = "fdr")
```


                 Term Estimate Std. Error      z Pr(>|z|)    S   2.5 %  97.5 %
     Cleb_Congruence    -1.625      0.404 -4.026   <0.001 11.6 -2.7356 -0.5144
     Cleb_Congruence    -1.500      0.342 -4.392   <0.001 13.0 -2.4399 -0.5601
     Cleb_Congruence    -0.875      0.323 -2.706   0.0250  5.3 -1.7648  0.0148
     Cleb_Congruence    -0.125      0.367 -0.341   0.7586  0.4 -1.1352  0.8852
     Cleb_Congruence     0.625      0.261  2.395   0.0366  4.8 -0.0931  1.3431
     Cleb_Congruence    -0.750      0.329 -2.279   0.0370  4.8 -1.6557  0.1557
     Cleb_Congruence    -1.063      0.469 -2.264   0.0370  4.8 -2.3537  0.2287
     Cleb_Congruence     0.563      0.338  1.664   0.1323  2.9 -0.3679  1.4929
     Cleb_Congruence    -0.938      0.383 -2.448   0.0366  4.8 -1.9912  0.1162
     Cleb_Congruence    -0.313      0.377 -0.829   0.4975  1.0 -1.3497  0.7247
     Condition_Couple    0.125      0.407  0.307   0.7586  0.4 -0.9941  1.2441

From `summary(acmp_1)` we will have the estimated mean difference for
each pair comparison, and we can reject the null hypothesis for
comparisons where the adjusted $p -value < .05$

If we want to estimate the interacting post-hoc, across between and
within conditions. We can include the between condition in the `by`
argument. This way the results will include the pairwise comparisons
across `Cleb_Congruence` within conditions, for each `Condition_Couple`
between condition

``` r
acmp_2 <- avg_comparisons(model2,
                          variables = list(Cleb_Congruence = "pairwise"), 
                          conf_level = 0.95, 
                          by = "Condition_Couple",
                          df = insight::get_df(model2))

acmp_2
```


                    Contrast Condition_Couple Estimate Std. Error      t Pr(>|t|)
     HM - Adidas              Beyonce & Jay-Z  -1.9375      0.571 -3.395  0.00195
     HM - Nike                Beyonce & Jay-Z  -1.7500      0.483 -3.623  0.00106
     HM - Puma                Beyonce & Jay-Z  -0.6875      0.457 -1.503  0.14319
     Nike - Adidas            Beyonce & Jay-Z  -0.1875      0.519 -0.361  0.72051
     Nike - Puma              Beyonce & Jay-Z   1.0625      0.369  2.879  0.00729
     Puma - Adidas            Beyonce & Jay-Z  -1.2500      0.465 -2.685  0.01169
     Tommy_Hilfiger - Adidas  Beyonce & Jay-Z  -1.4375      0.664 -2.166  0.03837
     Tommy_Hilfiger - HM      Beyonce & Jay-Z   0.5000      0.478  1.046  0.30407
     Tommy_Hilfiger - Nike    Beyonce & Jay-Z  -1.2500      0.542 -2.308  0.02805
     Tommy_Hilfiger - Puma    Beyonce & Jay-Z  -0.1875      0.533 -0.352  0.72747
     HM - Adidas              Shakira & Pique  -1.3125      0.571 -2.300  0.02861
     HM - Nike                Shakira & Pique  -1.2500      0.483 -2.588  0.01475
     HM - Puma                Shakira & Pique  -1.0625      0.457 -2.323  0.02712
     Nike - Adidas            Shakira & Pique  -0.0625      0.519 -0.120  0.90498
     Nike - Puma              Shakira & Pique   0.1875      0.369  0.508  0.61513
     Puma - Adidas            Shakira & Pique  -0.2500      0.465 -0.537  0.59517
     Tommy_Hilfiger - Adidas  Shakira & Pique  -0.6875      0.664 -1.036  0.30847
     Tommy_Hilfiger - HM      Shakira & Pique   0.6250      0.478  1.307  0.20112
     Tommy_Hilfiger - Nike    Shakira & Pique  -0.6250      0.542 -1.154  0.25754
     Tommy_Hilfiger - Puma    Shakira & Pique  -0.4375      0.533 -0.821  0.41824
       S  2.5 %  97.5 % Df
     9.0 -3.103 -0.7718 30
     9.9 -2.737 -0.7635 30
     2.8 -1.621  0.2464 30
     0.5 -1.248  0.8728 30
     7.1  0.309  1.8162 30
     6.4 -2.201 -0.2994 30
     4.7 -2.793 -0.0822 30
     1.7 -0.477  1.4766 30
     5.2 -2.356 -0.1441 30
     0.5 -1.276  0.9011 30
     5.1 -2.478 -0.1468 30
     6.1 -2.237 -0.2635 30
     5.2 -1.996 -0.1286 30
     0.1 -1.123  0.9978 30
     0.7 -0.566  0.9412 30
     0.7 -1.201  0.7006 30
     1.7 -2.043  0.6678 30
     2.3 -0.352  1.6016 30
     2.0 -1.731  0.4809 30
     1.3 -1.526  0.6511 30

    Term: Cleb_Congruence
    Type: response

``` r
hypotheses(acmp_2, multcomp = "fdr")
```


     Estimate Std. Error      z Pr(>|z|)   S   2.5 % 97.5 %
      -1.9375      0.571 -3.395  0.00687 7.2 -3.6190 -0.256
      -1.7500      0.483 -3.623  0.00583 7.4 -3.1731 -0.327
      -0.6875      0.457 -1.503  0.26546 1.9 -2.0347  0.660
      -0.1875      0.519 -0.361  0.76317 0.4 -1.7170  1.342
       1.0625      0.369  2.879  0.02659 5.2 -0.0247  2.150
      -1.2500      0.465 -2.685  0.03622 4.8 -2.6213  0.121
      -1.4375      0.664 -2.166  0.06732 3.9 -3.3925  0.518
       0.5000      0.478  1.046  0.42885 1.2 -0.9087  1.909
      -1.2500      0.542 -2.308  0.05369 4.2 -2.8453  0.345
      -0.1875      0.533 -0.352  0.76317 0.4 -1.7578  1.383
      -1.3125      0.571 -2.300  0.05369 4.2 -2.9940  0.369
      -1.2500      0.483 -2.588  0.03864 4.7 -2.6731  0.173
      -1.0625      0.457 -2.323  0.05369 4.2 -2.4097  0.285
      -0.0625      0.519 -0.120  0.90418 0.1 -1.5920  1.467
       0.1875      0.369  0.508  0.71931 0.5 -0.8997  1.275
      -0.2500      0.465 -0.537  0.71931 0.5 -1.6213  1.121
      -0.6875      0.664 -1.036  0.42885 1.2 -2.6425  1.268
       0.6250      0.478  1.307  0.34762 1.5 -0.7837  2.034
      -0.6250      0.542 -1.154  0.41404 1.3 -2.2203  0.970
      -0.4375      0.533 -0.821  0.54902 0.9 -2.0078  1.133

    Term: Cleb_Congruence

This turns into larger post-hoc results, so be careful in its reading
and interpretation

## Plot post-hoc

For plotting the post-hoc results when including between and within
factors, we can do it the same as before one predictor at the time, or
looking the the interaction.

We can see the model predicted means for each group combination by
including both predictors in the `by` argument. If you include only one
predictor, you will get the predictions for only that one, ignoring the
interaction.

Here we get the model predictions across both predictors, accounting for
the interaction.

``` r
p2 <- avg_predictions(model2,
                      by = c("Cleb_Congruence", "Condition_Couple") )
p2
```


     Cleb_Congruence Condition_Couple Estimate Std. Error     z Pr(>|z|)    S 2.5 %
      Adidas          Beyonce & Jay-Z     4.88      0.437 11.15   <0.001 93.5  4.02
      Adidas          Shakira & Pique     4.50      0.437 10.29   <0.001 80.1  3.64
      Puma            Beyonce & Jay-Z     3.63      0.389  9.31   <0.001 66.1  2.86
      Puma            Shakira & Pique     4.25      0.389 10.92   <0.001 89.8  3.49
      Nike            Beyonce & Jay-Z     4.69      0.412 11.38   <0.001 97.3  3.88
      Nike            Shakira & Pique     4.44      0.412 10.78   <0.001 87.6  3.63
      HM              Beyonce & Jay-Z     2.94      0.455  6.46   <0.001 33.1  2.05
      HM              Shakira & Pique     3.19      0.455  7.01   <0.001 38.6  2.30
      Tommy_Hilfiger  Beyonce & Jay-Z     3.44      0.471  7.30   <0.001 41.7  2.51
      Tommy_Hilfiger  Shakira & Pique     3.81      0.471  8.10   <0.001 50.7  2.89
     97.5 %
       5.73
       5.36
       4.39
       5.01
       5.49
       5.24
       3.83
       4.08
       4.36
       4.74

    Type: response

Then, we can plot the estimated means, accounting for the interactions.
With the same function as before, but by including both predictors in
the `by` argument. The function by default will choose the between
subject variable as the condition to separate the plot by group (based
on color)

``` r
plot_predictions(model2, by = c("Cleb_Congruence","Condition_Couple") )
```

![](8_2_RM_ANOVA_files/figure-commonmark/unnamed-chunk-27-1.png)

## Post-hoc planned comparisons

(Note, I have no theoretical reason for meaningful comparisons here, so
I am writing some as understandable examples)

For planned comparisons while having cross factors we will use the
`predictions` function, which estimates all cross factor means (similar
to `avg_predictions`). If you run the function with the default
arguments it will estimate the marginal means for each factor, and we
need to add the argument `cross=T` to estimate all possible cross
marginal means.

``` r
mm <- predictions(model2,
                   by = c("Cleb_Congruence","Condition_Couple"),
                   newdata = datagrid(grid_type = "balanced")  )
mm
```


     Cleb_Congruence Condition_Couple Estimate Std. Error     z Pr(>|z|)    S 2.5 %
      Adidas          Beyonce & Jay-Z     4.88      0.437 11.15   <0.001 93.5  4.02
      Adidas          Shakira & Pique     4.50      0.437 10.29   <0.001 80.1  3.64
      Puma            Beyonce & Jay-Z     3.63      0.389  9.31   <0.001 66.1  2.86
      Puma            Shakira & Pique     4.25      0.389 10.92   <0.001 89.8  3.49
      Nike            Beyonce & Jay-Z     4.69      0.412 11.38   <0.001 97.3  3.88
      Nike            Shakira & Pique     4.44      0.412 10.78   <0.001 87.6  3.63
      HM              Beyonce & Jay-Z     2.94      0.455  6.46   <0.001 33.1  2.05
      HM              Shakira & Pique     3.19      0.455  7.01   <0.001 38.6  2.30
      Tommy_Hilfiger  Beyonce & Jay-Z     3.44      0.471  7.30   <0.001 41.7  2.51
      Tommy_Hilfiger  Shakira & Pique     3.81      0.471  8.10   <0.001 50.7  2.89
     97.5 %
       5.73
       5.36
       4.39
       5.01
       5.49
       5.24
       3.83
       4.08
       4.36
       4.74

    Type: response

Once we have seen the cross means, we can build comparisons with weights
vectors. For example if we want to compare **Casual-Beyonce & Jay-Z** vs
**Casual-Shakira & Piqué** we can use the following weight vector in the
`hypothesis` argument

``` r
mm2 <- predictions(model2,
                   by = c("Cleb_Congruence","Condition_Couple"),
                   newdata = datagrid(grid_type = "balanced"),
                   hypothesis = c(0,0,0,1/2,1/2,0,0,0,-1/2,-1/2)  )
```

Here we see that we fail to reject the null hypothesis of both groups
having the same marginal mean.

And, we can also add multiple comparisons with a matrix of weights. In
this example, we are adding the same hypothesis as before, and adding
**Sporty-Beyonce & Jay-Z** vs **Sporty-Shakira & Piqué**

Note that for the matrix, each column represents a different hypothesis
and each row represents a group

``` r
cont_mat2 <- cbind(c(0,0,0,1/2,1/2,0,0,0,-1/2,-1/2),
                   c(1/3,1/3,1/3,0,0,-1/3,-1/3,-1/3,0,0))

mm3 <- predictions(model2,
                   by = c("Cleb_Congruence","Condition_Couple"),
                   newdata = datagrid(grid_type = "balanced"),
                   hypothesis = cont_mat2  )
mm3
```


     Estimate Std. Error    z Pr(>|z|)   S  2.5 % 97.5 %
        0.844      0.380 2.22   0.0264 5.2 0.0991   1.59
        0.813      0.334 2.44   0.0149 6.1 0.1588   1.47

    Term: custom
    Type: response

For both of these example, we fail to reject the null hypothesis.

## Interpretation

A repeated measure testing was used to determine the congruence between
five sports clothing brands and two celebrity couples. Participants
rated the congruence of five sports brands with one of the celebrity
couples (randomized), measured using a seven-point Likert scale ranging
from one (strongly disagree) to seven (strongly agree).

Participants were asked their agreement level to statements such as
“Adidas is a good match with the celebrities” and “Puma is a good match
with the celebrities”. The repeated measure used a within factor with
five levels (Adidas, Puma, Nike, H&M, Tommy Hilfiger) and a between
factor with two levels (Beyonce & Jay-Z and Shakira & Piqué). The result
showed that there we reject the null hypothesis of no differences in
congruence between the brands ($F (4, 124) = 6.93, p < .01$). Overall
Adidas had the highest mean congruence (M = 4.69, SE = 0.31).

We fail to reject the null hypothesis of equal congruence, when
comparing the two celebrity couples (interaction)
($F (4, 120) = 0.68, p = 0.606$). This shows that no brands showed a
significantly higher congruence with one couple compared to the other.
And brand differences should be look at ignoring couple effects.

Since no difference in brand scores exist between couples and Adidas has
the highest congruence score and differs in score with Puma, HM,
Tommy_Hilfiger, the best brand to use in the experimental research would
be Adidas.
