## Testing HTML Generated From Atom Markdown

In the hopes that I will blog more in 2018, I've been looking for ways to generate HTML more efficiently.  After submitting an assignment in class where I used Jupyter Markdown to write some stuff, my teacher recommended that I look into using Atom.io instead.  So far, so good.

### Main Goals:
- HTML is easilly generated from within Markdown editor
- Generated HTML is simple and clean
- Formatting is consistent with how I generally use Markdown in Jupyter
- Code blocks look decent

#### R Code Sample
```
library(sqldf)
library(tidyverse)
require(data.table)

# Load the 3 CSV files in R using the fread function from data.table package.
address <- fread("Address.csv")
business_entity_address <- fread("BusinessEntityAddress.csv")
employee <- fread("Employee.csv")

# Assume the 3 files are database tables and write a SQL query to join all the tables together
# and filters the data for Job Titles that start with the word 'Research'
sql_query <- ("SELECT b.BusinessEntityID, e.LoginID, e.JobTitle, a.City
              FROM business_entity_address b
              INNER JOIN employee e
              ON b.BusinessEntityID = e.BusinessEntityID
              INNER JOIN address a
              ON b.AddressID = a.AddressID
              WHERE e.JobTitle like 'Research%';")

# Use the sqldf package to run the sql from the step above.
results <- sqldf(sql_query)
```
So to sum it up, this seems to work pretty well and I'm looking forward to posting more regularly.
