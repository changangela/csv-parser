function validName(name) {
	ret = "";
	n = split(name, a, "[^a-zA-Z0-9_]+");

	for (i = 0; i < n; ++i) {
		if (a[i] == "") {
			continue;
		}
		if (ret == "") {
			ret = a[i];
		} else {
			ret = ret " " a[i];
		}
	}
	return ret;
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
	} else {
		ret = "StringField";
	}
	return "\"" ret "\"";
}

BEGIN {
	DELIMINATOR = "_";
	FS = ",";
	_MIN = 0;
	_NAME = "";

	headerRow = 2;
	nameColumn = 2;
	sizeColumn = 4
	descriptionColumn = 6;
	print "<Message>";
}

{
	if (NR <= 1) {
		_NAME = $i;
		print "\t<Name>" _NAME "</Name>";
	} else if (NR == headerRow) {

	} else if (NR == headerRow + 1) {
		_MIN = $descriptionColumn;
	} else if (NR == headerRow + 2) {
		_MIN = _Min $descriptionColumn;
		print "\t<MIN>" _MIN "</MIN>";
		print "\t<Fields>"
	} else {
		# print the type
		print "\t\t<Field xsi:type=" getType($descriptionColumn) ">"
		
		# replace spaces with underscore for valid identifier
		gsub(" ", "_", $nameColumn)
		print "\t\t\t<Name>" $nameColumn "</Name>"
		print "\t\t\t<Size>" $sizeColumn "</Size>"
		print "\t\t</Field>"
	}
}

END {
	print "\t</Fields>"
	print "</Message>"
}
