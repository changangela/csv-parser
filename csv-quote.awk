BEGIN {
	RS = "\"";
}

NR % 2 == 0{
	gsub(/\n/, "");
}

{
	printf("%s", $0);
}
