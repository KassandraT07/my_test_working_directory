setwd("D:/Occupancy Monitoring/Data/Processed Data")

#Load packages
#library(dplyr)
library(tidyverse)
library(boot)
library(unmarked)
library(MuMIn)

rm(list=ls())

#Imported dataset manually

data <- X2024_08_27_Cavity_MonitoringData_AnalysisReady
View(data)

#Select detection data
#(2:8) is go over two columns and then select the other 8
detection <- data%>%
  dplyr::select(2:8)%>%
  glimpse()

#Select site covariates
site_covs <- data%>%
  dplyr::select(quality,tree.species,opening.azimuth,height,cavity.width,cavity.type)%>%
  glimpse()
View(site_covs)

occupancy.data <- unmarkedFrameOccu(y=detection, siteCovs = site_covs)
summary(occupancy.data)

occu(~1 ~1, data=occupancy.data)%>% summary()

null_mod <- occu(~1 ~1, data=occupancy.data)
null_mod

#adding covariates
#quality,tree.species,opening.azimuth,height,cavity.width,cavity.type
mod_quality <- occu(~1 ~quality, data=occupancy.data)
mod_quality

mod_height <- occu(~1 ~height, data=occupancy.data)
mod_height

mod_tree.species <- occu(~1 ~tree.species, data=occupancy.data)
mod_tree.species

mod_opening.azimuth <- occu(~1 ~opening.azimuth, data=occupancy.data)
mod_opening.azimuth

mod_cavity.width <- occu(~1 ~cavity.width, data=occupancy.data)
mod_cavity.width

mod_cavity.type <- occu(~1 ~cavity.type, data=occupancy.data)
mod_cavity.type

#model dredging
mod_global <- occu(~detection ~quality+tree.species+opening.azimuth+height+cavity.width+cavity.type,
                   data=occupancy.data)
