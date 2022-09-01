Descriptive Statistics
================
Mauricio Garnier-Villarreal, Joris M. Schröder & Joseph Charles Van
Matre
01 September, 2022

-   <a href="#setup-the-r-session" id="toc-setup-the-r-session">Setup the R
    session</a>
-   <a href="#import-the-data-set" id="toc-import-the-data-set">Import the
    data set</a>
    -   <a href="#select-variables-of-interest"
        id="toc-select-variables-of-interest">Select variables of interest</a>
-   <a href="#continuous-items" id="toc-continuous-items">Continuous
    items</a>
    -   <a href="#descritive-for-multiple-groups"
        id="toc-descritive-for-multiple-groups">Descritive for multiple
        groups</a>
-   <a href="#categorical-items" id="toc-categorical-items">Categorical
    items</a>
    -   <a href="#frequency-tables" id="toc-frequency-tables">Frequency
        tables</a>
    -   <a href="#cross-tables" id="toc-cross-tables">Cross-tables</a>
-   <a href="#data-frame-summary" id="toc-data-frame-summary">Data frame
    Summary</a>

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
library(summarytools)
```

# Import the data set

Here we will be importing the `.sav` WVS data set

``` r
dat <- import("WVS_Cross-National_Wave_7_sav_v2_0.sav")
dim(dat)
```

    ## [1] 76897   548

Here we are calling our data set **dat** and asking to see the dimension
of it. We see that the data set has 76897 subjects, and 548 columns.

## Select variables of interest

In cases with large data sets like this we might want to select a subset
of variables that we want to work with. Since it is not easy to see 548
variables.

``` r
vars <- c("Q275", "Q260", "Q262", "Y001", "B_COUNTRY_ALPHA", "SACSECVAL")
dat2 <- dat[,vars]
dim(dat2)
```

    ## [1] 76897     6

``` r
head(dat2)
```

    ##   Q275 Q260 Q262 Y001 B_COUNTRY_ALPHA SACSECVAL
    ## 1    3    2   60    0             AND  0.287062
    ## 2    7    1   47    2             AND  0.467525
    ## 3    7    1   48    4             AND  0.425304
    ## 4    2    2   62    2             AND  0.556170
    ## 5    2    1   49    1             AND  0.458949
    ## 6    1    2   51    3             AND  0.210111

Here we are first creating a vector with the variable names for the ones
I want to keep. You can see all variable names for the full data set as
well:

``` r
colnames(dat)
```

After identifying which variables we will work with, we create a new
data set **dat2** with only these 7 variables, and make sure we did it
correctly by looking at the the dimension of the data **dim(dat2)**. We
also look at the first 6 rows: **head(dat2)**. These are quick checks
that we have created the new data correctly.

# Continuous items

When talking about descriptive statistics, we first need to know what
type of variable each item is. For continuous items, the type of
descriptive statistics we present are related to central tendency and
variability measures. We will use the `descr()` function from the
`summarytools` package.

Be aware that this function will give you resutls if you use them with
categorical variables, but these would not be meaningful.

From the selected variables the only ones that are truly continuous are
*age*

``` r
attributes(dat2$Q262)
```

    ## $label
    ## [1] "Age"
    ## 
    ## $format.spss
    ## [1] "F3.0"
    ## 
    ## $labels
    ## Other missing; Multiple answers Mail (EVS) 
    ##                                         -5 
    ##                                  Not asked 
    ##                                         -4 
    ##                                  No answer 
    ##                                         -2 
    ##                                 Don't know 
    ##                                         -1

and *Secular values*

``` r
attributes(dat2$SACSECVAL)
```

    ## $label
    ## [1] "SACSECVAL.- Welzel Overall Secular Values"
    ## 
    ## $format.spss
    ## [1] "F9.6"
    ## 
    ## $labels
    ## Missing 
    ##     -99

For their descriptive statistics, we just need to identify the data set,
and specify only the continuous items.

``` r
descr(dat2[,c("SACSECVAL","Q262")])
```

    ## Descriptive Statistics  
    ## dat2  
    ## N: 76897  
    ## 
    ##                         Q262   SACSECVAL
    ## ----------------- ---------- -----------
    ##              Mean      43.02        0.36
    ##           Std.Dev      16.37        0.18
    ##               Min      16.00        0.00
    ##                Q1      29.00        0.23
    ##            Median      41.00        0.36
    ##                Q3      55.00        0.48
    ##               Max     103.00        1.00
    ##               MAD      19.27        0.19
    ##               IQR      26.00        0.25
    ##                CV       0.38        0.48
    ##          Skewness       0.40        0.26
    ##       SE.Skewness       0.01        0.01
    ##          Kurtosis      -0.69       -0.43
    ##           N.Valid   76579.00    76635.00
    ##         Pct.Valid      99.59       99.66

This function provides a lot of useful information. The *N.valid* is the
total non missing answers for each variable, follow by a series of
descriptive statistics like the *Mean*, *standard deviation*, *median*,
*minimum*, *maximum*, and others. You can also transpose the table,
depending on which direction you prefer the table

``` r
descr(dat2[,c("SACSECVAL","Q262")], transpose = T)
```

    ## Descriptive Statistics  
    ## dat2  
    ## N: 76897  
    ## 
    ##                    Mean   Std.Dev     Min      Q1   Median      Q3      Max     MAD     IQR     CV
    ## --------------- ------- --------- ------- ------- -------- ------- -------- ------- ------- ------
    ##            Q262   43.02     16.37   16.00   29.00    41.00   55.00   103.00   19.27   26.00   0.38
    ##       SACSECVAL    0.36      0.18    0.00    0.23     0.36    0.48     1.00    0.19    0.25   0.48
    ## 
    ## Table: Table continues below
    ## 
    ##  
    ## 
    ##                   Skewness   SE.Skewness   Kurtosis    N.Valid   Pct.Valid
    ## --------------- ---------- ------------- ---------- ---------- -----------
    ##            Q262       0.40          0.01      -0.69   76579.00       99.59
    ##       SACSECVAL       0.26          0.01      -0.43   76635.00       99.66

You can save this information into a table object by putting it inside
the `tb()` function

``` r
desc1 <- tb(descr(dat2[,c("SACSECVAL","Q262")], 
                  transpose = T))
