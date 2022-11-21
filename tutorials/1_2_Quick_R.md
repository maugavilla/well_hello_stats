Intro_to_R
================
Laura Eberlein, Santiago Gómez-Echeverry & Dimitris Pavlopoulos
21 noviembre, 2022

*\## Session 1: Introduction to R*

In this seminar session, we introduce working with R. We illustrate some
basic functionality and help you familiarize yourself with RStudio.

*1 Getting to know R*

*1.1 First steps in R*

Let’s go through some of the basics of R. We can use R as a simple
calculator.

``` r
2+6
```

    ## [1] 8

Now that we know how to use the + sign for addition, let’s try some
other mathematical operations such as subtraction (-), multiplication
(\*), and division (/).

``` r
10-4
```

    ## [1] 6

``` r
5*3
```

    ## [1] 15

``` r
8/2
```

    ## [1] 4

In R, we always use objects and functions. Functions are what other
programs call commands, a set of instructions that carry out a specific
task. Functions often require some input and generate some output. For
example, instead of using the + operator for addition, we can use the
sum function to add two or more numbers.

``` r
sum(2,6)
```

    ## [1] 8

If you want to have a look at the online documentation of each function
in R, you can use help() or ?function.

    ## starting httpd help server ... done

In the example above, 2 and 6 are the inputs and 8 is the output. A
function always requires the use of parenthesis or round brackets ().
Inputs to the function are called arguments and go inside the brackets.
The output of a function is displayed on the screen. If we want to save
the results of our output, we can assign it to an object. To assign our
result to an object, we use the assignment operator “\<-”. If we want to
save our results of sum(2,6), we could do the following:

``` r
myresult <- sum(2,6)
myresult
```

    ## [1] 8

The line above creates a new object called myresult in our environment
and saves the result of the function in it.

*Sequences* Sequences are often needed when manipulating data. For
instance, you might want to perform an operation on the first 10 rows of
a data set so we need a way to select the range we are interested in.
There are two ways to create a sequence. Let’s try to create a sequence
of numbers from 1 to 10 using the two methods:

1)  Using the colon : operator. If you’re familiar with spreadsheets
    then you migh have already used : to select cells, for example
    A1:A20. In R, you can use the : to create a sequence in a similar
    fashion:
2)  Using the seq() function. The seq function has a number of options
    which control how the sequence is generated. For example, to create
    a sequence from 0 to 100 in increments of 5, we can use the optional
    “by” argument.

``` r
1:10
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
seq(from = 1,to = 10)
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
seq(from = 0,to = 100, by = 5)
```

    ##  [1]   0   5  10  15  20  25  30  35  40  45  50  55  60  65  70  75  80  85  90
    ## [20]  95 100

*1.2 Variables*

There are basically four types of variables in R:

1.  Numeric (Numbers)
2.  Character (Text, sometimes also called ‘strings’)
3.  Factor (Categorical data)
4.  Logical (True or False)

*Numeric*

``` r
x <- 20
x = 20 # There are different ways of assigning objects
x
```

    ## [1] 20

``` r
class(x) # View the class of the value assigned to x
```

    ## [1] "numeric"

*Character*

Textual data (recognizable by the quotes), either as single characters,
entire words, or even full texts.

``` r
chr <- "Some random text"
chr
```

    ## [1] "Some random text"

``` r
xt <- "20"
xt
```

    ## [1] "20"

Run the code below and see what happens.

``` r
#sum(xt,x) # Why is there an error?
```

Naturally, you cannot perform math with character data. Using the wrong
data type will generally yield an error. You can convert the value to a
different type with the *as* command:

``` r
xt1 <- as.numeric(xt) # converts character into numeric
sum(xt1,x)
```

    ## [1] 40

*Factor*

Factors are variables in R which take on a limited number of different
values, and are employed to refer to categorical variables (nominal or
ordinal).

``` r
f <- as.factor(1:10)
f
```

    ##  [1] 1  2  3  4  5  6  7  8  9  10
    ## Levels: 1 2 3 4 5 6 7 8 9 10

``` r
fac <- factor(c("SPSS", "Stata", "R"))
fac
```

    ## [1] SPSS  Stata R    
    ## Levels: R SPSS Stata

Note that although factors seem like typical numbers, they are not meant
for standard algebra.

``` r
mean(f) 
```

    ## Warning in mean.default(f): argument is not numeric or logical: returning NA

    ## [1] NA

Ordered factors can be created by setting the argument ordered=T

``` r
software <- factor(fac, levels = fac, ordered = T)
software
```

    ## [1] SPSS  Stata R    
    ## Levels: SPSS < Stata < R

*Logical*

Logical is a factor that takes on the values TRUE (also abbreviated T)
and FALSE (F). Logical vectors can be used in mathematical operations:
TRUE is treated as 1 and FALSE as 0.

``` r
test <- ifelse(x<30,TRUE, FALSE)
test
```

    ## [1] TRUE

*1.3 Data Structures*

There are different data structures in R. In the following, we will look
at vectors and data frames.

*Vectors*

A vector in R is a sequence of one or more values of the same data type.
From a social science background, it is very similar to what we often
call a variable.

We can create a vector in R using the *c()* function, where c stands for
collect. A vector can have any of the data types discussed above.

``` r
age <- c(27, 21, 23, 24)
age
```

    ## [1] 27 21 23 24

``` r
master <- c("Sociology", "Psychology", "Economics", "Political Science")
master
```

    ## [1] "Sociology"         "Psychology"        "Economics"        
    ## [4] "Political Science"

*class()* returns the type of a variable or in fact any object in R.

``` r
class(age)
```

    ## [1] "numeric"

``` r
class(master)
```

    ## [1] "character"

Let’s see how many elements our vector contains using the length()
function.

``` r
length(age)
```

    ## [1] 4

Next, we access the first element in our vector. We use square brackets
to access a specific element. The number in the square brackets is the
vector element that we access.

``` r
age[2] # second vector element
```

    ## [1] 21

To access all elements except the first element, we use the *-*
operator.

``` r
age[-2] # all elements except the second one
```

    ## [1] 27 23 24

We can access elements 2 to 4 by using a colon.

``` r
age[2:4]
```

    ## [1] 21 23 24

Finally, we can also access two specific non-adjacent elements, by using
the collect function c().

``` r
age[c(2,4)] # second and fourth element
```

    ## [1] 21 24

*Data frame*

A data frame is an object that holds data in a tabular format similar to
how spreadsheets work. Variables are generally kept in columns and
observations are in rows. To create a data frame, we use the
*data.frame()* function.

``` r
dat <- data.frame(id = 1:4, 
                  age = age, 
                  gender = c("Male", "Female", "Male", "Female"),
                  master = master, 
                  score = 6:9)
dat
```

    ##   id age gender            master score
    ## 1  1  27   Male         Sociology     6
    ## 2  2  21 Female        Psychology     7
    ## 3  3  23   Male         Economics     8
    ## 4  4  24 Female Political Science     9

As you can see, we created a data frame by combining different vectors.
We gave a name to each vector, so the variable names in the dataset
correspond to our vector names.

We can see the names of variables in our dataset with the names
function.

``` r
names(dat)
```

    ## [1] "id"     "age"    "gender" "master" "score"

We can also check the variable types in our data by using the *str()*
function.

``` r
str(dat)
```

    ## 'data.frame':    4 obs. of  5 variables:
    ##  $ id    : int  1 2 3 4
    ##  $ age   : num  27 21 23 24
    ##  $ gender: chr  "Male" "Female" "Male" "Female"
    ##  $ master: chr  "Sociology" "Psychology" "Economics" "Political Science"
    ##  $ score : int  6 7 8 9

Maybe you have noticed the new data frame object in your global
environment window. You can view the dataset in the spreadsheet form
that we are all used to by clicking on the object name.

The data structure clearly implies that there is a relation between the
elements in the column vectors. In other words, that each row represents
a case. In our example, these cases are participants, and the columns
represent:

- the participant id
- demographic variables: age and gender
- their master studies
- grades

*Selecting rows, columns and elements*

Often we want to access certain observations (rows) or certain columns
(variables) or a combination of the two without looking at the entire
dataset all at once. A way to select one column of your data is to use
the dollar sign (\$).

``` r
dat$age # select the age column using the dollar sign
```

    ## [1] 27 21 23 24

Additionally, we can use square brackets to subset data frames. In
square brackets we put a row and a column coordinate separated by a
comma. The row coordinate goes first and the column coordinate second.
For example:

``` r
dat[3,2] # returns the third row and the second column of the data frame.
```

    ## [1] 23

If we leave the column coordinate empty this means we would like all
columns. So, data\[3,\] returns the third row of the dataset.

``` r
dat[3,]
```

    ##   id age gender    master score
    ## 3  3  23   Male Economics     8

``` r
dat[,2]
```

    ## [1] 27 21 23 24

If we leave the row coordinate empty, R returns the entire column.
data\[,2\] returns the second column of the dataset.

``` r
dat[,2]
```

    ## [1] 27 21 23 24

We can also select all columns but the second one:

``` r
dat[,-2]
```

    ##   id gender            master score
    ## 1  1   Male         Sociology     6
    ## 2  2 Female        Psychology     7
    ## 3  3   Male         Economics     8
    ## 4  4 Female Political Science     9

Or select only columns 1 and 4:

``` r
dat[,c(1,4)]
```

    ##   id            master
    ## 1  1         Sociology
    ## 2  2        Psychology
    ## 3  3         Economics
    ## 4  4 Political Science

If you are working with larger data sets, it is often useful to look at
the first columns in your data frame to get a better understanding of
it. Below we only want to look at the first two rows of our data:

``` r
dat[1:2,]
```

    ##   id age gender     master score
    ## 1  1  27   Male  Sociology     6
    ## 2  2  21 Female Psychology     7

A very useful additional trick is that you can use all the columns to
make comparisons. For example, we can use the gender column to look up
all elements for which the value is “Male”, and use this to select rows.

``` r
dat[dat$gender == "Male",]
```

    ##   id age gender    master score
    ## 1  1  27   Male Sociology     6
    ## 3  3  23   Male Economics     8

You can do the same selecting two columns:

``` r
dat[dat$gender == "Male" & dat$master == "Sociology",]
```

    ##   id age gender    master score
    ## 1  1  27   Male Sociology     6

We can also use a condition, for example whether the students in our
dataset passed the course.

``` r
dat[dat$score>6,]
```

    ##   id age gender            master score
    ## 2  2  21 Female        Psychology     7
    ## 3  3  23   Male         Economics     8
    ## 4  4  24 Female Political Science     9

And use these conditions to *create new variables*:

``` r
dat$pass <- dat$score>6
dat
```

    ##   id age gender            master score  pass
    ## 1  1  27   Male         Sociology     6 FALSE
    ## 2  2  21 Female        Psychology     7  TRUE
    ## 3  3  23   Male         Economics     8  TRUE
    ## 4  4  24 Female Political Science     9  TRUE

*Subsetting*

Exercise 1: With the selection techniques you already learned how to
create a subset of the data. Try to subset the data so that only
students who passed their studies are included. Assign this subset to a
new name.

``` r
dat_new <- dat[dat$score>6,]
dat_new
```

    ##   id age gender            master score pass
    ## 2  2  21 Female        Psychology     7 TRUE
    ## 3  3  23   Male         Economics     8 TRUE
    ## 4  4  24 Female Political Science     9 TRUE

``` r
write.csv(dat_new, file = "test_data2.csv")
```

*2 Importing and saving data*

*2.1 Working directory*

Each R sessions is connected to a particular folder on your computer,
your working directory. We can check where we are by using the function
getwd() which stands for “get the current working directory”. This
resulting path is where the data will be stored.

    ## [1] "C:/Users/Startklar/OneDrive - Vrije Universiteit Amsterdam/Measurement Models in Quantitative Research/3 - Practicals/Meas_Models/well_hello_stats/tutorials"

*2.2 Saving data*

To save a data frame, ▶ write.csv() writes a data.frame object to a
CSV-file ▶ It takes an object and file path as input

``` r
write.csv(dat, file = "test_data.csv") # saves our previously created data frame
```

Have a look at the working directory you are currently using. After
running the previous R code, it should contain a csv file called
“test_data.csv”.

*2.3 Importing data*

Before you load the dataset into R, you first download it and save it
locally in your preferred working directory. We often load existing data
sets into R for analysis. Data come in many different file formats such
as .csv, .sav, .dta, etc.

You probably noticed that we installed a package before importing our
data. Once we have installed a package, we need to load it with the
library() function. After loading the package, we have access to the
package functions.

