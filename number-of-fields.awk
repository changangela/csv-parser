# begin of processing
BEGIN {
	# setting the file's field seperator
	FS = ",";	
}

# end of processing
END {
	print NF;
}