desc1
```

    ## # A tibble: 2 x 16
    ##   variable    mean     sd   min     q1    med     q3   max    mad    iqr    cv
    ##   <chr>      <dbl>  <dbl> <dbl>  <dbl>  <dbl>  <dbl> <dbl>  <dbl>  <dbl> <dbl>
    ## 1 Q262      43.0   16.4      16 29     41     55       103 19.3   26     0.381
    ## 2 SACSECVAL  0.361  0.175     0  0.234  0.359  0.484     1  0.185  0.250 0.484
    ## # ... with 5 more variables: skewness <dbl>, se.skewness <dbl>, kurtosis <dbl>,
    ## #   n.valid <dbl>, pct.valid <dbl>

## Descritive for multiple groups

We have already presented the basic descriptive information for
continuous variables. But a common next step is to evaluate these
descriptive information for multiple groups. We can do this with the
`stby()` function. In the first argument you specify the data set, with
all the continuous variables, in the INDICES argument you specify the
group variable.

``` r
stby(data = dat2[,c("SACSECVAL","Q262")], 
     INDICES   = dat2$Q260, 
     FUN = descr, 
     stats = "common", 
     transpose = TRUE)
```

    ## Descriptive Statistics  
    ## dat2  
    ## Group: Q260 = 1  
    ## N: 36556  
    ## 
    ##                    Mean   Std.Dev     Min   Median      Max    N.Valid   Pct.Valid
    ## --------------- ------- --------- ------- -------- -------- ---------- -----------
    ##            Q262   43.27     16.54   16.00    42.00   100.00   36460.00       99.74
    ##       SACSECVAL    0.37      0.18    0.00     0.36     1.00   36470.00       99.76
    ## 
    ## Group: Q260 = 2  
    ## N: 40290  
    ## 
    ##                    Mean   Std.Dev     Min   Median      Max    N.Valid   Pct.Valid
    ## --------------- ------- --------- ------- -------- -------- ---------- -----------
    ##            Q262   42.78     16.20   16.00    41.00   103.00   40100.00       99.53
    ##       SACSECVAL    0.36      0.17    0.00     0.35     0.97   40124.00       99.59

If you want to save this information as a matrix, to be able to
manipulate it or something else, it is best to export as a table with
the `tb()` function

``` r
desc2 <- tb(stby(data = dat2[,c("SACSECVAL","Q262")], 
     INDICES   = dat2$Q260, 
     FUN = descr, 
     stats = "common", 
     transpose = TRUE))
