# begin of processing
BEGIN {
	FS = ",";
	row = "[not found]";
}

# assume the header row is within the first 10 rows
NR <= 10 && row == "[not found]" {
	# check if all columns in row are non-empty
	isheaderrow = 1
	for (i = 1; i <= NF; ++i) {
		if ("" == $i) {
			isheaderrow = 0;
			break;
		}	
	}

	if (isheaderrow && NF == numfields) {
		row = NR;
	}
}

# end of processing
END {
	print row;
}