Let’s have a first look at our data:

    ## [1] 18060   513

    ## [1] 18060

    ## [1] 513

    ##          name essround edition  proddate  idno cntry   pweight   dweight nwspol
    ## 1  ESS10e01_3       10     1.3 4.10.2022 10002    BG 0.2177165 1.0323056     80
    ## 2  ESS10e01_3       10     1.3 4.10.2022 10006    BG 0.2177165 0.8791201     63
    ## 3  ESS10e01_3       10     1.3 4.10.2022 10009    BG 0.2177165 1.0060982    390
    ## 4  ESS10e01_3       10     1.3 4.10.2022 10024    BG 0.2177165 0.9553269     60
    ## 5  ESS10e01_3       10     1.3 4.10.2022 10027    BG 0.2177165 0.8410089    120
    ## 6  ESS10e01_3       10     1.3 4.10.2022 10048    BG 0.2177165 0.9463409     60
    ## 7  ESS10e01_3       10     1.3 4.10.2022 10053    BG 0.2177165 1.0139321     30
    ## 8  ESS10e01_3       10     1.3 4.10.2022 10055    BG 0.2177165 1.0327791     70
    ## 9  ESS10e01_3       10     1.3 4.10.2022 10059    BG 0.2177165 0.9908482     60
    ## 10 ESS10e01_3       10     1.3 4.10.2022 10061    BG 0.2177165 1.0490237     60
    ##    netusoft netustm ppltrst pplfair pplhlp polintr psppsgva actrolga psppipla
    ## 1         1      NA       5       5      1       4        1        2        2
    ## 2         5     180       0       6      2       1        4        4        4
    ## 3         5     405       5       3      4       3        3        2        2
    ## 4         5      80       5       5      3       4        1        1        1
    ## 5         5     120       4       4      2       1        3        1        1
    ## 6         5      60       3       3      3       1        1        1        1
    ## 7         5     120       3       5      5       3        2        2        2
    ## 8         5     260       4       4      6       3        3        2        2
    ## 9         1      NA       5       7      4       3        4        1        2
    ## 10        1      NA       0       1      2       3        1        1        1
    ##    cptppola trstprl trstlgl trstplc trstplt trstprt trstep trstun trstsci vote
    ## 1         2       3       2       3       3       3      4      4       6    2
    ## 2         4       5       8       9       6       7      8      8      10    1
    ## 3         2       3       3       3       3       2      6      5       6    1
    ## 4        NA       2       2       3       0       0      3      3       3    2
    ## 5         1       0       0       0       0       0      0      0       3    1
    ## 6         1       0       0       0       0       0      5      3       5    2
    ## 7         1       5       4       7       5       3      8      8       6    2
    ## 8         2       2       2       4       1       1      2      2       5    2
    ## 9        NA       2       3       7       2       2      5      7       8    1
    ## 10        1       0       0       2       0       0      0      0       9    1
    ##    prtvtebg prtvtbhr prtvtecz prtvthee prtvtefi prtvtefr prtvtghu prtvclt1
    ## 1        NA       NA       NA       NA       NA       NA       NA       NA
    ## 2         1       NA       NA       NA       NA       NA       NA       NA
    ## 3        NA       NA       NA       NA       NA       NA       NA       NA
    ## 4        NA       NA       NA       NA       NA       NA       NA       NA
    ## 5         2       NA       NA       NA       NA       NA       NA       NA
    ## 6        NA       NA       NA       NA       NA       NA       NA       NA
    ## 7        NA       NA       NA       NA       NA       NA       NA       NA
    ## 8        NA       NA       NA       NA       NA       NA       NA       NA
    ## 9         4       NA       NA       NA       NA       NA       NA       NA
    ## 10        3       NA       NA       NA       NA       NA       NA       NA
    ##    prtvclt2 prtvclt3 prtvtfsi prtvtesk contplt donprty badge sgnptit pbldmna
    ## 1        NA       NA       NA       NA       2       2     2       2       2
    ## 2        NA       NA       NA       NA       1       2     2       2       2
    ## 3        NA       NA       NA       NA       2       2     2       2       2
    ## 4        NA       NA       NA       NA       2       2     2       2       2
    ## 5        NA       NA       NA       NA       1       2     1       2       1
    ## 6        NA       NA       NA       NA       2       2     2       2       2
    ## 7        NA       NA       NA       NA       2       2     2       2       2
    ## 8        NA       NA       NA       NA       2       2     2       2       2
    ## 9        NA       NA       NA       NA       2       2     2       2       2
    ## 10       NA       NA       NA       NA       2       2     2       2       2
    ##    bctprd pstplonl volunfp clsprty prtclebg prtclbhr prtclecz prtclhee prtclffi
    ## 1       2        2       2       2       NA       NA       NA       NA       NA
    ## 2       1        2       2       1        1       NA       NA       NA       NA
    ## 3       2       NA       2       1       NA       NA       NA       NA       NA
    ## 4       2       NA       2       2       NA       NA       NA       NA       NA
    ## 5       1        1       2       1        9       NA       NA       NA       NA
    ## 6       2        2       2       2       NA       NA       NA       NA       NA
    ## 7       2        2       2       2       NA       NA       NA       NA       NA
    ## 8       2        2       2       1        2       NA       NA       NA       NA
    ## 9       2        2       2       2       NA       NA       NA       NA       NA
    ## 10      2        2       2       1        3       NA       NA       NA       NA
    ##    prtclffr prtclhhu prtclclt prtclfsi prtclesk prtdgcl lrscale stflife stfeco
    ## 1        NA       NA       NA       NA       NA      NA      NA       8      3
    ## 2        NA       NA       NA       NA       NA       1      10      10      3
    ## 3        NA       NA       NA       NA       NA      NA       4       5      5
    ## 4        NA       NA       NA       NA       NA      NA      NA       4      2
    ## 5        NA       NA       NA       NA       NA       1       4       3      2
    ## 6        NA       NA       NA       NA       NA      NA       5       5      0
    ## 7        NA       NA       NA       NA       NA      NA       5       6      4
    ## 8        NA       NA       NA       NA       NA       2       1       5      2
    ## 9        NA       NA       NA       NA       NA      NA       6       5      2
    ## 10       NA       NA       NA       NA       NA       2       7       5      0
    ##    stfgov stfdem stfedu stfhlth gincdif freehms hmsfmlsh hmsacld euftf lrnobed
    ## 1       4      4      3       4       4       3        3       3     2       3
    ## 2       3      8      8       3       5       3        2       4    10       4
    ## 3       2      2      3       2       4       4        3       3     6       1
    ## 4       2      0      1       1       2       3        2       4     4       3
    ## 5       9      3      2       1       1       4        2       5     8       3
    ## 6       0      0      5       3       1       5        1       5     5       1
    ## 7       3      6      6       7       1       2        4       4     7       2
    ## 8       1      1      5       3       2       3        3       3     4       1
    ## 9       2      5      6       7       1       2       NA       5     4       1
    ## 10      0      0     NA       3       1       5        1       5     0       1
    ##    loylead imsmetn imdfetn impcntr imbgeco imueclt imwbcnt happy sclmeet
    ## 1        3       3       3       3       2       2       2     6       6
    ## 2        2       1       2       2       7       5       4     9       7
    ## 3        2       1       3       2       6       7       6     5       4
    ## 4        3       1       3       2      NA      NA       5     3       4
    ## 5        5       1       3       4       4       5       3     3       4
    ## 6        2       1       2       2       5       5       5     5       6
    ## 7        3       2       3       3       4       5       4     7       7
    ## 8        2       2       2       2       5       5       5     5       3
    ## 9        2       1       2       2       7       7       7     6       6
    ## 10       1       4       4       4       1       1       0     5       2
    ##    inprdsc sclact crmvct aesfdrk health hlthhmp atchctr atcherp rlgblg rlgdnm
    ## 1        2      3      2       2      2       3       8       6      1      3
    ## 2        3      3      2       1      2       3      10       8      1      3
    ## 3        4      5      1       4      3       3       8       8      1      3
    ## 4        1      3      2       2      3       2       5       3      1      3
    ## 5        0      3      2       2      2       3       8       0      1      3
    ## 6        3      2      2       3      1       3      10       8      1      3
    ## 7        2      3      2       2      1       3      10       8      1      3
    ## 8        2      2      2       3      2       3       7       4      2     NA
    ## 9        1      4      2       2      3       2       9       4      1      3
    ## 10       2      1      2       2      4       1       4       0      1      6
    ##    rlgdnafi rlgdnhu rlgdnlt rlgdnbsk rlgblge rlgdnme rlgdeafi rlgdehu rlgdelt
    ## 1        NA      NA      NA       NA      NA      NA       NA      NA      NA
    ## 2        NA      NA      NA       NA      NA      NA       NA      NA      NA
    ## 3        NA      NA      NA       NA      NA      NA       NA      NA      NA
    ## 4        NA      NA      NA       NA      NA      NA       NA      NA      NA
    ## 5        NA      NA      NA       NA      NA      NA       NA      NA      NA
    ## 6        NA      NA      NA       NA      NA      NA       NA      NA      NA
    ## 7        NA      NA      NA       NA      NA      NA       NA      NA      NA
    ## 8        NA      NA      NA       NA       2      NA       NA      NA      NA
    ## 9        NA      NA      NA       NA      NA      NA       NA      NA      NA
    ## 10       NA      NA      NA       NA      NA      NA       NA      NA      NA
    ##    rlgdebsk rlgdgr rlgatnd pray dscrgrp dscrrce dscrntn dscrrlg dscrlng dscretn
    ## 1        NA      2       6    6       2       0       0       0       0       0
    ## 2        NA      6       6    6       2       0       0       0       0       0
    ## 3        NA      5       5    5       2       0       0       0       0       0
    ## 4        NA      6       5    2      NA       0       0       0       0       0
    ## 5        NA      4       5    5       2       0       0       0       0       0
    ## 6        NA     10       5    5       2       0       0       0       0       0
    ## 7        NA      5       5    6       2       0       0       0       0       0
    ## 8        NA      2       7    6       2       0       0       0       0       0
    ## 9        NA      5       5   NA       2       0       0       0       0       0
    ## 10       NA      5       5    5       2       0       0       0       0       0
    ##    dscrage dscrgnd dscrsex dscrdsb dscroth dscrdk dscrref dscrnap dscrna
    ## 1        0       0       0       0       0      0       0       1      0
    ## 2        0       0       0       0       0      0       0       1      0
    ## 3        0       0       0       0       0      0       0       1      0
    ## 4        0       0       0       0       0      0       0       1      0
    ## 5        0       0       0       0       0      0       0       1      0
    ## 6        0       0       0       0       0      0       0       1      0
    ## 7        0       0       0       0       0      0       0       1      0
    ## 8        0       0       0       0       0      0       0       1      0
    ## 9        0       0       0       0       0      0       0       1      0
    ## 10       0       0       0       0       0      0       0       1      0
    ##    ctzcntr brncntr cntbrthd livecnta lnghom1 lnghom2 feethngr facntr fbrncntc
    ## 1        1       1     6666       NA     BUL     000        1      1     6666
    ## 2        1       1     6666       NA     BUL     000        1      1     6666
    ## 3        1       1     6666       NA     BUL     000        1      1     6666
    ## 4       NA       1     6666       NA     BUL     000        1      1     6666
    ## 5        1       1     6666       NA     RUS     BUL        1      1     6666
    ## 6        1       1     6666       NA     BUL     000        1      1     6666
    ## 7        1       1     6666       NA     BUL     000        1      1     6666
    ## 8        1       1     6666       NA     BUL     000        1      1     6666
    ## 9        1       1     6666       NA     BUL     000        1      1     6666
    ## 10       1       1     6666       NA     TUR     000        2      1     6666
    ##    mocntr mbrncntc ccnthum ccrdprs wrclmch admrclc testic34 testic35 testic36
    ## 1       1     6666       5       7       4       1        7        8        8
    ## 2       1     6666       5       8       3       1        8        2        9
    ## 3       1     6666       3       8       3       3       NA       NA       NA
    ## 4       1     6666       4       7       4       3       NA       NA       NA
    ## 5       1     6666       3       4       4       2       NA       NA       NA
    ## 6       1     6666       3       7       3       1        7        3        5
    ## 7       1     6666       4       6       3       3       NA       NA       NA
    ## 8       1     6666       1       1       3       1        3        3        3
    ## 9       1     6666       5       8       4       2       NA       NA       NA
    ## 10      1     6666       1       0       1       1        0        0        0
    ##    testic37 testic38 testic39 testic40 testic41 testic42 vteurmmb vteubcmb
    ## 1        NA       NA       NA       NA       NA       NA       33       NA
    ## 2        NA       NA       NA       NA       NA       NA        1       NA
    ## 3        NA       NA       NA        3        3        4        1       NA
    ## 4        NA       NA       NA        4        3        3       55       NA
    ## 5         2        2        2       NA       NA       NA        2       NA
    ## 6        NA       NA       NA       NA       NA       NA        1       NA
    ## 7        NA       NA       NA        4        4        4        1       NA
    ## 8        NA       NA       NA       NA       NA       NA        1       NA
    ## 9         3        2        4       NA       NA       NA        2       NA
    ## 10       NA       NA       NA       NA       NA       NA        2       NA
    ##    fairelc dfprtal medcrgv rghmgpr votedir cttresa gptpelc gvctzpv grdfinc
    ## 1        9       8       7       8       8       8       8       8       7
    ## 2        8      10       9       0      10      10       8       2       7
    ## 3        9       9       8       5       7       5       7       3       6
    ## 4       10      10      10      10       7      10      10      10      10
    ## 5        9       8      10       5      10      10       8       5       8
    ## 6       10      10      10      10      10      10      10      10      10
    ## 7       10      10      10      10       8      10       8      10      10
    ## 8        5       5       7       5       7      10      10      10      10
    ## 9        9       8       9       8       8       9       8      10      10
    ## 10      10      10      10      10      10      10      10      10      10
    ##    viepol wpestop keydec fairelcc dfprtalc medcrgvc rghmgprc votedirc cttresac
    ## 1       7       7      8        1        2        1        9        2        1
    ## 2       6       3     NA       10        0        9       10        0        4
    ## 3       6       6      7        8        6        6        5        5        4
    ## 4       7       8      5        3        0        2        5        2        3
    ## 5       3       3     10        2        4        3       10        0        1
    ## 6      10      10     10        0        0        0       10        0        0
    ## 7       8      10      7        4        4        9       10        4        4
    ## 8      10      10      5        1        1        7        5        1        2
    ## 9       7       8      9        7        6        6        8        5        4
    ## 10     10      10     10        0        0        0        6        0        0
    ##    gptpelcc gvctzpvc grdfincc viepolc wpestopc keydecc chpldm chpldmi chpldmc
    ## 1         1        2        1       2        1       2      1       9       1
    ## 2        10        6        3       4        3       0      5      NA       8
    ## 3         2        2        5       1        2       5      1       4       6
    ## 4         0        3        3       0        0       7     NA      NA       3
    ## 5         2        2        1       0        0       8      5      NA      NA
    ## 6         0        0        0       0        0       5      1      10       0
    ## 7         7        5        2       5        5       8      1       8       6
    ## 8         1        1        1       1        1      NA      5      NA       1
    ## 9         3        3        4       4        7       7      5      NA       4
    ## 10        2        0        1       0        0       0      1      10       1
    ##    stpldmi stpldmc admit showcv impdema impdemb impdemc impdemd impdeme implvdm
    ## 1       NA      NA     3      1      NA      NA       1      NA      NA       3
    ## 2       NA      NA     2      1      NA       3      NA      NA      NA      10
    ## 3       NA      NA     4      1      NA      NA      NA       4      NA       2
    ## 4       NA      NA     5      1      NA      NA      NA      NA       5       4
    ## 5       NA      NA     5      1      NA      NA      NA      NA       1       7
    ## 6       NA      NA     5      1      NA      NA      NA      NA       4      10
    ## 7       NA      NA     1      1       1      NA      NA      NA      NA      10
    ## 8       NA      NA     1      1       3      NA      NA      NA      NA       5
    ## 9       NA      NA     3      1      NA      NA       2      NA      NA       9
    ## 10      NA      NA     4      1      NA      NA      NA       1      NA       5
    ##    accalaw hhmmb gndr gndr2 gndr3 gndr4 gndr5 gndr6 gndr7 gndr8 gndr9 gndr10
    ## 1        1     2    2     1    NA    NA    NA    NA    NA    NA    NA     NA
    ## 2        0     4    1     2     1     2    NA    NA    NA    NA    NA     NA
    ## 3        2     1    2    NA    NA    NA    NA    NA    NA    NA    NA     NA
    ## 4        3     3    2     1     2    NA    NA    NA    NA    NA    NA     NA
    ## 5        0     2    1     2    NA    NA    NA    NA    NA    NA    NA     NA
    ## 6       10     2    2     1    NA    NA    NA    NA    NA    NA    NA     NA
    ## 7        3     4    1     2     2     1    NA    NA    NA    NA    NA     NA
    ## 8        9     2    1     1    NA    NA    NA    NA    NA    NA    NA     NA
    ## 9        7     2    1     2    NA    NA    NA    NA    NA    NA    NA     NA
    ## 10      10     2    1     2    NA    NA    NA    NA    NA    NA    NA     NA
    ##    gndr11 gndr12 gndr13 yrbrn agea yrbrn2 yrbrn3 yrbrn4 yrbrn5 yrbrn6 yrbrn7
    ## 1      NA     NA     NA  1945   76   1941     NA     NA     NA     NA     NA
    ## 2      NA     NA     NA  1978   43   1978   2008   2015     NA     NA     NA
    ## 3      NA     NA     NA  1971   50     NA     NA     NA     NA     NA     NA
    ## 4      NA     NA     NA  1970   51   1998   2000     NA     NA     NA     NA
    ## 5      NA     NA     NA  1951   70   1972     NA     NA     NA     NA     NA
    ## 6      NA     NA     NA  1990   31   1987     NA     NA     NA     NA     NA
    ## 7      NA     NA     NA  1981   40   1983   1960   2008     NA     NA     NA
    ## 8      NA     NA     NA  1973   48   1973     NA     NA     NA     NA     NA
    ## 9      NA     NA     NA  1950   71   1952     NA     NA     NA     NA     NA
    ## 10     NA     NA     NA  1950   71   1953     NA     NA     NA     NA     NA
    ##    yrbrn8 yrbrn9 yrbrn10 yrbrn11 yrbrn12 yrbrn13 rshipa2 rshipa3 rshipa4
    ## 1      NA     NA      NA      NA      NA      NA       1      NA      NA
    ## 2      NA     NA      NA      NA      NA      NA       1       2       2
    ## 3      NA     NA      NA      NA      NA      NA      NA      NA      NA
    ## 4      NA     NA      NA      NA      NA      NA       2       6      NA
    ## 5      NA     NA      NA      NA      NA      NA       1      NA      NA
    ## 6      NA     NA      NA      NA      NA      NA       1      NA      NA
    ## 7      NA     NA      NA      NA      NA      NA       1       3       2
    ## 8      NA     NA      NA      NA      NA      NA       6      NA      NA
    ## 9      NA     NA      NA      NA      NA      NA       1      NA      NA
    ## 10     NA     NA      NA      NA      NA      NA       1      NA      NA
    ##    rshipa5 rshipa6 rshipa7 rshipa8 rshipa9 rshipa10 rshipa11 rshipa12 rshipa13
    ## 1       NA      NA      NA      NA      NA       NA       NA       NA       NA
    ## 2       NA      NA      NA      NA      NA       NA       NA       NA       NA
    ## 3       NA      NA      NA      NA      NA       NA       NA       NA       NA
    ## 4       NA      NA      NA      NA      NA       NA       NA       NA       NA
    ## 5       NA      NA      NA      NA      NA       NA       NA       NA       NA
    ## 6       NA      NA      NA      NA      NA       NA       NA       NA       NA
    ## 7       NA      NA      NA      NA      NA       NA       NA       NA       NA
    ## 8       NA      NA      NA      NA      NA       NA       NA       NA       NA
    ## 9       NA      NA      NA      NA      NA       NA       NA       NA       NA
    ## 10      NA      NA      NA      NA      NA       NA       NA       NA       NA
    ##    acchome accwrk accmove accoth accnone accref accdk accna fampref famadvs
    ## 1        0      0       0      0       1      0     0     0       1       1
    ## 2        1      1       1      1       0      0     0     0       4       5
    ## 3        0      1       0      0       0      0     0     0       4       3
    ## 4        1      0       1      0       0      0     0     0       2       3
    ## 5        1      1       1      1       0      0     0     0       1       1
    ## 6        1      0       1      0       0      0     0     0       5       5
    ## 7        1      0       1      0       0      0     0     0       5       5
    ## 8        1      0       1      1       0      0     0     0       3       3
    ## 9        1      0       0      1       0      0     0     0       3       3
    ## 10       0      0       0      0       1      0     0     0       1       1
    ##    fampdf mcclose mcinter mccoord mcpriv mcmsinf chldo12 gndro12a gndro12b
    ## 1       1      NA      NA      NA     NA      NA       1       NA        2
    ## 2       5      10       0      10      7       7       1       NA        1
    ## 3       4       2       7       5      7       7       1       NA        1
    ## 4       3       6       5      10      0       5       3        2       NA
    ## 5       1       5       5       9      5       5       2        1       NA
    ## 6       1      10       0      10      5       5       0       NA       NA
    ## 7       5      10       7       7      3       2       0       NA       NA
    ## 8       1       5       5      NA      5       6       1       NA        1
    ## 9       2       9       4       9      4       5       2        1       NA
    ## 10      1      NA      NA      NA     NA      NA       5        2       NA
    ##    ageo12 hhlio12 closeo12 ttmino12 speako12 scrno12 phoneo12 como12 c19spo12
    ## 1      52       2        1       20        3       7        4      7        3
    ## 2      12       1        2       NA        1       6        1      4        3
    ## 3      33       2        2     3625        3       6        1      6        3
    ## 4      34       2        2       NA        6       3        3      6        3
    ## 5      43       2        3        2        3       7        4      7        3
    ## 6      NA      NA       NA       NA       NA      NA       NA     NA       NA
    ## 7      NA      NA       NA       NA       NA      NA       NA     NA       NA
    ## 8      20       2        1       30        2       6        2      6        3
    ## 9      44       2        1       NA        4       7        3      7        2
    ## 10     48       2        2      240        6       7        4      7        5
    ##    c19mco12 livpnt pntmofa agepnt hhlipnt closepnt ttminpnt speakpnt scrnpnt
    ## 1         3      4      NA     NA      NA       NA       NA       NA      NA
    ## 2         3      1       1     75       2        2       40        3       7
    ## 3         2      4      NA     NA      NA       NA       NA       NA      NA
    ## 4         3      2      NA     70       2        1       20        4       3
    ## 5         3      2      NA     92       2        3       70        4       7
    ## 6        NA      1       1     53       2        1      240        6       2
    ## 7        NA      2      NA     61       1        1       NA        1       7
    ## 8         5      1       1     70       2        2       20        4       7
    ## 9         3      4      NA     NA      NA       NA       NA       NA      NA
    ## 10       NA      4      NA     NA      NA       NA       NA       NA      NA
    ##    phonepnt compnt c19sppnt c19mcpnt stfmjob trdawrk jbprtfp pfmfdjba dcsfwrka
    ## 1        NA     NA       NA       NA      NA      NA      NA       NA       NA
    ## 2         3      5        3        3       9       4       3        3        3
    ## 3        NA     NA       NA       NA       5       4       6       NA        1
    ## 4         3      7        3        3       7       3       3        3        1
    ## 5         3      7        3        3       4       5       5        3        1
    ## 6         2      6        3        3      NA      NA      NA       NA       NA
    ## 7         1      7        3        3      NA      NA      NA       NA       NA
    ## 8         3      7        2        5       6       3       3        3        1
    ## 9        NA     NA       NA       NA      NA      NA      NA       NA       NA
    ## 10       NA     NA       NA       NA      NA      NA      NA       NA       NA
    ##    wrkhome c19whome c19wplch wrklong wrkresp c19whacc mansupp manhlp manwrkpl
    ## 1       NA       NA       NA      NA      NA       NA      NA     NA       NA
    ## 2        1        2        2       6       1       44      55     NA       NA
    ## 3        4       55       NA       6       6        5      55     NA       NA
    ## 4        6       55       NA      55      NA       NA      10      2        1
    ## 5        6       55       NA      55      NA       NA       4      2        1
    ## 6       NA       NA       NA      NA      NA       NA      NA     NA       NA
    ## 7       NA       NA       NA      NA      NA       NA      NA     NA       NA
    ## 8        6       55       NA      NA      NA       NA       8      1        1
    ## 9       NA       NA       NA      NA      NA       NA      NA     NA       NA
    ## 10      NA       NA       NA      NA      NA       NA      NA     NA       NA
    ##    manspeak manscrn manphone mancom teamfeel wrkextra colprop colhlp colspeak
    ## 1        NA      NA       NA     NA       NA       NA      NA     NA       NA
    ## 2        NA      NA       NA     NA       10       10       7      3        4
    ## 3        NA      NA       NA     NA        6        5       4      2        2
    ## 4         1       7        7      7       10        1       2      2        1
    ## 5         1       7        4      7        7        0       1      1        1
    ## 6        NA      NA       NA     NA       NA       NA      NA     NA       NA
    ## 7        NA      NA       NA     NA       NA       NA      NA     NA       NA
    ## 8         6       7        7      7       10        5       2      1        1
    ## 9        NA      NA       NA     NA       NA       NA      NA     NA       NA
    ## 10       NA      NA       NA     NA       NA       NA      NA     NA       NA
    ##    colscrn colphone colcom c19spwrk c19mcwrk mcwrkhom ipcrtiv imprich ipeqopt
    ## 1       NA       NA     NA       NA       NA       NA       2       2       2
    ## 2        6        1      2        3        3       10       1       3       4
    ## 3        6        3      3        3        3        5       3       4       1
    ## 4        7        7      7        3       55       NA       3       5       2
    ## 5        7        3      7        3        3        0       1       3       2
    ## 6       NA       NA     NA       NA       NA       NA       1       5       1
    ## 7       NA       NA     NA       NA       NA       NA       2       4       2
    ## 8        6        3      7        3       55       NA       3       2       1
    ## 9       NA       NA     NA       NA       NA       NA       2       4       2
    ## 10      NA       NA     NA       NA       NA       NA       3       6       2
    ##    ipshabt impsafe impdiff ipfrule ipudrst ipmodst ipgdtim impfree iphlppl
    ## 1        5       3       1       2       4       4       2       1       3
    ## 2        2       5       1       2       1       6       1       1       3
    ## 3        4       5       3       3       4       4       5       2       3
    ## 4        3       3       3       2       2       6       5       4       3
    ## 5        1       5       2       5       3       6       1       2       2
    ## 6        1       1       3       1       2       1       3       1       1
    ## 7        1       2       3       2       2       2       4       1       2
    ## 8        1       1       3       2       4       3       1       2       1
    ## 9        1       2       1       1       2       2       3       2       1
    ## 10       2       3       4       3       4       3       6       3       4
    ##    ipsuces ipstrgv ipadvnt ipbhprp iprspot iplylfr impenv imptrad impfun
    ## 1        5       3       3       2       5       4      3       1      5
    ## 2        1       2       1       5       1       1      1       3      1
    ## 3        4       6       2       4       4       2      2       3      4
    ## 4        4       1       4       2       4       3      3       2      4
    ## 5        2       1       1       5       5       1      4       3      1
    ## 6        1       1       5       1       3       1      1       1      3
    ## 7        2       1       3       1       2       1      1       1      4
    ## 8        2       1       3       2       2       2      1       2      2
    ## 9        2       2       4       2       2       1      3       2      3
    ## 10       5       2       6       3       3       3      3       3      6
    ##    testii1 testii2 testii3 testii4 testii5 testii6 testii7 testii8 testii9
    ## 1        3       3       3      NA      NA      NA      NA      NA      NA
    ## 2        3       1       3      NA      NA      NA      NA      NA      NA
    ## 3       NA      NA      NA      NA      NA      NA       5       5       8
    ## 4       NA      NA      NA      NA      NA      NA       7       6       3
    ## 5       NA      NA      NA       3       1       1      NA      NA      NA
    ## 6        3       2       3      NA      NA      NA      NA      NA      NA
    ## 7       NA      NA      NA      NA      NA      NA       7       7       7
    ## 8        3       2       2      NA      NA      NA      NA      NA      NA
    ## 9       NA      NA      NA       4       2       4      NA      NA      NA
    ## 10       1       1       1      NA      NA      NA      NA      NA      NA
    ##    secgrdec scidecpb admc19 panpriph panmonpb govpriph govmonpb panfolru
    ## 1         2        1      2       NA       NA        1        2        8
    ## 2         1       NA      2       NA       NA        9        3        3
    ## 3         4        2      2       NA       NA        8        5        6
    ## 4         2        3      1        0        5       NA       NA        5
    ## 5         2        2      1        5        5       NA       NA        7
    ## 6         3        3      1        0        5       NA       NA        0
    ## 7        NA        3      1        3        5       NA       NA        4
    ## 8        NA        2      2       NA       NA        6        6        6
    ## 9        NA        4      2       NA       NA        4        4        5
    ## 10       NA       NA      2       NA       NA        4        4        4
    ##    panclobo panresmo gvhanc19 gvjobc19 gveldc19 gvfamc19 hscopc19 gvbalc19
    ## 1         3        8        7        1        8        8        8        5
    ## 2         0        0        3        6        4        7        3       10
    ## 3         6        3        3        4        3        3        3        5
    ## 4        10       10        4        4        4        2        3        4
    ## 5        NA        2        0        0        0        0        2       NA
    ## 6         0        0        0        0        0        0        0        0
    ## 7         8        5        6        5       NA        7        4        4
    ## 8         4        5        5        2        2        2        6        6
    ## 9         8        2        6        3        1        2        7        6
    ## 10        4        4        2        0        3        3        3        7
    ##    gvimpc19 gvconc19 respc19 reshhc19 hapljc19 hapirc19 hapwrc19 hapfuc19
    ## 1         8        1       3        4        0        0        0        0
    ## 2         5        4       2        2        0        1        0        0
    ## 3         3        4       2        4        0        0        0        1
    ## 4         4        2       2        2        0        1        1        0
    ## 5         2        1       3        3        0        0        0        0
    ## 6         0       NA       3        3        0        0        0        0
    ## 7         5        4       3        3        1        0        0        0
    ## 8         1        2       3        1        0        0        0        0
    ## 9         3        2       3        4        0        0        0        0
    ## 10        3       NA       3        3        0        0        0        0
    ##    hapfoc19 hapnoc19 hapnwc19 hapnpc19 haprec19 hapdkc19 hapnac19 icvacc19
    ## 1         0        0        0        1        0        0        0       NA
    ## 2         0        0        0        0        0        0        0       NA
    ## 3         0        0        0        0        0        0        0       NA
    ## 4         0        0        0        0        0        0        0       NA
    ## 5         0        1        0        0        0        0        0       NA
    ## 6         0        1        0        0        0        0        0       NA
    ## 7         0        0        0        0        0        0        0       NA
    ## 8         0        1        0        0        0        0        0       NA
    ## 9         0        0        0        1        0        0        0       NA
    ## 10        0        0        0        1        0        0        0       NA
    ##    getavc19 getnvc19 vdcond vdovexre vdtype vdtpsvre vdtpitre vdtpscre vdtpaure
    ## 1         3       NA      1        9     NA        0        0        0        0
    ## 2         2       NA      1       10     NA        0        0        0        0
    ## 3         2       NA      1        7     NA        0        0        0        0
    ## 4        NA       NA      2        4     NA        0        0        0        0
    ## 5         3       NA      1        7     NA        0        0        0        0
    ## 6         3       NA      2       10     NA        0        0        0        0
    ## 7         2       NA      1        7     NA        0        0        0        0
    ## 8         1       NA      2        7     NA        0        0        0        0
    ## 9         1       NA      1        5     NA        0        0        0        0
    ## 10        3       NA      1        5     NA        0        0        0        0
    ##    vdtpvire vdtpoire vdtpntre vdtpapre vdtprere vdtpdkre vdtpnare
    ## 1         0        0        0        1        0        0        0
    ## 2         0        0        0        1        0        0        0
    ## 3         0        0        0        1        0        0        0
    ## 4         0        0        0        1        0        0        0
    ## 5         0        0        0        1        0        0        0
    ## 6         0        0        0        1        0        0        0
    ## 7         0        0        0        1        0        0        0
    ## 8         0        0        0        1        0        0        0
    ## 9         0        0        0        1        0        0        0
    ## 10        0        0        0        1        0        0        0
    ##                  inwds               ainws               ainwe
    ## 1  2021-07-24 12:17:18 2021-07-24 12:18:03 2021-07-24 12:18:28
    ## 2  2021-08-28 07:30:52 2021-08-28 07:31:47 2021-08-28 07:32:38
    ## 3  2021-07-15 19:59:32 2021-07-15 20:00:37 2021-07-15 20:09:42
    ## 4  2021-08-01 12:22:41 2021-08-01 12:22:52 2021-08-01 12:24:26
    ## 5  2021-07-24 16:25:33 2021-07-24 16:25:36 2021-07-24 16:28:38
    ## 6  2021-08-29 12:21:51 2021-08-29 12:21:55 2021-08-29 12:22:57
    ## 7  2021-09-02 08:23:25 2021-09-02 08:23:26 2021-09-02 08:23:49
    ## 8  2021-07-05 19:55:20 2021-07-05 19:56:13 2021-07-05 19:58:44
    ## 9  2021-09-10 16:29:43 2021-09-10 16:29:45 2021-09-10 16:30:39
    ## 10 2021-08-18 08:47:10 2021-08-18 08:47:14 2021-08-18 08:47:45
    ##                  binwe               cinwe               dinwe
    ## 1  2021-07-24 12:40:18 2021-07-24 12:48:44 2021-07-24 12:56:00
    ## 2  2021-08-28 07:39:33 2021-08-28 07:42:47 2021-08-28 07:47:46
    ## 3  2021-07-15 20:29:47 2021-07-15 20:36:25 2021-07-15 20:43:26
    ## 4  2021-08-01 12:33:09 2021-08-01 12:40:37 2021-08-01 12:50:14
    ## 5  2021-07-24 16:58:07 2021-07-24 17:12:04 2021-07-24 17:29:33
    ## 6  2021-08-29 12:27:02 2021-08-29 12:31:39 2021-08-29 12:34:19
    ## 7  2021-09-02 08:27:20 2021-09-02 08:28:57 2021-09-02 08:30:30
    ## 8  2021-07-05 20:06:21 2021-07-05 20:12:14 2021-07-05 20:17:49
    ## 9  2021-09-10 16:38:50 2021-09-10 16:47:15 2021-09-10 17:02:21
    ## 10 2021-08-18 08:51:39 2021-08-18 08:54:41 2021-08-18 08:59:22
    ##                  finwe               ginwe               hinwe
    ## 1  2021-07-24 13:04:24 2021-07-24 13:05:44 2021-07-24 13:11:27
    ## 2  2021-08-28 07:56:35 2021-08-28 08:04:49 2021-08-28 08:07:22
    ## 3  2021-07-15 20:56:40 2021-07-15 21:26:27 2021-07-15 21:33:51
    ## 4  2021-08-01 13:03:26 2021-08-01 13:16:03 2021-08-01 13:19:41
    ## 5  2021-07-24 17:48:10 2021-07-24 18:02:21 2021-07-24 18:08:15
    ## 6  2021-08-29 12:43:28 2021-08-29 12:46:34 2021-08-29 12:48:56
    ## 7  2021-09-02 08:38:16 2021-09-02 08:39:40 2021-09-02 08:40:34
    ## 8  2021-07-05 20:27:22 2021-07-05 20:47:54 2021-07-05 20:51:29
    ## 9  2021-09-10 17:11:15 2021-09-10 17:15:48 2021-09-10 17:26:18
    ## 10 2021-08-18 09:06:23 2021-08-18 09:08:56 2021-08-18 09:10:58
    ##                  iinwe               kinwe               vinwe
    ## 1  2021-07-24 13:11:35 2021-07-24 13:12:20 2021-07-24 13:12:21
    ## 2  2021-08-28 08:07:39 2021-08-28 08:14:39 2021-08-28 08:14:43
    ## 3  2021-07-15 21:34:36 2021-07-15 21:42:37 2021-07-15 21:42:49
    ## 4  2021-08-01 13:20:15 2021-08-01 13:24:40 2021-08-01 13:24:46
    ## 5  2021-07-24 18:09:09 2021-07-24 18:16:57 2021-07-24 18:17:07
    ## 6  2021-08-29 12:49:21 2021-08-29 12:52:03 2021-08-29 12:52:09
    ## 7  2021-09-02 08:40:44 2021-09-02 09:22:35 2021-09-02 09:22:40
    ## 8  2021-07-05 20:52:06 2021-07-05 20:55:34                <NA>
    ## 9  2021-09-10 17:28:05 2021-09-10 17:31:46                <NA>
    ## 10 2021-08-18 09:11:11 2021-08-18 09:43:37 2021-08-18 09:43:40
    ##                  inwde               jinws               jinwe inwtm domain
    ## 1  2021-07-24 13:13:01 2021-07-24 13:12:33 2021-07-24 13:13:06    53       
    ## 2  2021-08-28 08:36:39 2021-08-28 08:25:43 2021-08-28 08:36:49    36       
    ## 3  2021-07-15 21:44:59 2021-07-15 21:43:42 2021-07-15 21:45:50    93       
    ## 4  2021-08-08 17:42:17 2021-08-01 13:25:19 2021-08-08 17:42:20    57       
    ## 5  2021-07-24 18:19:22 2021-07-24 18:18:09 2021-07-24 18:19:29   103       
    ## 6  2021-08-29 13:12:33 2021-08-29 12:52:24 2021-08-29 13:12:42    27       
    ## 7  2021-09-02 09:23:17 2021-09-02 09:22:52 2021-09-02 09:23:24    17       
    ## 8  2021-07-05 20:57:53 2021-07-05 20:56:27 2021-07-05 20:57:54    55       
    ## 9  2021-09-10 17:34:05 2021-09-10 17:32:21 2021-09-10 17:34:09    57       
    ## 10 2021-08-18 09:45:15 2021-08-18 09:44:03 2021-08-18 09:45:24    24       
    ##                   prob stratum psu rshpsts lvgptnea dvrcdeva marsts maritalb
    ## 1  .000627509143669158      67 426       1        2        2     66        1
    ## 2   .00073685182724148      68 384       1        1        2     66        1
    ## 3  .000643854844383895      57 253      66        1        1      4        4
    ## 4  .000678072799928486      30 102      66        1        1      4        4
    ## 5  .000770242942962795      20  62       1        1        2     66        1
    ## 6   .00068451144034043      64 374       1        2        2     66        1
    ## 7  .000638880243059248      39 166       1        2        2     66        1
    ## 8  .000627221423201263      50 216      66        1        2      1        1
    ## 9  .000653764291200787      38 152       1        2        2     66        1
    ## 10 .000617508543655276      17  50       1        2        2     66        1
    ##    chldhhe domicil edulvlb eisced edlvebg edlvehr edlvdcz edlvdee edlvdfi
    ## 1        1       1     323      4       8      NA      NA      NA      NA
    ## 2        6       4     620      6      12      NA      NA      NA      NA
    ## 3        1       1     720      7      13      NA      NA      NA      NA
    ## 4        6       4     313      4       9      NA      NA      NA      NA
    ## 5        1       4     720      7      13      NA      NA      NA      NA
    ## 6        1       4     323      4       8      NA      NA      NA      NA
    ## 7        6       3     313      4       9      NA      NA      NA      NA
    ## 8        1       1     323      4       7      NA      NA      NA      NA
    ## 9        1       1     323      4       7      NA      NA      NA      NA
    ## 10       1       4       0      1       2      NA      NA      NA      NA
    ##    edlvdfr edlvdahu edlvdlt edlvesi edlvdsk eduyrs pdwrk edctn uempla uempli
    ## 1       NA       NA      NA      NA      NA     12     0     0      0      0
    ## 2       NA       NA      NA      NA      NA     16     1     0      0      0
    ## 3       NA       NA      NA      NA      NA     16     1     0      0      0
    ## 4       NA       NA      NA      NA      NA     11     1     0      0      0
    ## 5       NA       NA      NA      NA      NA     17     1     0      0      0
    ## 6       NA       NA      NA      NA      NA     12     0     0      0      0
    ## 7       NA       NA      NA      NA      NA     12     0     0      1      0
    ## 8       NA       NA      NA      NA      NA     12     1     0      0      0
    ## 9       NA       NA      NA      NA      NA     11     0     0      0      0
    ## 10      NA       NA      NA      NA      NA      3     0     0      0      0
    ##    dsbld rtrd cmsrv hswrk dngoth dngref dngdk dngna mainact mnactic crpdwk
    ## 1      0    1     0     0      0      0     0     0      66       6      2
    ## 2      0    0     0     0      0      0     0     0      66       1      6
    ## 3      0    0     0     0      0      0     0     0      66       1      6
    ## 4      0    0     0     0      0      0     0     0      66       1      6
    ## 5      0    1     0     0      0      0     0     0       6       6      6
    ## 6      0    0     0     1      0      0     0     0      66       8      2
    ## 7      0    0     0     0      0      0     0     0      66       3      2
    ## 8      0    0     0     0      0      0     0     0      66       1      6
    ## 9      0    1     0     0      0      0     0     0      66       6      2
    ## 10     0    1     0     0      0      0     0     0      66       6      2
    ##    pdjobev pdjobyr emplrel emplno wrkctra estsz jbspv njbspv wkdcorga iorgact
    ## 1        1    2013       1  66666       1     4     2  66666        3       2
    ## 2        6    6666       3  66666       1     1     1      5       10      10
    ## 3        6    6666       3  66666       2     2     2  66666        4       5
    ## 4        6    6666       1  66666       1     3     2  66666        5       0
    ## 5        6    6666       1  66666       1     1     2  66666        0       0
    ## 6        1    2020       1  66666       1     1     2  66666        0       0
    ## 7        1    2020       1  66666       2     3     2  66666        0       0
    ## 8        6    6666       1  66666       1     2     2  66666        5       0
    ## 9        1    2014       1  66666       1     1     2  66666        4       2
    ## 10       1    2007       2      0       6     1     2  66666       10      88
    ##    wkhct wkhtot nacer2 tporgwk isco08 wrkac6m uemp3m uemp12m uemp5yr mbtru
    ## 1     40     40     14       3   7531       2      2       6       6     2
    ## 2     40     56     49       5   1120       2      1       2       2     3
    ## 3     50     55    777       4  77777       2      1       1       1     2
    ## 4     40     40     31       4   7543       8      2       6       6     3
    ## 5     40     40     41       4   3113       1      2       6       6     3
    ## 6     40     40     47       4   5223       2      2       6       6     3
    ## 7     40     40     18       4   7223       2      1       1       1     3
    ## 8     48     48    777       4   9622       2      8       6       6     3
    ## 9     40     40     30       4   7233       2      2       6       6     2
    ## 10   555     60      1       5   9212       2      2       6       6     3
    ##    hincsrca hinctnta hincfel edulvlpb eiscedp edlvpebg edlvpehr edlvpdcz
    ## 1         4        7       2      323       4        8       NA       NA
    ## 2         2       77       1      720       7       13       NA       NA
    ## 3         1        7       2     6666      66     6666       NA       NA
    ## 4         1        6       3     6666      66     6666       NA       NA
    ## 5         1        4       3      720       7       13       NA       NA
    ## 6         1       77       3      323       4        8       NA       NA
    ## 7         1       77       3      620       6       12       NA       NA
    ## 8         1        4       3     6666      66     6666       NA       NA
    ## 9         4        3       3      323       4        7       NA       NA
    ## 10        4        3       4        0       1        1       NA       NA
    ##    edlvpdee edlvpdfi edlvpdfr edlvpdahu edlvpdlt edlvpesi edlvpdsk pdwrkp
    ## 1        NA       NA       NA        NA       NA       NA       NA      0
    ## 2        NA       NA       NA        NA       NA       NA       NA      1
    ## 3        NA       NA       NA        NA       NA       NA       NA      0
    ## 4        NA       NA       NA        NA       NA       NA       NA      0
    ## 5        NA       NA       NA        NA       NA       NA       NA      0
    ## 6        NA       NA       NA        NA       NA       NA       NA      1
    ## 7        NA       NA       NA        NA       NA       NA       NA      1
    ## 8        NA       NA       NA        NA       NA       NA       NA      0
    ## 9        NA       NA       NA        NA       NA       NA       NA      0
    ## 10       NA       NA       NA        NA       NA       NA       NA      0
    ##    edctnp uemplap uemplip dsbldp rtrdp cmsrvp hswrkp dngothp dngdkp dngnapp
    ## 1       0       0       0      0     1      0      0       0      0       0
    ## 2       0       0       0      0     0      0      0       0      0       0
    ## 3       0       0       0      0     0      0      0       0      0       1
    ## 4       0       0       0      0     0      0      0       0      0       1
    ## 5       0       0       0      0     0      0      1       0      0       0
    ## 6       0       0       0      0     0      0      0       0      0       0
    ## 7       0       0       0      0     0      0      0       0      0       0
    ## 8       0       0       0      0     0      0      0       0      0       1
    ## 9       0       0       0      0     1      0      0       0      0       0
    ## 10      0       0       0      0     1      0      0       0      0       0
    ##    dngrefp dngnap mnactp crpdwkp isco08p emprelp wkhtotp edulvlfb eiscedf
    ## 1        0      0     66       2   66666       6     666      113       1
    ## 2        0      0     66       6    1345       1      40      323       4
    ## 3        0      0     66       6   66666       6     666      610       6
    ## 4        0      0     66       6   66666       6     666      222       2
    ## 5        0      0     66       2   66666       6     666      323       4
    ## 6        0      0     66       6    4120       1      40      323       4
    ## 7        0      0     66       6    3221       1      60      313       4
    ## 8        0      0     66       6   66666       6     666      229       2
    ## 9        0      0     66       2   66666       6     666      222       2
    ## 10       0      0     66       2   66666       6     666        0       1
    ##    edlvfebg edlvfehr edlvfdcz edlvfdee edlvfdfi edlvfdfr edlvfdahu edlvfdlt
    ## 1         3       NA       NA       NA       NA       NA        NA       NA
    ## 2         7       NA       NA       NA       NA       NA        NA       NA
    ## 3        11       NA       NA       NA       NA       NA        NA       NA
    ## 4         5       NA       NA       NA       NA       NA        NA       NA
    ## 5         8       NA       NA       NA       NA       NA        NA       NA
    ## 6         8       NA       NA       NA       NA       NA        NA       NA
    ## 7         9       NA       NA       NA       NA       NA        NA       NA
    ## 8         6       NA       NA       NA       NA       NA        NA       NA
    ## 9         5       NA       NA       NA       NA       NA        NA       NA
    ## 10        1       NA       NA       NA       NA       NA        NA       NA
    ##    edlvfesi edlvfdsk emprf14 occf14b edulvlmb eiscedm edlvmebg edlvmehr
    ## 1        NA       NA       1       9      113       1        3       NA
    ## 2        NA       NA       1       4      313       4        9       NA
    ## 3        NA       NA       1       4      421       5       10       NA
    ## 4        NA       NA       1       7      229       2        6       NA
    ## 5        NA       NA       1       6      222       2        5       NA
    ## 6        NA       NA       1       7      323       4        7       NA
    ## 7        NA       NA       1       7      313       4        9       NA
    ## 8        NA       NA       1       8      323       4        7       NA
    ## 9        NA       NA       1       7      222       2        5       NA
    ## 10       NA       NA       2       9        0       1        1       NA
    ##    edlvmdcz edlvmdee edlvmdfi edlvmdfr edlvmdahu edlvmdlt edlvmesi edlvmdsk
    ## 1        NA       NA       NA       NA        NA       NA       NA       NA
    ## 2        NA       NA       NA       NA        NA       NA       NA       NA
    ## 3        NA       NA       NA       NA        NA       NA       NA       NA
    ## 4        NA       NA       NA       NA        NA       NA       NA       NA
    ## 5        NA       NA       NA       NA        NA       NA       NA       NA
    ## 6        NA       NA       NA       NA        NA       NA       NA       NA
    ## 7        NA       NA       NA       NA        NA       NA       NA       NA
    ## 8        NA       NA       NA       NA        NA       NA       NA       NA
    ## 9        NA       NA       NA       NA        NA       NA       NA       NA
    ## 10       NA       NA       NA       NA        NA       NA       NA       NA
    ##    emprm14 occm14b atncrse anctry1 anctry2 regunit region
    ## 1        1       9       2   14030  555555       3  BG331
    ## 2        1       3       2   14030  555555       3  BG334
    ## 3        2       3       9   14030  555555       3  BG411
    ## 4        1       7       2   14030  555555       3  BG423
    ## 5        1       9       2   14030  555555       3  BG415
    ## 6        1       8       2   14030  555555       3  BG344
    ## 7        1       6       2   14030  555555       3  BG421
    ## 8        1       8       2   14030  555555       3  BG342
    ## 9        1       7       2   14030  555555       3  BG421
    ## 10       2       9       2   23007  555555       3  BG425

    ##      name              essround    edition            proddate        
    ##  Length:18060       Min.   :10   Length:18060       Length:18060      
    ##  Class :character   1st Qu.:10   Class :character   Class :character  
    ##  Mode  :character   Median :10   Mode  :character   Mode  :character  
    ##                     Mean   :10                                        
    ##                     3rd Qu.:10                                        
    ##                     Max.   :10                                        
    ##                                                                       
    ##       idno          cntry              pweight           dweight       
    ##  Min.   :10002   Length:18060       Min.   :0.07209   Min.   :0.05643  
    ##  1st Qu.:14493   Class :character   1st Qu.:0.21743   1st Qu.:0.94829  
    ##  Median :18879   Mode  :character   Median :0.29632   Median :1.00000  
    ##  Mean   :18932                      Mean   :0.53663   Mean   :1.00003  
    ##  3rd Qu.:23417                      3rd Qu.:0.36276   3rd Qu.:1.03208  
    ##  Max.   :27932                      Max.   :2.81741   Max.   :4.00726  
    ##                                                                        
    ##      nwspol           netusoft        netustm          ppltrst     
    ##  Min.   :   0.00   Min.   :1.000   Min.   :   0.0   Min.   : 0.00  
    ##  1st Qu.:  30.00   1st Qu.:3.000   1st Qu.:  90.0   1st Qu.: 3.00  
    ##  Median :  60.00   Median :5.000   Median : 180.0   Median : 5.00  
    ##  Mean   :  78.56   Mean   :3.958   Mean   : 219.2   Mean   : 4.83  
    ##  3rd Qu.:  90.00   3rd Qu.:5.000   3rd Qu.: 300.0   3rd Qu.: 7.00  
    ##  Max.   :1200.00   Max.   :5.000   Max.   :1440.0   Max.   :10.00  
    ##  NA's   :435       NA's   :27      NA's   :5467     NA's   :71     
    ##     pplfair           pplhlp          polintr        psppsgva    
    ##  Min.   : 0.000   Min.   : 0.000   Min.   :1.00   Min.   :1.000  
    ##  1st Qu.: 4.000   1st Qu.: 3.000   1st Qu.:2.00   1st Qu.:1.000  
    ##  Median : 5.000   Median : 5.000   Median :3.00   Median :2.000  
    ##  Mean   : 5.387   Mean   : 4.792   Mean   :2.78   Mean   :2.128  
    ##  3rd Qu.: 7.000   3rd Qu.: 7.000   3rd Qu.:3.00   3rd Qu.:3.000  
    ##  Max.   :10.000   Max.   :10.000   Max.   :4.00   Max.   :5.000  
    ##  NA's   :131      NA's   :80       NA's   :42     NA's   :432    
    ##     actrolga        psppipla        cptppola        trstprl      
    ##  Min.   :1.000   Min.   :1.000   Min.   :1.000   Min.   : 0.000  
    ##  1st Qu.:1.000   1st Qu.:1.000   1st Qu.:1.000   1st Qu.: 2.000  
    ##  Median :2.000   Median :2.000   Median :2.000   Median : 4.000  
    ##  Mean   :1.912   Mean   :2.001   Mean   :1.862   Mean   : 4.138  
    ##  3rd Qu.:3.000   3rd Qu.:3.000   3rd Qu.:2.000   3rd Qu.: 6.000  
    ##  Max.   :5.000   Max.   :5.000   Max.   :5.000   Max.   :10.000  
    ##  NA's   :349     NA's   :352     NA's   :485     NA's   :306     
    ##     trstlgl          trstplc          trstplt          trstprt      
    ##  Min.   : 0.000   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
    ##  1st Qu.: 3.000   1st Qu.: 5.000   1st Qu.: 1.000   1st Qu.: 1.000  
    ##  Median : 5.000   Median : 7.000   Median : 3.000   Median : 3.000  
    ##  Mean   : 4.856   Mean   : 6.134   Mean   : 3.449   Mean   : 3.381  
    ##  3rd Qu.: 7.000   3rd Qu.: 8.000   3rd Qu.: 5.000   3rd Qu.: 5.000  
    ##  Max.   :10.000   Max.   :10.000   Max.   :10.000   Max.   :10.000  
    ##  NA's   :295      NA's   :150      NA's   :211      NA's   :266     
    ##      trstep           trstun          trstsci            vote      
    ##  Min.   : 0.000   Min.   : 0.000   Min.   : 0.000   Min.   :1.000  
    ##  1st Qu.: 3.000   1st Qu.: 3.000   1st Qu.: 5.000   1st Qu.:1.000  
    ##  Median : 5.000   Median : 5.000   Median : 7.000   Median :1.000  
    ##  Mean   : 4.636   Mean   : 5.046   Mean   : 6.793   Mean   :1.391  
    ##  3rd Qu.: 7.000   3rd Qu.: 7.000   3rd Qu.: 9.000   3rd Qu.:2.000  
    ##  Max.   :10.000   Max.   :10.000   Max.   :10.000   Max.   :3.000  
    ##  NA's   :859      NA's   :1456     NA's   :6215     NA's   :184    
    ##     prtvtebg         prtvtbhr         prtvtecz         prtvthee     
    ##  Min.   : 1.000   Min.   : 1.000   Min.   : 1.000   Min.   : 1.000  
    ##  1st Qu.: 1.000   1st Qu.: 1.000   1st Qu.: 3.750   1st Qu.: 1.000  
    ##  Median : 3.000   Median : 2.000   Median : 4.000   Median : 2.000  
    ##  Mean   : 3.593   Mean   : 2.691   Mean   : 4.752   Mean   : 3.341  
    ##  3rd Qu.: 5.000   3rd Qu.: 4.000   3rd Qu.: 7.000   3rd Qu.: 4.000  
    ##  Max.   :12.000   Max.   :10.000   Max.   :10.000   Max.   :16.000  
    ##  NA's   :16595    NA's   :17294    NA's   :16688    NA's   :17111   
    ##     prtvtefi         prtvtefr        prtvtghu         prtvclt1     
    ##  Min.   : 1.000   Min.   : 1.00   Min.   : 1.000   Min.   : 1.000  
    ##  1st Qu.: 2.000   1st Qu.: 6.00   1st Qu.: 3.000   1st Qu.: 5.000  
    ##  Median : 5.000   Median : 7.00   Median : 3.000   Median : 9.000  
    ##  Mean   : 8.722   Mean   : 7.37   Mean   : 3.771   Mean   : 9.607  
    ##  3rd Qu.:17.000   3rd Qu.: 9.00   3rd Qu.: 4.000   3rd Qu.:13.000  
    ##  Max.   :22.000   Max.   :14.00   Max.   :55.000   Max.   :17.000  
    ##  NA's   :16948    NA's   :17186   NA's   :17026    NA's   :17221   
    ##     prtvclt2         prtvclt3         prtvtfsi         prtvtesk    
    ##  Min.   : 1.000   Min.   : 5.000   Min.   : 1.000   Min.   :1.000  
    ##  1st Qu.: 5.000   1st Qu.: 6.000   1st Qu.: 3.000   1st Qu.:1.000  
    ##  Median :11.000   Median : 9.000   Median : 6.000   Median :2.000  
    ##  Mean   : 9.889   Mean   : 9.545   Mean   : 5.594   Mean   :3.338  
    ##  3rd Qu.:15.250   3rd Qu.:12.500   3rd Qu.: 8.000   3rd Qu.:6.000  
    ##  Max.   :18.000   Max.   :17.000   Max.   :12.000   Max.   :8.000  
    ##  NA's   :18042    NA's   :18049    NA's   :17457    NA's   :17154  
    ##     contplt         donprty          badge          sgnptit     
    ##  Min.   :1.000   Min.   :1.000   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.000  
    ##  Median :2.000   Median :2.000   Median :2.000   Median :2.000  
    ##  Mean   :1.882   Mean   :1.966   Mean   :1.952   Mean   :1.839  
    ##  3rd Qu.:2.000   3rd Qu.:2.000   3rd Qu.:2.000   3rd Qu.:2.000  
    ##  Max.   :2.000   Max.   :2.000   Max.   :2.000   Max.   :2.000  
    ##  NA's   :163     NA's   :202     NA's   :177     NA's   :152    
    ##     pbldmna          bctprd         pstplonl       volunfp         clsprty     
    ##  Min.   :1.000   Min.   :1.000   Min.   :1.00   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.00   1st Qu.:2.000   1st Qu.:1.000  
    ##  Median :2.000   Median :2.000   Median :2.00   Median :2.000   Median :2.000  
    ##  Mean   :1.949   Mean   :1.875   Mean   :1.87   Mean   :1.872   Mean   :1.585  
    ##  3rd Qu.:2.000   3rd Qu.:2.000   3rd Qu.:2.00   3rd Qu.:2.000   3rd Qu.:2.000  
    ##  Max.   :2.000   Max.   :2.000   Max.   :2.00   Max.   :2.000   Max.   :2.000  
    ##  NA's   :160     NA's   :216     NA's   :194    NA's   :154     NA's   :436    
    ##     prtclebg         prtclbhr        prtclecz         prtclhee     
    ##  Min.   : 1.000   Min.   : 1.00   Min.   : 1.000   Min.   : 1.000  
    ##  1st Qu.: 1.000   1st Qu.: 5.00   1st Qu.: 4.000   1st Qu.: 2.000  
    ##  Median : 2.000   Median : 9.00   Median : 4.000   Median : 2.000  
    ##  Mean   : 3.377   Mean   :10.65   Mean   : 5.003   Mean   : 4.003  
    ##  3rd Qu.: 5.000   3rd Qu.:18.00   3rd Qu.: 7.000   3rd Qu.: 6.000  
    ##  Max.   :12.000   Max.   :20.00   Max.   :10.000   Max.   :19.000  
    ##  NA's   :16868    NA's   :17514   NA's   :17327    NA's   :17454   
    ##     prtclffi         prtclffr         prtclhhu         prtclclt     
    ##  Min.   : 1.000   Min.   : 1.000   Min.   : 1.000   Min.   : 1.000  
    ##  1st Qu.: 3.000   1st Qu.: 5.000   1st Qu.: 3.000   1st Qu.: 2.000  
    ##  Median : 5.000   Median : 7.000   Median : 3.000   Median : 3.000  
    ##  Mean   : 9.102   Mean   : 6.982   Mean   : 4.105   Mean   : 4.479  
    ##  3rd Qu.:17.000   3rd Qu.: 9.000   3rd Qu.: 4.000   3rd Qu.: 5.000  
    ##  Max.   :24.000   Max.   :12.000   Max.   :55.000   Max.   :65.000  
    ##  NA's   :17134    NA's   :17289    NA's   :17400    NA's   :17563   
    ##     prtclfsi         prtclesk        prtdgcl         lrscale      
    ##  Min.   : 1.000   Min.   :1.000   Min.   :1.000   Min.   : 0.000  
    ##  1st Qu.: 3.000   1st Qu.:2.000   1st Qu.:2.000   1st Qu.: 4.000  
    ##  Median : 6.000   Median :4.000   Median :2.000   Median : 5.000  
    ##  Mean   : 5.811   Mean   :4.235   Mean   :2.002   Mean   : 5.391  
    ##  3rd Qu.: 8.000   3rd Qu.:6.000   3rd Qu.:2.000   3rd Qu.: 7.000  
    ##  Max.   :12.000   Max.   :8.000   Max.   :4.000   Max.   :10.000  
    ##  NA's   :17711    NA's   :17617   NA's   :11360   NA's   :2308    
    ##     stflife           stfeco           stfgov          stfdem      
    ##  Min.   : 0.000   Min.   : 0.000   Min.   : 0.00   Min.   : 0.000  
    ##  1st Qu.: 6.000   1st Qu.: 3.000   1st Qu.: 2.00   1st Qu.: 3.000  
    ##  Median : 7.000   Median : 5.000   Median : 4.00   Median : 5.000  
    ##  Mean   : 6.961   Mean   : 4.655   Mean   : 4.29   Mean   : 4.907  
    ##  3rd Qu.: 8.000   3rd Qu.: 7.000   3rd Qu.: 6.00   3rd Qu.: 7.000  
    ##  Max.   :10.000   Max.   :10.000   Max.   :10.00   Max.   :10.000  
    ##  NA's   :157      NA's   :419      NA's   :420     NA's   :462     
    ##      stfedu          stfhlth          gincdif         freehms     
    ##  Min.   : 0.000   Min.   : 0.000   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.: 4.000   1st Qu.: 3.000   1st Qu.:1.000   1st Qu.:1.000  
    ##  Median : 6.000   Median : 6.000   Median :2.000   Median :2.000  
    ##  Mean   : 5.609   Mean   : 5.457   Mean   :2.089   Mean   :2.418  
    ##  3rd Qu.: 8.000   3rd Qu.: 8.000   3rd Qu.:3.000   3rd Qu.:3.000  
    ##  Max.   :10.000   Max.   :10.000   Max.   :5.000   Max.   :5.000  
    ##  NA's   :859      NA's   :144      NA's   :288     NA's   :492    
    ##     hmsfmlsh        hmsacld          euftf           lrnobed     
    ##  Min.   :1.000   Min.   :1.000   Min.   : 0.000   Min.   :1.000  
    ##  1st Qu.:3.000   1st Qu.:2.000   1st Qu.: 4.000   1st Qu.:2.000  
    ##  Median :4.000   Median :3.000   Median : 5.000   Median :2.000  
    ##  Mean   :3.561   Mean   :3.236   Mean   : 5.452   Mean   :2.369  
    ##  3rd Qu.:5.000   3rd Qu.:4.000   3rd Qu.: 7.000   3rd Qu.:3.000  
    ##  Max.   :5.000   Max.   :5.000   Max.   :10.000   Max.   :5.000  
    ##  NA's   :881     NA's   :687     NA's   :1188     NA's   :194    
    ##     loylead         imsmetn         imdfetn         impcntr       imbgeco      
    ##  Min.   :1.000   Min.   :1.000   Min.   :1.000   Min.   :1.0   Min.   : 0.000  
    ##  1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.0   1st Qu.: 3.000  
    ##  Median :3.000   Median :2.000   Median :3.000   Median :3.0   Median : 5.000  
    ##  Mean   :3.027   Mean   :2.206   Mean   :2.616   Mean   :2.7   Mean   : 4.886  
    ##  3rd Qu.:4.000   3rd Qu.:3.000   3rd Qu.:3.000   3rd Qu.:3.0   3rd Qu.: 7.000  
    ##  Max.   :5.000   Max.   :4.000   Max.   :4.000   Max.   :4.0   Max.   :10.000  
    ##  NA's   :599     NA's   :438     NA's   :429     NA's   :462   NA's   :593     
    ##     imueclt          imwbcnt           happy           sclmeet     
    ##  Min.   : 0.000   Min.   : 0.000   Min.   : 0.000   Min.   :1.000  
    ##  1st Qu.: 3.000   1st Qu.: 3.000   1st Qu.: 6.000   1st Qu.:3.000  
    ##  Median : 5.000   Median : 5.000   Median : 8.000   Median :5.000  
    ##  Mean   : 5.027   Mean   : 4.701   Mean   : 7.139   Mean   :4.559  
    ##  3rd Qu.: 7.000   3rd Qu.: 6.000   3rd Qu.: 9.000   3rd Qu.:6.000  
    ##  Max.   :10.000   Max.   :10.000   Max.   :10.000   Max.   :7.000  
    ##  NA's   :545      NA's   :636      NA's   :46       NA's   :97     
    ##     inprdsc          sclact          crmvct         aesfdrk     
    ##  Min.   :0.000   Min.   :1.000   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:1.000   1st Qu.:2.000   1st Qu.:2.000   1st Qu.:1.000  
    ##  Median :2.000   Median :3.000   Median :2.000   Median :2.000  
    ##  Mean   :2.328   Mean   :2.694   Mean   :1.898   Mean   :1.938  
    ##  3rd Qu.:3.000   3rd Qu.:3.000   3rd Qu.:2.000   3rd Qu.:2.000  
    ##  Max.   :6.000   Max.   :5.000   Max.   :2.000   Max.   :4.000  
    ##  NA's   :392     NA's   :328     NA's   :82      NA's   :187    
    ##      health         hlthhmp         atchctr          atcherp      
    ##  Min.   :1.000   Min.   :1.000   Min.   : 0.000   Min.   : 0.000  
    ##  1st Qu.:2.000   1st Qu.:2.000   1st Qu.: 7.000   1st Qu.: 5.000  
    ##  Median :2.000   Median :3.000   Median : 9.000   Median : 6.000  
    ##  Mean   :2.246   Mean   :2.644   Mean   : 8.127   Mean   : 6.128  
    ##  3rd Qu.:3.000   3rd Qu.:3.000   3rd Qu.:10.000   3rd Qu.: 8.000  
    ##  Max.   :5.000   Max.   :3.000   Max.   :10.000   Max.   :10.000  
    ##  NA's   :24      NA's   :71      NA's   :109      NA's   :249     
    ##      rlgblg          rlgdnm         rlgdnafi         rlgdnhu     
    ##  Min.   :1.000   Min.   :1.000   Min.   : 1.000   Min.   :110.0  
    ##  1st Qu.:1.000   1st Qu.:1.000   1st Qu.: 1.000   1st Qu.:110.0  
    ##  Median :1.000   Median :1.000   Median : 1.000   Median :110.0  
    ##  Mean   :1.429   Mean   :1.926   Mean   : 1.311   Mean   :152.1  
    ##  3rd Qu.:2.000   3rd Qu.:3.000   3rd Qu.: 1.000   3rd Qu.:120.0  
    ##  Max.   :2.000   Max.   :8.000   Max.   :14.000   Max.   :998.0  
    ##  NA's   :164     NA's   :7911    NA's   :17281    NA's   :16941  
    ##     rlgdnlt         rlgdnbsk         rlgblge         rlgdnme     
    ##  Min.   :1.000   Min.   : 1.000   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:1.000   1st Qu.: 4.000   1st Qu.:2.000   1st Qu.:1.000  
    ##  Median :1.000   Median : 9.000   Median :2.000   Median :1.000  
    ##  Mean   :1.118   Mean   : 6.828   Mean   :1.876   Mean   :1.611  
    ##  3rd Qu.:1.000   3rd Qu.: 9.000   3rd Qu.:2.000   3rd Qu.:2.000  
    ##  Max.   :8.000   Max.   :14.000   Max.   :2.000   Max.   :8.000  
    ##  NA's   :16798   NA's   :17007    NA's   :10342   NA's   :17111  
    ##     rlgdeafi         rlgdehu         rlgdelt         rlgdebsk    
    ##  Min.   : 1.000   Min.   :110.0   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.: 1.000   1st Qu.:110.0   1st Qu.:1.000   1st Qu.:2.000  
    ##  Median : 1.000   Median :110.0   Median :1.000   Median :9.000  
    ##  Mean   : 1.354   Mean   :175.5   Mean   :1.193   Mean   :6.543  
    ##  3rd Qu.: 1.000   3rd Qu.:257.5   3rd Qu.:1.000   3rd Qu.:9.000  
    ##  Max.   :13.000   Max.   :998.0   Max.   :7.000   Max.   :9.000  
    ##  NA's   :17814    NA's   :18004   NA's   :17977   NA's   :18014  
    ##      rlgdgr          rlgatnd           pray          dscrgrp     
    ##  Min.   : 0.000   Min.   :1.000   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.: 1.000   1st Qu.:5.000   1st Qu.:3.000   1st Qu.:2.000  
    ##  Median : 5.000   Median :6.000   Median :6.000   Median :2.000  
    ##  Mean   : 4.368   Mean   :5.606   Mean   :5.061   Mean   :1.926  
    ##  3rd Qu.: 7.000   3rd Qu.:7.000   3rd Qu.:7.000   3rd Qu.:2.000  
    ##  Max.   :10.000   Max.   :7.000   Max.   :7.000   Max.   :2.000  
    ##  NA's   :247      NA's   :155     NA's   :416     NA's   :269    
    ##     dscrrce           dscrntn            dscrrlg            dscrlng        
    ##  Min.   :0.00000   Min.   :0.000000   Min.   :0.000000   Min.   :0.000000  
    ##  1st Qu.:0.00000   1st Qu.:0.000000   1st Qu.:0.000000   1st Qu.:0.000000  
    ##  Median :0.00000   Median :0.000000   Median :0.000000   Median :0.000000  
    ##  Mean   :0.01301   Mean   :0.006589   Mean   :0.007309   Mean   :0.006589  
    ##  3rd Qu.:0.00000   3rd Qu.:0.000000   3rd Qu.:0.000000   3rd Qu.:0.000000  
    ##  Max.   :1.00000   Max.   :1.000000   Max.   :1.000000   Max.   :1.000000  
    ##                                                                            
    ##     dscretn            dscrage          dscrgnd            dscrsex        
    ##  Min.   :0.000000   Min.   :0.0000   Min.   :0.000000   Min.   :0.000000  
    ##  1st Qu.:0.000000   1st Qu.:0.0000   1st Qu.:0.000000   1st Qu.:0.000000  
    ##  Median :0.000000   Median :0.0000   Median :0.000000   Median :0.000000  
    ##  Mean   :0.008693   Mean   :0.0129   Mean   :0.009967   Mean   :0.004983  
    ##  3rd Qu.:0.000000   3rd Qu.:0.0000   3rd Qu.:0.000000   3rd Qu.:0.000000  
    ##  Max.   :1.000000   Max.   :1.0000   Max.   :1.000000   Max.   :1.000000  
    ##                                                                           
    ##     dscrdsb           dscroth          dscrdk            dscrref         
    ##  Min.   :0.00000   Min.   :0.000   Min.   :0.000000   Min.   :0.0000000  
    ##  1st Qu.:0.00000   1st Qu.:0.000   1st Qu.:0.000000   1st Qu.:0.0000000  
    ##  Median :0.00000   Median :0.000   Median :0.000000   Median :0.0000000  
    ##  Mean   :0.00825   Mean   :0.017   Mean   :0.001107   Mean   :0.0006645  
    ##  3rd Qu.:0.00000   3rd Qu.:0.000   3rd Qu.:0.000000   3rd Qu.:0.0000000  
    ##  Max.   :1.00000   Max.   :1.000   Max.   :1.000000   Max.   :1.0000000  
    ##                                                                          
    ##     dscrnap          dscrna            ctzcntr         brncntr     
    ##  Min.   :0.000   Min.   :0.000000   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:1.000   1st Qu.:0.000000   1st Qu.:1.000   1st Qu.:1.000  
    ##  Median :1.000   Median :0.000000   Median :1.000   Median :1.000  
    ##  Mean   :0.924   Mean   :0.003211   Mean   :1.034   Mean   :1.055  
    ##  3rd Qu.:1.000   3rd Qu.:0.000000   3rd Qu.:1.000   3rd Qu.:1.000  
    ##  Max.   :1.000   Max.   :1.000000   Max.   :2.000   Max.   :2.000  
    ##                                     NA's   :30      NA's   :15     
    ##    cntbrthd            livecnta       lnghom1            lnghom2         
    ##  Length:18060       Min.   :1937    Length:18060       Length:18060      
    ##  Class :character   1st Qu.:1971    Class :character   Class :character  
    ##  Mode  :character   Median :1985    Mode  :character   Mode  :character  
    ##                     Mean   :1985                                         
    ##                     3rd Qu.:2001                                         
    ##                     Max.   :2021                                         
    ##                     NA's   :17084                                        
    ##     feethngr        facntr        fbrncntc             mocntr     
    ##  Min.   :1.00   Min.   :1.000   Length:18060       Min.   :1.000  
    ##  1st Qu.:1.00   1st Qu.:1.000   Class :character   1st Qu.:1.000  
    ##  Median :1.00   Median :1.000   Mode  :character   Median :1.000  
    ##  Mean   :1.08   Mean   :1.097                      Mean   :1.086  
    ##  3rd Qu.:1.00   3rd Qu.:1.000                      3rd Qu.:1.000  
    ##  Max.   :2.00   Max.   :2.000                      Max.   :2.000  
    ##  NA's   :141    NA's   :114                        NA's   :55     
    ##    mbrncntc            ccnthum         ccrdprs          wrclmch   
    ##  Length:18060       Min.   : 1.00   Min.   : 0.000   Min.   :1.0  
    ##  Class :character   1st Qu.: 3.00   1st Qu.: 4.000   1st Qu.:3.0  
    ##  Mode  :character   Median : 3.00   Median : 6.000   Median :3.0  
    ##                     Mean   : 4.02   Mean   : 5.715   Mean   :3.2  
    ##                     3rd Qu.: 4.00   3rd Qu.: 8.000   3rd Qu.:4.0  
    ##                     Max.   :55.00   Max.   :10.000   Max.   :5.0  
    ##                     NA's   :355     NA's   :594      NA's   :337  
    ##     admrclc         testic34         testic35         testic36     
    ##  Min.   :1.000   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
    ##  1st Qu.:1.000   1st Qu.: 4.000   1st Qu.: 2.000   1st Qu.: 3.000  
    ##  Median :2.000   Median : 6.000   Median : 4.000   Median : 5.000  
    ##  Mean   :1.998   Mean   : 5.719   Mean   : 4.035   Mean   : 4.798  
    ##  3rd Qu.:3.000   3rd Qu.: 7.000   3rd Qu.: 6.000   3rd Qu.: 6.000  
    ##  Max.   :3.000   Max.   :10.000   Max.   :10.000   Max.   :10.000  
    ##  NA's   :197     NA's   :12294    NA's   :12268    NA's   :12315   
    ##     testic37        testic38        testic39        testic40    
    ##  Min.   :1.000   Min.   :1.000   Min.   :1.000   Min.   :0.000  
    ##  1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.000   1st Qu.:3.000  
    ##  Median :3.000   Median :2.000   Median :2.000   Median :4.000  
    ##  Mean   :2.668   Mean   :2.176   Mean   :2.445   Mean   :3.506  
    ##  3rd Qu.:3.000   3rd Qu.:3.000   3rd Qu.:3.000   3rd Qu.:5.000  
    ##  Max.   :4.000   Max.   :4.000   Max.   :4.000   Max.   :6.000  
    ##  NA's   :12354   NA's   :12331   NA's   :12404   NA's   :12346  
    ##     testic41        testic42        vteurmmb         vteubcmb    
    ##  Min.   :0.000   Min.   :0.000   Min.   : 1.000   Min.   : NA    
    ##  1st Qu.:1.000   1st Qu.:2.000   1st Qu.: 1.000   1st Qu.: NA    
    ##  Median :2.000   Median :3.000   Median : 1.000   Median : NA    
    ##  Mean   :2.426   Mean   :2.954   Mean   : 5.514   Mean   :NaN    
    ##  3rd Qu.:3.000   3rd Qu.:4.000   3rd Qu.: 1.000   3rd Qu.: NA    
    ##  Max.   :6.000   Max.   :6.000   Max.   :65.000   Max.   : NA    
    ##  NA's   :12324   NA's   :12377   NA's   :2326     NA's   :18060  
    ##     fairelc          dfprtal          medcrgv         rghmgpr      
    ##  Min.   : 0.000   Min.   : 0.000   Min.   : 0.00   Min.   : 0.000  
    ##  1st Qu.: 8.000   1st Qu.: 7.000   1st Qu.: 7.00   1st Qu.: 6.000  
    ##  Median :10.000   Median : 8.000   Median : 9.00   Median : 8.000  
    ##  Mean   : 8.916   Mean   : 8.039   Mean   : 8.39   Mean   : 7.784  
    ##  3rd Qu.:10.000   3rd Qu.:10.000   3rd Qu.:10.00   3rd Qu.:10.000  
    ##  Max.   :10.000   Max.   :10.000   Max.   :10.00   Max.   :10.000  
    ##  NA's   :258      NA's   :608      NA's   :323     NA's   :391     
    ##     votedir          cttresa          gptpelc          gvctzpv      
    ##  Min.   : 0.000   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
    ##  1st Qu.: 7.000   1st Qu.: 9.000   1st Qu.: 8.000   1st Qu.: 8.000  
    ##  Median : 8.000   Median :10.000   Median : 9.000   Median : 9.000  
    ##  Mean   : 8.065   Mean   : 9.057   Mean   : 8.407   Mean   : 8.456  
    ##  3rd Qu.:10.000   3rd Qu.:10.000   3rd Qu.:10.000   3rd Qu.:10.000  
    ##  Max.   :10.000   Max.   :10.000   Max.   :10.000   Max.   :10.000  
    ##  NA's   :489      NA's   :218      NA's   :490      NA's   :254     
    ##     grdfinc           viepol          wpestop           keydec      
    ##  Min.   : 0.000   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
    ##  1st Qu.: 7.000   1st Qu.: 6.000   1st Qu.: 7.000   1st Qu.: 7.000  
    ##  Median : 9.000   Median : 8.000   Median : 8.000   Median : 8.000  
    ##  Mean   : 8.061   Mean   : 7.744   Mean   : 8.031   Mean   : 7.881  
    ##  3rd Qu.:10.000   3rd Qu.:10.000   3rd Qu.:10.000   3rd Qu.:10.000  
    ##  Max.   :10.000   Max.   :10.000   Max.   :10.000   Max.   :10.000  
    ##  NA's   :345      NA's   :624      NA's   :460      NA's   :626     
    ##     fairelcc         dfprtalc         medcrgvc         rghmgprc     
    ##  Min.   : 0.000   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
    ##  1st Qu.: 4.000   1st Qu.: 3.000   1st Qu.: 4.000   1st Qu.: 5.000  
    ##  Median : 7.000   Median : 5.000   Median : 7.000   Median : 7.000  
    ##  Mean   : 6.381   Mean   : 5.247   Mean   : 6.158   Mean   : 6.551  
    ##  3rd Qu.: 9.000   3rd Qu.: 7.000   3rd Qu.: 9.000   3rd Qu.: 8.000  
    ##  Max.   :10.000   Max.   :10.000   Max.   :10.000   Max.   :10.000  
    ##  NA's   :613      NA's   :867      NA's   :428      NA's   :677     
    ##     votedirc         cttresac         gptpelcc         gvctzpvc     
    ##  Min.   : 0.000   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
    ##  1st Qu.: 2.000   1st Qu.: 2.000   1st Qu.: 2.000   1st Qu.: 2.000  
    ##  Median : 5.000   Median : 5.000   Median : 5.000   Median : 4.000  
    ##  Mean   : 4.578   Mean   : 4.614   Mean   : 4.802   Mean   : 4.005  
    ##  3rd Qu.: 7.000   3rd Qu.: 7.000   3rd Qu.: 7.000   3rd Qu.: 6.000  
    ##  Max.   :10.000   Max.   :10.000   Max.   :10.000   Max.   :10.000  
    ##  NA's   :715      NA's   :579      NA's   :898      NA's   :323     
    ##     grdfincc         viepolc          wpestopc         keydecc      
    ##  Min.   : 0.000   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
    ##  1st Qu.: 2.000   1st Qu.: 1.000   1st Qu.: 2.000   1st Qu.: 4.000  
    ##  Median : 4.000   Median : 3.000   Median : 4.000   Median : 5.000  
    ##  Mean   : 4.082   Mean   : 3.633   Mean   : 4.247   Mean   : 5.406  
    ##  3rd Qu.: 6.000   3rd Qu.: 5.000   3rd Qu.: 6.000   3rd Qu.: 8.000  
    ##  Max.   :10.000   Max.   :10.000   Max.   :10.000   Max.   :10.000  
    ##  NA's   :582      NA's   :671      NA's   :691      NA's   :1093    
    ##      chpldm         chpldmi          chpldmc          stpldmi      
    ##  Min.   :1.000   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
    ##  1st Qu.:1.000   1st Qu.: 7.000   1st Qu.: 2.000   1st Qu.: 6.000  
    ##  Median :1.000   Median : 8.000   Median : 4.000   Median : 7.000  
    ##  Mean   :1.924   Mean   : 7.981   Mean   : 4.014   Mean   : 6.968  
    ##  3rd Qu.:2.000   3rd Qu.:10.000   3rd Qu.: 6.000   3rd Qu.: 8.000  
    ##  Max.   :5.000   Max.   :10.000   Max.   :10.000   Max.   :10.000  
    ##  NA's   :616     NA's   :6923     NA's   :3717     NA's   :15218   
    ##     stpldmc           admit           showcv     impdema         impdemb     
    ##  Min.   : 0.000   Min.   :1.000   Min.   :1   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.: 5.000   1st Qu.:2.000   1st Qu.:1   1st Qu.:1.000   1st Qu.:2.000  
    ##  Median : 7.000   Median :3.000   Median :1   Median :3.000   Median :3.000  
    ##  Mean   : 6.194   Mean   :2.995   Mean   :1   Mean   :2.619   Mean   :2.987  
    ##  3rd Qu.: 8.000   3rd Qu.:4.000   3rd Qu.:1   3rd Qu.:4.000   3rd Qu.:4.000  
    ##  Max.   :10.000   Max.   :5.000   Max.   :1   Max.   :5.000   Max.   :5.000  
    ##  NA's   :15239                                NA's   :14509   NA's   :14517  
    ##     impdemc         impdemd         impdeme         implvdm      
    ##  Min.   :1.000   Min.   :1.000   Min.   :1.000   Min.   : 0.000  
    ##  1st Qu.:2.000   1st Qu.:1.000   1st Qu.:2.000   1st Qu.: 7.000  
    ##  Median :3.000   Median :3.000   Median :3.000   Median : 9.000  
    ##  Mean   :2.992   Mean   :2.862   Mean   :3.044   Mean   : 8.385  
    ##  3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.:5.000   3rd Qu.:10.000  
    ##  Max.   :5.000   Max.   :5.000   Max.   :5.000   Max.   :10.000  
    ##  NA's   :14625   NA's   :14536   NA's   :14535   NA's   :277     
    ##     accalaw           hhmmb             gndr           gndr2      
    ##  Min.   : 0.000   Min.   : 1.000   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.: 0.000   1st Qu.: 2.000   1st Qu.:1.000   1st Qu.:1.000  
    ##  Median : 3.000   Median : 2.000   Median :2.000   Median :1.000  
    ##  Mean   : 3.549   Mean   : 2.494   Mean   :1.551   Mean   :1.463  
    ##  3rd Qu.: 6.000   3rd Qu.: 3.000   3rd Qu.:2.000   3rd Qu.:2.000  
    ##  Max.   :10.000   Max.   :13.000   Max.   :2.000   Max.   :2.000  
    ##  NA's   :755      NA's   :53                       NA's   :4538   
    ##      gndr3           gndr4           gndr5           gndr6      
    ##  Min.   :1.000   Min.   :1.000   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:1.000   1st Qu.:1.000   1st Qu.:1.000   1st Qu.:1.000  
    ##  Median :2.000   Median :2.000   Median :2.000   Median :1.000  
    ##  Mean   :1.534   Mean   :1.507   Mean   :1.514   Mean   :1.472  
    ##  3rd Qu.:2.000   3rd Qu.:2.000   3rd Qu.:2.000   3rd Qu.:2.000  
    ##  Max.   :2.000   Max.   :2.000   Max.   :2.000   Max.   :2.000  
    ##  NA's   :10720   NA's   :14105   NA's   :16720   NA's   :17615  
    ##      gndr7           gndr8           gndr9           gndr10     
    ##  Min.   :1.000   Min.   :1.000   Min.   :1.000   Min.   :1.00   
    ##  1st Qu.:1.000   1st Qu.:1.000   1st Qu.:1.000   1st Qu.:1.00   
    ##  Median :2.000   Median :2.000   Median :1.000   Median :2.00   
    ##  Mean   :1.543   Mean   :1.509   Mean   :1.414   Mean   :1.65   
    ##  3rd Qu.:2.000   3rd Qu.:2.000   3rd Qu.:2.000   3rd Qu.:2.00   
    ##  Max.   :2.000   Max.   :2.000   Max.   :2.000   Max.   :2.00   
    ##  NA's   :17920   NA's   :18003   NA's   :18031   NA's   :18040  
    ##      gndr11          gndr12          gndr13          yrbrn           agea      
    ##  Min.   :1.0     Min.   :1       Min.   : NA     Min.   :1931   Min.   :15.00  
    ##  1st Qu.:2.0     1st Qu.:1       1st Qu.: NA     1st Qu.:1955   1st Qu.:36.00  
    ##  Median :2.0     Median :1       Median : NA     Median :1969   Median :51.00  
    ##  Mean   :1.8     Mean   :1       Mean   :NaN     Mean   :1970   Mean   :50.89  
    ##  3rd Qu.:2.0     3rd Qu.:1       3rd Qu.: NA     3rd Qu.:1985   3rd Qu.:66.00  
    ##  Max.   :2.0     Max.   :1       Max.   : NA     Max.   :2006   Max.   :90.00  
    ##  NA's   :18055   NA's   :18059   NA's   :18060   NA's   :120    NA's   :120    
    ##      yrbrn2         yrbrn3          yrbrn4          yrbrn5          yrbrn6     
    ##  Min.   :1931   Min.   :1931    Min.   :1931    Min.   :1933    Min.   :1931   
    ##  1st Qu.:1957   1st Qu.:1977    1st Qu.:1998    1st Qu.:2001    1st Qu.:2003   
    ##  Median :1970   Median :2000    Median :2006    Median :2009    Median :2010   
    ##  Mean   :1969   Mean   :1994    Mean   :2003    Mean   :2005    Mean   :2007   
    ##  3rd Qu.:1981   3rd Qu.:2009    3rd Qu.:2013    3rd Qu.:2015    3rd Qu.:2016   
    ##  Max.   :2021   Max.   :2021    Max.   :2021    Max.   :2021    Max.   :2021   
    ##  NA's   :4822   NA's   :10924   NA's   :14218   NA's   :16773   NA's   :17635  
    ##      yrbrn7          yrbrn8          yrbrn9         yrbrn10     
    ##  Min.   :1935    Min.   :1954    Min.   :1951    Min.   :1986   
    ##  1st Qu.:2003    1st Qu.:2002    1st Qu.:2002    1st Qu.:2002   
    ##  Median :2011    Median :2010    Median :2012    Median :2012   
    ##  Mean   :2005    Mean   :2007    Mean   :2008    Mean   :2009   
    ##  3rd Qu.:2016    3rd Qu.:2015    3rd Qu.:2017    3rd Qu.:2018   
    ##  Max.   :2021    Max.   :2020    Max.   :2020    Max.   :2020   
    ##  NA's   :17927   NA's   :18007   NA's   :18034   NA's   :18041  
    ##     yrbrn11         yrbrn12         yrbrn13         rshipa2     
    ##  Min.   :1990    Min.   :2018    Min.   : NA     Min.   :1.000  
    ##  1st Qu.:2004    1st Qu.:2018    1st Qu.: NA     1st Qu.:1.000  
    ##  Median :2015    Median :2018    Median : NA     Median :1.000  
    ##  Mean   :2010    Mean   :2018    Mean   :NaN     Mean   :1.568  
    ##  3rd Qu.:2019    3rd Qu.:2018    3rd Qu.: NA     3rd Qu.:2.000  
    ##  Max.   :2021    Max.   :2018    Max.   : NA     Max.   :6.000  
    ##  NA's   :18055   NA's   :18059   NA's   :18060   NA's   :4602   
    ##     rshipa3         rshipa4         rshipa5         rshipa6     
    ##  Min.   :1.000   Min.   :1.000   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.000  
    ##  Median :2.000   Median :2.000   Median :2.000   Median :3.000  
    ##  Mean   :2.391   Mean   :2.636   Mean   :2.992   Mean   :3.304  
    ##  3rd Qu.:3.000   3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.:5.000  
    ##  Max.   :6.000   Max.   :6.000   Max.   :6.000   Max.   :6.000  
    ##  NA's   :10776   NA's   :14135   NA's   :16741   NA's   :17623  
    ##     rshipa7         rshipa8         rshipa9         rshipa10    
    ##  Min.   :2.000   Min.   :1.000   Min.   :2.000   Min.   :1.00   
    ##  1st Qu.:2.000   1st Qu.:2.000   1st Qu.:4.000   1st Qu.:4.00   
    ##  Median :4.000   Median :4.000   Median :4.500   Median :5.00   
    ##  Mean   :3.743   Mean   :3.907   Mean   :4.107   Mean   :4.25   
    ##  3rd Qu.:5.000   3rd Qu.:5.000   3rd Qu.:5.000   3rd Qu.:5.00   
    ##  Max.   :6.000   Max.   :6.000   Max.   :6.000   Max.   :5.00   
    ##  NA's   :17924   NA's   :18006   NA's   :18032   NA's   :18040  
    ##     rshipa11        rshipa12        rshipa13        acchome      
    ##  Min.   :2.0     Min.   :5       Min.   : NA     Min.   :0.0000  
    ##  1st Qu.:2.0     1st Qu.:5       1st Qu.: NA     1st Qu.:1.0000  
    ##  Median :4.0     Median :5       Median : NA     Median :1.0000  
    ##  Mean   :3.4     Mean   :5       Mean   :NaN     Mean   :0.8405  
    ##  3rd Qu.:4.0     3rd Qu.:5       3rd Qu.: NA     3rd Qu.:1.0000  
    ##  Max.   :5.0     Max.   :5       Max.   : NA     Max.   :1.0000  
    ##  NA's   :18055   NA's   :18059   NA's   :18060                   
    ##      accwrk          accmove           accoth          accnone     
    ##  Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.000  
    ##  1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.000  
    ##  Median :0.0000   Median :1.0000   Median :0.0000   Median :0.000  
    ##  Mean   :0.4396   Mean   :0.5055   Mean   :0.4404   Mean   :0.123  
    ##  3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:0.000  
    ##  Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.000  
    ##                                                                    
    ##      accref             accdk              accna             fampref     
    ##  Min.   :0.000000   Min.   :0.000000   Min.   :0.000000   Min.   :1.000  
    ##  1st Qu.:0.000000   1st Qu.:0.000000   1st Qu.:0.000000   1st Qu.:1.000  
    ##  Median :0.000000   Median :0.000000   Median :0.000000   Median :3.000  
    ##  Mean   :0.002049   Mean   :0.003655   Mean   :0.001495   Mean   :2.965  
    ##  3rd Qu.:0.000000   3rd Qu.:0.000000   3rd Qu.:0.000000   3rd Qu.:4.000  
    ##  Max.   :1.000000   Max.   :1.000000   Max.   :1.000000   Max.   :5.000  
    ##                                                           NA's   :239    
    ##     famadvs          fampdf         mcclose          mcinter      
    ##  Min.   :1.000   Min.   :1.000   Min.   : 0.000   Min.   : 0.000  
    ##  1st Qu.:2.000   1st Qu.:1.000   1st Qu.: 5.000   1st Qu.: 4.000  
    ##  Median :3.000   Median :3.000   Median : 7.000   Median : 6.000  
    ##  Mean   :3.024   Mean   :3.051   Mean   : 6.588   Mean   : 5.795  
    ##  3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.: 9.000   3rd Qu.: 8.000  
    ##  Max.   :5.000   Max.   :5.000   Max.   :10.000   Max.   :10.000  
    ##  NA's   :173     NA's   :183     NA's   :730      NA's   :1063    
    ##     mccoord           mcpriv          mcmsinf          chldo12      
    ##  Min.   : 0.000   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
    ##  1st Qu.: 7.000   1st Qu.: 5.000   1st Qu.: 5.000   1st Qu.: 0.000  
    ##  Median : 8.000   Median : 6.000   Median : 7.000   Median : 1.000  
    ##  Mean   : 7.671   Mean   : 6.018   Mean   : 6.777   Mean   : 1.129  
    ##  3rd Qu.: 9.000   3rd Qu.: 8.000   3rd Qu.: 9.000   3rd Qu.: 2.000  
    ##  Max.   :10.000   Max.   :10.000   Max.   :10.000   Max.   :35.000  
    ##  NA's   :802      NA's   :846      NA's   :951      NA's   :303     
    ##     gndro12a        gndro12b         ageo12         hhlio12     
    ##  Min.   :1.00    Min.   :1.000   Min.   :12.00   Min.   :1.000  
    ##  1st Qu.:1.00    1st Qu.:1.000   1st Qu.:22.00   1st Qu.:1.000  
    ##  Median :1.00    Median :1.000   Median :33.00   Median :2.000  
    ##  Mean   :1.46    Mean   :1.473   Mean   :33.53   Mean   :1.679  
    ##  3rd Qu.:2.00    3rd Qu.:2.000   3rd Qu.:44.00   3rd Qu.:2.000  
    ##  Max.   :2.00    Max.   :2.000   Max.   :90.00   Max.   :2.000  
    ##  NA's   :11260   NA's   :14745   NA's   :8152    NA's   :7912   
    ##     closeo12        ttmino12         speako12        scrno12     
    ##  Min.   :1.000   Min.   :   0.0   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:1.000   1st Qu.:  15.0   1st Qu.:1.000   1st Qu.:5.000  
    ##  Median :2.000   Median :  40.0   Median :3.000   Median :7.000  
    ##  Mean   :1.853   Mean   : 150.8   Mean   :3.066   Mean   :5.848  
    ##  3rd Qu.:2.000   3rd Qu.: 120.0   3rd Qu.:4.000   3rd Qu.:7.000  
    ##  Max.   :5.000   Max.   :4800.0   Max.   :7.000   Max.   :7.000  
    ##  NA's   :9143    NA's   :11463    NA's   :7926    NA's   :7945   
    ##     phoneo12         como12         c19spo12         c19mco12    
    ##  Min.   :1.000   Min.   :1.000   Min.   : 1.000   Min.   :1.000  
    ##  1st Qu.:2.000   1st Qu.:3.000   1st Qu.: 3.000   1st Qu.:3.000  
    ##  Median :3.000   Median :5.000   Median : 3.000   Median :3.000  
    ##  Mean   :3.309   Mean   :4.745   Mean   : 3.593   Mean   :2.906  
    ##  3rd Qu.:4.000   3rd Qu.:7.000   3rd Qu.: 3.000   3rd Qu.:3.000  
    ##  Max.   :7.000   Max.   :7.000   Max.   :55.000   Max.   :5.000  
    ##  NA's   :7940    NA's   :7939    NA's   :7994     NA's   :8161   
    ##      livpnt         pntmofa          agepnt          hhlipnt     
    ##  Min.   :1.000   Min.   :1.000   Min.   : 32.00   Min.   :1.000  
    ##  1st Qu.:1.000   1st Qu.:1.000   1st Qu.: 56.00   1st Qu.:2.000  
    ##  Median :2.000   Median :1.000   Median : 66.00   Median :2.000  
    ##  Mean   :2.558   Mean   :1.416   Mean   : 65.69   Mean   :1.762  
    ##  3rd Qu.:4.000   3rd Qu.:2.000   3rd Qu.: 75.00   3rd Qu.:2.000  
    ##  Max.   :4.000   Max.   :2.000   Max.   :101.00   Max.   :2.000  
    ##  NA's   :208     NA's   :11774   NA's   :8436     NA's   :8195   
    ##     closepnt        ttminpnt          speakpnt       scrnpnt     
    ##  Min.   :1.000   Min.   :   0.00   Min.   :1.00   Min.   :1.000  
    ##  1st Qu.:1.000   1st Qu.:  15.00   1st Qu.:2.00   1st Qu.:6.000  
    ##  Median :2.000   Median :  30.00   Median :3.00   Median :7.000  
    ##  Mean   :2.099   Mean   :  95.51   Mean   :3.24   Mean   :6.122  
    ##  3rd Qu.:3.000   3rd Qu.:  90.00   3rd Qu.:4.00   3rd Qu.:7.000  
    ##  Max.   :5.000   Max.   :4320.00   Max.   :7.00   Max.   :7.000  
    ##  NA's   :9549    NA's   :10726     NA's   :8204   NA's   :8222   
    ##     phonepnt         compnt         c19sppnt         c19mcpnt    
    ##  Min.   :1.000   Min.   :1.000   Min.   : 1.000   Min.   :1.000  
    ##  1st Qu.:2.000   1st Qu.:3.000   1st Qu.: 3.000   1st Qu.:3.000  
    ##  Median :3.000   Median :6.000   Median : 3.000   Median :3.000  
    ##  Mean   :3.557   Mean   :5.144   Mean   : 3.531   Mean   :2.898  
    ##  3rd Qu.:4.000   3rd Qu.:7.000   3rd Qu.: 3.000   3rd Qu.:3.000  
    ##  Max.   :7.000   Max.   :7.000   Max.   :55.000   Max.   :5.000  
    ##  NA's   :8226    NA's   :8238    NA's   :8278     NA's   :8411   
    ##     stfmjob          trdawrk         jbprtfp         pfmfdjba   
    ##  Min.   : 0.000   Min.   :1.000   Min.   :1.000   Min.   :1.00  
    ##  1st Qu.: 7.000   1st Qu.:3.000   1st Qu.:2.000   1st Qu.:1.00  
    ##  Median : 8.000   Median :3.000   Median :3.000   Median :2.00  
    ##  Mean   : 7.511   Mean   :3.007   Mean   :3.033   Mean   :2.27  
    ##  3rd Qu.: 9.000   3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.:3.00  
    ##  Max.   :10.000   Max.   :5.000   Max.   :6.000   Max.   :5.00  
    ##  NA's   :8149     NA's   :8120    NA's   :8167    NA's   :9203  
    ##     dcsfwrka        wrkhome         c19whome        c19wplch    
    ##  Min.   :1.000   Min.   :1.000   Min.   : 1.00   Min.   :1.000  
    ##  1st Qu.:1.000   1st Qu.:3.000   1st Qu.: 3.00   1st Qu.:1.000  
    ##  Median :2.000   Median :6.000   Median :55.00   Median :1.000  
    ##  Mean   :1.765   Mean   :4.809   Mean   :29.52   Mean   :1.473  
    ##  3rd Qu.:2.000   3rd Qu.:6.000   3rd Qu.:55.00   3rd Qu.:2.000  
    ##  Max.   :3.000   Max.   :6.000   Max.   :55.00   Max.   :3.000  
    ##  NA's   :8133    NA's   :8142    NA's   :8265    NA's   :15900  
    ##     wrklong         wrkresp         c19whacc        mansupp     
    ##  Min.   : 1.00   Min.   :1.000   Min.   : 1.00   Min.   : 0.00  
    ##  1st Qu.: 3.00   1st Qu.:3.000   1st Qu.: 3.00   1st Qu.: 6.00  
    ##  Median : 5.00   Median :5.000   Median : 5.00   Median : 8.00  
    ##  Mean   :13.21   Mean   :4.153   Mean   :27.79   Mean   :14.52  
    ##  3rd Qu.: 6.00   3rd Qu.:6.000   3rd Qu.:55.00   3rd Qu.:10.00  
    ##  Max.   :55.00   Max.   :6.000   Max.   :55.00   Max.   :55.00  
    ##  NA's   :8360    NA's   :10147   NA's   :10132   NA's   :8292   
    ##      manhlp         manwrkpl         manspeak        manscrn     
    ##  Min.   :1.000   Min.   : 1.000   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:1.000   1st Qu.: 1.000   1st Qu.:1.000   1st Qu.:5.000  
    ##  Median :2.000   Median : 2.000   Median :3.000   Median :7.000  
    ##  Mean   :1.692   Mean   : 2.882   Mean   :2.954   Mean   :5.954  
    ##  3rd Qu.:2.000   3rd Qu.: 3.000   3rd Qu.:4.000   3rd Qu.:7.000  
    ##  Max.   :4.000   Max.   :44.000   Max.   :7.000   Max.   :7.000  
    ##  NA's   :9775    NA's   :9747     NA's   :9759    NA's   :9754   
    ##     manphone         mancom         teamfeel       wrkextra    
    ##  Min.   :1.000   Min.   :1.000   Min.   : 0.0   Min.   : 0.00  
    ##  1st Qu.:3.000   1st Qu.:3.000   1st Qu.: 8.0   1st Qu.: 2.00  
    ##  Median :4.000   Median :5.000   Median :10.0   Median : 5.00  
    ##  Mean   :4.416   Mean   :4.773   Mean   :16.5   Mean   : 4.99  
    ##  3rd Qu.:6.000   3rd Qu.:7.000   3rd Qu.:10.0   3rd Qu.: 8.00  
    ##  Max.   :7.000   Max.   :7.000   Max.   :55.0   Max.   :10.00  
    ##  NA's   :9781    NA's   :9767    NA's   :8132   NA's   :10062  
    ##     colprop           colhlp        colspeak        colscrn     
    ##  Min.   : 1.000   Min.   :1.00   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.: 1.000   1st Qu.:1.00   1st Qu.:1.000   1st Qu.:5.000  
    ##  Median : 3.000   Median :1.00   Median :1.000   Median :7.000  
    ##  Mean   : 9.201   Mean   :1.57   Mean   :2.092   Mean   :5.902  
    ##  3rd Qu.: 6.000   3rd Qu.:2.00   3rd Qu.:3.000   3rd Qu.:7.000  
    ##  Max.   :55.000   Max.   :4.00   Max.   :7.000   Max.   :7.000  
    ##  NA's   :8173     NA's   :9423   NA's   :9393    NA's   :9403   
    ##     colphone         colcom        c19spwrk         c19mcwrk     
    ##  Min.   :1.000   Min.   :1.00   Min.   : 1.000   Min.   : 1.000  
    ##  1st Qu.:3.000   1st Qu.:3.00   1st Qu.: 3.000   1st Qu.: 3.000  
    ##  Median :4.000   Median :4.00   Median : 3.000   Median : 3.000  
    ##  Mean   :4.065   Mean   :4.53   Mean   : 4.083   Mean   : 7.559  
    ##  3rd Qu.:6.000   3rd Qu.:7.00   3rd Qu.: 3.000   3rd Qu.: 3.000  
    ##  Max.   :7.000   Max.   :7.00   Max.   :55.000   Max.   :55.000  
    ##  NA's   :9445    NA's   :9444   NA's   :9495     NA's   :9490    
    ##     mcwrkhom         ipcrtiv         imprich         ipeqopt     
    ##  Min.   : 0.000   Min.   :1.000   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.: 1.000   1st Qu.:2.000   1st Qu.:3.000   1st Qu.:1.000  
    ##  Median : 6.000   Median :3.000   Median :4.000   Median :2.000  
    ##  Mean   : 5.459   Mean   :2.711   Mean   :4.018   Mean   :2.172  
    ##  3rd Qu.: 9.000   3rd Qu.:3.000   3rd Qu.:5.000   3rd Qu.:3.000  
    ##  Max.   :10.000   Max.   :6.000   Max.   :6.000   Max.   :6.000  
    ##  NA's   :10851    NA's   :282     NA's   :260     NA's   :272    
    ##     ipshabt         impsafe         impdiff         ipfrule     
    ##  Min.   :1.000   Min.   :1.000   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:2.000   1st Qu.:1.000   1st Qu.:2.000   1st Qu.:2.000  
    ##  Median :3.000   Median :2.000   Median :3.000   Median :3.000  
    ##  Mean   :3.208   Mean   :2.312   Mean   :2.998   Mean   :3.195  
    ##  3rd Qu.:4.000   3rd Qu.:3.000   3rd Qu.:4.000   3rd Qu.:4.000  
    ##  Max.   :6.000   Max.   :6.000   Max.   :6.000   Max.   :6.000  
    ##  NA's   :307     NA's   :221     NA's   :282     NA's   :357    
    ##     ipudrst         ipmodst         ipgdtim         impfree     
    ##  Min.   :1.000   Min.   :1.000   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.000   1st Qu.:1.000  
    ##  Median :2.000   Median :3.000   Median :3.000   Median :2.000  
    ##  Mean   :2.501   Mean   :2.745   Mean   :2.855   Mean   :2.309  
    ##  3rd Qu.:3.000   3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.:3.000  
    ##  Max.   :6.000   Max.   :6.000   Max.   :6.000   Max.   :6.000  
    ##  NA's   :324     NA's   :311     NA's   :288     NA's   :246    
    ##     iphlppl         ipsuces         ipstrgv         ipadvnt     
    ##  Min.   :1.000   Min.   :1.000   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:2.000   1st Qu.:2.000   1st Qu.:1.000   1st Qu.:3.000  
    ##  Median :2.000   Median :3.000   Median :2.000   Median :4.000  
    ##  Mean   :2.318   Mean   :3.176   Mean   :2.297   Mean   :3.815  
    ##  3rd Qu.:3.000   3rd Qu.:4.000   3rd Qu.:3.000   3rd Qu.:5.000  
    ##  Max.   :6.000   Max.   :6.000   Max.   :6.000   Max.   :6.000  
    ##  NA's   :246     NA's   :335     NA's   :335     NA's   :293    
    ##     ipbhprp         iprspot         iplylfr          impenv     
    ##  Min.   :1.000   Min.   :1.000   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:2.000   1st Qu.:2.000   1st Qu.:1.000   1st Qu.:1.000  
    ##  Median :2.000   Median :3.000   Median :2.000   Median :2.000  
    ##  Mean   :2.648   Mean   :3.218   Mean   :2.112   Mean   :2.203  
    ##  3rd Qu.:3.000   3rd Qu.:4.000   3rd Qu.:3.000   3rd Qu.:3.000  
    ##  Max.   :6.000   Max.   :6.000   Max.   :6.000   Max.   :6.000  
    ##  NA's   :306     NA's   :383     NA's   :245     NA's   :256    
    ##     imptrad          impfun         testii1         testii2     
    ##  Min.   :1.000   Min.   :1.000   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.000  
    ##  Median :3.000   Median :3.000   Median :3.000   Median :2.000  
    ##  Mean   :2.774   Mean   :3.067   Mean   :2.587   Mean   :2.174  
    ##  3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.:3.000   3rd Qu.:3.000  
    ##  Max.   :6.000   Max.   :6.000   Max.   :4.000   Max.   :4.000  
    ##  NA's   :238     NA's   :260     NA's   :12242   NA's   :12230  
    ##     testii3         testii4         testii5         testii6     
    ##  Min.   :1.000   Min.   :0.000   Min.   :0.000   Min.   :0.000  
    ##  1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.000  
    ##  Median :2.000   Median :4.000   Median :3.000   Median :3.000  
    ##  Mean   :2.417   Mean   :3.411   Mean   :2.525   Mean   :2.992  
    ##  3rd Qu.:3.000   3rd Qu.:5.000   3rd Qu.:3.000   3rd Qu.:4.000  
    ##  Max.   :4.000   Max.   :6.000   Max.   :6.000   Max.   :6.000  
    ##  NA's   :12297   NA's   :12283   NA's   :12264   NA's   :12322  
    ##     testii7          testii8          testii9         secgrdec    
    ##  Min.   : 0.000   Min.   : 0.000   Min.   : 0.00   Min.   :1.000  
    ##  1st Qu.: 4.000   1st Qu.: 2.000   1st Qu.: 3.00   1st Qu.:2.000  
    ##  Median : 6.000   Median : 4.000   Median : 5.00   Median :3.000  
    ##  Mean   : 5.609   Mean   : 4.082   Mean   : 4.78   Mean   :2.995  
    ##  3rd Qu.: 7.000   3rd Qu.: 6.000   3rd Qu.: 6.00   3rd Qu.:4.000  
    ##  Max.   :10.000   Max.   :10.000   Max.   :10.00   Max.   :5.000  
    ##  NA's   :12269    NA's   :12268    NA's   :12302   NA's   :3224   
    ##     scidecpb         admc19         panpriph         panmonpb     
    ##  Min.   :1.000   Min.   :1.000   Min.   : 0.000   Min.   : 0.000  
    ##  1st Qu.:2.000   1st Qu.:1.000   1st Qu.: 2.000   1st Qu.: 5.000  
    ##  Median :3.000   Median :1.000   Median : 4.000   Median : 6.000  
    ##  Mean   :3.093   Mean   :1.498   Mean   : 3.711   Mean   : 6.113  
    ##  3rd Qu.:4.000   3rd Qu.:2.000   3rd Qu.: 5.000   3rd Qu.: 8.000  
    ##  Max.   :5.000   Max.   :2.000   Max.   :10.000   Max.   :10.000  
    ##  NA's   :3007    NA's   :1977    NA's   :10144    NA's   :10223   
    ##     govpriph         govmonpb         panfolru         panclobo     
    ##  Min.   : 0.000   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
    ##  1st Qu.: 2.000   1st Qu.: 5.000   1st Qu.: 3.000   1st Qu.: 5.000  
    ##  Median : 4.000   Median : 7.000   Median : 5.000   Median : 7.000  
    ##  Mean   : 3.851   Mean   : 6.756   Mean   : 5.017   Mean   : 6.248  
    ##  3rd Qu.: 5.000   3rd Qu.: 9.000   3rd Qu.: 7.000   3rd Qu.: 9.000  
    ##  Max.   :10.000   Max.   :10.000   Max.   :10.000   Max.   :10.000  
    ##  NA's   :10228    NA's   :10284    NA's   :2245     NA's   :2536    
    ##     panresmo         gvhanc19         gvjobc19         gveldc19     
    ##  Min.   : 0.000   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
    ##  1st Qu.: 2.000   1st Qu.: 3.000   1st Qu.: 2.000   1st Qu.: 3.000  
    ##  Median : 5.000   Median : 5.000   Median : 5.000   Median : 5.000  
    ##  Mean   : 4.989   Mean   : 5.054   Mean   : 4.384   Mean   : 4.657  
    ##  3rd Qu.: 7.000   3rd Qu.: 7.000   3rd Qu.: 6.000   3rd Qu.: 7.000  
    ##  Max.   :10.000   Max.   :10.000   Max.   :10.000   Max.   :10.000  
    ##  NA's   :2418     NA's   :2595     NA's   :3294     NA's   :4072    
    ##     gvfamc19        hscopc19         gvbalc19         gvimpc19     
    ##  Min.   : 0.00   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
    ##  1st Qu.: 3.00   1st Qu.: 4.000   1st Qu.: 5.000   1st Qu.: 3.000  
    ##  Median : 5.00   Median : 6.000   Median : 5.000   Median : 5.000  
    ##  Mean   : 4.67   Mean   : 5.951   Mean   : 5.302   Mean   : 4.957  
    ##  3rd Qu.: 7.00   3rd Qu.: 8.000   3rd Qu.: 6.000   3rd Qu.: 7.000  
    ##  Max.   :10.00   Max.   :10.000   Max.   :10.000   Max.   :10.000  
    ##  NA's   :3603    NA's   :2372     NA's   :2974     NA's   :2394    
    ##     gvconc19        respc19         reshhc19        hapljc19      
    ##  Min.   :1.000   Min.   :1.000   Min.   :1.000   Min.   :0.00000  
    ##  1st Qu.:2.000   1st Qu.:3.000   1st Qu.:3.000   1st Qu.:0.00000  
    ##  Median :3.000   Median :3.000   Median :3.000   Median :0.00000  
    ##  Mean   :3.042   Mean   :2.645   Mean   :2.889   Mean   :0.01982  
    ##  3rd Qu.:4.000   3rd Qu.:3.000   3rd Qu.:3.000   3rd Qu.:0.00000  
    ##  Max.   :5.000   Max.   :3.000   Max.   :4.000   Max.   :1.00000  
    ##  NA's   :3115    NA's   :2336    NA's   :2254                     
    ##     hapirc19          hapwrc19          hapfuc19          hapfoc19      
    ##  Min.   :0.00000   Min.   :0.00000   Min.   :0.00000   Min.   :0.00000  
    ##  1st Qu.:0.00000   1st Qu.:0.00000   1st Qu.:0.00000   1st Qu.:0.00000  
    ##  Median :0.00000   Median :0.00000   Median :0.00000   Median :0.00000  
    ##  Mean   :0.07636   Mean   :0.04945   Mean   :0.05692   Mean   :0.02868  
    ##  3rd Qu.:0.00000   3rd Qu.:0.00000   3rd Qu.:0.00000   3rd Qu.:0.00000  
    ##  Max.   :1.00000   Max.   :1.00000   Max.   :1.00000   Max.   :1.00000  
    ##                                                                         
    ##     hapnoc19         hapnwc19          hapnpc19        haprec19      
    ##  Min.   :0.0000   Min.   :0.00000   Min.   :0.000   Min.   :0.00000  
    ##  1st Qu.:0.0000   1st Qu.:0.00000   1st Qu.:0.000   1st Qu.:0.00000  
    ##  Median :0.0000   Median :0.00000   Median :0.000   Median :0.00000  
    ##  Mean   :0.4587   Mean   :0.09291   Mean   :0.171   Mean   :0.00515  
    ##  3rd Qu.:1.0000   3rd Qu.:0.00000   3rd Qu.:0.000   3rd Qu.:0.00000  
    ##  Max.   :1.0000   Max.   :1.00000   Max.   :1.000   Max.   :1.00000  
    ##                                                                      
    ##     hapdkc19           hapnac19         icvacc19       getavc19   
    ##  Min.   :0.000000   Min.   :0.0000   Min.   :1.00   Min.   :1.00  
    ##  1st Qu.:0.000000   1st Qu.:0.0000   1st Qu.:1.00   1st Qu.:2.00  
    ##  Median :0.000000   Median :0.0000   Median :1.00   Median :2.00  
    ##  Mean   :0.003544   Mean   :0.1002   Mean   :1.07   Mean   :2.18  
    ##  3rd Qu.:0.000000   3rd Qu.:0.0000   3rd Qu.:1.00   3rd Qu.:3.00  
    ##  Max.   :1.000000   Max.   :1.0000   Max.   :2.00   Max.   :3.00  
    ##                                      NA's   :9373   NA's   :3409  
    ##     getnvc19         vdcond         vdovexre         vdtype     
    ##  Min.   :1.000   Min.   :1.000   Min.   : 0.00   Min.   :1.000  
    ##  1st Qu.:1.000   1st Qu.:1.000   1st Qu.: 7.00   1st Qu.:1.000  
    ##  Median :1.000   Median :1.000   Median : 8.00   Median :1.000  
    ##  Mean   :1.457   Mean   :1.254   Mean   : 7.92   Mean   :1.544  
    ##  3rd Qu.:2.000   3rd Qu.:1.000   3rd Qu.:10.00   3rd Qu.:3.000  
    ##  Max.   :2.000   Max.   :3.000   Max.   :10.00   Max.   :4.000  
    ##  NA's   :17522   NA's   :17      NA's   :172     NA's   :17433  
    ##     vdtpsvre           vdtpitre          vdtpscre           vdtpaure       
    ##  Min.   :0.000000   Min.   :0.00000   Min.   :0.000000   Min.   :0.000000  
    ##  1st Qu.:0.000000   1st Qu.:0.00000   1st Qu.:0.000000   1st Qu.:0.000000  
    ##  Median :0.000000   Median :0.00000   Median :0.000000   Median :0.000000  
    ##  Mean   :0.004042   Mean   :0.00371   Mean   :0.001273   Mean   :0.003931  
    ##  3rd Qu.:0.000000   3rd Qu.:0.00000   3rd Qu.:0.000000   3rd Qu.:0.000000  
    ##  Max.   :1.000000   Max.   :1.00000   Max.   :1.000000   Max.   :1.000000  
    ##                                                                            
    ##     vdtpvire           vdtpoire            vdtpntre          vdtpapre     
    ##  Min.   :0.000000   Min.   :0.0000000   Min.   :0.00000   Min.   :0.0000  
    ##  1st Qu.:0.000000   1st Qu.:0.0000000   1st Qu.:0.00000   1st Qu.:1.0000  
    ##  Median :0.000000   Median :0.0000000   Median :0.00000   Median :1.0000  
    ##  Mean   :0.001107   Mean   :0.0008306   Mean   :0.02348   Mean   :0.9643  
    ##  3rd Qu.:0.000000   3rd Qu.:0.0000000   3rd Qu.:0.00000   3rd Qu.:1.0000  
    ##  Max.   :1.000000   Max.   :1.0000000   Max.   :1.00000   Max.   :1.0000  
    ##                                                                           
    ##     vdtprere    vdtpdkre           vdtpnare       
    ##  Min.   :0   Min.   :0.00e+00   Min.   :0.000000  
    ##  1st Qu.:0   1st Qu.:0.00e+00   1st Qu.:0.000000  
    ##  Median :0   Median :0.00e+00   Median :0.000000  
    ##  Mean   :0   Mean   :5.54e-05   Mean   :0.001218  
    ##  3rd Qu.:0   3rd Qu.:0.00e+00   3rd Qu.:0.000000  
    ##  Max.   :0   Max.   :1.00e+00   Max.   :1.000000  
    ##                                                   
    ##      inwds                            ainws                       
    ##  Min.   :2020-09-18 10:18:44.00   Min.   :2020-09-18 10:20:04.00  
    ##  1st Qu.:2021-07-18 17:45:35.25   1st Qu.:2021-07-18 17:53:00.00  
    ##  Median :2021-08-18 15:08:21.00   Median :2021-08-18 15:53:26.00  
    ##  Mean   :2021-08-15 20:06:36.00   Mean   :2021-08-15 21:56:47.91  
    ##  3rd Qu.:2021-09-25 23:28:36.25   3rd Qu.:2021-09-26 10:07:25.50  
    ##  Max.   :2022-01-13 11:02:25.00   Max.   :2022-01-13 11:03:35.00  
    ##                                   NA's   :1                       
    ##      ainwe                            binwe                       
    ##  Min.   :2020-09-18 10:25:21.00   Min.   :2020-09-18 10:35:57.00  
    ##  1st Qu.:2021-07-18 17:54:00.00   1st Qu.:2021-07-18 18:13:58.50  
    ##  Median :2021-08-18 15:37:24.00   Median :2021-08-18 16:23:41.00  
    ##  Mean   :2021-08-15 23:53:38.34   Mean   :2021-08-16 01:16:27.64  
    ##  3rd Qu.:2021-09-26 10:45:38.00   3rd Qu.:2021-09-26 11:37:26.25  
    ##  Max.   :2022-01-13 11:05:18.00   Max.   :2022-01-13 11:14:24.00  
    ##  NA's   :23                       NA's   :2                       
    ##      cinwe                            dinwe                       
    ##  Min.   :2020-09-18 10:44:27.00   Min.   :2020-09-18 10:51:22.00  
    ##  1st Qu.:2021-07-18 18:28:00.00   1st Qu.:2021-07-17 17:19:04.50  
    ##  Median :2021-08-18 16:25:00.00   Median :2021-08-15 09:29:30.00  
    ##  Mean   :2021-08-16 01:15:20.55   Mean   :2021-08-14 07:13:19.07  
    ##  3rd Qu.:2021-09-26 11:32:28.00   3rd Qu.:2021-09-23 09:52:07.50  
    ##  Max.   :2022-01-13 11:20:10.00   Max.   :2022-01-13 11:27:50.00  
    ##  NA's   :7                        NA's   :830                     
    ##      finwe                            ginwe                       
    ##  Min.   :2020-09-18 11:01:21.00   Min.   :2020-09-18 11:07:19.00  
    ##  1st Qu.:2021-07-17 13:39:10.00   1st Qu.:2021-07-17 17:15:27.50  
    ##  Median :2021-08-14 11:39:00.00   Median :2021-08-15 13:26:22.00  
    ##  Mean   :2021-08-13 17:28:32.46   Mean   :2021-08-14 00:46:46.97  
    ##  3rd Qu.:2021-09-22 14:03:13.00   3rd Qu.:2021-09-23 10:53:51.75  
    ##  Max.   :2022-01-13 11:36:14.00   Max.   :2022-01-13 11:46:02.00  
    ##  NA's   :943                      NA's   :1188                    
    ##      hinwe                            iinwe                       
    ##  Min.   :2020-09-18 11:11:36.00   Min.   :2020-09-18 11:12:25.00  
    ##  1st Qu.:2021-07-18 20:44:00.00   1st Qu.:2021-07-18 10:55:46.00  
    ##  Median :2021-08-18 18:08:06.00   Median :2021-08-16 19:45:00.00  
    ##  Mean   :2021-08-16 06:39:15.91   Mean   :2021-08-14 12:56:08.73  
    ##  3rd Qu.:2021-09-26 12:02:27.00   3rd Qu.:2021-09-23 20:33:46.00  
    ##  Max.   :2022-01-13 11:49:38.00   Max.   :2022-01-17 18:42:13.00  
    ##  NA's   :35                       NA's   :1035                    
    ##      kinwe                            vinwe                       
    ##  Min.   :2021-05-05 10:40:51.00   Min.   :2021-01-01 09:00:17.00  
    ##  1st Qu.:2021-07-16 15:31:44.75   1st Qu.:2021-07-19 15:46:02.25  
    ##  Median :2021-08-08 14:58:30.50   Median :2021-08-14 17:23:41.50  
    ##  Mean   :2021-08-16 03:17:41.25   Mean   :2021-08-23 12:05:11.23  
    ##  3rd Qu.:2021-09-08 19:00:55.50   3rd Qu.:2021-09-20 13:12:45.00  
    ##  Max.   :2021-12-31 13:09:00.00   Max.   :2021-12-31 20:44:20.00  
    ##  NA's   :4236                     NA's   :2636                    
    ##      inwde                            jinws                       
    ##  Min.   :2020-09-18 11:21:51.00   Min.   :2020-09-18 11:21:51.00  
    ##  1st Qu.:2021-07-18 20:51:00.00   1st Qu.:2021-07-18 14:02:07.00  
    ##  Median :2021-08-18 19:02:56.50   Median :2021-08-17 08:16:57.00  
    ##  Mean   :2021-08-16 05:42:38.50   Mean   :2021-08-14 23:57:56.72  
    ##  3rd Qu.:2021-09-26 13:26:13.50   3rd Qu.:2021-09-23 19:12:45.00  
    ##  Max.   :2022-01-17 14:44:55.00   Max.   :2022-01-18 15:48:46.00  
    ##  NA's   :6                        NA's   :383                     
    ##      jinwe                            inwtm          domain         
    ##  Min.   :2020-09-18 11:22:51.00   Min.   :  5.0   Length:18060      
    ##  1st Qu.:2021-07-18 14:51:41.00   1st Qu.: 40.0   Class :character  
    ##  Median :2021-08-17 10:20:32.00   Median : 49.0   Mode  :character  
    ##  Mean   :2021-08-15 00:39:28.56   Mean   : 52.3                     
    ##  3rd Qu.:2021-09-23 20:34:49.00   3rd Qu.: 60.0                     
    ##  Max.   :2022-01-18 15:52:36.00   Max.   :759.0                     
    ##  NA's   :393                      NA's   :242                       
    ##      prob              stratum            psu          rshpsts     
    ##  Length:18060       Min.   :   1.0   Min.   :   1   Min.   : 1.00  
    ##  Class :character   1st Qu.: 119.0   1st Qu.: 886   1st Qu.: 1.00  
    ##  Mode  :character   Median : 940.0   Median :4314   Median : 3.00  
    ##                     Mean   : 646.9   Mean   :3738   Mean   :29.94  
    ##                     3rd Qu.:1075.0   3rd Qu.:5722   3rd Qu.:66.00  
    ##                     Max.   :1178.0   Max.   :7534   Max.   :99.00  
    ##                                                                    
    ##     lvgptnea        dvrcdeva         marsts         maritalb     
    ##  Min.   :1.000   Min.   :1.000   Min.   : 1.00   Min.   : 1.000  
    ##  1st Qu.:1.000   1st Qu.:2.000   1st Qu.: 5.00   1st Qu.: 1.000  
    ##  Median :2.000   Median :2.000   Median : 6.00   Median : 3.000  
    ##  Mean   :2.239   Mean   :1.878   Mean   :32.86   Mean   : 3.771  
    ##  3rd Qu.:2.000   3rd Qu.:2.000   3rd Qu.:66.00   3rd Qu.: 6.000  
    ##  Max.   :9.000   Max.   :9.000   Max.   :99.00   Max.   :99.000  
    ##                                                                  
    ##     chldhhe        domicil         edulvlb           eisced      
    ##  Min.   :1.00   Min.   :1.000   Min.   :   0.0   Min.   : 1.000  
    ##  1st Qu.:1.00   1st Qu.:1.000   1st Qu.: 313.0   1st Qu.: 3.000  
    ##  Median :2.00   Median :3.000   Median : 323.0   Median : 4.000  
    ##  Mean   :2.96   Mean   :2.803   Mean   : 443.7   Mean   : 4.633  
    ##  3rd Qu.:6.00   3rd Qu.:4.000   3rd Qu.: 610.0   3rd Qu.: 6.000  
    ##  Max.   :9.00   Max.   :9.000   Max.   :9999.0   Max.   :99.000  
    ##                                                                  
    ##     edlvebg           edlvehr           edlvdcz           edlvdee      
    ##  Min.   :   1.00   Min.   :   1.00   Min.   :   2.00   Min.   : 113.0  
    ##  1st Qu.:   7.00   1st Qu.:   5.00   1st Qu.:   4.00   1st Qu.: 313.0  
    ##  Median :   9.00   Median :   6.00   Median :   6.00   Median : 423.0  
    ##  Mean   :  10.94   Mean   :  25.17   Mean   :  31.56   Mean   : 458.5  
    ##  3rd Qu.:  12.00   3rd Qu.:   7.00   3rd Qu.:   8.00   3rd Qu.: 620.0  
    ##  Max.   :5555.00   Max.   :7777.00   Max.   :8888.00   Max.   :7777.0  
    ##  NA's   :15342     NA's   :16468     NA's   :15584     NA's   :16518   
    ##     edlvdfi           edlvdfr           edlvdahu          edlvdlt      
    ##  Min.   :   1.00   Min.   :   1.00   Min.   :   1.00   Min.   :   0.0  
    ##  1st Qu.:   5.00   1st Qu.:   7.00   1st Qu.:   4.00   1st Qu.:   7.0  
    ##  Median :   7.00   Median :  10.00   Median :   6.00   Median :  10.0  
    ##  Mean   :  12.69   Mean   :  42.83   Mean   :  52.67   Mean   :  92.8  
    ##  3rd Qu.:  10.00   3rd Qu.:  16.00   3rd Qu.:   7.00   3rd Qu.:  13.0  
    ##  Max.   :8888.00   Max.   :7777.00   Max.   :9999.00   Max.   :8888.0  
    ##  NA's   :16483     NA's   :16083     NA's   :16211     NA's   :16401   
    ##     edlvesi           edlvdsk           eduyrs          pdwrk       
    ##  Min.   :   0.00   Min.   :   1.0   Min.   : 0.00   Min.   :0.0000  
    ##  1st Qu.:   3.00   1st Qu.:   6.0   1st Qu.:11.00   1st Qu.:0.0000  
    ##  Median :   4.00   Median :   7.0   Median :12.00   Median :1.0000  
    ##  Mean   :  41.91   Mean   : 171.1   Mean   :14.45   Mean   :0.5356  
    ##  3rd Qu.:   6.00   3rd Qu.:   9.0   3rd Qu.:16.00   3rd Qu.:1.0000  
    ##  Max.   :9999.00   Max.   :9999.0   Max.   :99.00   Max.   :1.0000  
    ##  NA's   :16808     NA's   :16642                                    
    ##      edctn             uempla            uempli            dsbld        
    ##  Min.   :0.00000   Min.   :0.00000   Min.   :0.00000   Min.   :0.00000  
    ##  1st Qu.:0.00000   1st Qu.:0.00000   1st Qu.:0.00000   1st Qu.:0.00000  
    ##  Median :0.00000   Median :0.00000   Median :0.00000   Median :0.00000  
    ##  Mean   :0.07813   Mean   :0.03599   Mean   :0.02032   Mean   :0.02447  
    ##  3rd Qu.:0.00000   3rd Qu.:0.00000   3rd Qu.:0.00000   3rd Qu.:0.00000  
    ##  Max.   :1.00000   Max.   :1.00000   Max.   :1.00000   Max.   :1.00000  
    ##                                                                         
    ##       rtrd           cmsrv           hswrk             dngoth       
    ##  Min.   :0.000   Min.   :0e+00   Min.   :0.00000   Min.   :0.00000  
    ##  1st Qu.:0.000   1st Qu.:0e+00   1st Qu.:0.00000   1st Qu.:0.00000  
    ##  Median :0.000   Median :0e+00   Median :0.00000   Median :0.00000  
    ##  Mean   :0.297   Mean   :9e-04   Mean   :0.07785   Mean   :0.01124  
    ##  3rd Qu.:1.000   3rd Qu.:0e+00   3rd Qu.:0.00000   3rd Qu.:0.00000  
    ##  Max.   :1.000   Max.   :1e+00   Max.   :1.00000   Max.   :1.00000  
    ##                  NA's   :1592                                       
    ##      dngref             dngdk               dngna            mainact     
    ##  Min.   :0.000000   Min.   :0.0000000   Min.   :0.00000   Min.   : 1.00  
    ##  1st Qu.:0.000000   1st Qu.:0.0000000   1st Qu.:0.00000   1st Qu.:66.00  
    ##  Median :0.000000   Median :0.0000000   Median :0.00000   Median :66.00  
    ##  Mean   :0.002547   Mean   :0.0001661   Mean   :0.00144   Mean   :61.16  
    ##  3rd Qu.:0.000000   3rd Qu.:0.0000000   3rd Qu.:0.00000   3rd Qu.:66.00  
    ##  Max.   :1.000000   Max.   :1.0000000   Max.   :1.00000   Max.   :99.00  
    ##                                                                          
    ##     mnactic          crpdwk         pdjobev         pdjobyr        emplrel     
    ##  Min.   : 1.00   Min.   :1.000   Min.   :1.000   Min.   :1915   Min.   :1.000  
    ##  1st Qu.: 1.00   1st Qu.:2.000   1st Qu.:1.000   1st Qu.:2018   1st Qu.:1.000  
    ##  Median : 1.00   Median :6.000   Median :6.000   Median :6666   Median :1.000  
    ##  Mean   : 3.43   Mean   :4.158   Mean   :3.875   Mean   :5106   Mean   :1.563  
    ##  3rd Qu.: 6.00   3rd Qu.:6.000   3rd Qu.:6.000   3rd Qu.:6666   3rd Qu.:1.000  
    ##  Max.   :99.00   Max.   :9.000   Max.   :9.000   Max.   :9999   Max.   :9.000  
    ##                                                                                
    ##      emplno         wrkctra          estsz           jbspv          njbspv     
    ##  Min.   :    0   Min.   :1.000   Min.   :1.000   Min.   :1.00   Min.   :    0  
    ##  1st Qu.:66666   1st Qu.:1.000   1st Qu.:1.000   1st Qu.:2.00   1st Qu.:66666  
    ##  Median :66666   Median :1.000   Median :3.000   Median :2.00   Median :66666  
    ##  Mean   :61007   Mean   :2.077   Mean   :2.951   Mean   :2.15   Mean   :52968  
    ##  3rd Qu.:66666   3rd Qu.:2.000   3rd Qu.:4.000   3rd Qu.:2.00   3rd Qu.:66666  
    ##  Max.   :99999   Max.   :9.000   Max.   :9.000   Max.   :9.00   Max.   :99999  
    ##                                                                                
    ##     wkdcorga        iorgact           wkhct           wkhtot          nacer2   
    ##  Min.   : 0.00   Min.   : 0.000   Min.   :  0.0   Min.   :  0.0   Min.   :  1  
    ##  1st Qu.: 2.00   1st Qu.: 0.000   1st Qu.: 40.0   1st Qu.: 40.0   1st Qu.: 41  
    ##  Median : 7.00   Median : 4.000   Median : 40.0   Median : 40.0   Median : 56  
    ##  Mean   :11.18   Mean   : 9.846   Mean   :165.4   Mean   :157.5   Mean   :140  
    ##  3rd Qu.:10.00   3rd Qu.: 8.000   3rd Qu.: 48.0   3rd Qu.: 50.0   3rd Qu.: 85  
    ##  Max.   :99.00   Max.   :99.000   Max.   :999.0   Max.   :999.0   Max.   :999  
    ##                                                                                
    ##     tporgwk          isco08         wrkac6m          uemp3m     
    ##  Min.   : 1.00   Min.   :    0   Min.   :1.000   Min.   :1.000  
    ##  1st Qu.: 3.00   1st Qu.: 3131   1st Qu.:2.000   1st Qu.:1.000  
    ##  Median : 4.00   Median : 5223   Median :2.000   Median :2.000  
    ##  Mean   : 9.11   Mean   :12729   Mean   :2.314   Mean   :1.778  
    ##  3rd Qu.: 4.00   3rd Qu.: 8322   3rd Qu.:2.000   3rd Qu.:2.000  
    ##  Max.   :99.00   Max.   :99999   Max.   :9.000   Max.   :9.000  
    ##                                                                 
    ##     uemp12m         uemp5yr          mbtru          hincsrca     
    ##  Min.   :1.000   Min.   :1.000   Min.   :1.000   Min.   : 1.000  
    ##  1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.000   1st Qu.: 1.000  
    ##  Median :6.000   Median :6.000   Median :3.000   Median : 1.000  
    ##  Mean   :4.792   Mean   :4.786   Mean   :2.596   Mean   : 3.141  
    ##  3rd Qu.:6.000   3rd Qu.:6.000   3rd Qu.:3.000   3rd Qu.: 4.000  
    ##  Max.   :9.000   Max.   :9.000   Max.   :9.000   Max.   :99.000  
    ##                                                                  
    ##     hinctnta        hincfel         edulvlpb       eiscedp        edlvpebg    
    ##  Min.   : 1.00   Min.   :1.000   Min.   :   0   Min.   : 1.0   Min.   :   1   
    ##  1st Qu.: 4.00   1st Qu.:2.000   1st Qu.: 323   1st Qu.: 4.0   1st Qu.:   8   
    ##  Median : 6.00   Median :2.000   Median : 720   Median : 7.0   Median :  13   
    ##  Mean   :19.32   Mean   :2.144   Mean   :3249   Mean   :32.3   Mean   :3003   
    ##  3rd Qu.:10.00   3rd Qu.:3.000   3rd Qu.:6666   3rd Qu.:66.0   3rd Qu.:6666   
    ##  Max.   :99.00   Max.   :9.000   Max.   :9999   Max.   :99.0   Max.   :8888   
    ##                                                                NA's   :15342  
    ##     edlvpehr        edlvpdcz        edlvpdee        edlvpdfi    
    ##  Min.   :   1    Min.   :   1    Min.   : 113    Min.   :   1   
    ##  1st Qu.:   6    1st Qu.:   6    1st Qu.: 423    1st Qu.:   5   
    ##  Median :  11    Median :6666    Median : 720    Median :  12   
    ##  Mean   :2997    Mean   :3453    Mean   :3445    Mean   :2682   
    ##  3rd Qu.:6666    3rd Qu.:6666    3rd Qu.:6666    3rd Qu.:6666   
    ##  Max.   :9999    Max.   :8888    Max.   :9999    Max.   :8888   
    ##  NA's   :16468   NA's   :15584   NA's   :16518   NA's   :16483  
    ##     edlvpdfr       edlvpdahu        edlvpdlt        edlvpesi    
    ##  Min.   :   1    Min.   :   2    Min.   :   0    Min.   :   1   
    ##  1st Qu.:   9    1st Qu.:   4    1st Qu.:  10    1st Qu.:   4   
    ##  Median :  20    Median :  10    Median :6666    Median :   7   
    ##  Mean   :2809    Mean   :2829    Mean   :3454    Mean   :2529   
    ##  3rd Qu.:6666    3rd Qu.:6666    3rd Qu.:6666    3rd Qu.:6666   
    ##  Max.   :8888    Max.   :9999    Max.   :8888    Max.   :8888   
    ##  NA's   :16083   NA's   :16211   NA's   :16401   NA's   :16808  
    ##     edlvpdsk         pdwrkp           edctnp            uemplap       
    ##  Min.   :   1    Min.   :0.0000   Min.   :0.000000   Min.   :0.00000  
    ##  1st Qu.:   7    1st Qu.:0.0000   1st Qu.:0.000000   1st Qu.:0.00000  
    ##  Median :  16    Median :0.0000   Median :0.000000   Median :0.00000  
    ##  Mean   :3020    Mean   :0.3508   Mean   :0.007586   Mean   :0.01462  
    ##  3rd Qu.:6666    3rd Qu.:1.0000   3rd Qu.:0.000000   3rd Qu.:0.00000  
    ##  Max.   :8888    Max.   :1.0000   Max.   :1.000000   Max.   :1.00000  
    ##  NA's   :16642                                                        
    ##     uemplip             dsbldp             rtrdp            cmsrvp     
    ##  Min.   :0.000000   Min.   :0.000000   Min.   :0.0000   Min.   :0e+00  
    ##  1st Qu.:0.000000   1st Qu.:0.000000   1st Qu.:0.0000   1st Qu.:0e+00  
    ##  Median :0.000000   Median :0.000000   Median :0.0000   Median :0e+00  
    ##  Mean   :0.007032   Mean   :0.008472   Mean   :0.1506   Mean   :2e-04  
    ##  3rd Qu.:0.000000   3rd Qu.:0.000000   3rd Qu.:0.0000   3rd Qu.:0e+00  
    ##  Max.   :1.000000   Max.   :1.000000   Max.   :1.0000   Max.   :1e+00  
    ##                                                         NA's   :1592   
    ##      hswrkp           dngothp             dngdkp             dngnapp      
    ##  Min.   :0.00000   Min.   :0.000000   Min.   :0.0000000   Min.   :0.0000  
    ##  1st Qu.:0.00000   1st Qu.:0.000000   1st Qu.:0.0000000   1st Qu.:0.0000  
    ##  Median :0.00000   Median :0.000000   Median :0.0000000   Median :0.0000  
    ##  Mean   :0.04103   Mean   :0.005925   Mean   :0.0006645   Mean   :0.4397  
    ##  3rd Qu.:0.00000   3rd Qu.:0.000000   3rd Qu.:0.0000000   3rd Qu.:1.0000  
    ##  Max.   :1.00000   Max.   :1.000000   Max.   :1.0000000   Max.   :1.0000  
    ##                                                                           
    ##     dngrefp             dngnap             mnactp         crpdwkp     
    ##  Min.   :0.000000   Min.   :0.000000   Min.   : 1.00   Min.   :1.000  
    ##  1st Qu.:0.000000   1st Qu.:0.000000   1st Qu.:66.00   1st Qu.:6.000  
    ##  Median :0.000000   Median :0.000000   Median :66.00   Median :6.000  
    ##  Mean   :0.002159   Mean   :0.003931   Mean   :64.21   Mean   :5.181  
    ##  3rd Qu.:0.000000   3rd Qu.:0.000000   3rd Qu.:66.00   3rd Qu.:6.000  
    ##  Max.   :1.000000   Max.   :1.000000   Max.   :99.00   Max.   :9.000  
    ##                                                                       
    ##     isco08p         emprelp         wkhtotp         edulvlfb       eiscedf     
    ##  Min.   :    0   Min.   :1.000   Min.   :  0.0   Min.   :   0   Min.   : 1.00  
    ##  1st Qu.: 7131   1st Qu.:1.000   1st Qu.: 42.0   1st Qu.: 213   1st Qu.: 2.00  
    ##  Median :66666   Median :6.000   Median :666.0   Median : 321   Median : 3.00  
    ##  Mean   :46216   Mean   :4.273   Mean   :468.9   Mean   :1002   Mean   :10.07  
    ##  3rd Qu.:66666   3rd Qu.:6.000   3rd Qu.:666.0   3rd Qu.: 421   3rd Qu.: 5.00  
    ##  Max.   :99999   Max.   :9.000   Max.   :999.0   Max.   :9999   Max.   :99.00  
    ##                                                                                
    ##     edlvfebg         edlvfehr         edlvfdcz         edlvfdee    
    ##  Min.   :   1.0   Min.   :   1.0   Min.   :   1.0   Min.   :   0   
    ##  1st Qu.:   4.0   1st Qu.:   3.0   1st Qu.:   4.0   1st Qu.: 213   
    ##  Median :   7.0   Median :   5.0   Median :   5.0   Median : 321   
    ##  Mean   : 436.1   Mean   : 410.8   Mean   : 577.4   Mean   :1118   
    ##  3rd Qu.:   9.0   3rd Qu.:   6.0   3rd Qu.:   8.0   3rd Qu.: 610   
    ##  Max.   :8888.0   Max.   :8888.0   Max.   :8888.0   Max.   :8888   
    ##  NA's   :15342    NA's   :16468    NA's   :15584    NA's   :16518  
    ##     edlvfdfi         edlvfdfr       edlvfdahu         edlvfdlt    
    ##  Min.   :   1.0   Min.   :   1    Min.   :   1.0   Min.   :   0   
    ##  1st Qu.:   2.0   1st Qu.:   3    1st Qu.:   3.0   1st Qu.:   2   
    ##  Median :   5.0   Median :   7    Median :   4.0   Median :   7   
    ##  Mean   : 459.7   Mean   :1411    Mean   : 365.8   Mean   :1547   
    ##  3rd Qu.:   8.0   3rd Qu.:  19    3rd Qu.:   4.0   3rd Qu.:  13   
    ##  Max.   :8888.0   Max.   :8888    Max.   :9999.0   Max.   :8888   
    ##  NA's   :16483    NA's   :16083   NA's   :16211    NA's   :16401  
    ##     edlvfesi         edlvfdsk         emprf14         occf14b     
    ##  Min.   :   0.0   Min.   :   1.0   Min.   :1.000   Min.   : 1.00  
    ##  1st Qu.:   2.0   1st Qu.:   6.0   1st Qu.:1.000   1st Qu.: 5.00  
    ##  Median :   3.0   Median :   6.0   Median :1.000   Median : 7.00  
    ##  Mean   : 453.2   Mean   : 793.4   Mean   :1.625   Mean   :15.27  
    ##  3rd Qu.:   4.0   3rd Qu.:   7.0   3rd Qu.:1.000   3rd Qu.: 9.00  
    ##  Max.   :9999.0   Max.   :8888.0   Max.   :9.000   Max.   :99.00  
    ##  NA's   :16808    NA's   :16642                                   
    ##     edulvlmb         eiscedm          edlvmebg         edlvmehr     
    ##  Min.   :   0.0   Min.   : 1.000   Min.   :   1.0   Min.   :   1.0  
    ##  1st Qu.: 213.0   1st Qu.: 2.000   1st Qu.:   4.0   1st Qu.:   3.0  
    ##  Median : 321.0   Median : 3.000   Median :   7.0   Median :   4.0  
    ##  Mean   : 723.1   Mean   : 7.347   Mean   : 343.8   Mean   : 258.3  
    ##  3rd Qu.: 323.0   3rd Qu.: 4.000   3rd Qu.:   9.0   3rd Qu.:   6.0  
    ##  Max.   :9999.0   Max.   :99.000   Max.   :8888.0   Max.   :8888.0  
    ##                                    NA's   :15342    NA's   :16468   
    ##     edlvmdcz         edlvmdee         edlvmdfi         edlvmdfr    
    ##  Min.   :   1.0   Min.   :   0.0   Min.   :   1.0   Min.   :   1   
    ##  1st Qu.:   4.0   1st Qu.: 213.0   1st Qu.:   2.0   1st Qu.:   3   
    ##  Median :   5.0   Median : 313.0   Median :   5.0   Median :   7   
    ##  Mean   : 293.4   Mean   : 587.4   Mean   : 306.1   Mean   :1066   
    ##  3rd Qu.:   7.0   3rd Qu.: 520.0   3rd Qu.:   8.0   3rd Qu.:  14   
    ##  Max.   :8888.0   Max.   :8888.0   Max.   :8888.0   Max.   :8888   
    ##  NA's   :15584    NA's   :16518    NA's   :16483    NA's   :16083  
    ##    edlvmdahu         edlvmdlt         edlvmesi         edlvmdsk     
    ##  Min.   :   1.0   Min.   :   0.0   Min.   :   0.0   Min.   :   1.0  
    ##  1st Qu.:   3.0   1st Qu.:   1.0   1st Qu.:   2.0   1st Qu.:   4.0  
    ##  Median :   4.0   Median :   7.0   Median :   3.0   Median :   6.0  
    ##  Mean   : 207.9   Mean   : 801.1   Mean   : 220.6   Mean   : 659.1  
    ##  3rd Qu.:   6.0   3rd Qu.:  12.0   3rd Qu.:   4.0   3rd Qu.:   7.0  
    ##  Max.   :9999.0   Max.   :8888.0   Max.   :9999.0   Max.   :8888.0  
    ##  NA's   :16211    NA's   :16401    NA's   :16808    NA's   :16642   
    ##     emprm14         occm14b         atncrse         anctry1      
    ##  Min.   :1.000   Min.   : 1.00   Min.   :1.000   Min.   : 10000  
    ##  1st Qu.:1.000   1st Qu.: 4.00   1st Qu.:2.000   1st Qu.: 14030  
    ##  Median :1.000   Median : 7.00   Median :2.000   Median : 15020  
    ##  Mean   :1.697   Mean   :21.49   Mean   :1.835   Mean   : 17952  
    ##  3rd Qu.:3.000   3rd Qu.:66.00   3rd Qu.:2.000   3rd Qu.: 15040  
    ##  Max.   :9.000   Max.   :99.00   Max.   :9.000   Max.   :999999  
    ##                                                                  
    ##     anctry2          regunit         region         
    ##  Min.   : 11000   Min.   :2.000   Length:18060      
    ##  1st Qu.:555555   1st Qu.:3.000   Class :character  
    ##  Median :555555   Median :3.000   Mode  :character  
    ##  Mean   :573172   Mean   :2.891                     
    ##  3rd Qu.:555555   3rd Qu.:3.000                     
    ##  Max.   :999999   Max.   :3.000                     
    ## 

    ##   [1] "name"      "essround"  "edition"   "proddate"  "idno"      "cntry"    
    ##   [7] "pweight"   "dweight"   "nwspol"    "netusoft"  "netustm"   "ppltrst"  
    ##  [13] "pplfair"   "pplhlp"    "polintr"   "psppsgva"  "actrolga"  "psppipla" 
    ##  [19] "cptppola"  "trstprl"   "trstlgl"   "trstplc"   "trstplt"   "trstprt"  
    ##  [25] "trstep"    "trstun"    "trstsci"   "vote"      "prtvtebg"  "prtvtbhr" 
    ##  [31] "prtvtecz"  "prtvthee"  "prtvtefi"  "prtvtefr"  "prtvtghu"  "prtvclt1" 
    ##  [37] "prtvclt2"  "prtvclt3"  "prtvtfsi"  "prtvtesk"  "contplt"   "donprty"  
    ##  [43] "badge"     "sgnptit"   "pbldmna"   "bctprd"    "pstplonl"  "volunfp"  
    ##  [49] "clsprty"   "prtclebg"  "prtclbhr"  "prtclecz"  "prtclhee"  "prtclffi" 
    ##  [55] "prtclffr"  "prtclhhu"  "prtclclt"  "prtclfsi"  "prtclesk"  "prtdgcl"  
    ##  [61] "lrscale"   "stflife"   "stfeco"    "stfgov"    "stfdem"    "stfedu"   
    ##  [67] "stfhlth"   "gincdif"   "freehms"   "hmsfmlsh"  "hmsacld"   "euftf"    
    ##  [73] "lrnobed"   "loylead"   "imsmetn"   "imdfetn"   "impcntr"   "imbgeco"  
    ##  [79] "imueclt"   "imwbcnt"   "happy"     "sclmeet"   "inprdsc"   "sclact"   
    ##  [85] "crmvct"    "aesfdrk"   "health"    "hlthhmp"   "atchctr"   "atcherp"  
    ##  [91] "rlgblg"    "rlgdnm"    "rlgdnafi"  "rlgdnhu"   "rlgdnlt"   "rlgdnbsk" 
    ##  [97] "rlgblge"   "rlgdnme"   "rlgdeafi"  "rlgdehu"   "rlgdelt"   "rlgdebsk" 
    ## [103] "rlgdgr"    "rlgatnd"   "pray"      "dscrgrp"   "dscrrce"   "dscrntn"  
    ## [109] "dscrrlg"   "dscrlng"   "dscretn"   "dscrage"   "dscrgnd"   "dscrsex"  
    ## [115] "dscrdsb"   "dscroth"   "dscrdk"    "dscrref"   "dscrnap"   "dscrna"   
    ## [121] "ctzcntr"   "brncntr"   "cntbrthd"  "livecnta"  "lnghom1"   "lnghom2"  
    ## [127] "feethngr"  "facntr"    "fbrncntc"  "mocntr"    "mbrncntc"  "ccnthum"  
    ## [133] "ccrdprs"   "wrclmch"   "admrclc"   "testic34"  "testic35"  "testic36" 
    ## [139] "testic37"  "testic38"  "testic39"  "testic40"  "testic41"  "testic42" 
    ## [145] "vteurmmb"  "vteubcmb"  "fairelc"   "dfprtal"   "medcrgv"   "rghmgpr"  
    ## [151] "votedir"   "cttresa"   "gptpelc"   "gvctzpv"   "grdfinc"   "viepol"   
    ## [157] "wpestop"   "keydec"    "fairelcc"  "dfprtalc"  "medcrgvc"  "rghmgprc" 
    ## [163] "votedirc"  "cttresac"  "gptpelcc"  "gvctzpvc"  "grdfincc"  "viepolc"  
    ## [169] "wpestopc"  "keydecc"   "chpldm"    "chpldmi"   "chpldmc"   "stpldmi"  
    ## [175] "stpldmc"   "admit"     "showcv"    "impdema"   "impdemb"   "impdemc"  
    ## [181] "impdemd"   "impdeme"   "implvdm"   "accalaw"   "hhmmb"     "gndr"     
    ## [187] "gndr2"     "gndr3"     "gndr4"     "gndr5"     "gndr6"     "gndr7"    
    ## [193] "gndr8"     "gndr9"     "gndr10"    "gndr11"    "gndr12"    "gndr13"   
    ## [199] "yrbrn"     "agea"      "yrbrn2"    "yrbrn3"    "yrbrn4"    "yrbrn5"   
    ## [205] "yrbrn6"    "yrbrn7"    "yrbrn8"    "yrbrn9"    "yrbrn10"   "yrbrn11"  
    ## [211] "yrbrn12"   "yrbrn13"   "rshipa2"   "rshipa3"   "rshipa4"   "rshipa5"  
    ## [217] "rshipa6"   "rshipa7"   "rshipa8"   "rshipa9"   "rshipa10"  "rshipa11" 
    ## [223] "rshipa12"  "rshipa13"  "acchome"   "accwrk"    "accmove"   "accoth"   
    ## [229] "accnone"   "accref"    "accdk"     "accna"     "fampref"   "famadvs"  
    ## [235] "fampdf"    "mcclose"   "mcinter"   "mccoord"   "mcpriv"    "mcmsinf"  
    ## [241] "chldo12"   "gndro12a"  "gndro12b"  "ageo12"    "hhlio12"   "closeo12" 
    ## [247] "ttmino12"  "speako12"  "scrno12"   "phoneo12"  "como12"    "c19spo12" 
    ## [253] "c19mco12"  "livpnt"    "pntmofa"   "agepnt"    "hhlipnt"   "closepnt" 
    ## [259] "ttminpnt"  "speakpnt"  "scrnpnt"   "phonepnt"  "compnt"    "c19sppnt" 
    ## [265] "c19mcpnt"  "stfmjob"   "trdawrk"   "jbprtfp"   "pfmfdjba"  "dcsfwrka" 
    ## [271] "wrkhome"   "c19whome"  "c19wplch"  "wrklong"   "wrkresp"   "c19whacc" 
    ## [277] "mansupp"   "manhlp"    "manwrkpl"  "manspeak"  "manscrn"   "manphone" 
    ## [283] "mancom"    "teamfeel"  "wrkextra"  "colprop"   "colhlp"    "colspeak" 
    ## [289] "colscrn"   "colphone"  "colcom"    "c19spwrk"  "c19mcwrk"  "mcwrkhom" 
    ## [295] "ipcrtiv"   "imprich"   "ipeqopt"   "ipshabt"   "impsafe"   "impdiff"  
    ## [301] "ipfrule"   "ipudrst"   "ipmodst"   "ipgdtim"   "impfree"   "iphlppl"  
    ## [307] "ipsuces"   "ipstrgv"   "ipadvnt"   "ipbhprp"   "iprspot"   "iplylfr"  
    ## [313] "impenv"    "imptrad"   "impfun"    "testii1"   "testii2"   "testii3"  
    ## [319] "testii4"   "testii5"   "testii6"   "testii7"   "testii8"   "testii9"  
    ## [325] "secgrdec"  "scidecpb"  "admc19"    "panpriph"  "panmonpb"  "govpriph" 
    ## [331] "govmonpb"  "panfolru"  "panclobo"  "panresmo"  "gvhanc19"  "gvjobc19" 
    ## [337] "gveldc19"  "gvfamc19"  "hscopc19"  "gvbalc19"  "gvimpc19"  "gvconc19" 
    ## [343] "respc19"   "reshhc19"  "hapljc19"  "hapirc19"  "hapwrc19"  "hapfuc19" 
    ## [349] "hapfoc19"  "hapnoc19"  "hapnwc19"  "hapnpc19"  "haprec19"  "hapdkc19" 
    ## [355] "hapnac19"  "icvacc19"  "getavc19"  "getnvc19"  "vdcond"    "vdovexre" 
    ## [361] "vdtype"    "vdtpsvre"  "vdtpitre"  "vdtpscre"  "vdtpaure"  "vdtpvire" 
    ## [367] "vdtpoire"  "vdtpntre"  "vdtpapre"  "vdtprere"  "vdtpdkre"  "vdtpnare" 
    ## [373] "inwds"     "ainws"     "ainwe"     "binwe"     "cinwe"     "dinwe"    
    ## [379] "finwe"     "ginwe"     "hinwe"     "iinwe"     "kinwe"     "vinwe"    
    ## [385] "inwde"     "jinws"     "jinwe"     "inwtm"     "domain"    "prob"     
    ## [391] "stratum"   "psu"       "rshpsts"   "lvgptnea"  "dvrcdeva"  "marsts"   
    ## [397] "maritalb"  "chldhhe"   "domicil"   "edulvlb"   "eisced"    "edlvebg"  
    ## [403] "edlvehr"   "edlvdcz"   "edlvdee"   "edlvdfi"   "edlvdfr"   "edlvdahu" 
    ## [409] "edlvdlt"   "edlvesi"   "edlvdsk"   "eduyrs"    "pdwrk"     "edctn"    
    ## [415] "uempla"    "uempli"    "dsbld"     "rtrd"      "cmsrv"     "hswrk"    
    ## [421] "dngoth"    "dngref"    "dngdk"     "dngna"     "mainact"   "mnactic"  
    ## [427] "crpdwk"    "pdjobev"   "pdjobyr"   "emplrel"   "emplno"    "wrkctra"  
    ## [433] "estsz"     "jbspv"     "njbspv"    "wkdcorga"  "iorgact"   "wkhct"    
    ## [439] "wkhtot"    "nacer2"    "tporgwk"   "isco08"    "wrkac6m"   "uemp3m"   
    ## [445] "uemp12m"   "uemp5yr"   "mbtru"     "hincsrca"  "hinctnta"  "hincfel"  
    ## [451] "edulvlpb"  "eiscedp"   "edlvpebg"  "edlvpehr"  "edlvpdcz"  "edlvpdee" 
    ## [457] "edlvpdfi"  "edlvpdfr"  "edlvpdahu" "edlvpdlt"  "edlvpesi"  "edlvpdsk" 
    ## [463] "pdwrkp"    "edctnp"    "uemplap"   "uemplip"   "dsbldp"    "rtrdp"    
    ## [469] "cmsrvp"    "hswrkp"    "dngothp"   "dngdkp"    "dngnapp"   "dngrefp"  
    ## [475] "dngnap"    "mnactp"    "crpdwkp"   "isco08p"   "emprelp"   "wkhtotp"  
    ## [481] "edulvlfb"  "eiscedf"   "edlvfebg"  "edlvfehr"  "edlvfdcz"  "edlvfdee" 
    ## [487] "edlvfdfi"  "edlvfdfr"  "edlvfdahu" "edlvfdlt"  "edlvfesi"  "edlvfdsk" 
    ## [493] "emprf14"   "occf14b"   "edulvlmb"  "eiscedm"   "edlvmebg"  "edlvmehr" 
    ## [499] "edlvmdcz"  "edlvmdee"  "edlvmdfi"  "edlvmdfr"  "edlvmdahu" "edlvmdlt" 
    ## [505] "edlvmesi"  "edlvmdsk"  "emprm14"   "occm14b"   "atncrse"   "anctry1"  
    ## [511] "anctry2"   "regunit"   "region"