desc2
```

    ## # A tibble: 4 x 9
    ##   Q260  variable    mean     sd   min    med     max n.valid pct.valid
    ##   <fct> <chr>      <dbl>  <dbl> <dbl>  <dbl>   <dbl>   <dbl>     <dbl>
    ## 1 1     Q262      43.3   16.5      16 42     100       36460      99.7
    ## 2 1     SACSECVAL  0.366  0.180     0  0.36    1       36470      99.8
    ## 3 2     Q262      42.8   16.2      16 41     103       40100      99.5
    ## 4 2     SACSECVAL  0.357  0.170     0  0.346   0.972   40124      99.6

This was a simple example with descriptive across 2 groups, but you can
also estimate this for a large number of groups. For example, for across
all countries in the data set

``` r
desc_C <- tb(stby(data = dat2[,c("SACSECVAL","Q262")], 
     INDICES   = dat2$B_COUNTRY_ALPHA, 
     FUN = descr, 
     stats = "common", 
     transpose = TRUE))
desc_C
```

And if you want to go in more detail, you can estimate this across sex
and country. You can do this by expanding the INDICES argument, by
adding multiple variables as a list.

``` r
desc_SC <- tb(stby(data = dat2[,c("SACSECVAL","Q262")], 
     INDICES   = list(dat2$Q260,dat2$B_COUNTRY_ALPHA), 
     FUN = descr, 
     stats = "common", 
     transpose = TRUE))
