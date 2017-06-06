function trim(str) {
  # regex to remove all leading and trailing whitespace
  gsub(/^[ \t\n\r]+|[ \t\n\r]+$/, "", str);
  return str;
}

function specialtrim(str) {
  # regex to remove all non alphanumeric trailing and leading whitespace
  gsub(/^[^a-zA-Z0-9(]+|[^a-zA-Z0-9)]+$/, "", str);
  return str;
}

function alphanumeric(str) {
  # regex to remove all non alphanumeric characters
  gsub("[^a-zA-Z0-9]+", "", str);
  return str;
}


function find(a, b) {
  # if a contains b
  return index(tolower(a), tolower(b));
}

BEGIN{
  FS=","

  for (j = 1; j < headerrow; ++j) {
    getline;
    _NAME = _NAME $0;
  }

  # grab headers
  getline;
  for (i = 1; i <= NF; ++i) {
    headerNames[i] = alphanumeric($i);
  }

}

{
  printf ("%s=%d\n", alphanumeric($fieldcolumn), "0")
}

END{
  # last row contains comma
  # must create null item after it

}
