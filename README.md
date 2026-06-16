# Simulation Study: lslx vs Cardinality-Constrained Regularized ESEM

This repository contains the simulation code and result figures for my Bachelor End Project thesis:

**Comparing LSLX and Regularized ESEM Under Different Dimensionality Conditions: A Simulation Study**

The thesis compares two methods for estimating factor loading structures in exploratory latent variable models:

1. **lslx**, a semi-confirmatory structural equation modeling approach with penalized cross-loadings.
2. **Cardinality-constrained Regularized ESEM**, a regularized exploratory SEM approach using cardinality constraints.

The purpose of the simulation study is to examine how the relative performance of these two methods changes across different dimensionality conditions, sample sizes, and factor-correlation structures.

## Repository structure

```text
simulation-study-lslx-vs-cc-esem/
├── function/
│   ├── rESEM-CC.R
│   └── generation_function.R
│
├── tuning_point_analysis/
│   ├── corr_00/
│   ├── corr_03/
│   ├── corr_06/
│   └── regression/
│
├── figures/
│   ├── broad_scans/
│   ├── turning_point/
│   └── hdlss_supplementary/
│
├── HDLSS_CCESEM_corr0_03_06.Rmd
├── README.md
└── .gitignore
```

## Folder contents

Root files
README.md

This file explains the purpose of the repository, the folder structure, and how to run the code.

.gitignore

This file tells Git which temporary or unnecessary files should not be tracked.

HDLSS_CCESEM_corr0_03_06.Rmd

This is the supplementary HDLSS analysis script. It only runs cardinality-constrained Regularized ESEM, not lslx, because the lslx simulations become too time-consuming in the high-dimensional low-sample-size settings.

This script includes supplementary analyses for:

fixed N, varying J
fixed J, varying N
fixed J/N ratio, varying J
fixed J, varying J/N ratio

It compares the behavior of CC-ESEM under the three factor-correlation conditions:

corr = 0
corr = 0.3
corr = 0.6
function/

This folder contains the helper functions used by the simulation scripts.

rESEM-CC.R

This file contains the implementation of cardinality-constrained Regularized ESEM. The main simulation scripts call this file when fitting the CC-ESEM model.

generation_function.R

This file contains the data-generation function used in the simulations. It generates data from the common factor model used in the thesis.

The generated data follow the main simulation design:

three latent factors
simple loading structure
primary loading = 0.6
cross-loadings = 0
factor correlations = 0, 0.3, or 0.6
tuning_point_analysis/

This folder contains the main simulation scripts for comparing lslx and cardinality-constrained Regularized ESEM.

The subfolders are organized by factor-correlation condition:

corr_00  factor correlation = 0
corr_03  factor correlation = 0.3
corr_06  factor correlation = 0.6

Each condition folder contains two types of scripts:

broad scan scripts
local refinement scripts

The broad scan scripts produce the 2x2 summary figures for MSE, AB, VAR, and runtime.

The local refinement scripts zoom in on the turning-point regions where the MSE advantage changes from one method to the other.

tuning_point_analysis/corr_00/

This folder contains the scripts for the orthogonal factor condition, where the population factor correlation is:

rho = 0
broad_scan_figures_corr00.Rmd

This script runs the broad J-scan and N-scan for rho = 0.

It produces the 2x2 summary panels showing:

MSE
average absolute bias
variance
runtime
full_analysis_0_CC_J15to30.Rmd

This script runs the local refinement scans for:

rho = 0
J = 15 to J = 30

It is used to inspect where the MSE difference between lslx and CC-ESEM changes sign in the lower-J range.

full_analysis_0_CC_J33to45.Rmd

This script runs the local refinement scans for:

rho = 0
J = 33 to J = 45

It covers the middle-J range of the turning-point analysis.

full_analysis_0_CC_J48to60.Rmd

This script runs the local refinement scans for:

rho = 0
J = 48 to J = 60

It covers the higher-J range of the turning-point analysis.

tuning_point_analysis/corr_03/

This folder contains the scripts for the moderately correlated factor condition, where the population factor correlation is:

rho = 0.3
broad_scan_figures_corr03.Rmd

This script runs the broad J-scan and N-scan for rho = 0.3.

It produces the 2x2 summary panels for MSE, average absolute bias, variance, and runtime.

full_analysis_0_3_J15to30.Rmd

This script runs the local refinement scans for:

rho = 0.3
J = 15 to J = 30

It is used to identify the turning intervals in the lower-J range.