desc_SC
```

# Categorical items

For categorical variables the *mean* and previously presented statistics
are not meaningful. We need to describe them in a different way. For
this we will use the `summarytools` package.

Of the categorical variables, we will focus on *education*

``` r
attributes(dat2$Q275)
```

    ## $label
    ## [1] "Highest educational level: Respondent [ISCED 2011]"
    ## 
    ## $format.spss
    ## [1] "F3.0"
    ## 
    ## $labels
    ##         Other missing; Multiple answers Mail (EVS) 
    ##                                                 -5 
    ##                                          Not asked 
    ##                                                 -4 
    ##                                          No answer 
    ##                                                 -2 
    ##                                         Don´t know 
    ##                                                 -1 
    ## Early childhood education (ISCED 0) / no education 
    ##                                                  0 
    ##                        Primary education (ISCED 1) 
    ##                                                  1 
    ##                Lower secondary education (ISCED 2) 
    ##                                                  2 
    ##                Upper secondary education (ISCED 3) 
    ##                                                  3 
    ##    Post-secondary non-tertiary education (ISCED 4) 
    ##                                                  4 
    ##           Short-cycle tertiary education (ISCED 5) 
    ##                                                  5 
    ##                   Bachelor or equivalent (ISCED 6) 
    ##                                                  6 
    ##                     Master or equivalent (ISCED 7) 
    ##                                                  7 
    ##                   Doctoral or equivalent (ISCED 8) 
    ##                                                  8 
    ##                                              Other 
    ##                                                  9

,*post-materialistic* index

``` r
attributes(dat2$Y001)
```

    ## $label
    ## [1] "Post-Materialist index 12-item"
    ## 
    ## $format.spss
    ## [1] "F2.0"
    ## 
    ## $labels
    ##       Not asked       No answer     Materialist               1               2 
    ##              -4              -2               0               1               2 
    ##               3               4 Postmaterialist 
    ##               3               4               5

and *sex*

``` r
attributes(dat2$Q260)
```

    ## $label
    ## [1] "Sex"
    ## 
    ## $format.spss
    ## [1] "F3.0"
    ## 
    ## $labels
    ## Other missing; Multiple answers Mail (EVS) 
    ##                                         -5 
    ##                                  Not asked 
    ##                                         -4 
    ##                                  No answer 
    ##                                         -2 
    ##                                       Male 
    ##                                          1 
    ##                                     Female 
    ##                                          2

## Frequency tables

The `freq()` function generates **frequency tables** with counts,
proportions, as well as missing data information.

``` r
freq(dat2$Q275, plain.ascii = FALSE, style = "rmarkdown")
```

    ## ### Frequencies  
    ## #### dat2$Q275  
    ## **Label:** Highest educational level: Respondent [ISCED 2011]  
    ## **Type:** Numeric  
    ## 
    ## |     &nbsp; |  Freq | % Valid | % Valid Cum. | % Total | % Total Cum. |
    ## |-----------:|------:|--------:|-------------:|--------:|-------------:|
    ## |      **0** |  4126 |    5.41 |         5.41 |    5.37 |         5.37 |
    ## |      **1** |  9932 |   13.02 |        18.43 |   12.92 |        18.28 |
    ## |      **2** | 10623 |   13.93 |        32.36 |   13.81 |        32.10 |
    ## |      **3** | 19843 |   26.01 |        58.37 |   25.80 |        57.90 |
    ## |      **4** |  7090 |    9.29 |        67.67 |    9.22 |        67.12 |
    ## |      **5** |  6151 |    8.06 |        75.73 |    8.00 |        75.12 |
    ## |      **6** | 13045 |   17.10 |        92.83 |   16.96 |        92.08 |
    ## |      **7** |  4548 |    5.96 |        98.79 |    5.91 |        98.00 |
    ## |      **8** |   920 |    1.21 |       100.00 |    1.20 |        99.20 |
    ## | **\<NA\>** |   619 |         |              |    0.80 |       100.00 |
    ## |  **Total** | 76897 |  100.00 |       100.00 |  100.00 |       100.00 |

With this function, the first argument is the variable from which we
want to get a frequency table, and the following 2 arguments are related
to how the table looks. We try the following to see the difference in
presentation:

``` r
freq(dat2$Q275, plain.ascii = T, style = "simple")
```

Now, notice that the function recognizes the variable as *Numeric*, that
is because as far as **R** knows, the variable has only numbers. The
*education* variables is stored as integers, but each integer represents
a level of education. For this reason we see the numbers on the first
column, even though we want to represent education levels.

We can change this with the `factor()` function, and specify the
`labels` as the desired education values we want

``` r
dat2$edu_fac <- factor(dat2$Q275, 
                       levels = 0:8,
                       labels = c("Early childhood",
                                  "Primary",
                                  "Lower secondary",
                                  "Upper secondary",
                                  "Post-secondary non-tertiary",
                                  "Short-cycle tertiary",
                                  "Bachelor or equivalent",
                                  "Master or equivalent",
                                  "Doctoral or equivalent") )
