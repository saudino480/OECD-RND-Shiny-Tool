library(tidyverse)


data = read.csv(file = "../Science_Math_Spending.csv")


data1 = spread(data, key = unique(Country), value = Value)

names = colnames(data1)[14:59]
names[40:46]


data2 = data1 %>%
  group_by(YEAR, MSTI_VAR, MSTI.Variables, Unit, PowerCode, COU) %>%
  summarise_at(names, sum)



data3 = data2 %>%
  group_by(YEAR, MSTI_VAR, MSTI.Variables, Unit, PowerCode) %>%
  summarise_at(names, naSum, na.rm=TRUE)
  
  
countries = label_extractor(colnames(data3), 
                            (c(22, 51, 21, 28, 42, 47, 27, 52, 13, 29, 30, 34, 11, 19, 20)-1))

data_labels = label_extractor(colnames(data3), 1:5)

data3 = data3 %>%
  select(data_labels, countries)

data3$PowerCode[data3$Unit == ""] = "Millions"

data3$Unit[data3$Unit == ""] = "US Dollar"

temp_1 = data3 %>%
  filter(MSTI_VAR == "VA_PPP" & YEAR != 2018)


temp_2 = data3 %>%
  filter(MSTI_VAR == "GDP_PPP" & YEAR != 2018)

temp = temp_1

temp[countries] = temp_1[countries] / temp_2[countries]

temp$MSTI_VAR = as.factor("VA_XGDP")

temp$MSTI.Variables = as.factor("Value Added of Industry as a percent of GDP (current PPP$)")

temp$Unit = as.factor("Percentage")

temp$PowerCode = as.factor("Units")

temp_2$MSTI_VAR = as.factor("VA_GDPPPP")

data3 = rbind(data3, temp)

data3 = rbind(data3, temp_2)

data3$YEAR = as.numeric(data3$YEAR)

data3$MSTI_VAR = as.factor(data3$MSTI_VAR)

data3$MSTI.Variables = as.factor(data3$MSTI.Variables)

data3$Unit = as.factor(data3$Unit)

data3$PowerCode = as.factor(data3$PowerCode)


write.csv(data3, file = "./data/Science_Math_Eigth_Clean.csv")

####making groupings
x = unique(data3$MSTI_VAR)
y = unique(data$MSTI.Variables)

z = data.frame(x,y)
