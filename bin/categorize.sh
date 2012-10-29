filename=$(basename "$1")
export FILENAME="${filename%.*}"
for f in $OIC_HOME/categories/*.txt;
do
    catname=$(basename "$f")
    export CATNAME="${catname%.*}"
    #echo "perl $OIC_HOME/bin/categorize.pl -f=$1 -l=$OIC_HOME/categories/$CATNAME.txt > $FILENAME.cat.$CATNAME.txt"
    perl $OIC_HOME/bin/categorize.pl -f=$1 -l=$OIC_HOME/categories/$CATNAME.txt > $FILENAME.cat.$CATNAME.txt
done
# summarize the category results, the one with the most number of lines in it's file wins, others are deleted
# TODO normalization
#echo "                    wc -l $FILENAME.cat.*.txt | sort | grep -v total | cut -c 10-"
wc -l $FILENAME.cat.*.txt | sort | grep -v total | cut -c 10- > $FILENAME.cat-wc.txt
sed '$d' $FILENAME.cat-wc.txt > $FILENAME.cat-rm.txt
for f in $(cat $FILENAME.cat-rm.txt) ; do 
  rm $f
done
rm $FILENAME.cat-wc.txt
rm $FILENAME.cat-rm.txt
# remove dup keywords from the category file
#echo "           find ./ -name '$FILENAME.cat.*.txt' -exec uniq {} > {}.uniq \;"
#find ./ -name '$FILENAME.cat.*.txt' -exec uniq {} > {}.uniq \;
#find ./ -name '$FILENAME.cat.*.txt' -exec rm {}  \;
#rename 's/\.cat//' $FILENAME.cat.*
#rename 's/\.uniq//' $FILENAME.*.txt.uniq

# remove empty files
find ./ -empty -exec rm {} \;
