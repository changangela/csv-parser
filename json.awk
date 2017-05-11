function trim(str) {
  # regex to remove all leading and trailing whitespace
  gsub(/^[ \t\n\r]+|[ \t\n\r]+$/, "", str);
  return str;
}

function specialTrim(str) {
  # regex to remove all non alphanumeric trailing and leading whitespace
  gsub(/^[^a-zA-Z0-9(]+|[^a-zA-Z0-9)]+$/, "", str);
  return str;
}

function alphaNumeric(str) {
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

  for (j = 1; j < headerRow; ++j) {
    getline;
    _NAME = _NAME $0;
  }

  # grab headers
  getline;
  for (i = 1; i <= NF; ++i) {
    headerNames[i] = alphaNumeric($i);
  }

  print "data = {"
}

{
  printf ("  %s:{", $1)
  
  for(i = 2; i <= NF; ++i) {
    printf ("'%s':%d%s", headerNames[i], $i,(i == NF ? "" : ","))
  }

  print "},"
}

END{
  # last row contains comma
  # must create null item after it
  print "  null:{}\n}"

}
