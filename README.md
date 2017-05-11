# csv-suite

## Usage

* __nf__ returns the number of fields in the CSV file
* __fc__ returns the column position of the specified header string (case insensitive)
* __fr__ returns the row number of the header row in the CSV file
* __xml__ parses entire csv file and generates appropriate xml file
* __qtrim__ trims line breaks within quotations and returns the generated file (required for awk line by line parsing)
  ```bash
    $ awk -f nf "filename.csv"
    $ awk -v fieldName="header string" -f fc "filename.csv"
    $ awk -v numFields=[unsigned int] -f fr "filename.csv"
    $ awk -v del="deliminator" -f qtrim "filename.csv" > "fileoutname.csv"
  ```
- run ```./convert.sh``` 
  ```bash
  $ awk -f qtrim in.txt > processed.txt
  $ hr=$(awk -f fr processed.txt)
  $ awk -v headerRow=$hr -f xml processed.txt > out.xml
  $ rm processed.txt
  ```
