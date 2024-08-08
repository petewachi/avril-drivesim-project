#### Load libraries ####
library(readxl)
library(readr)
library(plyr)
library(dplyr)
library(lubridate)
library(data.table)  
library(tidyverse)

library('RHRV') #Heart Rate Analysis


#### Config ####


my_options <- options(digits.secs = 3) #for time in millisecond

#sim_freq <- 1000
HR_freq <- 64
EDA_freq <- 4
eye_freq <- 125

target_sampling_rate <- 64

pre_takeover_sec <- 10 #before (alert) trigger launched
post_takeover_sec <- 10 #after (alert) trigger launched
##### Helper Functions #####

replaceColNamePattern <- function(df, pattern, replace){ 
  names(df) <- gsub(pattern, replace, names(df))
  df
}


#### Import experiment list ####

participant_assignment_all <- read_excel("Experiment Assignment.xlsx",sheet = "Participant ID")
participant_assignment_all <- participant_assignment_all[participant_assignment_all[, "Status"]=="Completed", ]
#participant_assignment <- participant_assignment_all[participant_assignment_all[, "participant_ID"]==filter_participant_ID, ]
participant_assignment_all$TrialScenario <- "00"

expriment_list <- participant_assignment_all |>
  pivot_longer(cols = c("TrialScenario","1st Scenario","2nd Scenario","3rd Scenario","4th Scenario"), names_to = "scenario_order", values_to = "scenario") |>
  select(participant_ID, scenario, `Alert Design`,Sim_freq, `Appointment Date`,scenario_order)

expriment_list$design <- sapply(str_split(tools::file_path_sans_ext(expriment_list$scenario),"_"), `[`, 1)
expriment_list$scenario <- sapply(str_split(tools::file_path_sans_ext(expriment_list$scenario),"_"), `[`, 2)
#expriment_list$order <- substr(expriment_list$scenario, 1,1)
#expriment_list$scenario <- substr(expriment_list$scenario, 2,2)
expriment_list$`Alert Design` <- replace(expriment_list$`Alert Design`, is.na(expriment_list$scenario), "Trial")
expriment_list$scenario <- replace(expriment_list$scenario, is.na(expriment_list$scenario), "00")


####  Import HR file list ####
HR_dir <- "./HRData"
HR_list <- data.frame(HRfile = list.files(path = HR_dir,pattern = "\\.zip$"))
HR_list$HR_startTime <- sapply(str_split(tools::file_path_sans_ext(HR_list$HRfile),"_"), `[`, 1)
HR_list$HR_startTime <- as.POSIXct(as.numeric(HR_list$HR_startTime), format = "%Y.%m.%d %H.%M.%OS",origin=as.POSIXct("1970-01-01", tz="GMT"), tz="EST")
HR_list$participant_ID <- as.numeric(sapply(str_split(tools::file_path_sans_ext(HR_list$HRfile),"_"), `[`, 2))
#HR_list <- HR_list[HR_list[, "participant_ID"]==filter_participant_ID, ]



#### Import Simulation file list ####
sim_list <- data.frame(dir = list.dirs(path = "./SimData"))
sim_list$participant_id_path <- lapply(str_split(sim_list$dir, "/"),head, n=3)
sim_list$folderSplit <- lapply(str_split(sim_list$dir, "_"),tail, n=4)
sim_list <- sim_list[which(sapply(sapply(sim_list[,"folderSplit",drop=F],"[",),length)>1),]
for (i in 1:length(sim_list$dir)){
  
  sim_list$participant_ID[i] <- sim_list$participant_id_path[[i]][3]
  
  sim_list$scenario[i] <-  substr(sim_list$folderSplit[[i]][2],1,2)
  
  if (sim_list$scenario[i] == "00"){ #Test drive
    sim_list$design[i] <- "00"
  }
  else {
    sim_list$design[i] <-  substr(sim_list$folderSplit[[i]][1],1,1)
  }
  
  
  sim_list$sim_folder_name[i] <- sim_list$dir[i]
  sim_list$sim_file_name[i] <- as.list(list.files(path = sim_list$sim_folder_name[i],pattern = "\\.csv$"))
  file_date <- sim_list$folderSplit[[i]][3]
  file_time <- sim_list$folderSplit[[i]][4]
  sim_list$test_start_date_time[i] <- as.POSIXct(paste(file_date,file_time), format = "%Y.%m.%d %H.%M.%OS",origin=as.POSIXct("1970-01-01", tz="EST"), tz="EST")
}


