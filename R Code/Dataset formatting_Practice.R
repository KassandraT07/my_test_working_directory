#OM data
OM <- read.csv("D:/Occupancy Monitoring/FFO_CavityMonitoring_2024.csv")
View(OM)

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

library(dplyr)
Practice1.new <- Practice1 %>%
  mutate(Box.Cavity.Status = recode(
    Box.Cavity.Status,"Elf Owl inside" = "1", 
    "Feathers" = "1",
    "White wash on cavity wall " = "1",
   "Nest" = "1",
   "Mouse with nest" = "1",
   "Red Squirrel inside" = "1",
   "Feathers at entrance of cavity" = "1",
   "Unknown Feathers inside" = "1",
   "Feathers inside" = "1",
   "Nesting material" = "1",
   "Nest inside" = "1",
   "Wood Pecker" = "1",
   "ACWO" = "1",
   "Wasps" = "1",
   "Mice (2)" = "1",
   "Mouse with nest inside" = "1",
   "Mouse nest?" = "1",
   "Feathers and nest" = "1",
    "Flycatcher nest" = "1",
    "Fly catcher" = "1",
    "Start of a nest. Flycatcher?" = "1",
    "Flycatcher nestlings" = "1",
    "Flycatcher with eggs" = "1",
    "Feathers and scat" = "1",
    "Sulphur bellied fly catcher nest" = "1",
    "Sulphur-Bellied flycatcher" = "1",
    "Unknown squirrel nest" = "1",
    "ACWO nest" = "1",
    "Acorn Woodpecker" = "1",
    "Acorn woodpecker nest" = "1",))
View(Practice1.new)


Practice1.new <- Practice1 %>%
  mutate(Box.Cavity.Status = recode(
    Box.Cavity.Status,"White wash on cavity wall " = "1"))
print(Practice1.new)

#pivot wider
install.packages("tidyverse")
library("tidyr")

New <- pivot_wider(Practice1, names_from = "Box.Cavity.Status",values_from = "Date")
View(New)
