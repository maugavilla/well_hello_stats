Creating and Exporting Tables in APA Format (7th Edition)
================
R Helpdesk (Denise J. Roth) FSW VU Amsterdam
5/22/23

- <a href="#introduction" id="toc-introduction">Introduction</a>
- <a href="#set-up-the-r-session" id="toc-set-up-the-r-session">Set Up the
  R session</a>
- <a href="#import-the-dataset" id="toc-import-the-dataset">Import the
  dataset</a>
  - <a href="#prepare-the-dataset" id="toc-prepare-the-dataset">Prepare the
    dataset</a>
- <a href="#example-simple-linear-regression"
  id="toc-example-simple-linear-regression">Example: Simple Linear
  Regression</a>
  - <a href="#creating-a-nice_table" id="toc-creating-a-nice_table">Creating
    a <code>nice_table</code></a>
  - <a href="#exporting-the-table-to-word"
    id="toc-exporting-the-table-to-word">Exporting the Table to Word</a>
- <a href="#integration-with-rempsyc-functions"
  id="toc-integration-with-rempsyc-functions">Integration with
  <code>rempsyc</code> functions</a>
  - <a href="#linear-regression-with-nice_lm"
    id="toc-linear-regression-with-nice_lm">Linear Regression with
    <code>nice_lm</code></a>
  - <a href="#t-test-with-nice_t_test"
    id="toc-t-test-with-nice_t_test">T-test with
    <code>nice_t_test</code></a>
- <a href="#correlation-tables-with-apatables"
  id="toc-correlation-tables-with-apatables">Correlation Tables with
  <code>apaTables</code></a>
  - <a href="#import-the-dataset-1" id="toc-import-the-dataset-1">Import the
    dataset</a>
  - <a href="#prepare-the-data" id="toc-prepare-the-data">Prepare the
    data</a>
  - <a href="#creating-correlation-table"
    id="toc-creating-correlation-table">Creating Correlation Table</a>
- <a href="#anova-tables-with-apatables"
  id="toc-anova-tables-with-apatables">ANOVA tables with
  <code>apaTables</code></a>
  - <a href="#creating-an-example-dataset"
    id="toc-creating-an-example-dataset">Creating an example dataset</a>
  - <a href="#run-model-and-create-exportable-anova-table"
    id="toc-run-model-and-create-exportable-anova-table">Run model and
    create exportable ANOVA table</a>
  - <a href="#further-options" id="toc-further-options">Further options</a>

# Introduction

As soon as we have cleaned our data and conducted our analyses to test
our hypotheses, and investigate our research questions, we want to
present our findings in an appealing and readable way. There are various
options for doing this, but one important means of visualizing data is
the use of tables. In the social sciences, many journals make use of the
formatting and citation guidelines provided by the *American
Psychological Association (APA)*, whose current edition is its 7th
revision. While there are many existing options for creating tables in
APA format, several packages often only allow you to format tables using
a specific type of analysis or lack the ability of easily converting
them to Word. This is why in this tutorial, functions of the package
`rempsyc` are introduced. As opposed to packages with similar functions,
this one allows for a great degree of flexibility. In addition, this
tutorial also includes alternatives and provides a brief introduction in
how to use an alternative package (`apaTables`) for correlation and
ANOVA tables.

# Set Up the R session

