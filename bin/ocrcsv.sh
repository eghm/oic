# txt files to process should have an extension of .ocr
# TODO cleanup multi page tifs
echo "perls.sh {} regexEmail.pl email"
find . -maxdepth 1 -name '*.ocr' -exec perls.sh {} regexEmail.pl email \;
echo "perls.sh {} regexDates.pl dates"
find . -maxdepth 1 -name '*.ocr' -exec perls.sh {} regexDates.pl dates \;
#TODO check we have the largest value
echo "perls.sh {} regexDollars.pl dollars"
find . -maxdepth 1 -name '*.ocr' -exec perls.sh {} regexDollars.pl dollars \;
echo "categorize.sh {}"
find . -maxdepth 1 -name '*.ocr' -exec categorize.sh {} \;
echo -e "\ncsv.sh {} Some head: No such file or directory are to be expected."
find . -maxdepth 1 -name '*.ocr' -exec csv.sh {}  \;
echo "Renaming .ocr to .txt"
rename 's/\.ocr/\.txt/' *.ocr
echo "cp.sh {}"
find . -maxdepth 1 -name '*.csv' -exec cp.sh {} \;