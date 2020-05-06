# Twitter .csv Data Cleaner for Linguistics
An R Script that cleans Twitter API output data for easier manipulation and linguistic annotation. Output .csv files can readily be imported to Google Sheets or similar spreadsheet programs. 

Instructions

Data mined from the Twitter APIs in JSON files contains thousands of columns, most of which are empty or irrelevant. This script keeps only the most important columns, namely:``` created_at (date), text (of Tweet), id_str, in_reply_to_status_id, username, userscreen_name, userlocation```. Text fields such as Tweets, screen names and location information are UTF-8, so non-English characters and emoji are shown as in the original. The desired output columns can be modified in the script, by adding them to line 25.

Note: This script doesn't convert the API's JSON files to .csv files. Before running this script, the JSON files must be flattened and converted to .csv. For best results, use https://www.convertcsv.com/json-to-csv.htm (with encoding UTF-8).

Once you have your raw .csv files in one directory, edit line 10 of the R script by substituting the directory with raw .csv files. In Windows, use forward slashes: e.g. "C:/my_csv_files/*."

The output for each processed .csv file is another .csv file with fewer columns and ready to be imported into Google Sheets for further manipulation, i.e. corpus linguistics annotation. See sample files "sample.json", "sample.csv" & "samplecsv-clean.csv". The JSON file was obtained using searchtweets.py Python wrapper for the Twitter API. 

Importing to Google Sheets:
Create a blank sheet.
Go to File > Import > Upload > Select file
Then select the desired Import location; under Separator type select Custom: and type in ";" (no quotes); and select "No" for Convert text to numbers, dates, and formulas.

Please address comments and questions to pedro.diazlammertyn@kuleuven.be.