full_analysis_0_3_J33to45.Rmd

This script runs the local refinement scans for:

rho = 0.3
J = 33 to J = 45

It covers the middle-J range.

full_analysis_0_3_J48to60.Rmd

This script runs the local refinement scans for:

rho = 0.3
J = 48 to J = 60

It covers the higher-J range.

tuning_point_analysis/corr_06/

This folder contains the scripts for the strongly correlated factor condition, where the population factor correlation is:

rho = 0.6
broad_scan_figures_corr06.Rmd

This script runs the broad J-scan and N-scan for rho = 0.6.

It produces the 2x2 summary panels for MSE, average absolute bias, variance, and runtime.

full_analysis_0_6_J15to30.Rmd

This script runs the local refinement scans for:

rho = 0.6
J = 15 to J = 30

It covers the lower-J range.

full_analysis_0_6_J33to45.Rmd

This script runs the local refinement scans for:

rho = 0.6
J = 33 to J = 45

It covers the middle-J range. This file also includes additional checks for selected middle-J cases, such as J = 36 and J = 39, because the rho = 0.6 condition shows a more complex turning-point pattern.

full_analysis_0_6_J48to60.Rmd

This script runs the local refinement scans for:

rho = 0.6
J = 48 to J = 60

It covers the higher-J range.

0_6_shrink_48_60_500_1000.Rmd

This is an additional narrowed-range script for the strongly correlated condition.

It focuses on:

rho = 0.6
J = 48 to J = 60
N = 500 to N = 1000

This file was used to inspect the higher-J turning pattern more closely after the broad local refinement scan.

00.txt

This is a placeholder file that was used to create or preserve the folder structure on GitHub. It is not part of the analysis.

tuning_point_analysis/regression/

This folder contains the scripts used to summarize the turning intervals with simple interval-based regression.

These scripts do not rerun the full simulations. Instead, they use the turning intervals obtained from the local refinement scans.

turning_point_regression_corr00_manual.Rmd

This script summarizes the turning intervals for:

rho = 0

It fits a regression to describe how the turning interval changes as J increases.

turning_point_regression_corr03_manual.Rmd

This script summarizes the turning intervals for:

rho = 0.3

It is used to describe the turning-point pattern under the moderately correlated condition.

turning_point_regression_corr06_two_stage_manual.Rmd

This script summarizes the turning intervals for:

rho = 0.6

The rho = 0.6 condition shows a two-stage pattern, so this script treats the pattern differently from the rho = 0 and rho = 0.3 cases.

figures/

This folder contains the result figures and supplementary documents used in the thesis.

The figures are provided so that the main results can be inspected without rerunning all simulations.

figures/broad_scans/

This folder contains the broad-scan figures.

These figures correspond to the J-scan and N-scan summary plots for:

rho = 0
rho = 0.3
rho = 0.6

Each figure is a 2x2 panel showing:

MSE
average absolute bias
variance
runtime
figures/turning_point/

This folder contains the supplementary turning-point plots.

The local refinement scan produces many plots, so some of these figures are also organized in Word documents to make them easier to inspect. These documents collect the large set of turning-point plots by factor-correlation condition and scan range.

figures/hdlss_supplementary/

This folder contains the supplementary HDLSS figures for CC-ESEM only.

These figures correspond to the supplementary analyses in:

HDLSS_CCESEM_corr0_03_06.Rmd

They show the behavior of CC-ESEM under high-dimensional low-sample-size settings across different factor-correlation conditions.

## How to download the code

There are two common ways to download this repository.

### Option 1: Download ZIP

1. Open the GitHub repository page.
2. Click the green **Code** button.
3. Click **Download ZIP**.
4. Unzip the downloaded folder on your computer.
5. Open the project folder in RStudio.

### Option 2: Clone with Git

If Git is installed, run:

```bash
git clone https://github.com/YuhanShao/simulation-study-lslx-vs-cc-esem.git
```

Then open the downloaded folder in RStudio.

## Required R packages

The main scripts use the following R packages:

```r
library(MASS)
library(lavaan)
library(lslx)
```

If these packages are not installed, install them first:

```r
install.packages(c("MASS", "lavaan", "lslx"))
```

The cardinality-constrained Regularized ESEM function is provided in the `function/` folder and is not installed from CRAN.

## How to run the code

Before running any simulation script, make sure that the helper files are sourced correctly.

In the R Markdown files, check the setup chunk and update the source paths if needed:

