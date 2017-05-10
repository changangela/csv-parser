function validName(name) {
	# gsub("[^a-zA-Z0-9]+", "", name);
	
	ret = "";
	n = split(name, a, "[^a-zA-Z0-9]+");

	for (i = 1; i <= n; ++i) {
		if (a[i] == "") {
			continue;
		}
		if (ret == "") {
			ret = a[i];
		} else {
			ret = ret a[i];
		}
	}

	return ret;
}

function validDescription(description) {
	gsub("<", "[", description);
	gsub(">", "]", description);
	gsub("&", " and ", description);
	return description;
}

function validSize(size) {
	return size ~ /^[0-9]+$/;
}

function trim(str) {
	gsub(/^[ \t\n]+|[ \t\n]+$/, "", str);
	gsub(/^[^a-zA-Z0-9(]+|[^a-zA-Z0-9)]+$/, "", str)
	return str;
}

function alphaNumeric(str) {
	gsub("[^a-zA-Z0-9]+", "", str);
	return str;
}

function getType(key){
	ret = "[not found]";
	if (key == "e") {
		ret = "EnumField";
	} else if (key == "b") {
		ret = "BooleanField";
	} else if (key == "ui") {
		ret = "UnsignedIntField";
	} else if (key == "i") {
		ret = "SignedIntField";
	} else if (key == "d") {
		ret = "DataField";
	} else if (key == "a") {
		ret = "ArrayField";
	} else if (key == "dy") {
		ret = "DynamicField";
	} else if (key == "p") {
		ret = "PropertyField";
	} else if (key == "m") {
		ret = "MessageField";
	} else if (key == "s") {
		ret = "StringField";
	}
	return "\"" ret "\"";
}

function find(a, b) {
	return index(tolower(a), tolower(b));
}

function isEnum(description) {
	n = split(description, a, "[ \t\n]*[0-9]+[ \t\n]*:");
	if (n >= 3) {
		return 1;
	}
	return 0;
}

function getEnum(description) {
	print("\t\t\t<Items>")
	n = split(description, a, "[ \t\n]*[0-9]+[ \t\n]*:");

	for (i = 0; i <= n; ++i) {
		#trim
		a[i] = trim(a[i]);
		if (a[i] != "") {
			print "\t\t\t\t<string>" a[i] "</string>"; 
		}
	}
	print("\t\t\t</Items>")
}
function getKey(name, size, description) {
	
	# smart function that takes the size and description and returns an appropriate key value
	if (size == 1) {
		return "b";
	}

	# check if it is an enumeration
	if (isEnum(description)) {
		return "e";
	}

	if (find(description, "integer")) {
		return "i";
	}

	if (size > 64) {
		return "s";
	}

	if (find(description, "bit")) {
		return "d";
	}

	#hexadecimal encoding
	if (find(description, "0x")) {
		return "i";
	}

	if (find(description, "message")) {
		return "m";
	}

	if (size == 16 || size == 32) {
		return "i";
	}

	if (size == 8) {
		return "ui";
	}


	return "dy";


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
		
		#determine the column numbers that correspond to size, name, and description
		for (i = 1; i <= NF; ++i) {
			$i = alphaNumeric($i);
			if (sizeColumn == "" && (find($i, "nr") || find($i, "bits"))) {
				sizeColumn = i;
			} else if (descriptionColumn == "" && find($i, "description")) {
				descriptionColumn = i;
			} else if (nameColumn == "" && find($i, "name")) {
				nameColumn = i;
			}
		}

		if (sizeColumn != "" && descriptionColumn != "" && nameColumn != "") {
			print "<Message>";
			print "\t<Name>" validName(_NAME) "</Name>";
			print "\t<MIN>" _MIN "</MIN>";
			print "\t<Fields>"
		}
	} else {
		
		# do not skip by default
		skip = 0;
		
		# check that row is relevant
		if (alphaNumeric($(nameColumn - 1)) == "") {
			if (find($0, "total")) {
				skip = 1;
			} else {
				if (alphaNumeric($sizeColumn) == "") {
					skip = 1;
				}
				if (alphaNumeric($nameColumn) == "") {
					skip = 1;
				}
				if (!validSize($sizeColumn)) {
					skip = 1;
				}
			}
		}

		if (!skip) {
			#trim and format
			$nameColumn = validName($nameColumn);
			$sizeColumn = trim($sizeColumn);
			$descriptionColumn = validDescription(trim($descriptionColumn));

			# print the type		
			key = getKey($nameColumn, $sizeColumn, $descriptionColumn);
			print "\t\t<Field xsi:type=" getType(key) ">";

			# replace spaces with underscore for valid identifier
			print "\t\t\t<Name>" $nameColumn "</Name>";
			#if enumeration
			if (key == "e") {
				getEnum($descriptionColumn);
			}
			print "\t\t\t<Description>" $descriptionColumn "</Description>";
			print "\t\t\t<Size>" $sizeColumn "</Size>";
			print "\t\t</Field>";
		}
	}
}

END {
	if (sizeColumn != "" && descriptionColumn != "" && nameColumn != "" ) {
		print "\t</Fields>"
		print "</Message>"
	}
}