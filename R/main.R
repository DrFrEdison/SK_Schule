list.of.packages <- c("openxlsx", "this.path")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(openxlsx)
library(this.path)

# sk ####
sk$Pfad$home <- this.dir()
setwd( sk$Pfad$home )
setwd("..")
sk$Pfad$home <- getwd()

# Jahrgang ####
sk$Jahrgang <- "2022_2023"
dir.create( paste0(sk$Pfad$home, sk$Jahrgang), showWarnings = F)

# Dummy ####
sk$Pfad$Dummy <- paste0(sk$Pfad$home, "/Dummy/")
sk$Dummy$Zeugnisse <- dir( path = sk$Pfad$Dummy, pattern = "Zeugnisse.xlsx")
sk$Dummy$Zeugnisse <- grep( sk$Jahrgang, sk$Dummy$Zeugnisse, value = T)
sk$Dummy$Zeugnisse <- read.xlsx( paste0( sk$Pfad$Dummy, sk$Dummy$Zeugnisse ), colNames = F, skipEmptyRows = F)

# functions ####
sk$Pfad$R <- paste0( sk$Pfad$home, "/R/")
sk$Pfad$Rfunctions <- paste0( sk$Pfad$R, "functions/")

source( paste0( sk$Pfad$Rfunctions, "/_Zeugnisse_xlsx_zusammen.R"))
source( paste0( sk$Pfad$Rfunctions, "/_Zeugnisse_xlsx_einzeln.R"))
source( paste0( sk$Pfad$Rfunctions, "/_Zeugnisse_txt_einzeln.R"))

