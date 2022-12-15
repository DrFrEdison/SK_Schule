# this.path Paket ####
if( !"this.path" %in% installed.packages()[,"Package"]) install.packages( "this.path")
library(this.path)

# setwd
setwd( this.dir() )

sk <- list()
sk$Jahrgang <- "2022_2023"

source( "main.R" )

Klasse = "5"
Zeugniserstellung.xlsx.zusammen( Klasse = Klasse
                                 , Jahrgang = Jahrgang)

Klasse = "6"
Zeugniserstellung.xlsx.einzeln( Klasse = Klasse
                                , Jahrgang = Jahrgang)

Klasse = "7"
Zeugniserstellung.txt.einzeln( Klasse = Klasse
                               , Jahrgang = Jahrgang)
