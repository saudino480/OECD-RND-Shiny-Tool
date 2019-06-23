label_maker = function(col1, col2) {
  temp1 = as.character(col1)
  temp2 = as.character(col2)
  if (temp1[1] == "US Dollar" | temp1[1] == "National currency") {
    return(paste(temp1, "in", temp2, sep=" "))
    
  } else {
    return(temp1)
  }
}

gvisLabelMaker = function(col1, col2) {
  return({
    paste0("[{title:'",
           label_maker(col1, col2),
           "'}]")
  })
}

rsubstr = function(str, n) {
  return(substr(str, nchar(str)-n+1, nchar(str)))
}

debugSum = function(x, ...) {
  print(names(x))
  return(sum(x, ...))
}

naSum = function(x, ...) {
  if(all(unlist(lapply(x, is.na)))) {
    return(NA)
  } else {
    sum(x, ...)
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




