# Bank Marketing Classification

## Problem

Predict whether a customer will subscribe to a term deposit using the UCI Bank Marketing dataset. The dataset contains 41,188 records, 20 predictors, and an imbalanced binary target with approximately 11.3% positive examples.

## Experimental design

- Shared stratified 80/20 train/test split
- One-hot encoding for categorical variables
- Standardization for logistic regression and the neural network
- Five-fold cross-validation for modest hyperparameter selection
- Evaluation using accuracy, precision, recall, F1, ROC-AUC, and confusion matrices

## Results

| Model | Accuracy | Precision | Recall | F1 | ROC-AUC |
| --- | ---: | ---: | ---: | ---: | ---: |
| Decision tree | 0.8773 | 0.4752 | 0.8556 | 0.6110 | 0.9064 |
| Logistic regression | 0.8654 | 0.4517 | 0.9116 | 0.6041 | 0.9438 |
| Shallow neural network | 0.9178 | 0.6882 | 0.4946 | 0.5755 | 0.9463 |

## Interpretation

- Logistic regression produced the highest recall and is preferable when missing a likely subscriber is costly.
- The neural network achieved the highest accuracy and ROC-AUC but missed more positive cases.
- The decision tree produced the strongest F1 score and offered more interpretable nonlinear decisions.

## Limitation

The `duration` feature is known only after a call completes. Including it supports benchmark comparison but limits the model's usefulness for real pre-call targeting. A production experiment should retrain without this feature and revisit decision thresholds based on campaign costs.

Dataset: [UCI Bank Marketing](https://archive.ics.uci.edu/dataset/222/bank+marketing)
