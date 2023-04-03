Well Hello Stats
================
Mauricio Garnier-Villarreal
03 April, 2023

- <a href="#welcome" id="toc-welcome">Welcome</a>
- <a href="#what-is-r-and-why-should-you-learn-it"
  id="toc-what-is-r-and-why-should-you-learn-it">What is R and why should
  you learn it?</a>
- <a href="#prerequisites" id="toc-prerequisites">Prerequisites</a>
- <a href="#how-to-use-this-resource"
  id="toc-how-to-use-this-resource">How to use this resource</a>
- <a href="#the-tutorials" id="toc-the-tutorials">The tutorials</a>
  - <a href="#set-up" id="toc-set-up">Set up</a>
  - <a href="#basics" id="toc-basics">Basics</a>
  - <a href="#initial-work-with-data"
    id="toc-initial-work-with-data">Initial work with data</a>
  - <a href="#relations-betwen-variables"
    id="toc-relations-betwen-variables">Relations betwen variables</a>
  - <a href="#scale-evaluation" id="toc-scale-evaluation">Scale
    evaluation</a>
  - <a href="#general-linear-models" id="toc-general-linear-models">General
    Linear Models</a>
  - <a href="#mixture-models" id="toc-mixture-models">Mixture models</a>
  - <a href="#factor-analysis" id="toc-factor-analysis">Factor Analysis</a>
- <a href="#progress" id="toc-progress">Progress</a>

<div style="padding: 0.2em;">

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/R_logo.svg/1200px-R_logo.svg.png" width="130" align="right"/>

</div>

# Welcome

Welcome to **Well Hello Stats**. This is page to learn *R for Social
Scientists*, is a series of tutorials that will teach you how to use R
for research in the social sciences. Throughout the tutorials, you will
learn how to install and set up R and RStudio, get your data into R,
manage your data, and implement some of the most commonly used methods
in quantitative social science research using R and RStudio.

There are many great resources out there to learn R. This series of
tutorials is set up to teach you the necessary skills in a consistent
approach.

# What is R and why should you learn it?

R is an open-source statistical software language, that is currently
among the most popular languages for research in the social sciences. In
comparison to other popular software packages in social scientific
research, such as SPSS and Stata, R has several notable advantages:

- R is a programming language, which makes it much more versatile. While
  R focuses on statistical analysis at heart, it facilitates a
  wide-range of features, and virtually any tool for data analysis can
  be implemented.
- The range of things you can do with R is constantly being updated. R
  is open-source, meaning that anyone can contribute to its development.
  In particular, people can develop new *packages*, that can easily and
  safely be installed from within R with a single command. Since many
  scholars and industry professionals use R, it is likely that any
  cutting-edge and bleeding-edge techniques that you are interested in
  are already available. You can think of it as an app-store for all
  your data-analysis needs!
- R is free. While for students this is not yet a big deal due to free
  or cheap student and university licences, this can be a big plus in
  the commercial sector. Especially for small businesses and
  free-lancers. Allowing to democratize the access to cutting data
  analysis methods, for people in situations that otherwise would not be
  able to have access to a proprietary program.
- The use of syntax base software improves our ability to
  reproduce/replicate our results, track down mistakes and fix them, and
  we can save and reuse syntax for future projects.

RStudio is the most commonly used editor for working with R. RStudio
makes it easy to write and save code (the instructions for the tasks you
want R to execute), to view and plot your data, and to manage your
workspace (e.g., the code, data files, and output you are working with).

# Prerequisites

Our goal is to make this series of tutorials self-sufficient. This means
that there are not prerequisites in terms of knowledge of working with R
and RStudio. We will start from the very beginning, with how to install
R and RStudio on your Computer, how to set up RStudio for an easy
workflow, and the very basics of working with data. If you are familiar
with other programming languages or a statistical analysis software
(like Stata or SPSS), you will be able to learn R even faster.

Importantly, these tutorials are not a substitute for education in
quantitative research methods. They do teach you how to implement
different methods in R, but they do not cover questions about research
design, what the best method might be for the question you are asking,
how these methods work and what their assumptions are. Thus, you are
responsible for making sure that your analyses are sound.

# How to use this resource

If you have not worked with R before, it is best to follow the series of
tutorials from the beginning. Before we cover specific methods in the
social sciences, we start with the installation of R and RStudio,
clarify the most important basics for working with R, and teach you how
to import data into R.

