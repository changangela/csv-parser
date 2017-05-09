BEGIN {
	print "<Items>"
}

{
	# ignore the beginning
	$1 = "";

	# trim
	gsub(/^[ \t]+|[ \t]+$/, "", $0);
	print "\t<String>" $0 "</String>"; 
}

END {
	print "</Items>"
}
