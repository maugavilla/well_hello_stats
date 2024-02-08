Data management 1
================
Mauricio Garnier-Villarreal, Joris M. Schröder & Joseph Charles Van
Matre
08 February, 2024

- [Setup the R session](#setup-the-r-session)
- [Import the data set](#import-the-data-set)
  - [Select variables of interest](#select-variables-of-interest)
- [Recode items](#recode-items)
  - [Reverse code](#reverse-code)
  - [Reverse code missing value
    codes](#reverse-code-missing-value-codes)
  - [Dummy code](#dummy-code)
- [Create composite scores](#create-composite-scores)
  - [Sum score](#sum-score)
  - [Mean score](#mean-score)
- [Variable calculations](#variable-calculations)
  - [Equation calculations](#equation-calculations)
  - [Scale](#scale)
- [Selecting subsets](#selecting-subsets)

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
library(car)
```

    ## Loading required package: carData

``` r
library(psych)
```

    ## 
    ## Attaching package: 'psych'

    ## The following object is masked from 'package:car':
    ## 
    ##     logit

# Import the data set

Here we will be importing the `.sav` WVS data set

``` r
dat <- import("WVS_Cross-National_Wave_7_sav_v2_0.sav")
dim(dat)
```

    ## [1] 76897   548

Here we are calling our data set **dat** and asking to see the dimension
of it. We see that the data set has 76897 subjects, and 548 columns. If
you have downaloaded a different version of the WVS these number might
differ.

## Select variables of interest

In cases with large data sets like this we might want to select a subset
of variables that we want to work with. Since it is not easy to see 548
variables.

``` r
vars <- c("Q65", "Q69", "Q71", "Q72", "Q73", "Q275", "Q260", "Q262")
dat2 <- dat[,vars]
dim(dat2)
```

    ## [1] 76897     8

``` r
head(dat2)
```

    ##   Q65 Q69 Q71 Q72 Q73 Q275 Q260 Q262
    ## 1  NA   1   1   1   1    3    2   60
    ## 2  NA   3   4   4   4    7    1   47
    ## 3  NA   2   3   3   3    7    1   48
    ## 4  NA   3   3   3   3    2    2   62
    ## 5  NA   2   2   3   2    2    1   49
    ## 6  NA   1   2   2   2    1    2   51

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

# Recode items

## Reverse code

There are cases where you need to switch the direction of some items.
For example, we want to create a scale score for **Confidence in the
government**, which is evaluated in WVS with the items Q65, Q69, Q71,
Q72, and Q73.

Since we imported the `SPSS` file, which contains some attribute
information for the items. We can see what information the have

``` r
attributes(dat2$Q65)
```

    ## $label
    ## [1] "Confidence: Armed Forces"
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
    ##                                 Don´t know 
    ##                                         -1 
    ##                               A great deal 
    ##                                          1 
    ##                                Quite a lot 
    ##                                          2 
    ##                              Not very much 
    ##                                          3 
    ##                                None at all 
    ##                                          4

Here we can see that item **Q65** is about **Confidence in the Armed
Forces**. We can also see that 1 means that they have **A great deal of
confidence** and that 4 means that they have **None at all confidence**.
So, we see that the higher the score the less confidence they have in
the government. You can see the other items attributes

``` r
attributes(dat2$Q69) ## Confidence: The Police
attributes(dat2$Q71) ## Confidence: The Government
attributes(dat2$Q72) ## Confidence: The Political Parties
attributes(dat2$Q73) ## Confidence: Parliament
```

So, if we were to create a total score with the items like this, we
would be create the scale score for **Lack of confidence in the
government**. It just seems too many words, and I dont want to be
interpreting negative statements.

So, lets reverse code the items, so we can create the scale **Confidence
in the Government**. First we want to see what are the values that we
have in the data set. We can do this with the frequency tables.

``` r
table(dat2$Q65, useNA="always")
```

    ## 
    ##     1     2     3     4  <NA> 
    ## 22019 29214 15767  6362  3535

``` r
table(dat2$Q69, useNA="always")
```

    ## 
    ##     1     2     3     4  <NA> 
    ## 14485 30518 19804 10020  2070

``` r
table(dat2$Q71, useNA="always")
```

    ## 
    ##     1     2     3     4  <NA> 
    ## 11327 24395 22497 16016  2662

``` r
table(dat2$Q72, useNA="always")
```

    ## 
    ##     1     2     3     4  <NA> 
    ##  5090 17225 29054 22948  2580

``` r
table(dat2$Q73, useNA="always")
```

    ## 
    ##     1     2     3     4  <NA> 
    ##  7267 21501 25941 19568  2620

Here we see that for all the items, we have values from 1 to 4, and all
other responses have been properly set as missing `NA`. We are using 2
arguments from the `table()` function, first the variable, and second
asking what to do with the missing values, so we can see them included
in the frequencies.

We can shorten this code, instead of doing it for one variable at the
time. We can use the `apply()` function. First, add the data set with
only the scale variables to which do want to look at the frequency
tables, then the *MARGIN = 2* indicates that you want to execute the
function *FUN* to each column, as the 2 inciates the second element of
the dimensions. And finally, the function to apply *table*, and
additional arguments for the function

``` r
apply(dat2[,c("Q65","Q69","Q71","Q72","Q73")], MARGIN=2, FUN=table, useNA="always")
```

    ##        Q65   Q69   Q71   Q72   Q73
    ## 1    22019 14485 11327  5090  7267
    ## 2    29214 30518 24395 17225 21501
    ## 3    15767 19804 22497 29054 25941
    ## 4     6362 10020 16016 22948 19568
    ## <NA>  3535  2070  2662  2580  2620

At the end we get the same information, but it is good to see a couple
of ways, so you can figure out which one you are more comfortable with.

Now we know that we need to reverse code values from 1 to 4. We will use
the `recode()` function from the `car` package.

``` r
dat2$Q65_r <- recode(dat2$Q65, "1=4; 2=3; 3=2; 4=1")
dat2$Q69_r <- recode(dat2$Q69, "1=4; 2=3; 3=2; 4=1")
dat2$Q71_r <- recode(dat2$Q71, "1=4; 2=3; 3=2; 4=1")
dat2$Q72_r <- recode(dat2$Q72, "1=4; 2=3; 3=2; 4=1")
dat2$Q73_r <- recode(dat2$Q73, "1=4; 2=3; 3=2; 4=1")
```

First, we need to create a new variable in the data set, we can use t
`$` to create a new item name. Here I am using the same name, ending
with `_r`, indicating that is the same item reversed. Then, we the
`recode()` function takes 2 arguments, first the variable that you want
to recode, second the way the values should be changed. Note that the
recode values need to be between quotes `""`, and that the values have
to be separated by `;`.

Now we have reverse coded the 5 items, but we are not done yet. We need
to make sure we did it correctly. We can do this by doing a cross-table
between the original variable, and the new one.

``` r
table(dat2$Q65, dat2$Q65_r, useNA="always")
```

    ##       
    ##            1     2     3     4  <NA>
    ##   1        0     0     0 22019     0
    ##   2        0     0 29214     0     0
    ##   3        0 15767     0     0     0
    ##   4     6362     0     0     0     0
    ##   <NA>     0     0     0     0  3535

Here we can see that the variable values follow the diagonal, indicating
that values were recoded correctly. Only the `NA` is the same, because
we want to keep the same missing values. You can see the cross-tables
for the other variables with

``` r
table(dat2$Q69, dat2$Q69_r, useNA="always")
table(dat2$Q71, dat2$Q71_r, useNA="always")
table(dat2$Q72, dat2$Q72_r, useNA="always")
table(dat2$Q73, dat2$Q73_r, useNA="always")
```

Now we can see all the new variables in the data set

``` r
dim(dat2)
```

    ## [1] 76897    13

``` r
head(dat2)
```

    ##   Q65 Q69 Q71 Q72 Q73 Q275 Q260 Q262 Q65_r Q69_r Q71_r Q72_r Q73_r
    ## 1  NA   1   1   1   1    3    2   60    NA     4     4     4     4
    ## 2  NA   3   4   4   4    7    1   47    NA     2     1     1     1
    ## 3  NA   2   3   3   3    7    1   48    NA     3     2     2     2
    ## 4  NA   3   3   3   3    2    2   62    NA     2     2     2     2
    ## 5  NA   2   2   3   2    2    1   49    NA     3     3     2     3
    ## 6  NA   1   2   2   2    1    2   51    NA     4     3     3     3

``` r
colnames(dat2)
```

    ##  [1] "Q65"   "Q69"   "Q71"   "Q72"   "Q73"   "Q275"  "Q260"  "Q262"  "Q65_r"
    ## [10] "Q69_r" "Q71_r" "Q72_r" "Q73_r"

## Reverse code missing value codes

From the attributes we have seen that there were missing value codes,
even when those had been correctly set as `NA` when importing the data
set. But this might not be the case in all your data sets

``` r
attributes(dat2$Q65)
```

    ## $label
    ## [1] "Confidence: Armed Forces"
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
    ##                                 Don´t know 
    ##                                         -1 
    ##                               A great deal 
    ##                                          1 
    ##                                Quite a lot 
    ##                                          2 
    ##                              Not very much 
    ##                                          3 
    ##                                None at all 
    ##                                          4

Here we see that values -5, -4, -2, and -1 should be considered missing.
We can include these into the recode function, by adding these negative
values and making them equal to `=NA`.

``` r
dat2$Q65_r <- recode(dat2$Q65, "1=4; 2=3; 3=2; 4=1; -5=NA; -4=NA; -2=NA; -1=NA")
```

## Dummy code

Another issue could be to have a categorical variable, and you need to
create multiple dummy code variables. Changing a single categorical
variable into multiple binary variables.

For this example we will use the **Highest education level (Q275)**
variable. In the attributes, we can see that the valid answers go from 0
to 9. But when looking at the frequency table, we see that we have only
values from 0 (*Early childhood education*) to 8 (*Doctoral or
equivalent*)

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

This would mean that we need to create 9 dummy code variables. In each
dummy code variable having 1 indicating for each education level and 0
for all others. You could do this with a bunch of `recode()` functions.
But we also have a nice function `dummy.code()` from the `psych`
package.

``` r
dat2 <- data.frame(dat2, dummy.code(dat2$Q275))
head(dat2)
```

    ##   Q65 Q69 Q71 Q72 Q73 Q275 Q260 Q262 Q65_r Q69_r Q71_r Q72_r Q73_r X3 X6 X2 X1
    ## 1  NA   1   1   1   1    3    2   60    NA     4     4     4     4  1  0  0  0
    ## 2  NA   3   4   4   4    7    1   47    NA     2     1     1     1  0  0  0  0
    ## 3  NA   2   3   3   3    7    1   48    NA     3     2     2     2  0  0  0  0
    ## 4  NA   3   3   3   3    2    2   62    NA     2     2     2     2  0  0  1  0
    ## 5  NA   2   2   3   2    2    1   49    NA     3     3     2     3  0  0  1  0
    ## 6  NA   1   2   2   2    1    2   51    NA     4     3     3     3  0  0  0  1
    ##   X4 X5 X7 X0 X8
    ## 1  0  0  0  0  0
    ## 2  0  0  1  0  0
    ## 3  0  0  1  0  0
    ## 4  0  0  0  0  0
    ## 5  0  0  0  0  0
    ## 6  0  0  0  0  0

``` r
colnames(dat2)
```

    ##  [1] "Q65"   "Q69"   "Q71"   "Q72"   "Q73"   "Q275"  "Q260"  "Q262"  "Q65_r"
    ## [10] "Q69_r" "Q71_r" "Q72_r" "Q73_r" "X3"    "X6"    "X2"    "X1"    "X4"   
    ## [19] "X5"    "X7"    "X0"    "X8"

This function give us a matrix with all the dummy code variables. We can
combine it with the full data set with the `data.frame()` function. And
we can see that the dummy code variables are manes `X1`for Dummy code
for value 1, we can see this with a cross table

``` r
table(dat2$Q275, dat2$X1)
```

    ##    
    ##         0     1
    ##   0  4126     0
    ##   1     0  9932
    ##   2 10623     0
    ##   3 19843     0
    ##   4  7090     0
    ##   5  6151     0
    ##   6 13045     0
    ##   7  4548     0
    ##   8   920     0

You could check that for all other values

``` r
table(dat2$Q275, dat2$X0)
table(dat2$Q275, dat2$X2)
table(dat2$Q275, dat2$X3)
table(dat2$Q275, dat2$X4)
table(dat2$Q275, dat2$X5)
table(dat2$Q275, dat2$X6)
table(dat2$Q275, dat2$X7)
table(dat2$Q275, dat2$X8)
```

# Create composite scores

We create composite scores when we need to combine multiple items into 1
*total* score. The most common case is when we need to create a scale
score, like the **Confidence in the government** one.

## Sum score

We will see here to ways to create the composite scores. The first, and
I think the most common one is to sum up all the items. We can do this
creating a new variable with `$`, and summing values for each row
(subject) across a set of items

``` r
dat2$CG_sum <- rowSums(dat2[,c("Q65_r","Q69_r","Q71_r","Q72_r","Q73_r")], na.rm=T)
colnames(dat2)
```

    ##  [1] "Q65"    "Q69"    "Q71"    "Q72"    "Q73"    "Q275"   "Q260"   "Q262"  
    ##  [9] "Q65_r"  "Q69_r"  "Q71_r"  "Q72_r"  "Q73_r"  "X3"     "X6"     "X2"    
    ## [17] "X1"     "X4"     "X5"     "X7"     "X0"     "X8"     "CG_sum"

For this we use the `rowSums()` function, which sums up values across
rows. The first argument is the data set for which we want to sum up
values, note this has to include only the items you want to sum. And the
other argument we are using the `na.rm=T`, this specifies that when
missing values are present to ignore them and sum as many values as each
subject has. Functionally treating the missing as a 0.

## Mean score

The another method we will see is to get the average across items
instead of the sum. This is very similar as before, we just switch to
use the `rowMeans()` function.

``` r
dat2$CG_mean <- rowMeans(dat2[,c("Q65_r","Q69_r","Q71_r","Q72_r","Q73_r")], na.rm=T)
colnames(dat2)
```

    ##  [1] "Q65"     "Q69"     "Q71"     "Q72"     "Q73"     "Q275"    "Q260"   
    ##  [8] "Q262"    "Q65_r"   "Q69_r"   "Q71_r"   "Q72_r"   "Q73_r"   "X3"     
    ## [15] "X6"      "X2"      "X1"      "X4"      "X5"      "X7"      "X0"     
    ## [22] "X8"      "CG_sum"  "CG_mean"

Now we see we have created 2 composite scores. With the sum and the mean
across items. We recommend to use the mean instead of the sum. This for
several reasons, but the main ones being that the mean keeps the scale
of the original items (between 1 and 4 in this case) while the sum is in
the scale between the minimum and maximum of the sum. And the second
because with the sum the missing values either create a missing sum or
counts the missing value as 0, while when the mean ignores it it will
estimate the mean across all the answered items, not affecting the mean.

# Variable calculations

Creating composite variables are a way of doing calculations with
variables. But we can do any calculation that we consider necessary.

## Equation calculations

For example, we can table the mean composite score and subtract any
value of interest we want, could be 2 as it is the median range of
possible scores

``` r
dat2$CG_mean_minus2 <- dat2$CG_mean - 2
head(dat2)
```

    ##   Q65 Q69 Q71 Q72 Q73 Q275 Q260 Q262 Q65_r Q69_r Q71_r Q72_r Q73_r X3 X6 X2 X1
    ## 1  NA   1   1   1   1    3    2   60    NA     4     4     4     4  1  0  0  0
    ## 2  NA   3   4   4   4    7    1   47    NA     2     1     1     1  0  0  0  0
    ## 3  NA   2   3   3   3    7    1   48    NA     3     2     2     2  0  0  0  0
    ## 4  NA   3   3   3   3    2    2   62    NA     2     2     2     2  0  0  1  0
    ## 5  NA   2   2   3   2    2    1   49    NA     3     3     2     3  0  0  1  0
    ## 6  NA   1   2   2   2    1    2   51    NA     4     3     3     3  0  0  0  1
    ##   X4 X5 X7 X0 X8 CG_sum CG_mean CG_mean_minus2
    ## 1  0  0  0  0  0     16    4.00           2.00
    ## 2  0  0  1  0  0      5    1.25          -0.75
    ## 3  0  0  1  0  0      9    2.25           0.25
    ## 4  0  0  0  0  0      8    2.00           0.00
    ## 5  0  0  0  0  0     11    2.75           0.75
    ## 6  0  0  0  0  0     13    3.25           1.25

Now this variable would show negative values for subjects with a mean
scors lower than 2.

Another calculation we could do is to divide the mean composite score by
the subjects age, making it relative to it. Not sure of this makes a lot
of sense, but its something curious to show

``` r
dat2$CG_mean_age <- dat2$CG_mean/dat2$Q262
head(dat2)
```

    ##   Q65 Q69 Q71 Q72 Q73 Q275 Q260 Q262 Q65_r Q69_r Q71_r Q72_r Q73_r X3 X6 X2 X1
    ## 1  NA   1   1   1   1    3    2   60    NA     4     4     4     4  1  0  0  0
    ## 2  NA   3   4   4   4    7    1   47    NA     2     1     1     1  0  0  0  0
    ## 3  NA   2   3   3   3    7    1   48    NA     3     2     2     2  0  0  0  0
    ## 4  NA   3   3   3   3    2    2   62    NA     2     2     2     2  0  0  1  0
    ## 5  NA   2   2   3   2    2    1   49    NA     3     3     2     3  0  0  1  0
    ## 6  NA   1   2   2   2    1    2   51    NA     4     3     3     3  0  0  0  1
    ##   X4 X5 X7 X0 X8 CG_sum CG_mean CG_mean_minus2 CG_mean_age
    ## 1  0  0  0  0  0     16    4.00           2.00  0.06666667
    ## 2  0  0  1  0  0      5    1.25          -0.75  0.02659574
    ## 3  0  0  1  0  0      9    2.25           0.25  0.04687500
    ## 4  0  0  0  0  0      8    2.00           0.00  0.03225806
    ## 5  0  0  0  0  0     11    2.75           0.75  0.05612245
    ## 6  0  0  0  0  0     13    3.25           1.25  0.06372549

## Scale

Another common variable calculation is to scale a variable. This means
to change mean and/or standard deviation of the variable. You might up
needing to mean center a variable, we can do this with the
`scale()`function

``` r
dat2$CG_mean_center <- scale(dat2$CG_mean, center=T, scale = F)[,1]
head(dat2)
```

    ##   Q65 Q69 Q71 Q72 Q73 Q275 Q260 Q262 Q65_r Q69_r Q71_r Q72_r Q73_r X3 X6 X2 X1
    ## 1  NA   1   1   1   1    3    2   60    NA     4     4     4     4  1  0  0  0
    ## 2  NA   3   4   4   4    7    1   47    NA     2     1     1     1  0  0  0  0
    ## 3  NA   2   3   3   3    7    1   48    NA     3     2     2     2  0  0  0  0
    ## 4  NA   3   3   3   3    2    2   62    NA     2     2     2     2  0  0  1  0
    ## 5  NA   2   2   3   2    2    1   49    NA     3     3     2     3  0  0  1  0
    ## 6  NA   1   2   2   2    1    2   51    NA     4     3     3     3  0  0  0  1
    ##   X4 X5 X7 X0 X8 CG_sum CG_mean CG_mean_minus2 CG_mean_age CG_mean_center
    ## 1  0  0  0  0  0     16    4.00           2.00  0.06666667      1.5515812
    ## 2  0  0  1  0  0      5    1.25          -0.75  0.02659574     -1.1984188
    ## 3  0  0  1  0  0      9    2.25           0.25  0.04687500     -0.1984188
    ## 4  0  0  0  0  0      8    2.00           0.00  0.03225806     -0.4484188
    ## 5  0  0  0  0  0     11    2.75           0.75  0.05612245      0.3015812
    ## 6  0  0  0  0  0     13    3.25           1.25  0.06372549      0.8015812

With this function, we can specify to mean center the variable
`center=T`, but not to modify the standard deviation `scale=F`. If we
want to create a standardized variable out of it we can include both
arguments, lets remeber that a standardized variable is when the mean =
0, and sd = 1

``` r
dat2$CG_std <- scale(dat2$CG_mean, center=T, scale = T)[,1]
head(dat2)
```

    ##   Q65 Q69 Q71 Q72 Q73 Q275 Q260 Q262 Q65_r Q69_r Q71_r Q72_r Q73_r X3 X6 X2 X1
    ## 1  NA   1   1   1   1    3    2   60    NA     4     4     4     4  1  0  0  0
    ## 2  NA   3   4   4   4    7    1   47    NA     2     1     1     1  0  0  0  0
    ## 3  NA   2   3   3   3    7    1   48    NA     3     2     2     2  0  0  0  0
    ## 4  NA   3   3   3   3    2    2   62    NA     2     2     2     2  0  0  1  0
    ## 5  NA   2   2   3   2    2    1   49    NA     3     3     2     3  0  0  1  0
    ## 6  NA   1   2   2   2    1    2   51    NA     4     3     3     3  0  0  0  1
    ##   X4 X5 X7 X0 X8 CG_sum CG_mean CG_mean_minus2 CG_mean_age CG_mean_center
    ## 1  0  0  0  0  0     16    4.00           2.00  0.06666667      1.5515812
    ## 2  0  0  1  0  0      5    1.25          -0.75  0.02659574     -1.1984188
    ## 3  0  0  1  0  0      9    2.25           0.25  0.04687500     -0.1984188
    ## 4  0  0  0  0  0      8    2.00           0.00  0.03225806     -0.4484188
    ## 5  0  0  0  0  0     11    2.75           0.75  0.05612245      0.3015812
    ## 6  0  0  0  0  0     13    3.25           1.25  0.06372549      0.8015812
    ##       CG_std
    ## 1  2.1084462
    ## 2 -1.6285333
    ## 3 -0.2696317
    ## 4 -0.6093571
    ## 5  0.4098192
    ## 6  1.0892700

By setting both arguments `T`, we have standardized the mean composite
score of **Confidence in the government**.

# Selecting subsets

In many cases you would want to work a subset of subjects in the data
set. So lets see a few ways to do these selections. We will use the
`subset()` function. First, lets see if we wanted to select only
subjects that have **Bachelor or equivalent** as their highest education
level.

``` r
attributes(dat2$Q275)
table(dat2$Q275, useNA = "always")
```

We can see that this has the value **6** in this data set, so we can
select these cases like this

``` r
dat2_ed6 <- subset(dat2, Q275 == 6)
dim(dat2_ed6)
```

    ## [1] 13045    28

We first named our new data set, `dat2_ed6` in this case. Then use use
the subset function, the first argument is the full data set. And the
second argument is a (series) logical argument(s) to do the selection.
In this case that **Q275 == 6** this indicating that only values equal
to 6 will be selected. Note that these are 2 equal signs, not one.

Here we present to logical operatiors you can use in R.

| Operator | Description          |
|----------|----------------------|
| ==       | exactly equal        |
| \<       | lower than           |
| \<=      | lower than or equal  |
| \>       | higher than          |
| \>=      | higher than or equal |
| x & y    | x AND y              |
| x \| y   | x OR y               |
| !=       | not equal to         |
| !x       | not x                |

Now that we have seen some operators, lets make a couple of other
selection methods. Lets say that you want to select The subjects that
have Bachelor or higher, this means values of 6 or higher

``` r
dat2_ed678 <- subset(dat2, Q275 == 6 | Q275 == 7 | Q275 == 8)
dim(dat2_ed678)
```

    ## [1] 18513    28

``` r
table(dat2_ed678$Q275)
```

    ## 
    ##     6     7     8 
    ## 13045  4548   920

We can also do this with continuous variables, we have the age of the
subjects (Q262), so lets say that we want to select only subjects that
are older than 18 years old, meaning 19 or higher

``` r
dat2_age19 <- subset(dat2, Q262 > 18)
dim(dat2_age19)
```

    ## [1] 74913    28

Or we could select 18 or higher, meaning to not exclude 18 years old

``` r
dat2_age18 <- subset(dat2, Q262 >= 18)
dim(dat2_age18)
```

    ## [1] 76450    28

For a last one, lets combine this. Lets select subjects that have a
bachelor degree as their highest education level, and they are 25 years
old or older

``` r
dat2_bach25 <- subset(dat2, Q262 >= 15 & Q275 == 6)
dim(dat2_bach25)
```

    ## [1] 12973    28