In cases with large data sets like this we might want to *select a
subset of variables* that we want to work with.

    ## [1] 18060     3

    ##   agea eisced gndr
    ## 1   76      4    2
    ## 2   43      6    1
    ## 3   50      7    2
    ## 4   51      4    2
    ## 5   70      7    1
    ## 6   31      4    2

*3 Descriptive Statistics*

When talking about descriptive statistics, we first need to know what
type of variable each item is.

*Continuous* For *continuous* items, the type of descriptive statistics
we present are related to central tendency and variability measures. We
will use the descr() function from the summarytools package.

Be aware that this function will give you results if you use them with
categorical variables, but these would not be meaningful. From the
selected variables the only ones that are truly continuous are age.

``` r
#install.packages("summarytools")
library(summarytools)

descr(dat2$agea)
```

    ## Descriptive Statistics  
    ## dat2$agea  
    ## Label: Age of respondent, calculated  
    ## N: 18060  
    ## 
    ##                         agea
    ## ----------------- ----------
    ##              Mean      50.89
    ##           Std.Dev      18.45
    ##               Min      15.00
    ##                Q1      36.00
    ##            Median      51.00
    ##                Q3      66.00
    ##               Max      90.00
    ##               MAD      22.24
    ##               IQR      30.00
    ##                CV       0.36
    ##          Skewness      -0.07
    ##       SE.Skewness       0.02
    ##          Kurtosis      -0.93
    ##           N.Valid   17940.00
    ##         Pct.Valid      99.34

