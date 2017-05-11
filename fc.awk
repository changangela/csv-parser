# begin of processing
BEGIN {
	FS = ",";
	row = "[not found]";
}

# assume the header row is within the first 10 rows
NR <= 10 && row == "[not found]" {
	# check if all columns in row are non-empty
	isHeaderRow = 1
	for (i = 1; i <= NF; ++i) {
		if ("" == $i) {
			isHeaderRow = 0;
			break;
		}	
	}

	if (isHeaderRow && NF == numFields) {
		row = NR;
	}
}

# end of processing
END {
	print row;
}