When we start working in R, we always need to setup our session. For
this we need to set our working directory. In this case I am doing that
for the folder that holds the downloaded dataset from
[Kaggle](https://www.kaggle.com/datasets/gianinamariapetrascu/survey-on-students-perceptions-of-ai-in-education/).
Kaggle is an online data scientists’ community that provides a wide
range of different datasets that are freely available to users to
practice their computational skills. In this specific example, we will
be using a dataset which contains the results of a survey conducted on
undergraduate students enrolled in the 2nd and 3rd year of study at the
Faculty of Cybernetics, Statistics and Economic Informatics at the
Bucharest University of Economic Studies.

``` r
setwd("YOURWORKINGDIRECTORY")
```

The next step for setting up our session will be to load the packages
that we will be using. We will use some packages for data management
(`dplyr`, `tidyr`) and then need to load `rempsyc` in addition to that.
Will use `flextable` to export the tables. We also need `rio` for
importing different data sets. For some of the tables, we will also be
using `apaTables` Note that you potentially need to install some of
these packages, however.

``` r
library(dplyr)
library(tidyr)
library(rempsyc)
library(flextable)
library(rio)
library(apaTables)
```

# Import the dataset

Furthermore, we are importing our data in `.csv` format.

``` r
mydata <- import("Survey_AI.csv")
head(mydata)
```

      ID Q1.AI_knowledge                                             Q2.AI_sources
    1  1               8 Internet;Books/Scientific papers (physical/online format)
    2  2               7                                     Internet;Social media
    3  3               5 Internet;Books/Scientific papers (physical/online format)
    4  4               5                                     Internet;Social media
    5  5               4                                                  Internet
    6  6               5                  Internet;Discussions with family/friends
      Q2#1.Internet Q2#2.Books/Papers Q2#3.Social_media Q2#4.Discussions
    1             1                 1                 0                0
    2             1                 0                 1                0
    3             1                 1                 0                0
    4             1                 0                 1                0
    5             1                 0                 0                0
    6             1                 0                 0                1
      Q2#5.NotInformed Q3#1.AI_dehumanization Q3#2.Job_replacement
    1                0                      1                    2
    2                0                      2                    3
    3                0                      2                    1
    4                0                      4                    4
    5                0                      1                    2
    6                0                      3                    4
      Q3#3.Problem_solving Q3#4.AI_rulling_society Q4#1.AI_costly
    1                    5                       1              4
    2                    4                       1              3
    3                    4                       1              3
    4                    5                       3              4
    5                    5                       1              3
    6                    4                       3              4
      Q4#2.Economic_crisis Q4#3.Economic_growth Q4#4.Job_loss Q5.Feelings
    1                    2                    4             2           1
    2                    3                    4             3           1
    3                    1                    3             2           1
    4                    3                    3             4           1
    5                    1                    4             2           1
    6                    3                    3             4           2
                                        Q6.Domains Q6#1.Education Q6#2.Medicine
    1                 Education;Medicine;Marketing              1             1
    2           Medicine;Agriculture;Constructions              0             1
    3    Education;Marketing;Public Administration              1             0
    4                           Education;Medicine              1             1
    5 Education;Medicine;Agriculture;Constructions              1             1
    6  Education;Agriculture;Public Administration              1             0
      Q6#3.Agriculture Q6#4.Constructions Q6#5.Marketing Q6#6.Administration
    1                0                  0              1                   0
    2                1                  1              0                   0
    3                0                  0              1                   1
    4                0                  0              0                   0
    5                1                  1              0                   0
    6                1                  0              0                   1
      Q6#7.Art Q7.Utility_grade Q8.Advantage_teaching Q9.Advantage_learning
    1        0                9                     3                     1
    2        0                6                     2                     2
    3        0                6                     3                     3
    4        0                9                     1                     2
    5        0                8                     3                     2
    6        0                6                     1                     2
      Q10.Advantage_evaluation Q11.Disadvantage_educational_process Q12.Gender
    1                        2                                    3          1
    2                        1                                    2          2
    3                        3                                    4          2
    4                        2                                    3          1
    5                        3                                    4          1
    6                        3                                    1          1
      Q13.Year_of_study Q14.Major Q15.Passed_exams Q16.GPA
    1                 2         2                1     9.2
    2                 2         2                1     7.7
    3                 2         2                0     7.2
    4                 2         2                1     8.2
    5                 2         2                1     7.7
    6                 2         2                1     7.7

If you wish to import it from the github site, you can use the raw data
link as follows

``` r
mydata <- import("https://raw.githubusercontent.com/maugavilla/well_hello_stats/main/tutorials/Survey_AI.csv")
head(mydata)
```

## Prepare the dataset

Let us first select only the variables that we will be using for our
analysis and give them a more intuitive variable name. We want to see
whether there is a relationship between students’ knowledge of AI and
their perceptions of its usefulness in education.

``` r
mydata <- select(mydata, Knowledge = Q1.AI_knowledge, AI_Utility = Q7.Utility_grade, Sex = Q12.Gender)
head(mydata)
```

      Knowledge AI_Utility Sex
    1         8          9   1
    2         7          6   2
    3         5          6   2
    4         5          9   1
    5         4          8   1
    6         5          6   1

In a next step, we should create a factor variable that contains
information on the respondents’ sex as a control variable and give it a
meaningful scale.

``` r
mydata <- mutate(mydata, Female = as.factor(ifelse(Sex == "1", 1, 0)))
head(mydata)
```

      Knowledge AI_Utility Sex Female
    1         8          9   1      1
    2         7          6   2      0
    3         5          6   2      0
    4         5          9   1      1
    5         4          8   1      1
    6         5          6   1      1

# Example: Simple Linear Regression

Let us run a simple linear regression model where we use *AI Knowledge*
as our main independent variable and *AI Utility* as our dependent
variable while controlling for sex.

``` r
model <- lm(AI_Utility ~ Knowledge + Female, mydata)
summary(model)
```


    Call:
    lm(formula = AI_Utility ~ Knowledge + Female, data = mydata)

    Residuals:
        Min      1Q  Median      3Q     Max 
    -4.9917 -1.4116  0.3768  1.2028  4.3562 

    Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
    (Intercept)   4.8245     0.7410   6.510 4.47e-09 ***
    Knowledge     0.3959     0.1086   3.644 0.000453 ***
    Female1       0.4234     0.4457   0.950 0.344793    
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Residual standard error: 2.03 on 88 degrees of freedom
    Multiple R-squared:  0.1376,    Adjusted R-squared:  0.118 
    F-statistic: 7.021 on 2 and 88 DF,  p-value: 0.001482

Now we gather the summary statistics that we would like to include in
our table.

``` r
# Gather summary statistics
statistics.table <- as.data.frame(summary(model)$coefficients)

# Get the confidence interval (CI) of the regression coefficient
CI <- confint(model, level=0.95)

# Add a row to join the variables names and CI to the stats
statistics.table <- cbind(row.names(statistics.table), statistics.table, CI)
# Rename the columns appropriately
names(statistics.table) <- c("Term", "B", "SE", "t", "p", "CI_lower", "CI_upper")
```

## Creating a `nice_table`

With the summary statistics gathered, we can now easily create an
attractive table using `nice_table`.

``` r
nice_table(statistics.table)
```

![](4_3_creating_and_exporting_tables_files/figure-commonmark/unnamed-chunk-9-1.png)

## Exporting the Table to Word

In this next step, we can easily export the table we just created to
`.docx`. This is especially handy considering that formats such as
`.jpeg` or `.png` would not appear in the often strict word counts that
we work with.

``` r
my_table <- nice_table(statistics.table)
save_as_docx(my_table, path = "nice_table_example.docx")
```

# Integration with `rempsyc` functions

The `nice_table` functions also integrates smoothly with other
statistical functions from the `rempsyc` package such as `nice_lm` or
`nice_t_test`, among others. These functions already provide useful
default effect sizes and thus make for an attractive summary table.

## Linear Regression with `nice_lm`

The `nice_lm()` function creates the table of standard results from a
linear model

``` r
nice_lm(model)
```

      Dependent Variable Predictor df         b         t            p         sr2
    1         AI_Utility Knowledge 88 0.3958930 3.6444117 0.0004527553 0.130158422
    2         AI_Utility   Female1 88 0.4233699 0.9498447 0.3447925511 0.008841432
         CI_lower   CI_upper
    1 0.001675767 0.25864108
    2 0.000000000 0.04458759

Then we can wrap this table with the `nice_table()` function, to clean
it up for reporting

``` r
nice_table(nice_lm(model))
```

![](4_3_creating_and_exporting_tables_files/figure-commonmark/unnamed-chunk-12-1.png)

## T-test with `nice_t_test`

Similar, we have a quick function for $t-test$ with `nice_t_test`. Here
you need to specify the response and group variable for the analysis,
the function will do the analysis and create the table according to the
neccesary format for creating the table

``` r
t_table <- nice_t_test(data = mydata,
                       response = "AI_Utility",
                       group = "Sex",
                       warning = FALSE)
t_table
```

      Dependent Variable         t       df         p         d   CI_lower
    1         AI_Utility 0.7521476 50.37715 0.4554623 0.1795454 -0.2520583
       CI_upper
    1 0.6101455

Then we can pass those results to the `nice_table` function

``` r
nice_table(t_table)
```

![](4_3_creating_and_exporting_tables_files/figure-commonmark/unnamed-chunk-14-1.png)

The `nice_t_test` functions additionally offers making several t-tests
at once by specifying the desired dependent variables.

``` r
nice_table(nice_t_test(
  data = mydata,
  response = c("Knowledge", "AI_Utility"),
  group = "Sex",
  warning = FALSE) )
```

These are only some of the options offered with `nice_table` and
`rempsyc`. For further information, check out [Rémi Thériault’s
vignette](https://rempsyc.remi-theriault.com/articles/table).

# Correlation Tables with `apaTables`

For this example, we will be using a data set provided by the [General
Social Survey](https://gss.norc.org/get-the-data/stata/). We want to
find out whether different dimensions of institutional trust correlate
with each other.

## Import the dataset

In this example, our data is a `.dta`, `STATA` data file. However, the
`import()` can handle this file format just as well.

``` r
d <- import("GSS2021.dta")
dim(d)
```

    [1] 4032  735

## Prepare the data

Before running a quick correlation analysis, we select the variables of
interest and give them more intuitive variable names. Furthermore, we
remove all the missing observations from the dataframe.

``` r
d <- select(d, matches("CON"))

d <- select(d, confed, conjudge, consci, conlegis, conarmy)

d <- rename(d,
            federal = confed,
            court = conjudge,
            science = consci,
            congress = conlegis,
            military = conarmy)

d <- drop_na(d)
```

## Creating Correlation Table

Finally, we use the `apa.cor.table()` function to create a correlation
table that we can immediately export as a `.docx` file. This table will
report the mean, standard deviation from each variable, and all possible
Pearson correlations

``` r
apa.cor.table(d, filename="Table1_APA.docx", table.number=1)
```

# ANOVA tables with `apaTables`

## Creating an example dataset

For this example, we quickly create a data frame in R. This step would
of course be replaced with you reading in your own data that you would
like to read into R. In this artificial data set, we test whether the
weather used in an advertisement affects participants’ attitudes towards
the brand.

``` r
set.seed(123)
ad_data <- tibble(
  participant = rep(1:20, each = 6),
  weather = as.factor(rep(c("Sunny", "Cloudy", "Rainy"), each = 2, times = 20)),
  attitude_toward_brand = rnorm(120, mean = c(5, 4, 4, 3, 3, 2), sd = 1))
head(ad_data)
```

    # A tibble: 6 × 3
      participant weather attitude_toward_brand
            <int> <fct>                   <dbl>
    1           1 Sunny                    4.44
    2           1 Sunny                    3.77
    3           1 Cloudy                   5.56
    4           1 Cloudy                   3.07
    5           1 Rainy                    3.13
    6           1 Rainy                    3.72

## Run model and create exportable ANOVA table

We first need to run the analysis with the base function `aov`

``` r
ad_model1 <- aov(attitude_toward_brand ~ weather, data = ad_data)
summary(ad_model1)
```

                 Df Sum Sq Mean Sq F value Pr(>F)    
    weather       2  113.3   56.66   55.06 <2e-16 ***
    Residuals   117  120.4    1.03                   
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Then the `apa.aov.table` can be use to export the table in a
\`\`docx\`\`\` file

``` r
apa.aov.table(ad_model1, filename = "Table2_APA.doc", table.number = 2)
```

Note that these automatice functions make a lot of decisions for the
user, so if you wish to report different information, would need to
build the tables on your own

## Further options

Note that you can also use the `apaTables` for other models, such as
linear regression models. As is typical with R, there is not one single
way of using a package or function and different options offer different
strengths and weaknesses.
