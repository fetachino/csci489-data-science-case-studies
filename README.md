# CSCI 48900 Data Science Case Studies

[![R](https://img.shields.io/badge/R-data_analysis-276DC3?logo=r&logoColor=white)](https://www.r-project.org/)
[![Machine Learning](https://img.shields.io/badge/Machine_Learning-classification-F7931E)](case-studies/bank-marketing-classification.md)
[![Reproducible](https://img.shields.io/badge/Analysis-reproducible-2A9D8F)](#reproducibility-and-data-policy)

Selected R and machine-learning work demonstrating exploratory analysis, data cleaning, reproducible sampling, visualization, and model evaluation.

## Portfolio value

These case studies emphasize decision-making, not just model fitting: selecting appropriate metrics for imbalanced data, documenting leakage risks, cleaning real tabular schemas, and making analyses repeatable without redistributing restricted datasets.

## Projects

### Bank marketing classification

Compared logistic regression, a shallow neural network, and a decision tree on the UCI Bank Marketing dataset. The analysis emphasizes class imbalance and the tradeoff between recall, precision, interpretability, and overall discrimination.

Read the [case study](case-studies/bank-marketing-classification.md).

### Salary data cleaning and analysis

[`R/salary-data-cleaning.R`](R/salary-data-cleaning.R) cleans occupational salary data, handles invalid markers, aligns schemas, creates reproducible samples, analyzes Indiana salaries, and compares computer-related occupations across Indiana, California, and New York.

### Iris exploratory analysis

[`R/iris-exploration.R`](R/iris-exploration.R) calculates descriptive statistics, checks missing data, analyzes correlations, and creates scatter and box plots for the classic Iris dataset.

## Reproducibility and data policy

Scripts use relative paths and fixed random seeds where sampling is involved. Course-provided and third-party datasets are not redistributed; the UCI datasets can be obtained from their original sources.

## Run the R analyses

Install R and the packages required by the salary analysis:

```r
install.packages(c("readxl", "dplyr", "stringr", "writexl", "ggplot2"))
```

Place the referenced datasets beside the appropriate script, then run:

```console
Rscript R/iris-exploration.R
Rscript R/salary-data-cleaning.R
```

Verification consists of reviewing the console statistics and generated plots/workbooks. The Bank Marketing case study records its held-out metrics and experimental assumptions directly in Markdown.

## Course

CSCI 48900 — Data Science.

## About the author

Built by **Ahmed Balde** as part of a portfolio in data science, Python/R analytics, backend systems, and quality engineering. See more work on [GitHub](https://github.com/fetachino).
