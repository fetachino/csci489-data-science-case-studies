# CSCI 48900 Data Science Case Studies

Selected R and machine-learning work demonstrating exploratory analysis, data cleaning, reproducible sampling, visualization, and model evaluation.

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

## Course

CSCI 48900 — Data Science.

## Author

Ahmed Balde
