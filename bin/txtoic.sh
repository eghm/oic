cd ~/Documents/Scanned

if [ -z "$OIC_HOME" ]
then
    echo -e "\nenv OIC_HOME is not set!  Exiting.\n"
    exit
fi
export DTS_DIR=$(date +%Y/%m/%d)
export TIME_DTS=$(date +%H%M)
if [ -e $DTS_DIR/$TIME_DTS ]
then
    echo -e "\n$DTS_DIR/$TIME_DTS exists! Exiting.\n"
    exit
fi
mkdir -p $DTS_DIR/$TIME_DTS

echo "Copying txts to $DTS_DIR/$TIME_DTS"
cp *.txt $DTS_DIR/$TIME_DTS/
echo -e "Changing to directory $DTS_DIR/$TIME_DTS\n"
cd $DTS_DIR/$TIME_DTS
echo "Repace spaces with underscore in txts."
rename 's/ /_/' *.txt
echo "Renaming .txt to .ocr"
rename 's/\.txt/\.ocr/' *.txt

ocrcvs.sh