attributes(dat2$edu_fac)
```

    ## $levels
    ## [1] "Early childhood"             "Primary"                    
    ## [3] "Lower secondary"             "Upper secondary"            
    ## [5] "Post-secondary non-tertiary" "Short-cycle tertiary"       
    ## [7] "Bachelor or equivalent"      "Master or equivalent"       
    ## [9] "Doctoral or equivalent"     
    ## 
    ## $class
    ## [1] "factor"

And now we can look at the frequency table of the new factor education
variable

``` r
freq(dat2$edu_fac, plain.ascii = FALSE, style = "rmarkdown")
```

    ## ### Frequencies  
    ## #### dat2$edu_fac  
    ## **Type:** Factor  
    ## 
    ## |                          &nbsp; |  Freq | % Valid | % Valid Cum. | % Total | % Total Cum. |
    ## |--------------------------------:|------:|--------:|-------------:|--------:|-------------:|
    ## |             **Early childhood** |  4126 |    5.41 |         5.41 |    5.37 |         5.37 |
    ## |                     **Primary** |  9932 |   13.02 |        18.43 |   12.92 |        18.28 |
    ## |             **Lower secondary** | 10623 |   13.93 |        32.36 |   13.81 |        32.10 |
    ## |             **Upper secondary** | 19843 |   26.01 |        58.37 |   25.80 |        57.90 |
    ## | **Post-secondary non-tertiary** |  7090 |    9.29 |        67.67 |    9.22 |        67.12 |
    ## |        **Short-cycle tertiary** |  6151 |    8.06 |        75.73 |    8.00 |        75.12 |
    ## |      **Bachelor or equivalent** | 13045 |   17.10 |        92.83 |   16.96 |        92.08 |
    ## |        **Master or equivalent** |  4548 |    5.96 |        98.79 |    5.91 |        98.00 |
    ## |      **Doctoral or equivalent** |   920 |    1.21 |       100.00 |    1.20 |        99.20 |
    ## |                      **\<NA\>** |   619 |         |              |    0.80 |       100.00 |
    ## |                       **Total** | 76897 |  100.00 |       100.00 |  100.00 |       100.00 |

You can save the frequency table as table object as well, with the
`tb()` function

``` r
fq1 <- tb(freq(dat2$edu_fac, plain.ascii = FALSE, style = "rmarkdown"))
fq1
```

    ## # A tibble: 10 x 6
    ##    edu_fac                      freq pct_valid pct_valid_cum pct_tot pct_tot_cum
    ##    <fct>                       <dbl>     <dbl>         <dbl>   <dbl>       <dbl>
    ##  1 Early childhood              4126      5.41          5.41   5.37         5.37
    ##  2 Primary                      9932     13.0          18.4   12.9         18.3 
    ##  3 Lower secondary             10623     13.9          32.4   13.8         32.1 
    ##  4 Upper secondary             19843     26.0          58.4   25.8         57.9 
    ##  5 Post-secondary non-tertiary  7090      9.29         67.7    9.22        67.1 
    ##  6 Short-cycle tertiary         6151      8.06         75.7    8.00        75.1 
    ##  7 Bachelor or equivalent      13045     17.1          92.8   17.0         92.1 
    ##  8 Master or equivalent         4548      5.96         98.8    5.91        98.0 
    ##  9 Doctoral or equivalent        920      1.21        100      1.20        99.2 
    ## 10 <NA>                          619     NA            NA      0.805      100

Lets also modify the *sex* variable with `factor()` function

``` r
dat2$sex_fac <- factor(dat2$Q260, 
                       levels = 1:2,
                       labels = c("Male","Female") )
