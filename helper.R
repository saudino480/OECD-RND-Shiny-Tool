label_maker = function(col1, col2) {
  temp1 = as.character(col1)
  temp2 = as.character(col2)
  if (temp1[1] == "Percentage") {
    return("Percentage (%)")
  } else if (temp1[1] == "US Dollar") {
    return(paste(temp1, "in", temp2, sep=" "))
  } else {
    return("Error")
  }
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



test = data %>%
  group_by(MSTI_VAR, MSTI.Variables) %>%
  summarise_at(names, sum, na.rm=TRUE)





if (

else if
  sum(col, na.rm=TRUE)