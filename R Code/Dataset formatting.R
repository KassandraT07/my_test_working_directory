#OM data
OM <- read.csv("D:/Occupancy Monitoring/FFO_CavityMonitoring_2024.csv")
View(OM)

#shows all entries for this section
unique(OM$Box.Cavity.Status)

#Creating subset data to figure out code
Practice1 <- subset(OM, select=c(Box.Cavity.Name,Date,Box.Cavity.Status))
View(Practice1)

#convert empty to 0
Practice1[Practice1=="Empty"]<-0
View(Practice1)

#export from r into csv
write.csv(Practice1, "D:/Occupancy Monitoring/Practice1.csv")

OM.new <- read.csv("D:/Occupancy Monitoring/Practice1.csv")
View(OM.new)

#pivot wider
install.packages("tidyverse")
library("tidyr")

OM.reformat <- pivot_wider(OM.new, names_from = "Date",values_from = "Box.Cavity.Status")
View(OM.reformat)


#Creating subset data to figure out code
Practice2 <- subset(OM.new, select=c(Box.Cavity.Name,Box.Cavity.Status))
View(Practice2)

#pivot wider
install.packages("tidyverse")
library("tidyr")

OM.reformat <- pivot_wider(Practice2, names_from = "Box.Cavity.Status",values_from = "Box.Cavity.Name")
View(OM.reformat)




