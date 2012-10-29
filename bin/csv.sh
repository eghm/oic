#echo "csv.sh"
filename=$(basename "$1")
export FILENAME="${filename%.*}"
for f in $FILENAME.cat.*; # should only be the one category but need to get the name of it
do
	export DATE=$(head -n 1 $FILENAME.dates.txt)
	export DOLLARS=$(head -n 1 $FILENAME.dollars.txt)
	perl $OIC_HOME/bin/regexCategory.pl -i=$f > $FILENAME.cat.txt
	export CAT=$(head -n 1 $FILENAME.cat.txt)
	echo "$DATE,$CAT,$DOLLARS" > $FILENAME.csv
	rm $FILENAME.cat.txt
	perl $OIC_HOME/bin/csv2filename.pl -f=$FILENAME.csv > $FILENAME.csv.txt
done

