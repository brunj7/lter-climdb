#### testing WaterML R package to extract data from CUAHSI Hydrologic Information System (HIS)
### URL: https://cran.r-project.org/web/packages/WaterML/
library(tidyverse)

library(WaterML)

#get the list of supported CUAHSI HIS services
services <- GetServices()

#point to an CUAHSI HIS service and get a list of the variables and sites
# server <- "http://hydroportal.cuahsi.org/ipswich/cuahsi_1_1.asmx?WSDL"
server <- services %>% 
  filter(networkName =="GLEON_LakeAnnie") %>%
  select(url) %>% pull()

# get all variables
variables <- GetVariables(server)

# get all sites
sites <- GetSites(server)

# get full site info for all sites using the GetSiteInfo method
siteinfo <- GetSiteInfo(server, "GLEON_LakeAnnie:1100")

# Do a specific query
Temp <- GetValues(server, siteCode="GLEON_LakeAnnie:1100",
                  variableCode="GLEON_LakeAnnie:4000")

# plot the data
plot(Temp$time, Temp$DataValue)


