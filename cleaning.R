library(tidyverse)


data = read.csv(file = "../Science_Math_Spending.csv")

data = data %>%
  mutate(src = substr(MSTI_VAR, 1, 2))

data1 = spread(data, key = unique(Country), value = Value)

names = colnames(data1)[15:60]
names[40:46]


data2 = data1 %>%
  group_by(YEAR, MSTI_VAR, MSTI.Variables, Unit, PowerCode, src, COU) %>%
  summarise_at(names, sum)



data3 = data2 %>%
  group_by(YEAR, MSTI_VAR, MSTI.Variables, Unit, PowerCode, src) %>%
  summarise_at(names, naSum, na.rm=TRUE)
  
  
countries = label_extractor(colnames(data3), c(22, 51, 21, 28, 42, 47, 52, 13, 29, 30, 34, 11, 19, 20))

data_labels = label_extractor(colnames(data3), 1:6)

data3 = data3 %>%
  select(data_labels, countries)

data3$PowerCode[data3$Unit == ""] = "Millions"

data3$Unit[data3$Unit == ""] = "US Dollar"

data3 = data3 %>%
  mutate(label = label_maker(Unit, PowerCode))

data4 = data3 %>%
  transmute(gvisLabel = gvisLabelMaker(label))



View(unique(data3$PowerCode))

write.csv(data3, file = "./data/Science_Math_Seventh_Clean.csv")


View(unique(data3$MSTI_VAR))

View(unique(data1$MSTI_VAR))

print(colnames(data3))

raw_types = label_extractor(unique(data3$Unit), c(1,2,4,10))

pc_types = label_extractor(unique(data3$Unit), c(3,5,7))

####making groupings
x = unique(data3$MSTI_VAR)
y = unique(data3$MSTI.Variables)

z = data.frame(x,y)


B_ALL = label_extractor(z$x, c(5:7, 15))

B_XALL = label_extractor(z$x, c(16:18, 24))

B_XFIN = label_extractor(z$x, 19:22)

B_GPDXVA = label_extractor(z$x, c(23, 25))

BH_WRSRS = label_extractor(z$x, 26:27)

temp = c("C_ECO", "C_EDU", "C_GUF", "C_HEA", "C_NOR", "C_SPA")

C_PROGPPP = paste(temp, "PPP", sep="")

C_PROGXCV = paste(temp, "XCV", sep="")

G_ALLXGDP = label_extractor(z$x, 55:58)

G_XALLPR = label_extractor(z$x, 63:66)

G_XALLFI = label_extractor(z$x, 67:70)

GH_WRSRS = label_extractor(z$x, 75:76)

TD_BALANCE = labal_extractor(z$x, 116:118)

TD_EXPO = label_extractor(z$x, 119:121)

TD_IMPO = label_extractor(z$x, 122:124)

TD_MRKT = label_extractor(z$x, 125:127)

TH_WRSRS = label_extractor(z$x, 128:129)

TP_RSCOMBO = label_extractor(z$x, 134:135)

TP_TTCOMBO = label_extractor(z$x, 138:139)

VA_GDP = label_extractor(z$x, c(74, 142))

GDP_ALL = label_extractor(z$x, c(23,71,88,94))

