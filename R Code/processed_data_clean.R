#OM data
OM <- read.csv("D:/Occupancy Monitoring/Data/Raw Data/2024_FFO_CavityMonitoring_READONLY.csv")
View(OM)

library(dplyr)

#shows all entries for this section
unique(OM$Box.Cavity.Status)
unique(OM$Visit)

#Subset data with date and status
OM.subset <- subset(OM, select=c(Box.Cavity.Name,Visit,Box.Cavity.Status))
View(OM.subset)

#Turning data into 0 and 1's
OM.subset$Box.Cavity.Status <- ifelse(OM.subset$Box.Cavity.Status == "Empty",0,1)
View(OM.subset)

#Reformatting data by visits
library(tidyr)
OM.clean <- pivot_wider(OM.subset, names_from = "Visit", values_from = "Box.Cavity.Status")
View(OM.clean)

#Changing column names
colnames(OM.clean)[2] = "X1"
colnames(OM.clean)[3] = "X2"
colnames(OM.clean)[4] = "X3"
colnames(OM.clean)[5] = "X4"
colnames(OM.clean)[6] = "X5"
colnames(OM.clean)[7] = "X6"
colnames(OM.clean)[8] = "X7"

#export from r into csv
write.csv(OM.clean, "D:/Occupancy Monitoring/Data/Processed Data/2024-08-27_MonitoringData_Reformatted_OccAnalysis.csv")