If you are generally familiar with R, you can skip tutorials on the R
basics. If you want to follow tutorials on several methods, we recommend
that you have a brief look at tutorial on downloading the data from the
[World Value Survey (WVS)](https://www.worldvaluessurvey.org/). The WVS
will be used throughout most of the following tutorials. It is therefore
a good idea to download the data set before continuing with the
tutorials. If you are familiar with importing data as well you can jump
right to the tutorial on methods.

If you are generally familiar with R, already have your own data set,
and just want to know how to implement a specific method in R, you can
simply jump to tutorial that covers the methods you are interested in.

In these tutorials we start and focus on **base R** data manipulation
and work, instead of the **tidyverse** approach. This is because we
consider that useRs should first be comfortable with the base R
commands, and if desired can transition to use of the tidyverse as an
extension of R instead of the default use.

The tutorials `.Rmd` and `.md` files are found in the *tutorials*
folder. And the following section links to the respective `.md` files in
an structure format, so that you can navigate the tutorials from this
page.

# The tutorials

Here you will find links for the respective tutorials, and a short
description. They have been structure by increased complexity, kind of
following a course.

## Set up

- [Install R and RStudio for
  Mac](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/0_1_Installing_mac.md):
  how to step by step install R and RStudio on Mac operating system
- [Install R and RStudio for
  Windows](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/0_2_Installing_windows.md):
  how to step by step install R and RStudio on Windows operating system
- [Setting up
  RStudio](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/0_3_setting_up_RStudio.md):
  explanation of RStudio and how to set it up.

## Basics

- [R
  Basics](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/1_1_R_basics.md):
  basic use of R, data types, data structures, importing data,
  functions, install and load packages, working directory and saving
  your work.
- [Download the WVS data
  set](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/2_1_download_WVS.md):
  where to request access to the World Value Survey (WVS) data set, used
  in a lot of the tutorials.
- [Import data sets
  (long)](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/3_1_Import_data_sets_long.md):
  introduction to data formats, Base R, use of packages foreign, haven
  and rio, general recommendations. Packages: rio, haven, foreign.
- [Import data sets
  (short)](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/3_2_Import_data_sets_short.md):
  introduction to data formats, use of package rio, general
  recommendations.

## Initial work with data

- [Data management
  1](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/4_1_Data_management_1.md):
  setting up R session, import data set, recode items, create composite
  scores, variable calculations, selecting subsets. Packages: rio, car,
  psych.
- [Data management
  2](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/4_2_Data_management_2.md):
  setting up R session, import data set, variable types, use the factor
  function.
- [Descriptive
  Statistics](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/5_1_descriptive_statistics.md):
  setting up R session, import data set, continuous items, categorical
  items, data frame summary. Packages: rio, summarytools.
- [Basic
  plots](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/5_2_basic_plots.md):
  setting up R session, import data set, ggplot2 basics, histogram,
  scatter plot, bar plot, box plot. Packages: rio, ggplot2.

## Relations betwen variables

- [Correlation](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/6_1_correlation.md):
  setting up R session, import data set, scatter plot, Pearson
  correlation, Spearman correlation, Kendal-tau correlation, extracting
  the matrices, correlogram, pairs plot. Packages: rio, psych, corrplot,
  ggplot2, GGally.

## Scale evaluation

- [Reliability](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/7_1_reliability.md):
  what is reliability analysis?, preparation, reliability analysis
  (Cronbach’s alpha, McDonald’s omega). Packages: rio, psych, car.

## General Linear Models

- [t-test](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/8_1_ttest.md):
  setting up R session, import data set, difference in means, one sample
  t-test, two sample t-test, paired sample t-test, effect sizes,
  graphing your results. Packages: rio, effectsize, ggpubr.
- [Linear
  regression](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/9_1_linear_regression.md):
  setting up R session, import data set, simple linear regression,
  linear regression with a binary predictor, multiple linear regression,
  standardize solution, assumptions, effect size, plots, interpretation.
  Packages: rio, psych, effectsize, visreg, rockchalk, ggplot2.
- [Moderation with
  `lm`](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/10_1_moderation_lm.md):
  what is moderation, setting up R session, import data set, moderation
  analysis steps, categorical and continuous moderator, main effects,
  interaction models, effect size, probbing, plotting, interpretation.
  Packages: rio, effectsize, visreg, reghelper.  
- [Moderation with the PROCESS
  macro](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/10_2_moderation_PROCESS.md):
  what is moderation, installing PROCESS macro, setting up R session,
  import data set, moderation analysis steps, categorical and continuous
  moderator, main effects, interaction models, effect size, probbing,
  plotting, interpretation. Packages: rio, PROCESS macro
- [Mediation with path
  analysis](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/11_1_mediation_path.md):
  what is mediation, setting up R session, import data set, mediation
  analysis steps, total effect, indirect effect, NHST methods,
  recommendations and interpretation. Packages: rio, lavaan, semTools.
- [Mediation with the PROCESS
  macro](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/11_2_mediation_PROCESS.md):
  what is mediation, installing PROCESS macro, setting up R session,
  import data set, mediation analysis steps, total effect, indirect
  effect, NHST methods, recommendations and interpretation. Packages:
  rio, PROCESS macro

## Mixture models

- [LCA with depmixS4 (categorical
  indicators)](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/12_LCA_depmixS4_cat.md):
  latent class analysis. depmixS4 basics, dichotomous indicator example,
  class enumeration, and interpretation. Packages: rio, depmixS4,
  sjlabelled, summarytools, ggplot2.
- [LCA with tidySEM (categorical
  indicators)](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/12_LCA_tidySEM_cat.md):
  latent class analysis. tidySEM basics, dichotomous indicator example,
  class enumeration, and interpretation. Packages: rio, tidySEM,
  sjlabelled, summarytools, ggplot2, tidyr.
- [HMM with depmixS4 (categorical
  indicators)](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/12_HMM_depmixS4_cat.md):
  hidden markov models, depmixS4 basics, dichotomous indicator example,
  time invariant and time variant HMM, class enumeration, plots.
  Packages: rio, depmixS4, sjlabelled, summarytools, ggplot2, ggseqplot,
  tidyr, TraMineR.

## Factor Analysis

- [Confirmatory Factor Analysis with continuous
  indicators](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/13_CFA_cont.md):
  test theory, measurement model, data preparation, CFA, lavaan,
  estimation, model evaluation, reliability, presenting results.
  Packages: psych, lavaan, semTools, car, tidyr, ggplot2.
- [Exploratory Factor Analysis with continuous
  indicators](https://github.com/maugavilla/well_hello_stats/blob/main/tutorials/13_EFA_cont.md):
  test theory, measurement model, data preparation, EFA, estimation,
  rotation, factor enumeration, cross-validation. Packages: psych,
  lavaan, semTools, car, tidyr, ggplot2, patchwork.

# Progress

As must things in life, these tutorials as a work in progress. So we
will continue updating and adding new tutorials.

These tutorials started as a request from the Sociology department, as
they are transitioning out of proprietary software. But we expect this
to go beyond the departmental needs.

You are welcome to suggest new tutorials, and/or collaborate one.
