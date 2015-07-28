#-> Eddie Lu
if [ $# -le 0 ]; then
  echo "Error: Please provide file to process";
  exit 1;
fi

file=$1
newfile="sorted_$1"
node --harmony sortnew.js $1

if [ "$?" -ne "0" ]; then
  echo "Error updating new and completed terms: sortnew.js";
  exit 2;
fi

casperjs freesound_scraper.js $newfile

if [ "$?" -ne "0" ]; then
  echo "Error grabbing audio clips for new terms";
  exit 3;
fi

echo "Done! Finished processing $file!";
