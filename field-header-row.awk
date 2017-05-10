# begin of processing
BEGIN {
	FS = ",";
	row = "[not found]"
}

# assume the header row is within the first 10 rows
NR <= 10 && row == "[not found]" {
	# check if row has more than 1 non empty
	count = 0;
	for (i = 1; i <= NF; ++i) {
		if ("" != $i) {
			count = count + 1;
		}
	}

	if (count > 3) {
		row = NR;
	}
}

# end of processing
END {
	print row;
}