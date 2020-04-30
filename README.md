# Twitter-Data-Cleaner
An R Script that cleans Twitter API output data for easier manipulation and annotation, especially for linguistics purposes.

Instructions

Data mined from the Twitter APIs in JSON files contains thousands of columns. T
This script keeps only the most important columns, namely: date, text, username, userlocation, in_reply_to, etc.
The output is a slimmer ```.csv``` file that can be readily opened in Google Sheets or Microsoft Excel for further manipulation. 

Note: This script doesn't convert the API's ```JSON``` files to ```.csv``` files. Before running this script, the JSON files must be converted to .csv manually, e.g. via convertcsv.com (with encoding UTF-8).

