#### testing WaterML R package to extract data from CUAHSI Hydrologic Information System (HIS)
### URL: https://cran.r-project.org/web/packages/WaterML/

library(tidyverse)
library(stringr)
library(WaterML)

#get the list of supported CUAHSI HIS services
services <- GetServices()

# point to an CUAHSI HIS service and get a list of the variables and sites
# server <- "http://hydroportal.cuahsi.org/ipswich/cuahsi_1_1.asmx?WSDL"

# Get a specific station
server <- services %>% 
  # Get all the SCAN network
  filter(str_detect(.$networkName, "SCAN")) %>%
  select(url) %>% pull()

# get all variables
variables <- GetVariables(server)

# get all sites
sites <- GetSites(server)

# get full site info for all sites using the GetSiteInfo method
siteinfo <- GetSiteInfo(server, "SCAN:2069_NH_SCAN")


# Do a specific query
Temp <- GetValues(server, siteCode="SCAN:2069_NH_SCAN",
                  variableCode="SCAN:TOBS_D",
                  startDate="2017-08-01", endDate="2017-10-01")
# Took ~220 sec

# plot the data
plot(Temp$time, Temp$DataValue)


