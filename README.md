# Coursera-Getting-and-Cleaning-Data-Course-Project
Repo For the Coursera Data Cleaning Class project

# General direction
This repo contains everything needed to run and review the run_analysis.R script prepared for the Data Cleaning Course for Coursera

The script will check for the existence of the UCI HAR Dataset directory, in the current directory.<br>
If the directory does not exist it will attempt to download the file and unzip it.<br>
It is assumed that none of the subfolders are modified and that the files are not moved around, as there is no seach logic built in.<br>
Once the folder is found the analysis is perfomed.<br>

1-The features and labels are stored <br>
2-The features are subset to only keep those with "mean" and "std" in the name<br>
3-Activity and Test Data is loaded for the above features<br>
4-All the data is merged and then turned into factors<br>
5-Finally only the means are kept and written to a file as requested<br>
