##Preparing data for single season occupancy models in r

frogs <- read.csv("C:/Users/kassa/Downloads/raw_survey_data.csv")
View(frogs)

sitecoords1 <- read.csv("C:/Users/kassa/Downloads/point_locations.csv")

library(dplyr)

##Single season occ models, want data structure to include a single row
##for each site with three columns for detection

##Going to do survey covariates (wind and date)
##extract just the first visits to each site
frogsV1 <- subset(frogs, visit == 1)

## link coordinates with each site
lookup_1a <- merge(x=sitecoords1, by.x="point_id", y=frogsV1, by.y="pointID", all.x=TRUE)
lookup_1b <- group_by(lookup_1a, point_id)

View(lookup_1b)

##summarize dataset for each detection covariate
##gives summary data for each group
##can do min(), max(), or mean()
lookup_1cloud <- data.frame(summarise(lookup_1b, cloud = mean(cloud)))
lookup_1julian <- data.frame(summarise(lookup_1b, julian = mean(date)))
lookup_1temp <- data.frame(summarise(lookup_1b, temp = mean(temp)))
lookup_1wind <- data.frame(summarise(lookup_1b, wind = mean(wind)))
lookup_1msss <- data.frame(summarise(lookup_1b, msss = mean(minutes)))
lookup_1noise <- data.frame(summarise(lookup_1b, noise = mean(noise_index)))
                            
##Repeat for visits 2 and 3
# second visit

frogsV2 <- subset(frogs, visit == 2) # removing all data except from visit 2

lookup_2a <- merge(x = sitecoords1, by.x = "point_id", y = frogsV2, by.y = "pointID", all.x = TRUE) #vlookup

lookup_2b <- group_by(lookup_2a, point_id)

lookup_2cloud <- data.frame(summarise(lookup_2b, cloud = mean(cloud)))
lookup_2julian <- data.frame(summarise(lookup_2b, julian = mean(date)))
lookup_2temp <- data.frame(summarise(lookup_2b, temp = mean(temp)))
lookup_2wind <- data.frame(summarise(lookup_2b, wind = mean(wind)))
lookup_2msss <- data.frame(summarise(lookup_2b, msss = mean(minutes)))
lookup_2noise <- data.frame(summarise(lookup_2b, noise = mean(noise_index)))

# third visit

frogsV3 <- subset(frogs, visit == 3) # removing all data except from visit 3

lookup_3a <- merge(x = sitecoords1, by.x = "point_id", y = frogsV3, by.y = "pointID", all.x = TRUE) #vlookup
lookup_3b <- group_by(lookup_3a, point_id)

lookup_3cloud <- data.frame(summarise(lookup_3b, cloud = mean(cloud)))
lookup_3julian <- data.frame(summarise(lookup_3b, julian = mean(date)))
lookup_3temp <- data.frame(summarise(lookup_3b, temp = mean(temp)))
lookup_3wind <- data.frame(summarise(lookup_3b, wind = mean(wind)))
lookup_3msss <- data.frame(summarise(lookup_3b, msss = mean(minutes)))
lookup_3noise <- data.frame(summarise(lookup_3b, noise = mean(noise_index)))

##Now combine each visits covariates of each type
##created new data frame with just point ID
point_idVals <- data.frame("point_id" = lookup_1wind$point_id)
View(point_idVals)

##Combine each wind visit
windVals <- cbind("wind1" = lookup_1wind$wind, "wind2" = lookup_2wind$wind, "wind3" = lookup_3wind$wind)

##clouds
cloudVals <- cbind("cloud1" = lookup_1cloud$cloud, "wind2" = lookup_2cloud$cloud, "wind3" = lookup_3cloud$cloud)

##julian date
julianVals <- cbind("julian1" = lookup_1julian$julian, "julian2" = lookup_2julian$julian, "julian3" = lookup_3julian$julian)

##temps
tempVals <- cbind("temp1" = lookup_1temp$temp, "temp2" = lookup_2temp$temp, "temp3" = lookup_3temp$temp)

##minutes
msssVals <- cbind("msss1" = lookup_1msss$msss, "msss2" = lookup_2msss$msss, "msss3" = lookup_3msss$msss)

##noise
noiseVals <- cbind("noise1" = lookup_1noise$noise, "noise2" = lookup_2noise$noise, "noise3" = lookup_3noise$noise)

##combine into single file
AllDetCovs <- cbind(point_idVals, windVals, cloudVals, julianVals, tempVals, msssVals, noiseVals)

View(AllDetCovs)
                            
##Preparing Detection History

##Add detection history for focal species
##Remove detection sthat occurred beyond 100m from observer
frogs100 <- subset(frogs, distance <= 100) # removing detections beyond 100m

focalspecies <- "wood frog"
frogsV1 <- subset(frogs100, visit == 1) # removing all data except from visit 1
frogsV2 <- subset(frogs100, visit == 2) #  removing all data except from visit 2
frogsV3 <- subset(frogs100, visit == 3) #  removing all data except from visit 3

frogsV1_foc <- subset(frogsV1, species == focalspecies)
# subsetting focal species from first visit

frogsV2_foc <- subset(frogsV2, species == focalspecies)
# subsetting focal species from second visit

frogsV3_foc <- subset(frogsV3, species == focalspecies)
# subsetting focal species from third visit

##Now extract occupancy data from visit 1
# first visit

lookup1 <- merge(x = sitecoords1, by.x = "point_id", y = frogsV1_foc, by.y = "pointID", all.x = TRUE) #vlookup

lookup1$abundance[is.na(lookup1$abundance)] <- 0 # convert non-detections to zero in 'abundance'1

lookup1 <- mutate(lookup1, vis1 = if_else(abundance == 0, 0, 1))

visit1data <- data.frame("v1" = lookup1$vis1, "point1" = lookup1$point_id)
# point id added as a double-check

# second visit

lookup2 <- merge(x = sitecoords1, by.x = "point_id", y = frogsV2_foc, by.y = "pointID", all.x = TRUE) #vlookup

lookup2$abundance[is.na(lookup2$abundance)] <- 0

# convert non-detections to zero in 'abundance'

lookup2 <- mutate(lookup2, vis2 = if_else(abundance == 0, 0, 1))

visit2data <- data.frame("v2" = lookup2$vis2, "point2" = lookup1$point_id)
# point id added as a double-check

# third visit

lookup3 <- merge(x = sitecoords1, by.x = "point_id", y = frogsV3_foc, by.y = "pointID", all.x = TRUE) #vlookup

lookup3$abundance[is.na(lookup3$abundance)] <- 0
# convert non-detections to zero in 'abundance'

lookup3 <- mutate(lookup3, vis3 = if_else(abundance == 0, 0, 1))

visit3data <- data.frame("v3" = lookup3$vis3, "point3" = lookup1$point_id)
# point id added as a double-check

# combining detection history

dethistory <- cbind(visit1data, visit2data, visit3data)

sitehistory <- merge(x = sitecoords1, by.x = "point_id", y = dethistory, by.y = "point1", all.x = TRUE) #vlookup

sitehistory <- select(sitehistory, -pointid, -point2, -point3) # delete trash columns

View(sitehistory)

##Now combine everything into a single file
FrogOccupancyData <- merge(x = sitehistory, by.x = "point_id", y=AllDetCovs, by.y = "point_id",all.x=TRUE)
View(FrogOccupancyData)




