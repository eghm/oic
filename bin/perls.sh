filename=$(basename "$1")
export FILENAME="${filename%.*}"
#echo "perl $OIC_HOME/bin/$2 -f=$1 > $FILENAME.$3.txt"
perl $OIC_HOME/bin/$2 -f=$1 > $FILENAME.$3.txt