attributes(dat2$sex_fac)
```

    ## $levels
    ## [1] "Male"   "Female"
    ## 
    ## $class
    ## [1] "factor"

We see this table presents the absolute frequency counts, percentage of
valid answers, valid cumulative percentage, total percentage, and total
cumulative percentage.

We can also use the same function, and provide multiple variables at
once, getting the frequency tables for each specify variable

``` r
freq(dat2[,c("edu_fac","Y001","sex_fac")], plain.ascii = FALSE, style = "rmarkdown")
```

    ## ### Frequencies  
    ## #### dat2$edu_fac  
    ## **Type:** Factor  
    ## 
    ## |                          &nbsp; |  Freq | % Valid | % Valid Cum. | % Total | % Total Cum. |
    ## |--------------------------------:|------:|--------:|-------------:|--------:|-------------:|
    ## |             **Early childhood** |  4126 |    5.41 |         5.41 |    5.37 |         5.37 |
    ## |                     **Primary** |  9932 |   13.02 |        18.43 |   12.92 |        18.28 |
    ## |             **Lower secondary** | 10623 |   13.93 |        32.36 |   13.81 |        32.10 |
    ## |             **Upper secondary** | 19843 |   26.01 |        58.37 |   25.80 |        57.90 |
    ## | **Post-secondary non-tertiary** |  7090 |    9.29 |        67.67 |    9.22 |        67.12 |
    ## |        **Short-cycle tertiary** |  6151 |    8.06 |        75.73 |    8.00 |        75.12 |
    ## |      **Bachelor or equivalent** | 13045 |   17.10 |        92.83 |   16.96 |        92.08 |
    ## |        **Master or equivalent** |  4548 |    5.96 |        98.79 |    5.91 |        98.00 |
    ## |      **Doctoral or equivalent** |   920 |    1.21 |       100.00 |    1.20 |        99.20 |
    ## |                      **\<NA\>** |   619 |         |              |    0.80 |       100.00 |
    ## |                       **Total** | 76897 |  100.00 |       100.00 |  100.00 |       100.00 |
    ## 
    ## #### dat2$Y001  
    ## **Label:** Post-Materialist index 12-item  
    ## **Type:** Numeric  
    ## 
    ## |     &nbsp; |  Freq | % Valid | % Valid Cum. | % Total | % Total Cum. |
    ## |-----------:|------:|--------:|-------------:|--------:|-------------:|
    ## |      **0** |  7185 |    9.94 |         9.94 |    9.34 |         9.34 |
    ## |      **1** | 17272 |   23.89 |        33.82 |   22.46 |        31.80 |
    ## |      **2** | 22793 |   31.52 |        65.34 |   29.64 |        61.45 |
    ## |      **3** | 16381 |   22.65 |        87.99 |   21.30 |        82.75 |
    ## |      **4** |  6973 |    9.64 |        97.64 |    9.07 |        91.82 |
    ## |      **5** |  1709 |    2.36 |       100.00 |    2.22 |        94.04 |
    ## | **\<NA\>** |  4584 |         |              |    5.96 |       100.00 |
    ## |  **Total** | 76897 |  100.00 |       100.00 |  100.00 |       100.00 |
    ## 
    ## #### dat2$sex_fac  
    ## **Type:** Factor  
    ## 
    ## |     &nbsp; |  Freq | % Valid | % Valid Cum. | % Total | % Total Cum. |
    ## |-----------:|------:|--------:|-------------:|--------:|-------------:|
    ## |   **Male** | 36556 |  47.570 |       47.570 |  47.539 |       47.539 |
    ## | **Female** | 40290 |  52.430 |      100.000 |  52.395 |       99.934 |
    ## | **\<NA\>** |    51 |         |              |   0.066 |      100.000 |
    ## |  **Total** | 76897 | 100.000 |      100.000 | 100.000 |      100.000 |

## Cross-tables

For categorical variables, if we want to estimate frequency tables
across multiple other groups, we estimate cross-tables. These present
the frequency of variable 1 at each level of variable 2, and vice versa,
depending on which direction you want to read the table.

To do this we use the function `ctable()`. Here we see the cross-table
between sex and education level. For this the main 2 arguments we have
to provide are 2 categorical variables of interest. You also include the
`prop` argument, which specifies which proportions you want to show. In
this first example we include *don’t include any*:

``` r
ctable(dat2$edu_fac, dat2$sex_fac, prop="n", style = "simple")
```

    ## Cross-Tabulation  
    ## edu_fac * sex_fac  
    ## Data Frame: dat2  
    ## 
    ## ----------------------------- --------- ------- -------- ------ -------
    ##                                 sex_fac    Male   Female   <NA>   Total
    ##                       edu_fac                                          
    ##               Early childhood              1558     2565      3    4126
    ##                       Primary              4397     5533      2    9932
    ##               Lower secondary              5082     5539      2   10623
    ##               Upper secondary              9515    10319      9   19843
    ##   Post-secondary non-tertiary              3566     3522      2    7090
    ##          Short-cycle tertiary              2935     3215      1    6151
    ##        Bachelor or equivalent              6506     6538      1   13045
    ##          Master or equivalent              2238     2309      1    4548
    ##        Doctoral or equivalent               503      417      0     920
    ##                          <NA>               256      333     30     619
    ##                         Total             36556    40290     51   76897
    ## ----------------------------- --------- ------- -------- ------ -------

Here we include *row* proportions:

``` r
ctable(dat2$edu_fac, dat2$sex_fac, prop="r", style = "simple")
```

    ## Cross-Tabulation, Row Proportions  
    ## edu_fac * sex_fac  
    ## Data Frame: dat2  
    ## 
    ## ----------------------------- --------- --------------- --------------- ------------- ----------------
    ##                                 sex_fac            Male          Female          <NA>            Total
    ##                       edu_fac                                                                         
    ##               Early childhood              1558 (37.8%)    2565 (62.2%)    3 (0.073%)    4126 (100.0%)
    ##                       Primary              4397 (44.3%)    5533 (55.7%)    2 (0.020%)    9932 (100.0%)
    ##               Lower secondary              5082 (47.8%)    5539 (52.1%)    2 (0.019%)   10623 (100.0%)
    ##               Upper secondary              9515 (48.0%)   10319 (52.0%)    9 (0.045%)   19843 (100.0%)
    ##   Post-secondary non-tertiary              3566 (50.3%)    3522 (49.7%)    2 (0.028%)    7090 (100.0%)
    ##          Short-cycle tertiary              2935 (47.7%)    3215 (52.3%)    1 (0.016%)    6151 (100.0%)
    ##        Bachelor or equivalent              6506 (49.9%)    6538 (50.1%)    1 (0.008%)   13045 (100.0%)
    ##          Master or equivalent              2238 (49.2%)    2309 (50.8%)    1 (0.022%)    4548 (100.0%)
    ##        Doctoral or equivalent               503 (54.7%)     417 (45.3%)    0 (0.000%)     920 (100.0%)
    ##                          <NA>               256 (41.4%)     333 (53.8%)   30 (4.847%)     619 (100.0%)
    ##                         Total             36556 (47.5%)   40290 (52.4%)   51 (0.066%)   76897 (100.0%)
    ## ----------------------------- --------- --------------- --------------- ------------- ----------------

Here we include *column* proportions:

``` r
ctable(dat2$edu_fac, dat2$sex_fac, prop="c", style = "simple")
```

    ## Cross-Tabulation, Column Proportions  
    ## edu_fac * sex_fac  
    ## Data Frame: dat2  
    ## 
    ## ----------------------------- --------- ---------------- ---------------- ------------- ----------------
    ##                                 sex_fac             Male           Female          <NA>            Total
    ##                       edu_fac                                                                           
    ##               Early childhood              1558 (  4.3%)    2565 (  6.4%)    3 (  5.9%)    4126 (  5.4%)
    ##                       Primary              4397 ( 12.0%)    5533 ( 13.7%)    2 (  3.9%)    9932 ( 12.9%)
    ##               Lower secondary              5082 ( 13.9%)    5539 ( 13.7%)    2 (  3.9%)   10623 ( 13.8%)
    ##               Upper secondary              9515 ( 26.0%)   10319 ( 25.6%)    9 ( 17.6%)   19843 ( 25.8%)
    ##   Post-secondary non-tertiary              3566 (  9.8%)    3522 (  8.7%)    2 (  3.9%)    7090 (  9.2%)
    ##          Short-cycle tertiary              2935 (  8.0%)    3215 (  8.0%)    1 (  2.0%)    6151 (  8.0%)
    ##        Bachelor or equivalent              6506 ( 17.8%)    6538 ( 16.2%)    1 (  2.0%)   13045 ( 17.0%)
    ##          Master or equivalent              2238 (  6.1%)    2309 (  5.7%)    1 (  2.0%)    4548 (  5.9%)
    ##        Doctoral or equivalent               503 (  1.4%)     417 (  1.0%)    0 (  0.0%)     920 (  1.2%)
    ##                          <NA>               256 (  0.7%)     333 (  0.8%)   30 ( 58.8%)     619 (  0.8%)
    ##                         Total             36556 (100.0%)   40290 (100.0%)   51 (100.0%)   76897 (100.0%)
    ## ----------------------------- --------- ---------------- ---------------- ------------- ----------------

Or you can include *total* proportions:

``` r
ctable(dat2$edu_fac, dat2$sex_fac, prop="t", style = "simple")
```

# Data frame Summary

We can use use the `dfSummary()` function to get a full report of the
data. Be careful as this will take the default settings of your
variables, and some information may not make sense (e.g. categorical
variables stored as integers.) For example:

``` r
view(dfSummary(dat2))
```
