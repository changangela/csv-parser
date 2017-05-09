# begin of processing
BEGIN {
	FS = ",";
	column = "[not found]";
}

# Assume the header row is within the first 10 rows
NR <= 10 {
	for (i = 1; i <= NF; ++i) {
		if (tolower(fieldName) == tolower($i)) {
			column = i;
			break;
		}	
	}
}

# end of processing
END {
	print column;
}
