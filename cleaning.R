
data = read.csv(file = "../Science_Math_Spending.csv")

data = data %>%
  mutate(src = substr(MSTI_VAR, 1, 2))

data1 = spread(data, key = unique(Country), value = Value, fill = 0)

names = colnames(data1)[15:60]
names[40:46]

data1 = data1 %>%
  group_by(YEAR, MSTI.Variables, Unit, PowerCode, src) %>%
  summarise_at(names, sum, na.rm=TRUE)


write.csv(data1, file = "./data/Science_Math_Fifth_Clean.csv")

