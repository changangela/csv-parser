# csv-processor

## Usage

### Number of fields
Script returns the number of fields in the CSV file.
  ```bash
    $ awk -f number-of-fields.awk "filename.csv"
  ```
### Field header column
Script returns the column position of the specified header string (case insensitive).
  ```bash
    $ awk -v fieldName="header string" -f field-header-column.awk "filename.csv"
  ```
### Field header row
Script returns the row number of the header row in the the CSV file.
  ```bash
    $ awk -v numFields=[unsigned int] -f field-header-row.awk "filename.csv"
  ```
