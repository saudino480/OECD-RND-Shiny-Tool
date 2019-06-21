
data = read.csv(file = "../Science_Math_Spending.csv")

data = data %>%
  mutate(src = substr(MSTI_VAR, 1, 2))

data1 = spread(data, key = unique(Country), value = Value)

names = colnames(data1)[15:60]
names[40:46]

data2 = data1 %>%
  filter(!complete.cases(data1[names]))


data2 = data1 %>%
  group_by(YEAR, MSTI_VAR, MSTI.Variables, Unit, PowerCode, src, COU) %>%
  summarise_at(names, debugSum)

idx = !complete.cases(data2[,names])
  
data3 = data2[idx,]


data2 = data1 %>%
  group_by(YEAR, MSTI_VAR, MSTI.Variables, Unit, PowerCode, src) %>%
  
  
write.csv(data1, file = "./data/Science_Math_Sixth_Clean.csv")



test = data %>%
  group_by(MSTI_VAR, MSTI.Variables) %>%
  summarise(uberSum(spain))

