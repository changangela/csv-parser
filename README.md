# csv-processor

## Usage

Number of fields
- Script returns the number of fields in the CSV file.
  ```bash
    $ awk -f number-of-fields.awk "filename.csv"
  ```
Field header column
- Script returns the column position of the specified header string (case insensitive).
  ```bash
    $ awk -v fieldName="header string" -f number-of-fields.awk "filename.csv"
  ```
