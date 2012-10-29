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

echo -e "\nFor best results use High DPI and scan as Text.\n"
echo "Copying pdfs to $DTS_DIR/$TIME_DTS"
cp *.pdf $DTS_DIR/$TIME_DTS/
echo -e "Changing to directory $DTS_DIR/$TIME_DTS\n"
cd $DTS_DIR/$TIME_DTS
echo "Repace spaces with underscore in pdfs."
rename 's/ /_/' *.pdf
echo "Converting pdfs to tifs using ghostscript."
find . -maxdepth 1 -name '*.pdf' -exec gs -o {}%03d.tif -sDEVICE=tiffg4 -r720x720 -g6120x7920 {} \;
echo -e "\nUsing imagemagick trim to remove unscanned areas (assuming your scanned area is upper left) into .tif.trim."
find . -maxdepth 1 -name '*.pdf*.tif' -exec convert {} -trim {}.trim \;
echo "Removing untrimmed, conveterd tifs *.pdf*.tif"
rm *pdf*.tif
echo "Rename .pdf in *.tif.trim to _pdf_pg"
rename 's/\.pdf/_pdf_pg/' *.tif.trim
echo -e "\nOCRing with tesseract.  Ignoring any Cancelled repeat of length # due to Joined messages.\n"
find . -maxdepth 1 -name '*.tif.trim' -exec tesseract {} {} \;
echo -e "\nIgnoring any Cancelled repeat of length # due to Joined messages.\n"
echo "Renaming .tif.trim to .tif"
rename 's/\.tif\.trim/\.tif/' *.tif.trim
echo "Renaming tif.trim.txt to .ocr"
rename 's/\.tif\.trim\.txt/\.ocr/' *.tif.trim.txt

ocrcsv.sh
