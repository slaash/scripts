#!/bin/bash

for ((i=0;i<10;i++));
do
	echo "for: $i"
done

#############################

i=0
while [ $i -lt 10 ];
do
	echo "while: $i"
	let i=i+1
done

#############################

i=0
until [ $i -eq 10 ];
do
	echo "until: $i"
	let i=i+1
done

#############################

echo "da o valoare pt i"
read i
if [ $i = 0 ]; then
	echo "if: $i=0"
else
	echo "if: $i!=0"
fi

#############################

function display {
	echo "func: $1"
}
for ((i=0;i<10;i++));
do
	display $i
done

#############################

i=1
cat psaux.sh|while read linie;
do
	echo "linia ${i}: ${linie}"
	let i=i+1
done

#############################

if test -d "tmp"
then
	echo "directorul tmp exista"
fi

#############################

if pgrep tcsh
then
	echo "tcsh ruleaza"
else
	echo "nu exista un proces cu numele asta"
fi

#############################

#!/bin/bash
for i in $( ls *.sh); do
        echo item: $i
done