This function provides a lot of useful information. The N.valid is the
total non missing answers for the variable, followed by a series of
descriptive statistics like the mean, standard deviation, median,
minimum, maximum, and others. You can also transpose the table,
depending on which direction you prefer.

``` r
descr(dat2$agea, transpose = T)
```

    ## Descriptive Statistics  
    ## dat2$agea  
    ## Label: Age of respondent, calculated  
    ## N: 18060  
    ## 
    ##               Mean   Std.Dev     Min      Q1   Median      Q3     Max     MAD     IQR     CV
    ## ---------- ------- --------- ------- ------- -------- ------- ------- ------- ------- ------
    ##       agea   50.89     18.45   15.00   36.00    51.00   66.00   90.00   22.24   30.00   0.36
    ## 
    ## Table: Table continues below
    ## 
    ##  
    ## 
    ##              Skewness   SE.Skewness   Kurtosis    N.Valid   Pct.Valid
    ## ---------- ---------- ------------- ---------- ---------- -----------
    ##       agea      -0.07          0.02      -0.93   17940.00       99.34

You can also get the descriptive statistics of a continuous variable by
group:

``` r
desc <- stby(data = dat2[,c("agea")], 
     INDICES   = dat2$gndr, 
     FUN = descr, 
     stats = "common", 
     transpose = TRUE)
desc
```

    ## Descriptive Statistics  
    ## value  
    ## N: 8100  
    ## 
    ##                Mean   Std.Dev     Min   Median     Max   N.Valid   Pct.Valid
    ## ----------- ------- --------- ------- -------- ------- --------- -----------
    ##       value   49.78     18.23   15.00    50.00   90.00   8042.00       99.28
    ## 
    ## N: 9960  
    ## 
    ##                Mean   Std.Dev     Min   Median     Max   N.Valid   Pct.Valid
    ## ----------- ------- --------- ------- -------- ------- --------- -----------
    ##       value   51.78     18.58   15.00    52.00   90.00   9898.00       99.38

