Zeugniserstellung.txt.einzeln <- function( Klasse
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
  dat$Zeugnissemod <- Dummy.Zeugnisse
  dat$Zeugnissemod <- dat$Zeugnissemod[ -c(1:3) , ]
  
  for(i in 1 : length( dat$Schueler)){
    
    setwd( paste0( paste0( Pfad, "/", Jahrgang, "/Klasse_", Klasse), "/", Klassenordner$Zeugnisse))
    dir.create( dat$Schueler[ i ] )
    setwd( paste0( "./", dat$Schueler[ i ]))
    
    for(j in 1 : nrow( dat$Zeugnissemod )){
      
      write.table( dat$Zeugnissemod[ j , "X3"]
                   , paste0( formatC(j, digits = 2, width = 2, flag = "0")
                             , "_"
                             , dat$Zeugnissemod[ j , "X1"]
                             , "_"
                             , dat$Zeugnissemod[ j , "X2"]
                             , ".txt")
                   , row.names = F
                   , col.names = F)
    }
    
  }
  return( data.frame( Vorname = dat$xlsx$Vorname, Name = dat$xlsx$Name) )
}
