BEGIN {
	print "<Items>"
}

{
	n = split($0, a, "[ \t]*[0-9]+[ \t]*:");

	for (i = 2; i <= n; ++i) {
		#trim
		gsub(/^[ \t]+|[ \t]+$/, "", a[i])
		print "\t<string>" a[i] "</string>"; 
	}

}

END {
	print "</Items>"
}