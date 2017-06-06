# csv-suite

**CSV Suite** is a RFC 4180 compliant CSV parsing and encoding bash utility. Allows for cross directory conversion of files from CSV to JSON or XML.

## Installation
```bash
$ sudo apt-get install gawk
$ git clone http://github.com/changangela/csv-parser
$ cd csv-parser
```

## Usage

* ```nf``` returns the number of fields in the CSV file
* ```fc``` returns the column position of the specified header string (case insensitive)
* ```fr``` returns the row number of the header row in the CSV file
* ```xml``` parses entire CSV file and generates appropriate XML file
* ```json``` parses entire CSV file and generates appropriate JSON file
* ```qtrim``` trims line breaks within quotations and returns the generated file (required for awk line by line parsing)

## Conversion
- run ```./xml.sh``` for direct conversion to XML
- run ```./json.sh``` for direct conversion to JSON

#### Quotation trim

```bash
$ awk -f nf "filename.csv"
$ awk -v fieldName="header string" -f fc "filename.csv"
$ awk -v numFields=[unsigned int] -f fr "filename.csv"
$ awk -v del="deliminator" -f qtrim "filename.csv" > "fileoutname.csv"
```

#### XML
```bash
$ awk -f qtrim in.txt > processed.txt
$ hr=$(awk -f fr processed.txt)
$ awk -v headerRow=$hr -f xml processed.txt > out.xml
$ rm processed.txt
```
