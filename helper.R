#### HELPER FUNCTIONS FOR SHINYPROJECT JUN-23-2019 ####

## STR MANIPULATIONS ####
label_maker = function(col1, col2) {
  temp1 = as.character(col1)
  temp2 = as.character(col2)
  if (temp1[1] == "US Dollar" |
      temp1[1] == "National currency" | temp1[1] == "Persons") {
    return(paste(temp1, "in", temp2, sep = " "))
    
  } else if (temp1[1] == "Percentage") {
    return("Percent (%)")
  } else if (temp1[1] == "Growth rate") {
    return("Growth Rate (%)")
  } else {
    return(temp1[1])
  }
}

label_extractor = function(df, idx) {
  temp_df = unlist(df)
  temp = ""
  
  for (i in idx) {
    #print(i)
    if (i != idx[1]) {
      temp = paste(temp, as.character(temp_df[i]), sep = "@")
      #print(paste("if statement", temp, i, sep= " : "))
    } else {
      temp = as.character(temp_df[i])
      #print(paste("else statement", temp, i, sep= " : "))
    }
  }
  
  #print(typeof(temp))
  temp = unlist(strsplit(temp, split = "@"))
  
}

gvisLabelMaker = function(col1, col2) {
  return({
    paste0("[{title:'",
           label_maker(col1, col2),
           "'}]")
  })
}

rsubstr = function(str, n) {
  return(substr(str, nchar(str) - n + 1, nchar(str)))
}

filter_by_pattern = function(df, col, ptn) {
  df %>% filter(str_detect(df[[col]], ptn))
}


## AGGREGATING FUNCTIONS ####

netPercent = function(x) {
  if (all(unlist(lapply(x, is.na)))) {
    return(NA)
  } else {
    temp = unlist(x[which(!is.na(x))])
    return(((temp[length(temp)] - temp[1]) / temp[1])*100)
  }
}

netChange = function(x) {
  if (all(unlist(lapply(x, is.na)))) {
    return(NA)
  } else {
    temp = unlist(x[which(!is.na(x))])
    return(temp[length(temp)] - temp[1])
  }
}

maxColName = function(df, cols) {
  return(colnames(df[cols])[max.col(df[cols], ties.method = "first")])
}

maxColValue = function(df, cols) {
  return(df[[maxColName(df, cols)]])
}

minColName = function(df, cols) {
  return(colnames(df[cols])[which.min(apply(df[cols], MARGIN = 2, min))])
}

minColValue = function(df, cols) {
  return(df[[minColName(df, cols)]])
}

summaryCol = function(df, cols) {
  
}

debugSum = function(x, ...) {
  print(names(x))
  return(sum(x, ...))
}

naSum = function(x, ...) {
  if (all(unlist(lapply(x, is.na)))) {
    return(NA)
  } else {
    sum(x, ...)
  }
}