#### Import HR file list #### TBC

#### Merging file lists ####
expriment_list <- cbind(expriment_list[order(expriment_list$"Appointment Date"),], HR_list[order(HR_list$"HR_startTime"),]["HRfile"])

expriment_list <- join(expriment_list, sim_list, type = "left", by = c("participant_ID","scenario","design"))

#Importing data
experiment_data <- data.frame()

baseline_data <- data.frame()

#### Importing Simulation Data ####
for (i in 1:length(expriment_list[[1]])) {
  tempData <- read.csv(paste0(expriment_list$sim_folder_name[i],"/",expriment_list$sim_file_name[i]),header=TRUE, sep=";", dec=".", stringsAsFactors=FALSE)
  tempData <- tempData %>%
    select(STEP,date_time, starts_with("Driver_Performance."), contains("Cockpit"), contains("velocit"),contains("acceleration"))

  ##### Down Sample Sim Data #####
  # Calculate the downsampling factor
  downsample_factor <- sim_freq / target_sampling_rate
  
  # Downsample the data
  downsampled_data <- combined_data[seq(1, nrow(combined_data), by = downsample_factor), ]
  # Print the length of the original and downsampled data
  cat("Original data length:", length(combined_data[[1]]), "\n")
  cat("Downsampled data length:", length(downsampled_data[[1]]), "\n")
  
  
  
  tempData$date_time <- sim_list$test_start_date_time[i]+(tempData$STEP/expriment_list$sim_freq)
  #tempData <- rbind.data.frame(tempData,tempData)
  
  
  if (expriment_list$scenario = "00"){
    
    
    temp
  }
  # Find begin step and last sim step of each trigger
  beginSteps <- aggregate(STEP ~ + design + group + scenario + Driver_Performance.inputs.trigger_ID, data = tempData[which(tempData$Driver_Performance.inputs.trigger_ID > 0),], FUN = min)
  names(beginSteps)[length(beginSteps)] <- "triggerBeginSTEP"
  lastSteps <- aggregate(STEP ~ + design + group + scenario + Driver_Performance.inputs.trigger_ID, data = tempData[which(tempData$Driver_Performance.inputs.trigger_ID > 0),], FUN = max)
  names(lastSteps)[length(lastSteps)] <- "triggerLastSTEP"
  
  triggerSteps <- inner_join(beginSteps, lastSteps, by = c("design","group","scenario","Driver_Performance.inputs.trigger_ID"))
  rm(beginSteps,lastSteps)
  
  #add margin to evaluate data after trigger
  pre_takeover_margin_step <- pre_takeover_sec*1000
  after_trigger_margin_step = post_takeover_sec*1000
  extendingTriggerSteps <- triggerSteps[triggerSteps$Driver_Performance.inputs.trigger_ID==3,]
  
  for (i in length(extendingTriggerSteps)) {
    combined_data$Driver_Performance.inputs.trigger_ID[which(combined_data$design == extendingTriggerSteps$design[i] & combined_data$group == extendingTriggerSteps$group[i] & combined_data$scenario == extendingTriggerSteps$scenario[i] &  combined_data$STEP>= extendingTriggerSteps$triggerBeginSTEP[i] & combined_data$STEP <= extendingTriggerSteps$triggerBeginSTEP[i]+after_trigger_margin_step)] <- 3
  }
}
#rm(tempData)