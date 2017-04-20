
## Function to intialize a file to store data
InitializeFile = function(forecast_Hours=24, forecast_Title="temp",
                          unit="(C)", sep=","){
    
    setwd("P:\\University")
    
    file_Path<-paste(forecast_Title, ".csv", sep="")
    
    if(!file.exists(file_Path)){
        file.create(file_Path)
        
        ## making the col names:
        col_Names <-c("Date",paste(
            "current ",forecast_Title,unit, sep=""
        ))
        for(i in 1:forecast_Hours){
            forecast_Name = paste("forcast ",forecast_Title," in ", 
                                  i,"h ",unit,sep="")
            col_Names <- append(col_Names,forecast_Name)
        }
        
        ## adding title to the file:
        titles = as.data.frame(as.list(col_Names),stringsAsFactors = FALSE,
                               col.names = NULL, fix.empty.names = FALSE)
        write.table(titles, file_Path, sep=sep,
                    append=TRUE,col.names = FALSE, row.names = FALSE)
    }
    
    
    return(file_Path)
}




## script to read in data from websites

library(rvest)
library(xml2)

## change directory as needed, if not changed, the default directory
## is where this file is saved. If the absolute path to this file contains
## spaces, then the script might not work. 

# setwd("P:\\University")
file_Path = normalizePath(InitializeFile(forecast_Title = "temperature")) 


forecast <- "https://weather.gc.ca/forecast/hourly/on-118_metric_e.html"
current_Weather <- "https://weather.gc.ca/city/pages/on-118_metric_e.html"
sep <- ","

forecast_xml <- read_html(x=forecast)

#list of temperature forecast
temperature_css <- ".text-center:nth-child(2)"
temperature_xml <- rvest::html_nodes(forecast_xml,temperature_css)
temperature_Forecast <- lapply(temperature_xml, function(x){
    rvest::html_text(x)
})

# Getting current Temperature

current_Temp_css <-"div.col-xs-6 p.lead span.wxo-metric-hide"
current_Temp <- read_html(current_Weather) %>%
    rvest::html_nodes(current_Temp_css) %>%
    rvest::html_text()

# Formatting the capatured results
temperature_Forecast <- as.numeric(as.vector(
    temperature_Forecast))
current_Temp <- as.numeric(gsub("[^-0-9]+","",
                                current_Temp))
time <- Sys.time()
data <- append(current_Temp,temperature_Forecast)
data <- as.data.frame(as.list(data),stringsAsFactors = FALSE,
                      col.names = NULL, fix.empty.names = FALSE)
data <- cbind(time,data)

# writing to the file

write.table(data, file = file_Path,append=TRUE,
            col.names = FALSE, row.names = FALSE,
            sep=sep)


print("excuted")
