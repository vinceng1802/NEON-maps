## AUTHORS: V. Nguyen & A.D. Wright
## DESCRIPTION: Making maps depicting the distribution and intensity of bird, fish, and mammal sampling data per NEON site

## IMPORT DATA
setwd("C:/Users/Vince/Desktop/Zipkin Lab")
surData <- read.csv('Field Sites (NEON).csv')

## INSTALL PACAKGES
library(tidyverse)
library(ggmap)
library(maps)
library(mapdata)

##DATA SUMMARY
head(surData)
  #Returns number of sites in Northeast Domain
nrow(surData[surData$Domain.Name == 'Northeast',])


## DATA  MANIPULATION
#Split lat long into 2 different columns
surData2 <- surData %>%
  separate(Lat..Long., c("Lat", "Long"), sep = ",  ")
#Rename the column indicating the # of samples
colnames(surData2)[7] <- 'Bird_Samples'
colnames(surData2)[9] <- 'Mammal_Samples'
colnames(surData2)[11] <- 'Fish_Samples'
colnames(surData2)[13] <- 'Beetle_Samples'
# Remove Alaska, HAwaii and Puerto Rico
surData2 <- surData2 %>% filter(State != 'AK') %>% filter(State != 'HI') %>% filter(State != 'PR')

## PLOTTING
#Make map (http://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html) 
# & (https://eriqande.github.io/rep-res-eeb-2017/map-making-in-R.html)
#Base map
usa <- map_data("usa") # we already did this, but we can do it again
#Bird map
birds <- ggplot() + geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = 'white', color = 'blue') + 
  coord_fixed(1.3) +
  geom_point(data = surData2, aes(x = as.numeric(Long), y = as.numeric(Lat), size = Bird_Samples), alpha = 0.4) +
  theme_void()
birds ##600x300
#Mammal map
mammal <- ggplot() + geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = 'white', color = 'blue') + 
  coord_fixed(1.3) +
  geom_point(data = surData2, aes(x = as.numeric(Long), y = as.numeric(Lat), size = Mammal_Samples), alpha = 0.4) +
  theme_void()
mammal
#Fish map
fish <- ggplot() + geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = 'white', color = 'blue') + 
  coord_fixed(1.3) +
  geom_point(data = surData2, aes(x = as.numeric(Long), y = as.numeric(Lat), size = Fish_Samples), alpha = 0.4) +
  theme_void()
fish