*Missing values*

Using the function above, we saw that our variable of interest (age) has
a total of 17940 non missing answers. Since our data has 1806 entries,
this means that the variable contains some missing values that R refers
to as *“NA”*. There are different ways of dealing with NAs. In the
following, we will delete missing values to keep the rectangular
structure of our data.This means, when we delete a missing value from
one variable, we delete it for the entire row of the dataset.

First, we introduce the is.na() function. We supply a vector to the
function and it checks for every element, whether it is missing or not.
R returns true or false. Let’s use the function on our variable.

    ##     [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##    [13] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##    [25] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##    [37] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##    [49] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##    [61] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##    [73] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##    [85] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##    [97] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [109] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [121] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [133] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [145] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [157] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [169] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [181] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [193] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [205] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [217] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [229] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [241] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [253] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [265] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [277] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [289] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [301] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [313] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [325] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [337] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [349] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [361] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [373] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [385] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [397] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [409] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [421] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [433] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [445] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [457] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [469] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [481] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [493] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [505] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [517] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ##   [529] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [541] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [553] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [565] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [577] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [589] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [601] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [613] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [625] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [637] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [649] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [661] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [673] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [685] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [697] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
    ##   [709] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ##   [721] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [733] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [745] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
    ##   [757] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [769] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [781] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
    ##   [793] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [805] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [817] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [829] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [841] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [853] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [865] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [877] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [889] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [901] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [913] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [925] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [937] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [949] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [961] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [973] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [985] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##   [997] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1009] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1021] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1033] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1045] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1057] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1069] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1081] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1093] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1105] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1117] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1129] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1141] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1153] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1165] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1177] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1189] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1201] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1213] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1225] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1237] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1249] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1261] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1273] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1285] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1297] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1309] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1321] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1333] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1345] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1357] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1369] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
    ##  [1381] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1393] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1405] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1417] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1429] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1441] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1453] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1465] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1477] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1489] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1501] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1513] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1525] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
    ##  [1537] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1549] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1561] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1573] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1585] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1597] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1609] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1621] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1633] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1645] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1657] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1669] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1681] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1693] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1705] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1717] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1729] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1741] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1753] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1765] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1777] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1789] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1801] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1813] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1825] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1837] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1849] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1861] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1873] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1885] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1897] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1909] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
    ##  [1921] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
    ##  [1933] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1945] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
    ##  [1957] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1969] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1981] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [1993] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2005] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2017] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2029] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2041] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2053] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2065] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2077] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2089] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2101] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2113] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2125] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2137] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2149] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2161] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2173] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2185] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2197] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2209] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2221] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2233] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2245] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ##  [2257] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2269] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2281] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2293] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2305] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2317] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2329] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2341] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2353] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
    ##  [2365] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2377] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2389] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2401] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2413] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2425] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2437] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2449] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2461] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
    ##  [2473] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
    ##  [2485] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2497] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2509] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2521] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2533] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2545] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2557] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2569] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2581] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2593] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2605] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2617] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2629] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2641] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2653] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2665] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2677] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2689] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2701] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2713] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2725] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2737] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2749] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2761] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2773] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2785] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2797] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2809] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2821] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2833] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2845] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2857] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2869] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2881] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2893] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2905] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2917] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2929] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2941] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2953] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2965] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2977] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [2989] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3001] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3013] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3025] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3037] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3049] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3061] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3073] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3085] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3097] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3109] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3121] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3133] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3145] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3157] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3169] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3181] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3193] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3205] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3217] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3229] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3241] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3253] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3265] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3277] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3289] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3301] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3313] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3325] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3337] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3349] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3361] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3373] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3385] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3397] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3409] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3421] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3433] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3445] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3457] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3469] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3481] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3493] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3505] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3517] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3529] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3541] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3553] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3565] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3577] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3589] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3601] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3613] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3625] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3637] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3649] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3661] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3673] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3685] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3697] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3709] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3721] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3733] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3745] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3757] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3769] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3781] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3793] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3805] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3817] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3829] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3841] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3853] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3865] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3877] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3889] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3901] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3913] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3925] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3937] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3949] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3961] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3973] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3985] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [3997] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4009] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4021] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4033] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4045] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4057] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4069] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4081] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4093] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4105] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4117] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4129] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4141] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4153] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4165] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4177] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4189] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4201] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4213] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4225] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4237] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4249] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4261] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4273] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4285] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4297] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4309] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4321] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4333] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4345] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4357] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4369] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4381] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4393] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4405] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4417] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4429] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4441] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4453] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4465] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4477] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4489] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4501] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4513] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4525] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4537] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4549] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4561] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4573] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4585] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4597] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4609] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4621] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4633] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4645] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4657] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4669] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4681] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4693] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4705] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4717] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4729] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4741] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4753] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4765] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4777] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4789] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4801] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4813] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4825] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4837] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4849] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4861] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4873] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4885] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4897] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4909] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4921] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4933] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4945] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4957] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4969] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4981] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [4993] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5005] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5017] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5029] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5041] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5053] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5065] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5077] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5089] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5101] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5113] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5125] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5137] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5149] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5161] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5173] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5185] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5197] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5209] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5221] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5233] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5245] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5257] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5269] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5281] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5293] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5305] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5317] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5329] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5341] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5353] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5365] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5377] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5389] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5401] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5413] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5425] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5437] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5449] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5461] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5473] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5485] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5497] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5509] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5521] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5533] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5545] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5557] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5569] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5581] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5593] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5605] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5617] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5629] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5641] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5653] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5665] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5677] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5689] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5701] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5713] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5725] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5737] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5749] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5761] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5773] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5785] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5797] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5809] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5821] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5833] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5845] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5857] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5869] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5881] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5893] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5905] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5917] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5929] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5941] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5953] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5965] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5977] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [5989] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6001] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6013] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6025] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6037] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6049] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6061] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6073] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6085] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6097] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6109] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6121] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6133] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6145] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6157] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6169] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6181] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6193] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6205] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6217] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6229] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6241] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6253] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6265] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6277] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6289] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6301] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6313] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6325] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6337] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6349] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6361] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6373] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6385] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6397] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6409] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6421] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6433] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6445] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6457] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6469] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6481] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6493] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6505] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6517] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6529] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6541] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6553] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6565] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6577] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6589] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6601] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6613] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6625] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6637] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6649] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6661] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6673] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6685] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6697] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6709] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6721] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6733] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6745] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6757] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6769] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6781] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6793] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6805] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6817] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6829] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6841] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6853] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6865] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6877] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6889] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6901] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6913] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6925] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6937] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6949] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6961] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6973] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6985] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [6997] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7009] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7021] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7033] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7045] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7057] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7069] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7081] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7093] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7105] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7117] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7129] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7141] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7153] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7165] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7177] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7189] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7201] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7213] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7225] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7237] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7249] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7261] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7273] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7285] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7297] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7309] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7321] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7333] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7345] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7357] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7369] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7381] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7393] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7405] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7417] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7429] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7441] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7453] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7465] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7477] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7489] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7501] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7513] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7525] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7537] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7549] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7561] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7573] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7585] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7597] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7609] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7621] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7633] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7645] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7657] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7669] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7681] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7693] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7705] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7717] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7729] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7741] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7753] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7765] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7777] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7789] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7801] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7813] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7825] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7837] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7849] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7861] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7873] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7885] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7897] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7909] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7921] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7933] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7945] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7957] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7969] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7981] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [7993] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8005] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8017] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8029] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8041] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8053] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8065] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8077] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8089] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8101] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8113] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8125] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8137] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8149] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8161] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8173] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8185] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8197] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8209] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8221] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8233] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8245] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8257] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8269] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8281] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8293] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8305] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8317] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8329] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8341] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8353] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8365] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8377] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8389] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8401] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8413] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8425] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8437] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8449] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8461] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8473] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8485] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8497] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8509] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8521] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8533] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8545] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8557] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8569] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8581] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8593] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8605] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8617] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8629] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8641] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8653] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8665] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8677] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8689] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8701] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8713] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ##  [8725] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8737] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8749] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8761] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8773] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8785] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8797] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8809] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8821] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8833] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8845] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8857] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8869] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8881] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8893] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8905] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8917] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8929] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8941] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8953] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8965] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8977] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [8989] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9001] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9013] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9025] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9037] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9049] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9061] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9073] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9085] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9097] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9109] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9121] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9133] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9145] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9157] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9169] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9181] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9193] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9205] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9217] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9229] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9241] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9253] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9265] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9277] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9289] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9301] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9313] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9325] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9337] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9349] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9361] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9373] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9385] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9397] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9409] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9421] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9433] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9445] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9457] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9469] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9481] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9493] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9505] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9517] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9529] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9541] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9553] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9565] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9577] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9589] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9601] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9613] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9625] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9637] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9649] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9661] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9673] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9685] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9697] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9709] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9721] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
    ##  [9733] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9745] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9757] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9769] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9781] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9793] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9805] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9817] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9829] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9841] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9853] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9865] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9877] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9889] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9901] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9913] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9925] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9937] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9949] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9961] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9973] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9985] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##  [9997] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10009] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10021] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10033] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10045] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10057] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10069] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10081] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10093] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10105] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10117] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10129] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10141] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10153] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10165] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10177] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10189] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10201] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10213] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10225] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10237] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10249] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10261] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10273] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10285] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10297] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10309] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10321] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10333] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
    ## [10345] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10357]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10369] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10381] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10393] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10405] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10417] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE
    ## [10429] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10441] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ## [10453] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10465] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10477] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10489]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10501] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10513] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ## [10525]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10537]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10549] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10561] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10573] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10585] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10597] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10609] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
    ## [10621] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10633] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10645] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ## [10657] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10669] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10681] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10693] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10705] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10717] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10729] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10741] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10753] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ## [10765] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10777] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
    ## [10789] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10801] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10813] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10825] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10837] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10849] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
    ## [10861] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10873] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10885] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10897] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10909] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10921] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ## [10933] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10945] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10957] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
    ## [10969] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10981] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [10993] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11005] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11017] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11029] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ## [11041] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11053] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11065] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11077] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11089] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11101] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
    ## [11113] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ## [11125] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
    ## [11137] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11149] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11161] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11173] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11185] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11197] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11209] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
    ## [11221] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11233] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11245] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11257] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11269] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11281] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11293] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11305] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
    ## [11317] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11329]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11341] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11353] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11365] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ## [11377] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11389] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11401] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11413] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11425] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11437] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11449] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11461] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
    ## [11473] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
    ## [11485] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11497] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11509] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11521] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11533] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11545] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11557] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11569] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11581] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11593] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11605] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11617] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
    ## [11629] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11641] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11653] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
    ## [11665] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
    ## [11677] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
    ## [11689] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11701] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11713] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11725] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11737] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11749] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
    ## [11761] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE  TRUE
    ## [11773] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11785] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11797] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11809] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11821] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11833] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11845] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ## [11857] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11869] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11881] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11893] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11905] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11917] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11929] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11941] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11953] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11965] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11977] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [11989] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12001] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12013] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12025] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12037] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12049] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12061] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12073] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12085] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12097] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12109] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12121] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12133] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12145] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12157] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12169] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12181] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12193] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12205] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12217] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12229] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12241] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12253] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12265] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12277] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12289] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12301] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12313] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12325] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12337] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12349] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12361] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12373] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12385] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12397] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12409] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12421] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12433] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12445] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12457] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12469] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12481] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12493] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12505] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12517] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12529] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12541] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12553] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12565] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12577] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12589] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12601] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12613] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12625] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12637] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12649] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12661] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12673] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12685] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12697] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12709] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12721] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12733] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12745] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12757] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12769] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12781] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12793] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12805] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12817] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12829] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12841] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12853] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12865] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12877] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12889] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12901] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12913] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12925] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12937] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12949] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12961] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12973] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12985] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [12997] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13009] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13021] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13033] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13045] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13057] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13069] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13081] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13093] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13105] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13117] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13129] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13141] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13153] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13165] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13177] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13189] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13201] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13213] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13225] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13237] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13249] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13261] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13273] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13285] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13297] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13309] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13321] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13333] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13345] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13357] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13369] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13381] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13393] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13405] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13417] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13429] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13441] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13453] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13465] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13477] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13489] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13501] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13513] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13525] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13537] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13549] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13561] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13573] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13585] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13597] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13609] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13621] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13633] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13645] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13657] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13669] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13681] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13693] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13705] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13717] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13729] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13741] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13753] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13765] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13777] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13789] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13801] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13813] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13825] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13837] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13849] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13861] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13873] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13885] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13897] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13909] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13921] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13933] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13945] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13957] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13969] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13981] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13993] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14005] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14017] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14029] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14041] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14053] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14065] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14077] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14089] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14101] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14113] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14125] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14137] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14149] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14161] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14173] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14185] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14197] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14209] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14221] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14233] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14245] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14257] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14269] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14281] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14293] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14305] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14317] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14329] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14341] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14353] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14365] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14377] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14389] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14401] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14413] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14425] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14437] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14449] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14461] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14473] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14485] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14497] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14509] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14521] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14533] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14545] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14557] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14569] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14581] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14593] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14605] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14617] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14629] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14641] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14653] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14665] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14677] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14689] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14701] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14713] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14725] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14737] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14749] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14761] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14773] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14785] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14797] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14809] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14821] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14833] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14845] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14857] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14869] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14881] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14893] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14905] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14917] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14929] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14941] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14953] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14965] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14977] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [14989] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15001] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15013] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15025] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15037] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15049] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15061] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15073] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15085] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15097] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15109] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15121] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15133] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15145] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15157] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15169] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15181] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15193] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15205] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15217] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15229] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15241] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15253] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15265] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15277] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15289] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15301] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15313] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15325] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15337] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15349] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15361] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15373] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15385] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15397] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15409] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15421] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15433] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15445] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15457] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15469] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15481] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15493] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15505] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15517] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15529] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15541] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15553] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15565] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15577] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15589] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15601] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15613] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15625] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15637] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15649] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15661] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15673] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15685] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15697] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15709] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15721] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15733] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15745] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15757] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15769] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15781] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15793] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15805] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15817] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15829] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15841] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15853] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15865] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15877] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15889] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15901] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15913] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15925] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15937] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15949] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15961] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15973] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15985] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [15997] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16009] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16021] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16033] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16045] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16057] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16069] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16081] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16093] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16105] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16117] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16129] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16141] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16153] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16165] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16177] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16189] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16201] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16213] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16225] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16237] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16249] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16261] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16273] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16285] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16297] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16309] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16321] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16333] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16345] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16357] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16369] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16381] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16393] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16405] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16417] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16429] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16441] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16453] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16465] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16477] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16489] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16501] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16513] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16525] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16537] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16549] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16561] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16573] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16585] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16597] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16609] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16621] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16633] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16645] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16657] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16669] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16681] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
    ## [16693] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
    ## [16705] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16717] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16729] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16741]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16753] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16765] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16777] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16789] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16801] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16813] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16825] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
    ## [16837] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16849] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16861] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16873] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16885] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16897] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16909] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16921] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16933] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16945] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ## [16957] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ## [16969] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
    ## [16981] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [16993] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17005] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ## [17017] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17029] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17041] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17053] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17065] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17077] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17089]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17101] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17113] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17125] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17137]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17149] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
    ## [17161] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
    ## [17173] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17185] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17197] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17209] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
    ## [17221] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17233] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17245]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17257] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17269] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
    ## [17281] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17293] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17305] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17317] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17329] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17341] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17353] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17365] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17377] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17389] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17401] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17413] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17425] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ## [17437] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17449] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17461] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
    ## [17473] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17485] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17497] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
    ## [17509] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
    ## [17521] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17533] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17545] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17557] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
    ## [17569] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
    ## [17581] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ## [17593] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE
    ## [17605] FALSE FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE
    ## [17617] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17629] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17641] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17653] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
    ## [17665] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17677] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17689] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17701] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17713] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17725] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ## [17737] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17749] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17761] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE FALSE
    ## [17773] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
    ## [17785] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17797] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17809] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17821] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17833] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ## [17845] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17857] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17869] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17881] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ## [17893] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17905] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17917] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17929] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17941] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
    ## [17953]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17965] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17977] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [17989] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [18001] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [18013] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [18025] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
    ## [18037] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [18049] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE

