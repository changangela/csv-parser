# csv-processor

## Usage

- number-of-fields: script returns the number of fields in the CSV file
- field-header-column: script returns the column position of the specified header string (case insensitive)
- field-header-row: script returns the row number of the header row in the CSV file
- get-type: script returns the value of the type corresponding to the specified key
- csv-quote: script replaces or trims line breaks within quotations and returns the generated file

  ```bash
    $ awk -f number-of-fields.awk "filename.csv"
    $ awk -v fieldName="header string" -f field-header-column.awk "filename.csv"
    $ awk -v numFields=[unsigned int] -f field-header-row.awk "filename.csv"
    $ awk -v key="key" -f get-type.awk
    $ awk -v del="deliminator" -f csv-quote "filename.csv" > "filename.csv"
  ```
