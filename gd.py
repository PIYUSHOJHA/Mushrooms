import pandas as pd
import numpy as np
from matplotlib import pyplot as plt
from sklearn import preprocessing
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score
from sklearn.linear_model import LogisticRegression
from sklearn.cross_validation import train_test_split
data = pd.read_csv("H:\mushrooms.csv")
labelEncoder = preprocessing.LabelEncoder()
for col in data.columns:
    data[col] = labelEncoder.fit_transform(data[col])

# Splitting test train set, with 20% of the data as the validation set
train, test = train_test_split(data, test_size = 0.2)
print(test)