To see the amount of missing values (NA in R) in our variable, we can
combine is.na() with the table() function.

    ## 
    ## FALSE  TRUE 
    ## 17940   120

    ## [1] NA

    ## [1] 50.88645

    ## [1] 18.4512

So, our variable has 120 missing values. Our dataset has 18060 rows.
Check your global environment to confirm this or use the nrow()
function. If we delete all missing values from agea, our dataset will
lose 120 rows.

Before we delete missing values, we introduce the which() function. It
returns the row indexes (the rows in the dataset) where some condition
is true. So if we use which() and is.na(), we get the row numbers in our
dataset where values are missing on agea.

    ##   [1]   525   707   717   756   791   870   966  1156  1380  1419  1532  1602
    ##  [13]  1730  1781  1876  1915  1931  1956  2254  2364  2471  2484  8721  9483
    ##  [25]  9727 10340 10349 10357 10394 10425 10427 10449 10458 10489 10521 10525
    ##  [37] 10537 10616 10653 10673 10696 10761 10783 10859 10929 10968 11030 11038
    ##  [49] 11081 11111 11121 11136 11219 11316 11329 11374 11467 11484 11548 11621
    ##  [61] 11624 11660 11676 11683 11705 11759 11762 11769 11772 11848 11853 16648
    ##  [73] 16671 16691 16704 16741 16836 16953 16966 16980 16997 17014 17089 17104
    ##  [85] 17137 17156 17172 17200 17215 17245 17275 17333 17434 17468 17507 17515
    ##  [97] 17526 17567 17576 17590 17601 17602 17609 17610 17614 17622 17664 17734
    ## [109] 17753 17768 17769 17774 17783 17842 17862 17890 17947 17953 17981 18035

