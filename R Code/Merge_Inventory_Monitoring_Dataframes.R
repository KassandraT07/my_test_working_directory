#Cavity Inventory Data
Sys.setlocale("LC_ALL", "C") #would not open file, found this code online to fix

CavityInventory <- read.csv("D:/Occupancy Monitoring/Data/Raw Data/2024-08-27_CavityInventory_READONLY.csv")
View(CavityInventory)

#Monitoring Data
#OM data
OM <- read.csv("D:/Occupancy Monitoring/Data/Processed Data/2024-08-27_MonitoringData_Reformatted_OccAnalysis.csv")
View(OM)

#Changing column names
colnames(CavityInventory)[1] = "Box.Cavity.Name"

#Merging data frames
Merged.Data <- merge(OM,CavityInventory, by="Box.Cavity.Name")
View(Merged.Data)

unique(Merged.Data$Box.Cavity.Name)
unique(OM$Box.Cavity.Name)

#take out column numbering
head(Merged.Data)
Merged.Data$X.x <- NULL

#export from r into csv
write.csv(Merged.Data, "D:/Occupancy Monitoring/Data/Processed Data/2024-08-27_Cavity_MonitoringData_AnalysisReady.csv")




