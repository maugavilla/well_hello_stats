Data management 2: variable types, and factors
================
Mauricio Garnier-Villarreal, Joris M. Schröder & Joseph Charles Van
Matre
08 February, 2024

- [Setup the R session](#setup-the-r-session)
- [Import the data set](#import-the-data-set)
  - [Select variables of interest](#select-variables-of-interest)
- [Variable types](#variable-types)
- [`factor`](#factor)

# Setup the R session

When we start up we always need to setup our session. For this wee need
to set our working directory, in this case I am doing that for the
folder that holds the downloaded [World Values Survey
(WVS)](https://www.worldvaluessurvey.org/) `SPSS` data set

``` r
setwd("~path_to_your_file")
```

The next step for our session will be to load the packages that we will
be using

``` r
library(rio)
```

# Import the data set

Here we will be importing the `.sav` WVS data set

``` r
dat <- import("WVS_Cross-National_Wave_7_sav_v2_0.sav")
dim(dat)
```

    ## [1] 76897   548

Here we are calling our data set **dat** and asking to see the dimension
of it. We see that the data set has 76897 subjects, and 548 columns. If
you downloaded a different version of the WVS, these number might differ

## Select variables of interest

In cases with large data sets like this we might want to select a subset
of variables that we want to work with. Since it is not easy to see 548
variables.

``` r
vars <- c("Q275", "Q260", "Q262")
dat2 <- dat[,vars]
dim(dat2)
```

    ## [1] 76897     3

``` r
head(dat2)
```

    ##   Q275 Q260 Q262
    ## 1    3    2   60
    ## 2    7    1   47
    ## 3    7    1   48
    ## 4    2    2   62
    ## 5    2    1   49
    ## 6    1    2   51

Here we are first creating a vector with the variable names for the ones
I want to keep. You can see all variable names for the full data set as
well

``` r
colnames(dat)
```

After writing which variables we want to work with, we create a new data
set **dat2** with only these 7 variables, and make sure we did it
correctly by looking at the the dimension of the data **dim(dat2)** and
looking at the first 6 rows of it **head(dat2)**. These are quick checks
that we have done this correctly.

# Variable types

When working with data, need to be clear on what type of data is
provided by each variable. From these selected items, we will look at 3
types, binary (Sex, Q260), ordered categorical (Highest education level
Q275), and continuous (Age Q262).

For all of these variables, the data is imported as numerical because
even for the categorical variables we have stated that some numbers mean
something other than the number. For this reason, we could ask something
that makes no sense, like the mean of the education level

``` r
mean(dat2$Q275, na.rm=T)
```

    ## [1] 3.50413

And R will give us a value, but this is meaningless because we have
categorical levels of education, so this 3.5 cannot be interpreted.

We can see the attributes and basix frequency table of a variable like
this

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

``` r
table(dat2$Q275, useNA = "always")
```

    ## 
    ##     0     1     2     3     4     5     6     7     8  <NA> 
    ##  4126  9932 10623 19843  7090  6151 13045  4548   920   619

In this case we can see the possible answer labels, and that the actual
answers are between 0 (*Early childhood education*) and 8 (*Doctoral or
equivalent*).

The same applies for the Sex variable, we can see that we have some
missing value attributes, and possible valid answers of Male (1) and
Female (2), and looking at the frequency table we see that there are
more women than men in the sample.

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

``` r
table(dat2$Q260, useNA = "always")
```

    ## 
    ##     1     2  <NA> 
    ## 36556 40290    51

It is worth noting that research in general has failed the area of
diversity, as very few data sets include variables accounting for gender
diversity, and we still see only variables with options of Male and
Female. We expect for this dversity to be accounted in future data sets.

On the other side, we can also have real continuous variables like Age.
For which the mean is a meaningful metric

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

``` r
mean(dat2$Q262, na.rm=T)
```

    ## [1] 43.01547

``` r
median(dat2$Q262, na.rm=T)
```

    ## [1] 41

Here we can see that the average age of the sample is 43.02 years old,
and the median age is 41.

Clearly, depending of the type of variable is the type of information
that we should ask R to give us. R doesn’t know what the numbers mean
for us.

# `factor`

As we said, R doesn’t know what the numbers in the data are. But you can
tell it, for example you can tell it that a variable is categorical by
specifying as a `factor()`. With this function we can specify to treat a
variable as categorical.

``` r
dat2$sex_fac <- factor(dat2$Q260)
attributes(dat2$sex_fac)
```

    ## $levels
    ## [1] "1" "2"
    ## 
    ## $class
    ## [1] "factor"

``` r
mean(dat2$sex_fac, na.rm=T)
```

    ## Warning in mean.default(dat2$sex_fac, na.rm = T): argument is not numeric or
    ## logical: returning NA

    ## [1] NA

When we use the `factor()` function, we can create a new factor variable
for the sex variable. When we do this we see in attributes that the
`class` specifies that it is a factor, and we have a `levels` attribute
that tell us the possible answers. And when we try to estimate mean, now
we get an `NA` for it, as R cannot estimate a mean for a categorical
variable.

We can also extend the use of the factor function. Since it is already
categorical, why keep using numbers, lets change those numerical codes
for text that specifies what they mean.

``` r
dat2$sex_fac <- factor(dat2$Q260, 
                       levels = c(1,2),
                       labels = c("Male", "Feamale"))
attributes(dat2$sex_fac)
```

    ## $levels
    ## [1] "Male"    "Feamale"
    ## 
    ## $class
    ## [1] "factor"

``` r
table(dat2$Q260, dat2$sex_fac)
```

    ##    
    ##      Male Feamale
    ##   1 36556       0
    ##   2     0   40290

Here we use 2 new arguments in the `factor()` function. The `levels`
argument are the *old* value for the sex variable, and the `labels`
argument are the new text values that are meaningful. This way we are
re-coding the values of the variable, and the type of the variable at
the same time.

Now, lets see how that looks for the education variable, this one is a
little more complicated for the larger number of categories.

``` r
dat2$eud_fac <- factor(dat2$Q275, 
                       levels = 0:8,
                       labels = names(attributes(dat2$Q275)$labels)[5:13] )
attributes(dat2$eud_fac)
```

    ## $levels
    ## [1] "Early childhood education (ISCED 0) / no education"
    ## [2] "Primary education (ISCED 1)"                       
    ## [3] "Lower secondary education (ISCED 2)"               
    ## [4] "Upper secondary education (ISCED 3)"               
    ## [5] "Post-secondary non-tertiary education (ISCED 4)"   
    ## [6] "Short-cycle tertiary education (ISCED 5)"          
    ## [7] "Bachelor or equivalent (ISCED 6)"                  
    ## [8] "Master or equivalent (ISCED 7)"                    
    ## [9] "Doctoral or equivalent (ISCED 8)"                  
    ## 
    ## $class
    ## [1] "factor"

``` r
table(dat2$eud_fac)
```

    ## 
    ## Early childhood education (ISCED 0) / no education 
    ##                                               4126 
    ##                        Primary education (ISCED 1) 
    ##                                               9932 
    ##                Lower secondary education (ISCED 2) 
    ##                                              10623 
    ##                Upper secondary education (ISCED 3) 
    ##                                              19843 
    ##    Post-secondary non-tertiary education (ISCED 4) 
    ##                                               7090 
    ##           Short-cycle tertiary education (ISCED 5) 
    ##                                               6151 
    ##                   Bachelor or equivalent (ISCED 6) 
    ##                                              13045 
    ##                     Master or equivalent (ISCED 7) 
    ##                                               4548 
    ##                   Doctoral or equivalent (ISCED 8) 
    ##                                                920

With this we are changing the levels to `0:8` to specify that we have
values from 0 to 8. For the `labels`, I did not wanted to write all the
education categories, so I pulled these category names from the
`attributes()` function. This way we now have a categorical variable,
that R knows is categorical with meaningful labels.
