# begin of processing
BEGIN {
	FS = ",";
	row = "[not found]"
}

# assume the header row is within the first 10 rows
# assume the header row can be incomplete

NR <= 10 && row == "[not found]" {
	# check if all columns in row are non-empty
	isHeaderRow = 3
	for (i = 1; i <= NF; ++i) {
		if ("" == $i) {
			isHeaderRow = isHeaderRow - 1;
			if (!isHeaderRow) {
				break;
			}
		}	
	}

	if (isHeaderRow) {
		row = NR;
	}
}

# end of processing
END {
	print row;
}
