function validXML(str) {
	# invalid characters are <, >, ", ', and &
	gsub("<", "[", str);
	gsub(">", "]", str);
	gsub("&", " + ", str);
	gsub("'", " ", str);
	return str;
}

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

function header() {
	# prints header of the xml encoding
	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
	print "<" _NAME ">";
}
function closer() {
	# prints closer of the xml encoding
	print "<\\" _NAME ">";

}
BEGIN {
	FS = ",";
	_NAME = "";
	skip = 0;
}

{
	if (NR <= headerRow - 1) {
		_NAME = _NAME $i;
	} else if (NR == headerRow) {
		# trim the NAME variable to be a valid xml tag
		_NAME = alphanumeric(_NAME);
		
		# print the XML header
		header()

		# populate the field headers array
		n = split($0, fieldheaders, FS);

		# trim and make valid
		for (i = 1; i <= n; ++i) {
			fieldheaders[i] = alphanumeric(fieldheaders[i]);
		}

	} else {
		
		# do not skip by default
		skip = 0;
		
		# check that row is relevant
		if (alphanumeric($0) == "") {
			# the row has no content
			skip = 1;
		}

		if (!skip) {
			print "\t<Field>"
			for (i = 1; i <= NF; ++i) {
				#trim and format
				$i = specialtrim($i);
				print "\t\t<"fieldheaders[i]">"
				print "\t\t\t"$i
				print "\t\t<\\"fieldheaders[i]">"
			}
			print "\t<\\Field>"
		}
	}
}

END {
	closer();
}
