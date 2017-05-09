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
	} else if (key == "s") {
		ret = "StringField";
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
	}
	return ret;
}

BEGIN {
	print getType(key)
}
