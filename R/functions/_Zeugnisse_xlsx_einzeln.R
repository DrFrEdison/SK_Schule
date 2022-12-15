Zeugniserstellung.xlsx.einzeln <- function( Klasse
                                            , Jahrgang
                                            , Pfad = sk$Pfad$home
                                            , Dummy.Zeugnisse = sk$Dummy$Zeugnisse){
  
  # Welche Klasse
  dat <- list()
  Klasse <- Klasse
  Klassenordner <- dir( paste0( Pfad, "/", Jahrgang, "/Klasse_", Klasse) )
  Klassenordner <- as.list( Klassenordner )
  names( Klassenordner ) <- unlist( Klassenordner )
  
  # Welche Schueler?
  setwd( paste0( Pfad, "/", Jahrgang, "/Klasse_", Klasse, "/", Klassenordner$Schueler))
  dat$xlsx <- read.xlsx(paste0( Jahrgang, "_", Klassenordner$Schueler, "_Klasse_", Klasse, ".xlsx"))
  dat$Schueler <- paste( dat$xlsx$Vorname, dat$xlsx$Name, sep = "_")
  dat$Schueler <- gsub(" ", "", dat$Schueler)
  
  # Erstelle Zeugnisse
  setwd( paste0( paste0( Pfad, "/", Jahrgang, "/Klasse_", Klasse), "/", Klassenordner$Zeugnisse))
  
  # Erstelle Reiter mit Schueler-Namen
  for(i in 1 : length( dat$Schueler )){
    
    if( length( dir( pattern = paste0( Jahrgang, "_Zeugnis_Klasse_", Klasse, "_", dat$Schueler[ i ], ".xlsx"))) == 1) next
    # Erstelle Excel-Workbook
    dat$wb <- createWorkbook( paste0( Jahrgang, "_", Klassenordner$Zeugnisse, "_Klasse_", Klasse))
    addWorksheet( dat$wb, dat$Schueler[ i ])
    
    dat$Zeugnissemod <- Dummy.Zeugnisse
    dat$Zeugnissemod[1 , ] <- c( dat$xlsx$Vorname[ i ], dat$xlsx$Name[ i ], "")
    dat$Zeugnissemod[2 , ] <- c( paste0("Jahrgang = ", Jahrgang), paste("Klasse", Klasse), "")
    
    writeData( wb = dat$wb
               , sheet = 1
               , x = dat$Zeugnissemod
               , colNames = F)
    
    setColWidths(wb = dat$wb
                 , sheet = 1
                 , cols = 1:2, widths = "auto")
    
    
    saveWorkbook(dat$wb
                 , paste0( Jahrgang, "_Zeugnis_Klasse_", Klasse, "_", dat$Schueler[ i ], ".xlsx")
                 , overwrite = F)
  }
  
  return( data.frame( Vorname = dat$xlsx$Vorname, Name = dat$xlsx$Name) )
}
