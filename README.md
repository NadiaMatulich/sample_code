# Sample

This exercise sets out to retrieve, clean and plot national accounts data for South Africa.

Four files are included in the code folder:

- reading_econdata.R uses the EconData portal by Codera [https://www.econdata.co.za](see here for more) to read in data as well as an excel document in the data folder. The framework is provided by econdata, however, it provides the data as a large list, however, I have written the function to convert the data to a data frame. 

- graph_theme.R specifies colours and some preferences for graphing. These are some of my graphing preferences that I found myself using when making graphs (minimalist, very clean), so it has just been written as a theme I can call on when needed. A colour scheme is also specified here.

- data_wrangling.R joins the national accounts data to the inflation data, and performs some operations:
  - Convert the inflation data from monthly to quarterly
  - Calculates annual growth rates
  - Calculates the proportions that consumption, government spending, investment and net exports contribute to GDP.

- graphing.R imports and then plots this data, and the plots are imported and shown in the sample_readme. For the "clean" document, please see the pdf, and for the code, please see the .rmd file. 

(Please note, my .Renviron file contains my login credentials to Econdata that makes this run but that document has been placed in the gitignore)


