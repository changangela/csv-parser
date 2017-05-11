#!/bin/bash
awk -f qtrim in.txt > processed.txt
hr=$(awk -f fr processed.txt)
awk -v headerRow=$hr -f xml processed.txt > out.xml
rm processed.txt
