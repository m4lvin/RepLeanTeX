#!/bin/bash

echo -n > clean.txt
echo -n > output.txt

printf "\nAsking for axioms of %s by writing this to pipe:\n" $1
printf "{ \"cmd\" : \"#print axioms %s \", \"env\" : 0 }\n" $1
printf "{ \"cmd\" : \"#print axioms %s \", \"env\" : 0 }\n\n" $1 > pipe

# give some time
sleep 0.3

printf "Reading output:\n"
cat output.txt

echo -n "\\verb|" > clean.txt
(cat output.txt | grep -a axioms | awk -F'[][]' '{print $2}' | tr -d '\n' ) >> clean.txt
echo -n "|" >> clean.txt

#cat clean.txt

printf "Done asking for axioms of %s.\n\n" $1
