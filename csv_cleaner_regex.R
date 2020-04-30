library(stringi)
library(stringr)
library(readr)
library(sqldf)
library(bit64)
library(data.table)
#When importing to Sheets: Select ";" as separator; Convert formats "No"
#Directory with .csv files
extension <- "csv"
fileNames <- Sys.glob(paste("C:/Users/u0126720/Documents/csv_test/*.",
                            extension, sep=""))
#Create a list of integers
fileNumbers <- seq(fileNames)


#Pipeline: 1. Add JSON to CSV converter; 2. Add FOR LOOP (w/ or w/ocatch-error) so as to process all files in one dir. 3. Test with output from different years.

for (fileNumber in fileNumbers){
  newfileName <- paste(sub(paste("\\.", sep = ""), "", fileNames[fileNumber]),
                         "new-", ".csv", sep = "")

  #tx <- paste(readLines("C:/Users/u0126720/Documents/csv_test/test.csv", encoding="UTF-8"), collapse="%%%")
  tx <- paste(readLines(fileNames[fileNumber], encoding="UTF-8"), collapse="%%%")
  tx <-gsub("(*UCP)(*UTF)%%%([S|M|T|W|F]{1}[u|o|e|h|r|a]{1}[n|e|d|u|i|t]{1} [J|F|M|A|S|O|N|D]{1}[a|e|p|u|c|o]{1}[n|b|r|y|l|g|p|t|v|c]{1} \\d\\d \\d\\d:\\d\\d:\\d\\d \\+\\d{4} 20[0-9]{2})", "\n\\1", tx, ignore.case = FALSE, perl=TRUE, fixed=FALSE)
  tx <-gsub("%%%", "", tx, ignore.case = FALSE, perl=TRUE, fixed=FALSE)
  tx <-gsub(",user/name,user/screen_name,user/location,user/url,user/description,", ",username1,userscreen_name1,userlocation1,userurl1,userdescription1,", tx, ignore.case = FALSE, perl=TRUE, fixed=FALSE)
  tx <-gsub(",entities/media/0/media_url,", ",mediaurl,", tx, ignore.case = FALSE, perl=TRUE, fixed=FALSE)
  tx <-gsub(";", "", tx, ignore.case = FALSE, perl=TRUE, fixed=FALSE)
  #tx <-gsub("\"{2,}", "\"", tx, ignore.case = FALSE, perl=TRUE, fixed=FALSE)
  #tx <-gsub("\"", "", tx, ignore.case = FALSE, perl=TRUE, fixed=FALSE)
  #tx <-gsub("^", "\"", tx, ignore.case = FALSE, perl=TRUE, fixed=FALSE)
  #tx <-gsub("$", "\"", tx, ignore.case = FALSE, perl=TRUE, fixed=FALSE)
  #tx <-gsub("(\\n)", "\"\\1\"", tx, ignore.case = FALSE, perl=TRUE, fixed=FALSE)
  #write_lines(tx, "C:/Users/u0126720/Documents/csv_test/one_line.csv")
  #Cambiando el input de fread de file a text funciona.s
  tablapiola <- fread(text = tx, header = TRUE, sep = ",", nrows = 501, stringsAsFactors = FALSE, fill = TRUE, select = 1:50)
  dfmediaurl <- sqldf('select created_at, text, id_str, in_reply_to_status_id, username1, userscreen_name1, userlocation1 from tablapiola')
  #Not sure these two are necessary; it might be a good idea to add similar lines for username and location.
  dfmediaurl$created_at  <- gsub("\"{2}", "\"", dfmediaurl$created_at)
  dfmediaurl$text  <- gsub("\"{2}", "\"", dfmediaurl$text)
  #write.table(x = dfmediaurl, file = "C:/Users/u0126720/Documents/csv_test/treated.csv", append = FALSE, quote = TRUE, sep = ";", row.names = FALSE, col.names = TRUE)
  write.table(x = dfmediaurl, file = newfileName, append = FALSE, quote = TRUE, sep = ";", row.names = FALSE, col.names = TRUE)

}

