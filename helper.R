


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