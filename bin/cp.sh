#echo "cp.sh"
filename=$(basename "$1")
export FILENAME="${filename%.*}"
export UNDERSCORE_FILENAME=_$FILENAME
export LINKNAME=$(head -n 1 $FILENAME.csv.txt)
cp $FILENAME.csv $LINKNAME$UNDERSCORE_FILENAME.csv
cp $FILENAME.tif $LINKNAME$UNDERSCORE_FILENAME.tif
cp $FILENAME.txt $LINKNAME$UNDERSCORE_FILENAME.txt
