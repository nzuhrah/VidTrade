#Check working directory
getwd()

#read trade raw data
rawdata.jan_april2019 <- read.csv("2019_Jan-April - comtrade goods(detail)-monthly.csv", header = TRUE, sep = ",")
head(rawdata.jan_april2019)
is.data.frame(rawdata.jan_april2019)
str(rawdata.jan_april2019)

rawdata.may_aug2019 <- read.csv("2019_May-Aug - comtrade goods(detail)-monthly.csv", header = TRUE, sep = ",")
head(rawdata.may_aug2019)
is.data.frame(rawdata.may_aug2019)
str(rawdata.may_aug2019)

rawdata.sept_dec2019 <- read.csv("2019_Sept-Dec - comtrade goods(detail)-monthly.csv", header = TRUE, sep = ",")
head(rawdata.sept_dec2019)
is.data.frame(rawdata.sept_dec2019)
str(rawdata.sept_dec2019)

rawdata.jan_april2020 <- read.csv("2020_Jan-Apr - comtrade goods(detail)-monthly.csv", header = TRUE, sep = ",")
head(rawdata.jan_april2020)
is.data.frame(rawdata.jan_april2020)
str(rawdata.jan_april2020)

#select and combine column $Period, $Reporter and $Trade.Value as dataframe
newdata.jan_april2019 <- data.frame(rawdata.jan_april2019$Period,rawdata.jan_april2019$Reporter,rawdata.jan_april2019$Trade.Value..US..)
head(newdata.jan_april2019)
str(newdata.jan_april2019)

newdata.may_aug2019 <- data.frame(rawdata.may_aug2019$Period,rawdata.may_aug2019$Reporter,rawdata.may_aug2019$Trade.Value..US..)
head(newdata.may_aug2019)
str(newdata.may_aug2019)

newdata.sept_dec2019 <- data.frame(rawdata.sept_dec2019$Period,rawdata.sept_dec2019$Reporter,rawdata.sept_dec2019$Trade.Value..US..)
head(newdata.sept_dec2019)
str(newdata.sept_dec2019)

newdata.jan_april2020 <- data.frame(rawdata.jan_april2020$Period,rawdata.jan_april2020$Reporter,rawdata.jan_april2020$Trade.Value..US..)
head(newdata.jan_april2020)
str(newdata.jan_april2020)

#rename variable
library(data.table)

var.name <- c("Year_Month","Country","Trade.Value")
setnames(newdata.jan_april2019,var.name)
head(newdata.jan_april2019)
str(newdata.jan_april2019)

setnames(newdata.may_aug2019,var.name)
head(newdata.may_aug2019)
str(newdata.may_aug2019)

setnames(newdata.sept_dec2019,var.name)
head(newdata.sept_dec2019)
str(newdata.sept_dec2019)

setnames(newdata.jan_april2020,var.name)
head(newdata.jan_april2020)
str(newdata.jan_april2020)

#Combine all data frame and Change Year_Month format
library(dplyr)
trade.2019_2020 <- bind_rows(newdata.jan_april2019,newdata.may_aug2019,newdata.sept_dec2019,newdata.jan_april2020)
head(trade.2019_2020)

trade.2019 <- bind_rows(newdata.jan_april2019,newdata.may_aug2019,newdata.sept_dec2019)
head(trade.2019)

#Check NA value in dataframe
sum(is.na(trade.2019_2020))

#Write data frame in csv file
write.csv(newdata.jan_april2020,file = "Trade Value Data 2020.csv")
write.csv(trade.2019_2020, file = "Trade Value Data 2019 - 2020.csv")
write.csv(trade.2019, file = "Trade Value Data 2019.csv")