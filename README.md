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

### `function/`

This folder contains the helper functions required by the simulation scripts.

* `rESEM-CC.R` contains the implementation of cardinality-constrained Regularized ESEM.
* `generation_function.R` contains the data-generation function used to simulate the common factor model.

These files need to be sourced before running the simulation scripts.

### `tuning_point_analysis/`

This folder contains the main simulation scripts for the comparison between lslx and cardinality-constrained Regularized ESEM.

The subfolders are organized by factor-correlation condition:

```text
corr_00  factor correlation = 0
corr_03  factor correlation = 0.3
corr_06  factor correlation = 0.6
```

Each of these folders contains local refinement scan scripts for different ranges of `J`.

The `regression/` folder contains the interval-regression scripts used to summarize the turning-point patterns.

### `figures/`

This folder contains the result figures used in the thesis.

```text
broad_scans/          Broad J-scan and N-scan summary figures
turning_point/        Local refinement and turning-point figures
hdlss_supplementary/  Supplementary HDLSS figures for CC-ESEM
```

The figures are included for reference, so the main visual results can be inspected without rerunning all simulations.

### `HDLSS_CCESEM_corr0_03_06.Rmd`

This file contains the supplementary HDLSS analysis for cardinality-constrained Regularized ESEM only.

It examines CC-ESEM under high-dimensional low-sample-size settings across factor-correlation conditions `0`, `0.3`, and `0.6`.

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
4. Save or export the figures from RStudio if needed.

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