We said that our dataset will lose 120 rows. Let’s use the length()
function to confirm that this is the case.

    ## [1] 120

As we can see, we have indeed identified 120 rows that we would like to
delete from our dataset.

We now delete the rows with missing values on age by overwriting our
original dataset with a new dataset that is a copy of the old without
missing values on age. To subset our dataset, we use the square
brackets. We can use the *!* operator, which means *“not”*. So the
function returns “TRUE” if an observation is not missing.

Confirm that our new dataset (dat2) has 17940 rows remaining.

*Categorical*

For categorical variables the mean and previously presented statistics
are not meaningful. We need to describe them in a different way. For
this we will use the summarytools package and focus on the variables
education and gender.

    ## NULL

    ## 
    ##    1    2    3    4    5    6    7   55   77   88   99 
    ##  569 2151 2749 5911 1958 2001 2525   21   25   12   18

    ## $levels
    ## [1] "Less than lower secondary"        "Lower secondary"                 
    ## [3] "Lower tier upper secondary"       "Upper tier upper secondary"      
    ## [5] "Advanced vocational"              "Lower tertiary education (BA)"   
    ## [7] "Higher tertiary education (>=MA)" "Other"                           
    ## 
    ## $class
    ## [1] "factor"

    ## NULL

    ##                                   
    ##                                    Male Female
    ##   Less than lower secondary         286    281
    ##   Lower secondary                   929   1217
    ##   Lower tier upper secondary       1180   1552
    ##   Upper tier upper secondary       2635   3257
    ##   Advanced vocational               896   1053
    ##   Lower tertiary education (BA)     878   1124
    ##   Higher tertiary education (>=MA) 1172   1341
    ##   Other                               6     15

