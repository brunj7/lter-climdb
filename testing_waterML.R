#### testing WaterML R package to extract data from CUAHSI Hydrologic Information System (HIS)
### URL: https://cran.r-project.org/web/packages/WaterML/


library(WaterML)

#get the list of supported CUAHSI HIS services
services <- GetServices()


server <- "http://hydroportal.cuahsi.org/ipswich/cuahsi_1_1.asmx?WSDL"
variables <- GetVariables(server)
sites <- GetSites(server)
Temp <- GetValues(server,siteCode="IRWA:FB-BV",variableCode="IRWA:Temp")

