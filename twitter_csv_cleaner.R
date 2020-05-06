library(sqldf)
library(bit64)
library(data.table)

#JSON files obtained from the Twitter API must be flattened and converted to .csv. 
#For best results, use https://www.convertcsv.com/json-to-csv.htm

extension <- "csv"
#Directory with raw .csv files, e.g. "C:/my_csv_files/*." Replace dir with path; in Windows, use "/".
fileNames <- Sys.glob(paste("dir/*.",
                            extension, sep=""))

fileNumbers <- seq(fileNames)

for (fileNumber in fileNumbers){
  newfileName <- paste(sub(paste("\\.", sep = ""), "", fileNames[fileNumber]),
                       "-clean", ".csv", sep = "")
    tx <- paste(readLines(fileNames[fileNumber], encoding="UTF-8"), collapse="%%%")
  tx <-gsub("(*UCP)(*UTF)%%%([S|M|T|W|F]{1}[u|o|e|h|r|a]{1}[n|e|d|u|i|t]{1} [J|F|M|A|S|O|N|D]{1}[a|e|p|u|c|o]{1}[n|b|r|y|l|g|p|t|v|c]{1} \\d\\d \\d\\d:\\d\\d:\\d\\d \\+\\d{4} 20[0-9]{2})", "\n\\1", tx, ignore.case = FALSE, perl=TRUE, fixed=FALSE)
  tx <-gsub("%%%", "", tx, ignore.case = FALSE, perl=TRUE, fixed=FALSE)
  tx <-gsub(",user/name,user/screen_name,user/location,user/url,user/description,", ",username1,userscreen_name1,userlocation1,userurl1,userdescription1,", tx, ignore.case = FALSE, perl=TRUE, fixed=FALSE)
  tx <-gsub(",entities/media/0/media_url,", ",mediaurl,", tx, ignore.case = FALSE, perl=TRUE, fixed=FALSE)
  tx <-gsub(";", "", tx, ignore.case = FALSE, perl=TRUE, fixed=FALSE)
  tx_as_table <- fread(text = tx, header = TRUE, sep = ",", nrows = 501, stringsAsFactors = FALSE, fill = TRUE, select = 1:50)
  dfmediaurl <- sqldf('select created_at, text, id_str, in_reply_to_status_id, username1, userscreen_name1, userlocation1 from tx_as_table')
  write.table(x = dfmediaurl, file = newfileName, append = FALSE, quote = TRUE, sep = ";", row.names = FALSE, col.names = TRUE)
  
}

