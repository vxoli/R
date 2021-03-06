## Load and Combine Files
## To improve this function
## 1) convert to DataFrame,
## 2) pass number of months to read to function

combine <- function()
  {

##Need to get directory and CSV file names in directory  
## For now assume wd is set before function invoked.
  filenames <- dir(pattern=".csv$")
  print(filenames)
  first <- as.integer(readline(prompt="Enter start ID: "))
  last <- as.integer(readline(prompt="Enter end ID: "))
  filenames <- filenames[first:last]
  ##Combine 1st two files in directory into data
  ## Number of column and names may vary in each file.
  ## Routine matches colnames and if needed adds columns
  print(paste("Loading:",filenames[1]))
  x <- as.data.frame(read.csv(filenames[1]))
  print(paste("Loading:",filenames[2]))
  y <- as.data.frame(read.csv(filenames[2]))
  x.diff<-setdiff(colnames(x),colnames(y))
  y.diff<-setdiff(colnames(y),colnames(x))
  x[,c(as.character(y.diff))]<-NA
  y[,c(as.character(x.diff))]<-NA
  data<-rbind(x,y)
  
  ##now loop through remaining file names adding each to data
  for (filename in filenames[3:length(filenames)]) { ##loop for filename from 3rd to end
    ## compared to above:
    ## x is new data from file, y is from var "data"
    print(paste("Loading:",filename))
    x<- as.data.frame(read.csv(filename))
    
    ## Number of column and names may vary in each file.
    ## Routine matches colnames and if needed adds columns
    x.diff<-setdiff(colnames(x),colnames(data))
    y.diff<-setdiff(colnames(data),colnames(x))
    x[,c(as.character(y.diff))]<-NA
    data[,c(as.character(x.diff))]<-NA
    data<-rbind(x,data)
    
  } ## end for filenames loop
 
   ## All files in wd now combined into var "data"

## ?? add in some manipulations like convert dates to as.Date(x$Operation.Date, "%d-%b-%Y")
  
## Return variable with combines data set and clear working variables.
 return(data)
  
} ##End of function