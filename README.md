# Categorical Data Analysis (The feeling of happiness) using R and STATA.
## Introduction 
This project aims to study the happiness of people in Japan by analyzing various aspects of their lives using categorical data analysis. The project focuses on understanding the impact of factors such as security, religion, health, economy, corruption, and demographics on individuals' happiness levels. By uncovering these relationships, we seek to not only shed light on the factors influencing happiness but also inform decision-making and develop strategies to foster happier lives.

## Objective
The main objective of this project is to analyze the categorical data obtained from the World Values Survey (WVS - Wave 7) to identify the factors affecting the level of happiness of people in Japan. Moving forward, we aim to build predictive models using binary logistic regression and multinomial regression to determine to which extent these factors affect happiness. Inform decision-making and develop strategies to foster happier lives in Japan.

## Methodology 
In this project, a dataset consisting of 1353 individuals living in Japan was drawn from the World Values Survey. The dataset includes six categorical variables (qualitative ordinal), one categorical response variable (happiness), and five explanatory variables representing different aspects of people's lives.
To explore the relationships between the variables, two-way contingency tables will be constructed, and the Goodman and Kruskal gamma measure of association will be employed to quantify and assess the strength and directionality of the relationships.Applied statistical tests to determine the significance of the associations.
We fitted a binary logistic regression model to explore the binary outcome of 'Happy' and 'Unhappy'. It helped in identify the significant variables contributing to happiness, then assessing the goodness of fit of the model and determining its predictive power using the ROC curve. 
Multinomial regression model was fitted to understand the factors influencing different levels of happiness, namely: Very happy, Rather happy, Not very happy, Not at all happy.
