BEGIN {
	RS = "\"";
}

NR % 2 == 0 {
	gsub(/[\n\r]/, " ");
}

{
	printf("%s%s", $0, "\t");
}
