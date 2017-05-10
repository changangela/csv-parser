function validName(name) {
	# gsub("[^a-zA-Z0-9]+", "", name);
	
	ret = "";
	n = split(name, a, "[^a-zA-Z0-9]+");

	for (i = 1; i <= n && i <= 4; ++i) {
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

function trim(str) {
	gsub(/^[ \t]+|[ \t]+$/, "", str);
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
	n = split(description, a, "[ \t]*[0-9]+[ \t]*:");
	if (n > 3) {
		return 1;
	}
	return 0;
}

function getEnum(description) {
	print("\t\t\t<Items>")
	n = split(description, a, "[ \t]*[0-9]+[ \t]*:");

	for (i = 2; i <= n; ++i) {
		#trim
		a[i] = trim(a[i]);
		print "\t\t\t\t<string>" a[i] "</string>"; 
	}
	print("\t\t\t<Items>")
}
function getKey(name, size, description) {
	
	# smart function that takes the size and description and returns an appropriate key value
	if (size == 1) {
		return "b";
	}

	if (find(description, "empty")) {
		return "dy";
	}

	if (find(description, "bit")) {
		return "d";
	}

	# check if it is an enumeration
	if (isEnum(description)) {
		return "e";
	}

	if (size == 32) {
		return "i";
	}

	if (size == 16 || size == 8) {
		return "ui";
	}


	if (size > 32) {
		return "s";
	}

	return "";


}
BEGIN {
	FS = ",";
	_MIN = 0;
	_NAME = "";

	print "<Message>";
}

{
	if (NR <= headerRow - 1) {
		_NAME = _NAME $i;
	} else if (NR == headerRow) {
		print "\t<Name>" validName(_NAME) "</Name>";
		
		#determine the column numbers that correspond to size, name, and description
		for (i = 1; i <= NF; ++i) {
			$i = alphaNumeric($i);
			if (tolower($i) == tolower("nrbits")) {
				sizeColumn = i;
			} else if (tolower($i) == tolower("description")) {
				descriptionColumn = i;
			} else if (tolower($i) == tolower("fieldname")) {
				nameColumn = i;
			}
		}
	} else if (NR == headerRow + 1) {
	} else if (NR == headerRow + 2) {
		print "\t<MIN>" 0 "</MIN>";
		print "\t<Fields>"
	} else {
		# check that row is relevant
		if (alphaNumeric($(nameColumn - 1)) != "" ) {
			#trim and format
			$nameColumn = validName($nameColumn);
			$sizeColumn = trim($sizeColumn);
			$descriptionColumn = trim($descriptionColumn);

			# print the type		
			key = getKey($nameColumn, $sizeColumn, $descriptionColumn);
			print "\t\t<Field xsi:type=" getType(key) ">";
			
			#if enumeration
			if (key == "e") {
				getEnum(description);
			}

			# replace spaces with underscore for valid identifier
			print "\t\t\t<Name>" $nameColumn "</Name>";
			print "\t\t\t<Description>" $descriptionColumn "</Description>";
			print "\t\t\t<Size>" $sizeColumn "</Size>";
			print "\t\t</Field>";
		}
	}
}

END {
	print "\t</Fields>"
	print "</Message>"
}
