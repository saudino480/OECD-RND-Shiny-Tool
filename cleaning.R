library(tidyverse)


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
  summarise_at(names, sum)

data3 = data2 %>%
  group_by(YEAR, MSTI_VAR, MSTI.Variables, Unit, PowerCode, src) %>%
  summarise_at(names, naSum, na.rm=TRUE)
  
write.csv(data3, file = "./data/Science_Math_Seventh_Clean.csv")


View(unique(data3$MSTI_VAR))


####making groupings

B_ALL = label_extractor(z$unique.x., c(5:7, 15))

B_XALL = label_extractor(z$unique.x., c(16:18, 24))

B_XFIN = label_extractor(z$unique.x., 19:22)

B_GPDXVA = label_extractor(z$unique.x., c(23, 25))

BH_WRSRS = label_extractor(z$unique.x., 26:27)

temp = c("C_ECO", "C_EDU", "C_GUF", "C_HEA", "C_NOR", "C_SPA")

C_PROGPPP = paste(temp, "PPP", sep="")

C_PROGXCV = paste(temp, "XCV", sep="")

G_ALLXGDP = label_extractor(z$unique.x., 55:58)

G_XALLPR = label_extractor(z$unique.x., 63:66)

G_XALLFI = label_extractor(z$unique.x., 67:70)

GH_WRSRS = label_extractor(z$unique.x., 75:76)

TD_BALANCE = labal_extractor(z$unique.x., 116:118)

TD_EXPO = label_extractor(z$unique.x., 119:121)

TD_IMPO = label_extractor(z$unique.x., 122:124)

TD_MRKT = label_extractor(z$unique.x., 125:127)

TH_WRSRS = label_extractor(z$unique.x., 128:129)

TP_RSCOMBO = label_extractor(z$unique.x., 134:135)

TP_TTCOMBO = label_extractor(z$unique.x., 138:139)

VA_GDP = label_extractor(z$unique.x., c(74, 142))

GDP_ALL = label_extractor(z$unique.x., c(23,71,88,94))