```r
source("function/rESEM-CC.R")
source("function/generation_function.R")
```

If you run the scripts from the repository root folder, the relative paths above should work. If you run a script from another working directory, update the paths accordingly.

A recommended running order is:

```text
1. Run the scripts in tuning_point_analysis/corr_00/
2. Run the scripts in tuning_point_analysis/corr_03/
3. Run the scripts in tuning_point_analysis/corr_06/
4. Run the scripts in tuning_point_analysis/regression/
5. Run HDLSS_CCESEM_corr0_03_06.Rmd for the supplementary HDLSS analysis
```

The local refinement scripts can be run independently, but the regression scripts depend on the turning intervals obtained from the local refinement analyses.

Some simulations may take a long time to run, especially lslx for larger values of `J`.

## Simulation design

The simulations are based on a simple-structure common factor model with three latent factors.

The main data-generating settings are:

```text
Number of factors:       3
Primary loading:         0.6
Cross-loadings:          0
Reliability:             0.36
Factor correlations:     0, 0.3, 0.6
Replications:            50 per condition
```

The observed variables are divided equally over the three factors. In the population model, each variable has one primary loading of `0.6`, while all cross-loadings are set to zero.

The factor-correlation condition is varied to examine whether the relative performance of the methods changes when the latent factors become more correlated.

## Methods compared

### lslx

The lslx model is specified as a semi-confirmatory model. Primary loading positions are freely estimated, while cross-loadings are penalized.

The LASSO penalty is selected by BIC from the following tuning grid:

```r
lambda_grid <- seq(0.00, 0.10, 0.05)
```

Before calculating the performance measures, the estimated loading matrix is aligned with the true loading matrix by matching factor order and factor signs.

### Cardinality-constrained Regularized ESEM

The Regularized ESEM model is estimated with a cardinality constraint. In the simulations, the number of non-zero loadings per factor is set to the true number of primary loadings:

```r
CARD <- rep(J / 3, 3)
```

The implementation uses multiple random starts:

```r
nstarts <- 20
MaxIter <- 1000
eps <- 1e-6
```

The method is evaluated across the three factor-correlation conditions.

## Performance measures

The two methods are compared using the following measures:

```text
MSE      Mean squared error of the loading estimates
AB       Average absolute bias of the loading estimates
VAR      Average variance of the loading estimates
Runtime  Average computation time
```

The main comparison uses the MSE difference:

```r
mse_diff <- esem_mse - lslx_mse
```

A negative value means that cardinality-constrained Regularized ESEM has a lower MSE than lslx. A positive value means that lslx has a lower MSE.

## Main analyses

### Broad scans

The broad scans examine the overall performance patterns across wider ranges of `J` and `N`.

Two types of scans are used:

```text
J-scan: fixed N, varying J
N-scan: fixed J, varying N
```

The corresponding figures are stored in:

```text
figures/broad_scans/
```

### Local refinement scans

The local refinement scans focus on the regions where the MSE difference between the two methods changes sign.

These scripts are stored by factor-correlation condition:

```text
tuning_point_analysis/corr_00/
tuning_point_analysis/corr_03/
tuning_point_analysis/corr_06/
```

The corresponding figures are stored in:

```text
figures/turning_point/
```

### Turning-point regression

The turning intervals are summarized using interval-based regression. These scripts are stored in:

```text
tuning_point_analysis/regression/
```

### Supplementary HDLSS analysis

The supplementary HDLSS analysis focuses on cardinality-constrained Regularized ESEM only.

It includes:

```text
fixed N, varying J
fixed J, varying N
fixed J/N ratio, varying J
fixed J, varying J/N ratio
```

The supplementary figures are stored in:

```text
figures/hdlss_supplementary/
```

## Reproducing the figures

The result figures are already included in the `figures/` folder.

To reproduce them from code:

1. Run the corresponding R Markdown script.
2. Check that the helper files in `function/` are correctly sourced.
3. Re-run the plotting chunks in the script.

Because the simulations involve numerical optimization and multi-start estimation, exact runtime and small numerical differences may vary across computers, R versions, and package versions.

## Reproducibility notes

The simulation scripts use a fixed random seed where applicable:

```r
set.seed(42)
```

The repository is intended to document the simulation workflow used in the thesis, including data generation, model fitting, performance calculation, turning-point analysis, supplementary HDLSS analysis, and figure generation.

## Author

Yuhan Shao
Bachelor Data Science
Eindhoven University of Technology / Tilburg University
