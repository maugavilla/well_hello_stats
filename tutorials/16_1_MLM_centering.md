# Multilevel Regression: centering
Mauricio Garnier-Villarreal
2026-03-17

- [Introduction to Centering in Multilevel
  Models](#introduction-to-centering-in-multilevel-models)
  - [Why Do We Need to Separate These
    Effects?](#why-do-we-need-to-separate-these-effects)
  - [Packages and Data](#packages-and-data)
  - [Preliminary Step: Creating the Cluster
    Mean](#preliminary-step-creating-the-cluster-mean)
  - [The Uncentered Model (Baseline)](#the-uncentered-model-baseline)
  - [Grand Mean Centering](#grand-mean-centering)
    - [Model 2a: Grand Mean Centering
      Only](#model-2a-grand-mean-centering-only)
    - [Model 2b: Grand Mean Centering + Group
      Mean](#model-2b-grand-mean-centering--group-mean)
  - [Group Mean Centering](#group-mean-centering)
    - [Model 3a: Group Mean Centering
      Only](#model-3a-group-mean-centering-only)
    - [Model 3b: Group Mean Centering + Group
      Mean](#model-3b-group-mean-centering--group-mean)
  - [The Fully Centered Model (CWC + Centered Group
    Mean)](#the-fully-centered-model-cwc--centered-group-mean)
    - [Model 4: The Final Model](#model-4-the-final-model)
      - [Detailed Interpretation of Final Model
        Results](#detailed-interpretation-of-final-model-results)
  - [Variance Partitioning](#variance-partitioning)
  - [Summary Table for
    Interpretation](#summary-table-for-interpretation)
  - [Conclusions from the Final
    Model](#conclusions-from-the-final-model)
  - [Summary of Model Results](#summary-of-model-results)
  - [Effect Size Measures](#effect-size-measures)
    - [Using the `performance` package](#using-the-performance-package)
    - [Using the `r2mlm` package](#using-the-r2mlm-package)
      - [Detailed Explanation of `r2mlm()`
        Output](#detailed-explanation-of-r2mlm-output)
      - [Key Takeaways from This
        Output:](#key-takeaways-from-this-output)
  - [Summary of Interpretations and
    Recommendations](#summary-of-interpretations-and-recommendations)
  - [References](#references)

## Introduction to Centering in Multilevel Models

Centering is the process of subtracting a constant from a variable to
create a new, shifted version of that variable. In single-level
regression, centering is primarily used to give the intercept a
meaningful interpretation: the expected value of the outcome when all
predictors are zero (Aiken & West, 1991). If a predictor does not have a
natural zero point (e.g., a Likert scale from 1 to 7), the intercept can
be uninterpretable. Centering at the grand mean solves this by making
zero represent the average score.

In multilevel models (MLMs), centering takes on additional importance
because it helps us separate the effects of a predictor into its
**within-cluster** and **between-cluster** components (Enders & Tofighi,
2007; Raudenbush & Bryk, 2002). Failing to separate these effects
results in a “conflated” or “smushed” coefficient that is an
uninterpretable blend of the two (Hoffman & Walters, 2022; Preacher et
al., 2010).

### Why Do We Need to Separate These Effects?

Consider a study of students nested within schools. We want to examine
the relationship between student Socio-Economic Status (SES) and math
achievement. The relationship can be broken down into two distinct
questions:

1.  **Within-School Effect**: For students in the *same* school, is
    higher SES associated with higher math scores?
2.  **Between-School Effect**: Do schools with a higher *average* SES
    tend to have higher average math scores?

These two effects can be, and often are, different in magnitude. The
difference between them is known as the **contextual effect**: the
effect of being in a higher-SES school, over and above the effect of
one’s own SES (Marsh’s “Big-Fish-Little-Pond Effect”). A standard MLM
with uncentered SES conflates these effects, producing a single
coefficient that does not accurately represent either one.

This tutorial will guide you through the three main centering strategies
for level-1 predictors, showing how to estimate and interpret these
distinct effects using R.

### Packages and Data

We will use the `SB.csv` dataset (Snijders & Bosker, 1999) containing
2,287 pupils in 131 schools. Our outcome is a language post-test score
(`langpost`), and our predictor is verbal IQ (`iq_verb`). We will also
use several R packages for data manipulation, model fitting, and effect
size calculation.

``` r
# Load required packages
library(lme4)
library(lmerTest)
library(rio)
library(parameters)
library(performance)
library(r2mlm)
library(dplyr)
library(ggplot2)
library(tidyr)

# Read data
SB <- import("SB.csv")
SB <- drop_na(SB)  # remove missing for simplicity
head(SB)
```

      schoolnr pupilnr iq_verb  iq_perf sex minority repeatgr aritpret classnr
    1        1   17001    15.0 12.33333   0        0        0       14     180
    2        1   17002    14.5 10.00000   0        1        0       12     180
    3        1   17003     9.5 11.00000   0        0        0       10     180
    4        1   17004    11.0 10.00000   0        0        0       13     180
    5        1   17005     8.0  6.66667   0        0        0        8     180
    6        1   17006     9.5  9.00000   0        1        0        8     180
      aritpost langpret langpost ses denomina schoolse satiprin natitest meetings
    1       24       36       46  23        1       11  3.42857        0      1.7
    2       19       36       45  10        1       11  3.42857        0      1.7
    3       24       33       33  15        1       11  3.42857        0      1.7
    4       26       29       46  23        1       11  3.42857        0      1.7
    5        9       19       20  10        1       11  3.42857        0      1.7
    6       13       22       30  10        1       11  3.42857        0      1.7
      currmeet mixedgra percmino aritdiff homework classsiz groupsiz
    1  1.83333        0       60       12  2.33333       29       29
    2  1.83333        0       60       12  2.33333       29       29
    3  1.83333        0       60       12  2.33333       29       29
    4  1.83333        0       60       12  2.33333       29       29
    5  1.83333        0       60       12  2.33333       29       29
    6  1.83333        0       60       12  2.33333       29       29

### Preliminary Step: Creating the Cluster Mean

To separate within- and between-cluster effects, we first need the
cluster mean of our predictor. This will be used both for centering and
as a level-2 predictor.

``` r
# Calculate the mean iq_verb for each school
school_means <- SB %>%
  group_by(schoolnr) %>%
  summarise(iq_mean = mean(iq_verb, na.rm = TRUE))

# Merge the school mean back into the main data frame
SB <- left_join(SB, school_means, by = "schoolnr")

head(SB[, c("schoolnr", "iq_verb", "iq_mean")])
```

      schoolnr iq_verb iq_mean
    1        1    15.0   10.32
    2        1    14.5   10.32
    3        1     9.5   10.32
    4        1    11.0   10.32
    5        1     8.0   10.32
    6        1     9.5   10.32

### The Uncentered Model (Baseline)

We start with a baseline model using the raw, uncentered predictor. This
model will serve as a reference point. It includes a random intercept
for schools but keeps the slope of iq_verb fixed for simplicity.

``` r
model_uncentered <- lmer(langpost ~ 1 + iq_verb + (1 | schoolnr),
                         data = SB, REML = FALSE)

summary(model_uncentered)
```

    Linear mixed model fit by maximum likelihood . t-tests use Satterthwaite's
      method [lmerModLmerTest]
    Formula: langpost ~ 1 + iq_verb + (1 | schoolnr)
       Data: SB

          AIC       BIC    logLik -2*log(L)  df.resid 
      15259.8   15282.7   -7625.9   15251.8      2283 

    Scaled residuals: 
        Min      1Q  Median      3Q     Max 
    -4.0958 -0.6370  0.0580  0.7069  3.1467 

    Random effects:
     Groups   Name        Variance Std.Dev.
     schoolnr (Intercept)  9.497   3.082   
     Residual             42.227   6.498   
    Number of obs: 2287, groups:  schoolnr, 131

    Fixed effects:
                 Estimate Std. Error        df t value Pr(>|t|)    
    (Intercept) 1.117e+01  8.788e-01 1.926e+03   12.71   <2e-16 ***
    iq_verb     2.488e+00  7.005e-02 2.276e+03   35.52   <2e-16 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Correlation of Fixed Effects:
            (Intr)
    iq_verb -0.937

``` r
parameters(model_uncentered)
```

    # Fixed Effects

    Parameter   | Coefficient |   SE |        95% CI | t(2283) |      p
    -------------------------------------------------------------------
    (Intercept) |       11.17 | 0.88 | [9.44, 12.89] |   12.71 | < .001
    iq verb     |        2.49 | 0.07 | [2.35,  2.63] |   35.52 | < .001

    # Random Effects

    Parameter                | Coefficient
    --------------------------------------
    SD (Intercept: schoolnr) |        3.08
    SD (Residual)            |        6.50

**Interpretation of the Uncentered Model:**

- The coefficient for `iq_verb`iq_verb is 2.49. This is a conflated,
  uninterpretable blend of the within-school and between-school effects.
  It does not tell us whether the effect is due to a student’s own IQ
  relative to their classmates or due to the average IQ level of the
  school they attend.
- The intercept is the predicted language score when `iq_verb = 0`,
  which is not meaningful in this context.

This model highlights why centering is necessary. We cannot answer our
substantive questions about within- and between-school effects from
these results.

### Grand Mean Centering

Grand Mean Centering (CGM) involves subtracting the overall grand mean
of the predictor from every observation. The centered variable is
created as:

$$ \text{iq\_cgm}_{ij} = \text{iq\_verb}_{ij} - \bar{x}_{..} $$

where $\bar{x}_{..}$ is the grand mean of `iq_verb`.

``` r
# Calculate the grand mean
grand_mean_iq <- mean(SB$iq_verb)

# Create the grand-mean centered variable
SB$iq_cgm <- SB$iq_verb - grand_mean_iq

# Verify that the mean of the new variable is zero
mean(SB$iq_cgm)
```

    [1] 3.904947e-18

#### Model 2a: Grand Mean Centering Only

This model includes only the grand-mean centered predictor. The
coefficient will still be conflated because the between-school variance
is still present in the predictor.

``` r
model_cgm_only <- lmer(langpost ~ 1 + iq_cgm + (1 | schoolnr),
                       data = SB, REML = FALSE)

summary(model_cgm_only)
```

    Linear mixed model fit by maximum likelihood . t-tests use Satterthwaite's
      method [lmerModLmerTest]
    Formula: langpost ~ 1 + iq_cgm + (1 | schoolnr)
       Data: SB

          AIC       BIC    logLik -2*log(L)  df.resid 
      15259.8   15282.7   -7625.9   15251.8      2283 

    Scaled residuals: 
        Min      1Q  Median      3Q     Max 
    -4.0958 -0.6370  0.0580  0.7069  3.1467 

    Random effects:
     Groups   Name        Variance Std.Dev.
     schoolnr (Intercept)  9.497   3.082   
     Residual             42.227   6.498   
    Number of obs: 2287, groups:  schoolnr, 131

    Fixed effects:
                 Estimate Std. Error        df t value Pr(>|t|)    
    (Intercept) 4.061e+01  3.069e-01 1.203e+02  132.34   <2e-16 ***
    iq_cgm      2.488e+00  7.005e-02 2.276e+03   35.52   <2e-16 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Correlation of Fixed Effects:
           (Intr)
    iq_cgm 0.018 

``` r
parameters(model_cgm_only)
```

    # Fixed Effects

    Parameter   | Coefficient |   SE |         95% CI | t(2283) |      p
    --------------------------------------------------------------------
    (Intercept) |       40.61 | 0.31 | [40.01, 41.21] |  132.34 | < .001
    iq cgm      |        2.49 | 0.07 | [ 2.35,  2.63] |   35.52 | < .001

    # Random Effects

    Parameter                | Coefficient
    --------------------------------------
    SD (Intercept: schoolnr) |        3.08
    SD (Residual)            |        6.50

**Interpretation:**

- The coefficient for `iq_cgm` is 2.49—identical to the uncentered
  model. Grand mean centering alone does not disaggregate the effects;
  it only shifts the location of the intercept.
- The intercept is now the predicted language score for a student with
  average IQ (since `iq_cgm = 0`), which is more interpretable: 4.61

#### Model 2b: Grand Mean Centering + Group Mean

To actually separate the within and contextual effects, we add the
school mean (`iq_mean`) as a level-2 predictor.

``` r
model_cgm_full <- lmer(langpost ~ 1 + iq_cgm + iq_mean + (1 | schoolnr),
                       data = SB, REML = FALSE)

summary(model_cgm_full)
```

    Linear mixed model fit by maximum likelihood . t-tests use Satterthwaite's
      method [lmerModLmerTest]
    Formula: langpost ~ 1 + iq_cgm + iq_mean + (1 | schoolnr)
       Data: SB

          AIC       BIC    logLik -2*log(L)  df.resid 
      15237.5   15266.2   -7613.8   15227.5      2282 

    Scaled residuals: 
        Min      1Q  Median      3Q     Max 
    -4.1338 -0.6428  0.0607  0.7024  3.1563 

    Random effects:
     Groups   Name        Variance Std.Dev.
     schoolnr (Intercept)  7.729   2.780   
     Residual             42.152   6.492   
    Number of obs: 2287, groups:  schoolnr, 131

    Fixed effects:
                 Estimate Std. Error        df t value Pr(>|t|)    
    (Intercept) 2.194e+01  3.690e+00 1.788e+02   5.946 1.41e-08 ***
    iq_cgm      2.415e+00  7.166e-02 2.155e+03  33.698  < 2e-16 ***
    iq_mean     1.589e+00  3.127e-01 1.763e+02   5.079 9.59e-07 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Correlation of Fixed Effects:
            (Intr) iq_cgm
    iq_cgm   0.230       
    iq_mean -0.997 -0.229

``` r
parameters(model_cgm_full)
```

    # Fixed Effects

    Parameter   | Coefficient |   SE |         95% CI | t(2282) |      p
    --------------------------------------------------------------------
    (Intercept) |       21.94 | 3.69 | [14.71, 29.18] |    5.95 | < .001
    iq cgm      |        2.41 | 0.07 | [ 2.27,  2.56] |   33.70 | < .001
    iq mean     |        1.59 | 0.31 | [ 0.98,  2.20] |    5.08 | < .001

    # Random Effects

    Parameter                | Coefficient
    --------------------------------------
    SD (Intercept: schoolnr) |        2.78
    SD (Residual)            |        6.49

**Explanation of Syntax:**

- `langpost ~ 1 + iq_cgm + iq_mean`: This specifies the fixed part of
  the model. We include an intercept (1), the grand-mean centered
  predictor, and the school-level mean.
- `(1 | schoolnr)`: This is the random part, specifying a random
  intercept for each school. The slopes are fixed in this example for
  simplicity.
- `REML = FALSE`: We use Maximum Likelihood (ML) estimation to allow for
  model comparisons later. For final inference, Restricted Maximum
  Likelihood (REML) is generally preferred.

**Interpretation of Fixed Effects:**

- Intercept ($\gamma_{00}$): The estimated math achievement for a
  student with an average IQ (since `iq_cgm = 0`) in a school with an
  average IQ (`iq_mean` is not centered yet). This intercept is not as
  clean as it could be because `iq_mean` is not centered.
- iq_cgm ($\gamma_{10}$): This is the within-school effect. For students
  in the same school, a one-unit increase in a student’s IQ relative to
  the grand mean is associated with a 2.41-point increase in their
  language score. Because we have included `iq_mean`, this coefficient
  is a “pure” estimate of the within-school effect (Enders & Tofighi,
  2007).
- iq_mean ($\gamma_{01}$): This is the contextual effect. For two
  students with the same IQ (`iq_cgm` is held constant), a one-unit
  increase in their school’s average IQ is associated with a 1.59-point
  increase in their language score. This represents the added benefit of
  being in a higher-IQ school, above and beyond one’s own IQ.

To get the between-school effect (the effect of a school’s average IQ on
school-average achievement), we would add the within and contextual
effects: $\gamma_{10} + \gamma_{01}$. For our model, this is 4.

### Group Mean Centering

Group Mean Centering (CWC) – also known as Centering Within Cluster –
involves subtracting the cluster mean from each observation. The
centered variable is created as:

$$ \text{iq\_cwc}_{ij} = \text{iq\_verb}_{ij} - \bar{x}_{.j} $$

where $\bar{x}_{.j}$ is the mean of `iq_verb` for school $j$.

``` r
# Create the group-mean centered variable using the pre-calculated school means
SB$iq_cwc <- SB$iq_verb - SB$iq_mean

# Verify that the mean of the new variable is zero for each school
SB %>%
  group_by(schoolnr) %>%
  summarise(mean_cwc = mean(iq_cwc)) %>%
  pull(mean_cwc) %>%
  summary()
```

          Min.    1st Qu.     Median       Mean    3rd Qu.       Max. 
    -8.359e-16 -3.751e-16  0.000e+00  2.251e-17  4.100e-16  8.595e-16 

#### Model 3a: Group Mean Centering Only

This model includes only the group-mean centered predictor. Because all
between-school variance has been removed from `iq_cwc`, its coefficient
is a pure within-school effect, even without adding the group mean back
in.

``` r
model_cwc_only <- lmer(langpost ~ 1 + iq_cwc + (1 | schoolnr),
                       data = SB, REML = FALSE)

summary(model_cwc_only)
```

    Linear mixed model fit by maximum likelihood . t-tests use Satterthwaite's
      method [lmerModLmerTest]
    Formula: langpost ~ 1 + iq_cwc + (1 | schoolnr)
       Data: SB

          AIC       BIC    logLik -2*log(L)  df.resid 
      15351.4   15374.4   -7671.7   15343.4      2283 

    Scaled residuals: 
        Min      1Q  Median      3Q     Max 
    -4.0111 -0.6400  0.0600  0.7011  3.0117 

    Random effects:
     Groups   Name        Variance Std.Dev.
     schoolnr (Intercept) 21.94    4.684   
     Residual             42.24    6.499   
    Number of obs: 2287, groups:  schoolnr, 131

    Fixed effects:
                 Estimate Std. Error        df t value Pr(>|t|)    
    (Intercept) 4.029e+01  4.356e-01 1.200e+02   92.49   <2e-16 ***
    iq_cwc      2.415e+00  7.173e-02 2.145e+03   33.66   <2e-16 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Correlation of Fixed Effects:
           (Intr)
    iq_cwc 0.000 

``` r
parameters(model_cwc_only)
```

    # Fixed Effects

    Parameter   | Coefficient |   SE |         95% CI | t(2283) |      p
    --------------------------------------------------------------------
    (Intercept) |       40.29 | 0.44 | [39.43, 41.14] |   92.49 | < .001
    iq cwc      |        2.41 | 0.07 | [ 2.27,  2.56] |   33.66 | < .001

    # Random Effects

    Parameter                | Coefficient
    --------------------------------------
    SD (Intercept: schoolnr) |        4.68
    SD (Residual)            |        6.50

**Interpretation:**

- iq_cwc ($\gamma_{10}$): This is a pure estimate of the within-school
  effect. For students in the same school, a one-unit increase in a
  student’s IQ relative to their school’s average is associated with a
  2.41-point increase in their language score. This is the same
  within-effect we got from the full CGM model.
- The intercept is the predicted language score for a student at their
  school’s average IQ.

#### Model 3b: Group Mean Centering + Group Mean

To also obtain the between-school effect, we add the school mean
(`iq_mean`) as a level-2 predictor.

``` r
model_cwc_full <- lmer(langpost ~ 1 + iq_cwc + iq_mean + (1 | schoolnr),
                       data = SB, REML = FALSE)

summary(model_cwc_full)
```

    Linear mixed model fit by maximum likelihood . t-tests use Satterthwaite's
      method [lmerModLmerTest]
    Formula: langpost ~ 1 + iq_cwc + iq_mean + (1 | schoolnr)
       Data: SB

          AIC       BIC    logLik -2*log(L)  df.resid 
      15237.5   15266.2   -7613.8   15227.5      2282 

    Scaled residuals: 
        Min      1Q  Median      3Q     Max 
    -4.1338 -0.6428  0.0607  0.7024  3.1563 

    Random effects:
     Groups   Name        Variance Std.Dev.
     schoolnr (Intercept)  7.729   2.780   
     Residual             42.152   6.492   
    Number of obs: 2287, groups:  schoolnr, 131

    Fixed effects:
                  Estimate Std. Error         df t value Pr(>|t|)    
    (Intercept)   -6.63310    3.59159  160.55644  -1.847   0.0666 .  
    iq_cwc         2.41477    0.07166 2154.91780  33.698   <2e-16 ***
    iq_mean        4.00330    0.30443  158.45465  13.150   <2e-16 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Correlation of Fixed Effects:
            (Intr) iq_cwc
    iq_cwc   0.000       
    iq_mean -0.997  0.000

``` r
parameters(model_cwc_full)
```

    # Fixed Effects

    Parameter   | Coefficient |   SE |         95% CI | t(2282) |      p
    --------------------------------------------------------------------
    (Intercept) |       -6.63 | 3.59 | [-13.68, 0.41] |   -1.85 | 0.065 
    iq cwc      |        2.41 | 0.07 | [  2.27, 2.56] |   33.70 | < .001
    iq mean     |        4.00 | 0.30 | [  3.41, 4.60] |   13.15 | < .001

    # Random Effects

    Parameter                | Coefficient
    --------------------------------------
    SD (Intercept: schoolnr) |        2.78
    SD (Residual)            |        6.49

**Interpretation of Fixed Effects:**

- Intercept ($\gamma_{00}$): The estimated math achievement for a
  student with an IQ equal to their school’s average (since
  `iq_cwc = 0`), in a school with an average IQ (`iq_mean = 0`? Again,
  not centered). This is the unadjusted mean for an average school.
  - iq_cwc ($\gamma_{10}$): This remains the pure within-school effect,
    unchanged from Model 3a.
  - iq_mean ($\gamma_{01}$): This is the between-school effect. A
    one-unit increase in a school’s average IQ is associated with a
    4-point increase in a student’s predicted language score (for a
    student at their school’s average IQ, where `iq_cwc = 0`).

To get the contextual effect from this model, we subtract the within
effect from the between effect: $\gamma_{01} - \gamma_{10}$. For our
model, this is 1.59, which should match the contextual effect from the
full CGM model.

### The Fully Centered Model (CWC + Centered Group Mean)

In the previous models, the intercept’s interpretation is still slightly
awkward because the level-2 predictor (`iq_mean`) is not centered. To
make the intercept maximally interpretable (i.e., the expected outcome
for a student with average IQ in a school of average IQ), we can also
center the group means at their grand mean.

**Centering the Group Means**

This is a form of centering at level-2. We create a new variable,
iq_mean_c, by subtracting the grand mean of the school means from each
school’s mean.

``` r
# Calculate the grand mean of the school means
grand_mean_schools <- mean(SB$iq_mean)

# Create the centered school mean variable
SB$iq_mean_c <- SB$iq_mean - grand_mean_schools

# Verify its mean is zero
mean(SB$iq_mean_c)
```

    [1] 2.294887e-18

#### Model 4: The Final Model

We now fit the “fully centered” model with the group-mean centered
predictor (`iq_cwc`) at level-1 and the centered school mean
(`iq_mean_c`) at level-2.

``` r
model_final <- lmer(langpost ~ 1 + iq_cwc + iq_mean_c + (1 | schoolnr),
                    data = SB, REML = FALSE)

summary(model_final)
```

    Linear mixed model fit by maximum likelihood . t-tests use Satterthwaite's
      method [lmerModLmerTest]
    Formula: langpost ~ 1 + iq_cwc + iq_mean_c + (1 | schoolnr)
       Data: SB

          AIC       BIC    logLik -2*log(L)  df.resid 
      15237.5   15266.2   -7613.8   15227.5      2282 

    Scaled residuals: 
        Min      1Q  Median      3Q     Max 
    -4.1338 -0.6428  0.0607  0.7024  3.1563 

    Random effects:
     Groups   Name        Variance Std.Dev.
     schoolnr (Intercept)  7.729   2.780   
     Residual             42.152   6.492   
    Number of obs: 2287, groups:  schoolnr, 131

    Fixed effects:
                 Estimate Std. Error        df t value Pr(>|t|)    
    (Intercept) 4.074e+01  2.844e-01 1.242e+02  143.25   <2e-16 ***
    iq_cwc      2.415e+00  7.166e-02 2.155e+03   33.70   <2e-16 ***
    iq_mean_c   4.003e+00  3.044e-01 1.585e+02   13.15   <2e-16 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Correlation of Fixed Effects:
              (Intr) iq_cwc
    iq_cwc    0.000        
    iq_mean_c 0.078  0.000 

``` r
parameters(model_final)
```

    # Fixed Effects

    Parameter   | Coefficient |   SE |         95% CI | t(2282) |      p
    --------------------------------------------------------------------
    (Intercept) |       40.74 | 0.28 | [40.18, 41.30] |  143.25 | < .001
    iq cwc      |        2.41 | 0.07 | [ 2.27,  2.56] |   33.70 | < .001
    iq mean c   |        4.00 | 0.30 | [ 3.41,  4.60] |   13.15 | < .001

    # Random Effects

    Parameter                | Coefficient
    --------------------------------------
    SD (Intercept: schoolnr) |        2.78
    SD (Residual)            |        6.49

##### Detailed Interpretation of Final Model Results

The `parameters(model_final)` output provides the parameter estimates
for our fully centered multilevel model. This model includes:

- **Level-1**: Group-mean centered IQ (`iq_cwc`), representing each
  student’s deviation from their school’s average IQ
- **Level-2**: Centered school mean IQ (`iq_mean_c`), representing each
  school’s deviation from the overall average school IQ
- **Random intercept** for schools (`(1 | schoolnr)`), allowing each
  school to have its own baseline language score

###### Fixed Effects

The fixed effects describe the average relationships in the population.

| Parameter       | Coefficient |  SE  |      95% CI      | t-value | p-value |
|:----------------|:-----------:|:----:|:----------------:|:-------:|:-------:|
| **(Intercept)** |    40.74    | 0.28 | \[40.18, 41.30\] | 143.25  | \< .001 |
| **iq cwc**      |    2.41     | 0.07 |  \[2.27, 2.56\]  |  33.70  | \< .001 |
| **iq mean c**   |    4.00     | 0.30 |  \[3.41, 4.60\]  |  13.15  | \< .001 |

###### Intercept ($\gamma_{00} = 40.74$)

The intercept represents the predicted language score for a student
with:

- An IQ equal to their school’s average (`iq_cwc = 0`)
- Attending a school with the overall average IQ (`iq_mean_c = 0`)

In substantive terms, a typical student (average IQ relative to their
school) in a typical school (average school IQ) is predicted to have a
language score of **40.74**. This is a highly interpretable baseline
value.

###### iq cwc ($\gamma_{10} = 2.41$)

This is the **within-school effect** of IQ. For students in the same
school, a one-point increase in a student’s IQ relative to their
school’s average is associated with a **2.41-point increase** in their
predicted language score.

- **Interpretation**: Within any given school, students with higher IQ
  than their schoolmates tend to have higher language scores. For every
  point a student’s IQ exceeds their school’s average, their language
  score is expected to be 2.41 points higher.
- **Statistical significance**: The effect is significant ($p < .001$),
  and the 95% confidence interval \[2.27, 2.56\] does not include zero.

###### iq mean c ($\gamma_{01} = 4.00$)

This is the **between-school effect** of IQ. A one-point increase in a
school’s average IQ (compared to the overall average) is associated with
a **4.00-point increase** in the predicted language score for a student
at that school’s average IQ.

- **Interpretation**: Schools with higher average IQ tend to have higher
  average language scores. For a student whose IQ is at their school’s
  average, attending a school with an average IQ one point higher than
  the typical school is associated with a 4.00-point higher language
  score.
- **Statistical significance**: The effect is significant ($p < .001$),
  with a 95% confidence interval \[3.41, 4.60\].
- **Comparison with within effect**: The between-school effect (4.00) is
  substantially larger than the within-school effect (2.41), suggesting
  that school-level factors associated with average IQ have a stronger
  impact than individual-level IQ differences within schools.

###### Contextual Effect

The contextual effect (the effect of school average IQ above and beyond
individual IQ) can be calculated as:

$$ 
\text{Contextual Effect} = \gamma_{01} - \gamma_{10} = 4.00 - 2.41 = 1.59 
$$

This means that for two students with the same individual IQ, the one
attending a school with an average IQ one point higher is predicted to
score **1.59 points higher** on the language test. This represents the
pure contextual benefit of being in a higher-IQ school environment.

###### Random Effects

The random effects describe the variance components – how much schools
and students vary around the fixed effects.

| Parameter                    |  SD  | Variance (SD²) |
|:-----------------------------|:----:|:--------------:|
| **SD (Intercept: schoolnr)** | 2.78 |      7.73      |
| **SD (Residual)**            | 6.49 |     42.12      |

###### SD (Intercept: schoolnr) = 2.78

This is the standard deviation of school intercepts around the fixed
intercept. After controlling for school-average IQ, schools still vary
in their adjusted mean language scores.

- **Interpretation**: The intercepts for different schools (their
  baseline language scores after accounting for IQ) are normally
  distributed with a standard deviation of 2.78.
- **Practical meaning**: About 95% of schools have adjusted mean
  language scores within approximately ±1.96 × 2.78 = ±5.45 points of
  the fixed intercept (40.74). This means school means range from about
  35.29 to 46.19 after controlling for IQ.
- **Substantive implication**: Even after accounting for IQ differences,
  substantial between-school variation remains – other school-level
  factors (teaching quality, resources, etc.) likely contribute to these
  differences.

###### SD (Residual) = 6.49

This is the standard deviation of the level-1 residuals – the
within-school variation among students after accounting for IQ.

- **Interpretation**: Students’ observed language scores deviate from
  their school’s predicted line with a standard deviation of 6.49
  points.
- **Practical meaning**: About 95% of students have residuals within
  ±1.96 × 6.49 = ±12.72 points of their predicted score. This represents
  the unexplained within-school variation.
- **Substantive implication**: Considerable individual differences
  remain unexplained – other student-level factors (motivation, prior
  achievement, family background) likely contribute to these
  differences.

### Variance Partitioning

The total variance in language scores can be estimated from the random
effects:

- **Between-school variance** = (2.78)² = 7.73
- **Within-school variance** = (6.49)² = 42.12
- **Total variance** = 7.73 + 42.12 = 49.85

The intraclass correlation (ICC) – the proportion of total variance that
is between schools – is:

$$ 
\text{ICC} = \frac{7.73}{49.85} = 0.155 
$$

About **15.5%** of the variance in language scores is between schools,
with the remaining 84.5% within schools. This confirms that most of the
variation is at the student level, but school differences are still
meaningful.

### Summary Table for Interpretation

| Parameter | Estimate | Interpretation |
|:---|:--:|:---|
| **Intercept (γ₀₀)** | 40.74 | Predicted language score for an average student (at school mean IQ) in an average school (at overall mean school IQ). |
| **Within-school IQ (γ₁₀)** | 2.41 | For students in the same school, a 1-point higher IQ (relative to school mean) predicts 2.41-point higher language score. |
| **Between-school IQ (γ₀₁)** | 4.00 | For a student at their school’s mean IQ, attending a school with 1-point higher average IQ predicts 4.00-point higher language score. |
| **Contextual effect** | 1.59 | Net benefit of being in a higher-IQ school, holding individual IQ constant. |
| **School SD (τ₀₀)** | 2.78 | Schools vary around the intercept with SD of 2.78 (95% of schools within ±5.45 points). |
| **Residual SD (σ)** | 6.49 | Students vary around their school’s predicted line with SD of 6.49 (95% within ±12.72 points). |
| **ICC** | 0.155 | 15.5% of total variance is between schools; 84.5% is within schools. |

### Conclusions from the Final Model

1.  **IQ matters both within and between schools**: Both individual IQ
    relative to schoolmates (γ₁₀ = 2.41) and school-average IQ (γ₀₁ =
    4.00) are strong, significant predictors of language achievement.

2.  **Context matters**: The contextual effect of 1.59 confirms that
    school-level IQ has an effect above and beyond individual IQ –
    consistent with “peer effects” or school environment influences.

3.  **Most variance is within schools**: With an ICC of 0.155, the
    majority of variation in language scores is at the student level,
    but school differences are still substantial and meaningful.

4.  **Substantial unexplained variance remains**: Both within-school (SD
    = 6.49) and between-school (SD = 2.78) residual variance indicate
    that additional predictors at both levels could improve the model.

5.  **The model successfully disaggregates effects**: By using
    group-mean centering and including the centered school mean, we have
    cleanly separated within-school and between-school effects,
    providing clear, interpretable estimates for each.

### Summary of Model Results

| Model | Intercept | Level-1 Slope | Level-2 Slope | Interpretation of Level-1 Slope |
|:---|:---|:---|:---|:---|
| **Uncentered** | 11.17 | 2.49 | \- | Conflated (uninterpretable) |
| **CGM Only** | 40.61 | 2.49 | \- | Still conflated (no level-2 control) |
| **CGM Full** | 21.94 | 2.41 | 1.59 | Within effect (with `iq_mean` control) |
| **CWC Only** | 40.29 | 2.41 | \- | Pure within effect |
| **CWC Full** | -6.63 | 2.41 | 4.00 | Within + between effects |
| **Final (Centered Means)** | 40.74 | 2.41 | 4.00 | Within + between, with clean intercept |

Notice that the within-effect from the CWC models (2.41) is different
from the within-effect derived from the CGM models (2.49). This is
because the CGM within-effect is conditional on controlling for the
school mean, while the CWC within-effect is unconditional. They
represent the same underlying relationship but in slightly different
parameterizations. The between-effect (4.00) and the contextual effect
(calculated as 4.00 - 2.41 = 1.59) are consistent across models.

### Effect Size Measures

We can now compare the effect sizes across these different models.

#### Using the `performance` package

The `r2()` function provides marginal (fixed effects only) and
conditional (fixed + random effects) $R^2$.

``` r
r2(model_uncentered)
```

    # R2 for Mixed Models

      Conditional R2: 0.460
         Marginal R2: 0.339

``` r
r2(model_cgm_only)
```

    # R2 for Mixed Models

      Conditional R2: 0.460
         Marginal R2: 0.339

``` r
r2(model_cgm_full)
```

    # R2 for Mixed Models

      Conditional R2: 0.485
         Marginal R2: 0.391

``` r
r2(model_cwc_only)
```

    # R2 for Mixed Models

      Conditional R2: 0.504
         Marginal R2: 0.246

``` r
r2(model_cwc_full)
```

    # R2 for Mixed Models

      Conditional R2: 0.485
         Marginal R2: 0.391

``` r
r2(model_final)
```

    # R2 for Mixed Models

      Conditional R2: 0.485
         Marginal R2: 0.391

You will notice that `model_uncentered` and `model_cgm_only` have the
same marginal and conditional $R^2$. `model_cwc_only` has a different
$R^2$ because it is a different model (it excludes the between-school
variance from the predictor). `model_cgm_full`, `model_cwc_full`, and
`model_final` all have the same $R^2$, as they are statistically
equivalent; centering simply reparameterizes them without changing the
overall model fit.

#### Using the `r2mlm` package

The `r2mlm()` function provides a much more detailed decomposition.
We’ll run it on the final model.

``` r
r2mlm(model_final)
```

![](16_1_MLM_centering_files/figure-commonmark/unnamed-chunk-12-1.png)

    $Decompositions
                         total    within   between
    fixed, within   0.25576201 0.3318867        NA
    fixed, between  0.13496108        NA 0.5884001
    slope variation 0.00000000 0.0000000        NA
    mean variation  0.09440848        NA 0.4115999
    sigma2          0.51486842 0.6681133        NA

    $R2s
             total    within   between
    f1  0.25576201 0.3318867        NA
    f2  0.13496108        NA 0.5884001
    v   0.00000000 0.0000000        NA
    m   0.09440848        NA 0.4115999
    f   0.39072309        NA        NA
    fv  0.39072309 0.3318867        NA
    fvm 0.48513158        NA        NA

##### Detailed Explanation of `r2mlm()` Output

The `r2mlm()` function from the `r2mlm` package provides a comprehensive
decomposition of variance explained in multilevel models, following the
framework developed by Rights & Sterba (2019). The output is divided
into two main sections: `$Decompositions` and `$R2s`.

###### 1. `$Decompositions` – Variance Components

This table shows the proportion of variance in the outcome variable
(`langpost`) attributable to different sources. The columns represent:

- **total**: Proportion of the *total* outcome variance (sum of
  within-cluster and between-cluster variance).
- **within**: Proportion of the *within-cluster* variance only (variance
  among students within the same school).
- **between**: Proportion of the *between-cluster* variance only
  (variance among school means).

The rows represent different sources of variance:

- **fixed, within**: Variance explained by the fixed effect of the
  level-1 predictor (`iq_cwc`). This is the variance attributable to
  students’ deviations from their school’s mean IQ.
- **fixed, between**: Variance explained by the fixed effect of the
  level-2 predictor (`iq_mean_c`). This is the variance attributable to
  differences in average IQ between schools.
- **slope variation**: Variance explained by random slopes. In this
  model, the slope is fixed, so this is zero.
- **mean variation**: Variance explained by random intercepts
  (between-school differences in mean achievement after accounting for
  predictors).
- **sigma2**: Unexplained residual variance at level-1 (within schools).

###### Interpreting the Numbers:

| Source | Total | Within | Between | Interpretation |
|:---|:--:|:--:|:--:|:---|
| **fixed, within** | 0.256 | 0.332 | NA | 25.6% of total variance is explained by within-school IQ differences. Within schools, 33.2% of the within-school variance is explained by IQ. |
| **fixed, between** | 0.135 | NA | 0.588 | 13.5% of total variance is explained by between-school IQ differences. Between schools, 58.8% of the between-school variance is explained by average IQ. |
| **mean variation** | 0.094 | NA | 0.412 | 9.4% of total variance is due to remaining between-school differences (random intercepts) after controlling for IQ. Between schools, 41.2% of the between-school variance remains unexplained. |
| **sigma2** | 0.515 | 0.668 | NA | 51.5% of total variance is unexplained within-school variance. Within schools, 66.8% of the within-school variance remains unexplained. |

**Check**: The total column sums to 1.00 (0.256 + 0.135 + 0.094 + 0.515
= 1.00), confirming that all variance is accounted for.

###### 2. `$R2s` – R-Squared Measures

This table provides various R² measures, each representing the
proportion of variance explained by different combinations of
predictors. The notation follows Rights & Sterba (2019):

- **f1**: Variance explained by level-1 predictors via *fixed slopes*
  (within effect).
- **f2**: Variance explained by level-2 predictors via *fixed slopes*
  (between effect).
- **v**: Variance explained by *random slope variation* (here zero
  because slopes are fixed).
- **m**: Variance explained by *random intercept variation*
  (between-school differences after controlling for predictors).
- **f**: Variance explained by *all fixed effects* (f1 + f2).
- **fv**: Variance explained by *fixed effects + random slope variation*
  (f + v).
- **fvm**: Variance explained by *fixed effects + random slope
  variation + random intercept variation* (f + v + m) – this is the
  *conditional* R².

###### Interpreting the Numbers:

| Measure | Total | Within | Between | Interpretation |
|:---|:--:|:--:|:--:|:---|
| **f1** | 0.256 | 0.332 | NA | The within-school IQ effect explains 25.6% of total variance and 33.2% of within-school variance. |
| **f2** | 0.135 | NA | 0.588 | The between-school IQ effect explains 13.5% of total variance and 58.8% of between-school variance. |
| **v** | 0.000 | 0.000 | NA | No variance is explained by random slope variation (slopes are fixed). |
| **m** | 0.094 | NA | 0.412 | Remaining between-school differences explain 9.4% of total variance and 41.2% of between-school variance. |
| **f** | 0.391 | NA | NA | All fixed effects together explain 39.1% of total variance. |
| **fv** | 0.391 | 0.332 | NA | Fixed effects + random slopes (same as f because v=0) explain 39.1% of total variance and 33.2% of within variance. |
| **fvm** | 0.485 | NA | NA | The full model (fixed effects + random intercepts) explains 48.5% of total variance. This is the *conditional R²*. |

##### Key Takeaways from This Output:

1.  **Within-school IQ is a strong predictor**: It explains 25.6% of
    total variance and 33.2% of within-school variance.
2.  **Between-school IQ is even stronger at the school level**: It
    explains 58.8% of between-school variance, but only 13.5% of total
    variance because between-school variance is a smaller portion of the
    total.
3.  **Substantial unexplained variance remains**: 51.5% of total
    variance (and 66.8% of within-school variance) is unexplained –
    there are other student-level factors not in the model.
4.  **School differences persist after controlling for IQ**: Random
    intercepts explain 9.4% of total variance and 41.2% of
    between-school variance, meaning schools differ in ways not captured
    by average IQ.
5.  **Total model performance**: The conditional R² (fvm) of 0.485
    indicates that the full model explains 48.5% of the total variance
    in language scores.

### Summary of Interpretations and Recommendations

| Centering Strategy | Model | $\gamma_{10}$ (Level-1 Slope) | $\gamma_{01}$ (Level-2 Slope) | Intercept |
|:---|:---|:---|:---|:---|
| **Uncentered** | Baseline | Conflated | N/A | Predicted outcome when `iq_verb` = 0. (Often meaningless) |
| **CGM** | Only | Conflated | N/A | Predicted outcome for student with avg. IQ. |
|  | Full | Within Effect | Contextual Effect | Predicted outcome for avg. IQ student in school with `iq_mean`=0. |
| **CWC** | Only | Within Effect | N/A | Predicted outcome for student at school’s avg. IQ. |
|  | Full | Within Effect | Between Effect | Predicted outcome for student at school’s avg. IQ in school with `iq_mean`=0. |
| **CWC + Centered Means** | Final | Within Effect | Between Effect | Predicted outcome for student at school’s avg. IQ in school with avg. IQ. |

Recommendations:

- **If your primary interest is a Level-1 predictor**, use Group Mean
  Centering (CWC). It provides an unbiased estimate of the
  within-cluster effect and more accurate variance components
  (Raudenbush & Bryk, 2002). You must include the cluster mean as a
  level-2 predictor to avoid conflating the effect and to obtain the
  between effect.
- **If your primary interest is a Level-2 predictor**, and you have
  Level-1 covariates you need to control for, Grand Mean Centering (CGM)
  is often preferred. It effectively partials out the Level-1 covariate,
  providing a clean estimate of the level-2 effect (Enders & Tofighi,
  2007).
- **If you are interested in both within and between effects**, or
  testing contextual hypotheses, use either CGM or CWC with the cluster
  mean included. Both models will allow you to derive the same three
  effects (within, between, contextual). For the most interpretable
  intercept, also center your level-2 predictors (cluster means) at
  their grand mean.
- **For a clean, fully disaggregated model**, always include the cluster
  mean of your Level-1 predictor in the Level-2 model. This separates
  the variance and prevents your Level-1 coefficient from being
  “smeared” with Level-2 variance.

### References

- Aiken, L. S., & West, S. G. (1991). Multiple regression: Testing and
  interpreting interactions. Sage.
- Enders, C. K., & Tofighi, D. (2007). Centering predictor variables in
  cross-sectional multilevel models: A new look at an old issue.
  Psychological Methods, 12(2), 121–138.
- Hoffman, L., & Walters, R. W. (2022). Catching up on multilevel
  modeling. Annual Review of Psychology, 73, 659-689.
- Hox, J. J., Moerbeek, M., & van de Schoot, R. (2018). Multilevel
  analysis: Techniques and applications (3rd ed.). Routledge.
- Preacher, K. J., Zyphur, M. J., & Zhang, Z. (2010). A general
  multilevel SEM framework for assessing multilevel mediation.
  Psychological Methods, 15(3), 209–233.
- Raudenbush, S. W., & Bryk, A. S. (2002). Hierarchical linear models:
  Applications and data analysis methods (2nd ed.). Sage.
- Rights, J. D., & Sterba, S. K. (2019). Quantifying explained variance
  in multilevel models: An integrative framework for defining R-squared
  measures. Psychological Methods, 24(3), 309–338.
- Snijders, T. A. B., & Bosker, R. J. (2012). Multilevel analysis: An
  introduction to basic and advanced multilevel modeling (2nd ed.).
  Sage.
- Wu, Y.-W. B., & Wooldridge, P. J. (2005). The impact of centering
  first-level predictors on individual and contextual effects in
  multilevel data analysis. Nursing Research, 54(3), 212-216.
