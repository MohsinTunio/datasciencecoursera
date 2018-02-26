***Codebook.md***
As you can see that the files provided in this excercise are all text files having tabular structure, so read.table() function
is used to appropriately load train and test data sets. Next the code runs merging the datasets, binding them together and looking for specific patterns 
such as mean and standard deviation.

There are plenty of data items with numeric data type or may be called double or float in some programming languages due to their precision


The following functions are used in this exercise
- read.table() # to get tabular data
- names() # to display column names 
- grepl() # grepl function takes multiple arguments, but simply it goes like grepl("pattern", data) data in the form of a vector etc.
- cbind() # the famous function to bind two vectors: puts them together and displays them
- dcast() # this function performs similar tasks as we learned for tapply i.e. applying same operations across columns: you may search its documentation
- melt() #for restructuring data: I would advise that you go through its documentation
- write.table() # finally for writing output and saving it into a .txt file

By default write.table() will generate a .txt file in the main working directory, you can however change it to a subdirectory within.

Furthermore, documentation for dplyr, tidyr, and reshape2 should be looked into to get a detailed into. 
Note: There are many variants of greXXX type function such as greexpr grep etc... be careful and use only greply for pattern matching.




