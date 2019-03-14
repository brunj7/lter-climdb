#### testing WaterML R package to extract data from CUAHSI Hydrologic Information System (HIS)
### URL: https://cran.r-project.org/web/packages/WaterML/

library(tidyverse)
library(stringr)
library(WaterML)
library(ggplot2)

#get the list of supported CUAHSI HIS services
services <- GetServices()

# point to an CUAHSI HIS service and get a list of the variables and sites
# server <- "http://hydroportal.cuahsi.org/ipswich/cuahsi_1_1.asmx?WSDL"

# Get a specific station
server <- services %>% 
  # Get all the GLEON stations
  # filter(str_detect(.$networkName, "GLEON")) %>%
  # Lake Annie
  filter(networkName =="GLEON_LakeAnnie") %>%
  select(url) %>% pull()

# get all variables
variables <- GetVariables(server)

# get all sites
sites <- GetSites(server)

# get full site info for all sites using the GetSiteInfo method
siteinfo <- GetSiteInfo(server, "GLEON_LakeAnnie:1020")

# Do a specific query on the 2m above graound sensor and temperature
system.time(
  Temp <- GetValues(server, siteCode="GLEON_LakeAnnie:1020",
                  variableCode="GLEON_LakeAnnie:2010")
)
# Took ~220 sec

# plot the data
# plot(Temp$time, Temp$DataValue)

ggplot(Temp) +
  geom_line(aes(time,DataValue))