*Frequency tables*

The freq() function generates frequency tables with counts, proportions,
as well as missing data information.

    ## Frequencies  
    ## dat2$educ  
    ## Type: Factor  
    ## 
    ##                                           Freq   % Valid   % Valid Cum.   % Total   % Total Cum.
    ## -------------------------------------- ------- --------- -------------- --------- --------------
    ##              Less than lower secondary     567      3.18           3.18      3.16           3.16
    ##                        Lower secondary    2146     12.04          15.22     11.96          15.12
    ##             Lower tier upper secondary    2732     15.33          30.55     15.23          30.35
    ##             Upper tier upper secondary    5892     33.06          63.61     32.84          63.19
    ##                    Advanced vocational    1949     10.94          74.55     10.86          74.06
    ##          Lower tertiary education (BA)    2002     11.23          85.78     11.16          85.22
    ##       Higher tertiary education (>=MA)    2513     14.10          99.88     14.01          99.23
    ##                                  Other      21      0.12         100.00      0.12          99.34
    ##                                   <NA>     118                               0.66         100.00
    ##                                  Total   17940    100.00         100.00    100.00         100.00

    ## ### Frequencies  
    ## #### dat2$educ  
    ## **Type:** Factor  
    ## 
    ## |                               &nbsp; |  Freq | % Valid | % Valid Cum. | % Total | % Total Cum. |
    ## |-------------------------------------:|------:|--------:|-------------:|--------:|-------------:|
    ## |        **Less than lower secondary** |   567 |    3.18 |         3.18 |    3.16 |         3.16 |
    ## |                  **Lower secondary** |  2146 |   12.04 |        15.22 |   11.96 |        15.12 |
    ## |       **Lower tier upper secondary** |  2732 |   15.33 |        30.55 |   15.23 |        30.35 |
    ## |       **Upper tier upper secondary** |  5892 |   33.06 |        63.61 |   32.84 |        63.19 |
    ## |              **Advanced vocational** |  1949 |   10.94 |        74.55 |   10.86 |        74.06 |
    ## |    **Lower tertiary education (BA)** |  2002 |   11.23 |        85.78 |   11.16 |        85.22 |
    ## | **Higher tertiary education (>=MA)** |  2513 |   14.10 |        99.88 |   14.01 |        99.23 |
    ## |                            **Other** |    21 |    0.12 |       100.00 |    0.12 |        99.34 |
    ## |                           **\<NA\>** |   118 |         |              |    0.66 |       100.00 |
    ## |                            **Total** | 17940 |  100.00 |       100.00 |  100.00 |       100.00 |
    ## 
    ## #### dat2$gender  
    ## **Type:** Factor  
    ## 
    ## |     &nbsp; |  Freq | % Valid | % Valid Cum. | % Total | % Total Cum. |
    ## |-----------:|------:|--------:|-------------:|--------:|-------------:|
    ## |   **Male** |  8042 |   44.83 |        44.83 |   44.83 |        44.83 |
    ## | **Female** |  9898 |   55.17 |       100.00 |   55.17 |       100.00 |
    ## | **\<NA\>** |     0 |         |              |    0.00 |       100.00 |
    ## |  **Total** | 17940 |  100.00 |       100.00 |  100.00 |       100.00 |

We can also use the same function, and provide multiple variables at
once, getting the frequency tables for each specific variable.

    ## ### Frequencies  
    ## #### dat2$educ  
    ## **Type:** Factor  
    ## 
    ## |                               &nbsp; |  Freq | % Valid | % Valid Cum. | % Total | % Total Cum. |
    ## |-------------------------------------:|------:|--------:|-------------:|--------:|-------------:|
    ## |        **Less than lower secondary** |   567 |    3.18 |         3.18 |    3.16 |         3.16 |
    ## |                  **Lower secondary** |  2146 |   12.04 |        15.22 |   11.96 |        15.12 |
    ## |       **Lower tier upper secondary** |  2732 |   15.33 |        30.55 |   15.23 |        30.35 |
    ## |       **Upper tier upper secondary** |  5892 |   33.06 |        63.61 |   32.84 |        63.19 |
    ## |              **Advanced vocational** |  1949 |   10.94 |        74.55 |   10.86 |        74.06 |
    ## |    **Lower tertiary education (BA)** |  2002 |   11.23 |        85.78 |   11.16 |        85.22 |
    ## | **Higher tertiary education (>=MA)** |  2513 |   14.10 |        99.88 |   14.01 |        99.23 |
    ## |                            **Other** |    21 |    0.12 |       100.00 |    0.12 |        99.34 |
    ## |                           **\<NA\>** |   118 |         |              |    0.66 |       100.00 |
    ## |                            **Total** | 17940 |  100.00 |       100.00 |  100.00 |       100.00 |
    ## 
    ## #### dat2$gender  
    ## **Type:** Factor  
    ## 
    ## |     &nbsp; |  Freq | % Valid | % Valid Cum. | % Total | % Total Cum. |
    ## |-----------:|------:|--------:|-------------:|--------:|-------------:|
    ## |   **Male** |  8042 |   44.83 |        44.83 |   44.83 |        44.83 |
    ## | **Female** |  9898 |   55.17 |       100.00 |   55.17 |       100.00 |
    ## | **\<NA\>** |     0 |         |              |    0.00 |       100.00 |
    ## |  **Total** | 17940 |  100.00 |       100.00 |  100.00 |       100.00 |

*Cross-tables*

For categorical variables, if we want to estimate frequency tables
across multiple other groups, we estimate cross-tables. These present
the frequency of variable 1 at each level of variable 2, and vice versa,
depending on which direction you want to read the table.

To do this we use the function *ctable()*. Here we see the cross-table
between gender and education level. For this the main 2 arguments we
have to provide are 2 categorical variables of interest. You also
include the prop argument, which specifies which proportions you want to
show. In this first example we include don’t include any:

    ## Cross-Tabulation, Row Proportions  
    ## educ * gender  
    ## Data Frame: dat2  
    ## 
    ## ---------------------------------- -------- -------------- -------------- ----------------
    ##                                      gender           Male         Female            Total
    ##                               educ                                                        
    ##          Less than lower secondary             286 (50.4%)    281 (49.6%)     567 (100.0%)
    ##                    Lower secondary             929 (43.3%)   1217 (56.7%)    2146 (100.0%)
    ##         Lower tier upper secondary            1180 (43.2%)   1552 (56.8%)    2732 (100.0%)
    ##         Upper tier upper secondary            2635 (44.7%)   3257 (55.3%)    5892 (100.0%)
    ##                Advanced vocational             896 (46.0%)   1053 (54.0%)    1949 (100.0%)
    ##      Lower tertiary education (BA)             878 (43.9%)   1124 (56.1%)    2002 (100.0%)
    ##   Higher tertiary education (>=MA)            1172 (46.6%)   1341 (53.4%)    2513 (100.0%)
    ##                              Other               6 (28.6%)     15 (71.4%)      21 (100.0%)
    ##                               <NA>              60 (50.8%)     58 (49.2%)     118 (100.0%)
    ##                              Total            8042 (44.8%)   9898 (55.2%)   17940 (100.0%)
    ## ---------------------------------- -------- -------------- -------------- ----------------

Here we include column proportions:

    ## Cross-Tabulation, Column Proportions  
    ## educ * gender  
    ## Data Frame: dat2  
    ## 
    ## ---------------------------------- -------- ---------------- --------------- ----------------
    ##                                      gender             Male          Female            Total
    ##                               educ                                                           
    ##          Less than lower secondary             286 (  3.56%)    281 (  2.8%)     567 (  3.2%)
    ##                    Lower secondary             929 ( 11.55%)   1217 ( 12.3%)    2146 ( 12.0%)
    ##         Lower tier upper secondary            1180 ( 14.67%)   1552 ( 15.7%)    2732 ( 15.2%)
    ##         Upper tier upper secondary            2635 ( 32.77%)   3257 ( 32.9%)    5892 ( 32.8%)
    ##                Advanced vocational             896 ( 11.14%)   1053 ( 10.6%)    1949 ( 10.9%)
    ##      Lower tertiary education (BA)             878 ( 10.92%)   1124 ( 11.4%)    2002 ( 11.2%)
    ##   Higher tertiary education (>=MA)            1172 ( 14.57%)   1341 ( 13.5%)    2513 ( 14.0%)
    ##                              Other               6 (  0.07%)     15 (  0.2%)      21 (  0.1%)
    ##                               <NA>              60 (  0.75%)     58 (  0.6%)     118 (  0.7%)
    ##                              Total            8042 (100.00%)   9898 (100.0%)   17940 (100.0%)
    ## ---------------------------------- -------- ---------------- --------------- ----------------
