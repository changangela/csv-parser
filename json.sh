#!/bin/bash
awk -f qtrim in.txt > processed.txt
hr=$(awk -f fr processed.txt)
awk -v headerRow=$hr -f json processed.txt > out.json
rm processed.txt
