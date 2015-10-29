#
# builder.sh
#
# Copyright (c) 2015,
# Mooniak <hello@mooniak.com>
# Ayantha Randika <paarandika@gmail.com>
#
# Released under the GNU General Public License version 3 or later.
# See accompanying LICENSE file for details.

#!/bin/bash

cd ../sources/sfd

python ../../scripts/fontconvert StickNoBills-sinhala-0.sfd ../../sources --ufo
python ../../scripts/fontconvert StickNoBills-sinhala-1.sfd ../../sources --ufo
python ../../scripts/fontconvert StickNoBills-latin-1.sfd ../../sources --ufo
python ../../scripts/fontconvert StickNoBills-latin-0.sfd ../../sources --ufo
python ../../scripts/fontconvert StickNoBills-tamil-0.sfd ../../sources --ufo
python ../../scripts/fontconvert StickNoBills-tamil-1.sfd ../../sources --ufo

cd ../../scripts
python merger.py ../masters/StickNoBills-Regular.ufo ../sources/StickNoBills-sinhala-0.ufo ../sources/StickNoBills-latin-0.ufo ../sources/StickNoBills-tamil-0.ufo
python merger.py ../masters/StickNoBills-ExtraBold.ufo ../sources/StickNoBills-sinhala-1.ufo ../sources/StickNoBills-latin-1.ufo ../sources/StickNoBills-tamil-1.ufo

cd ../
python build.py

echo "Update the gh-pages branch? [y/n]"
res="n"
read -t 120 res

if [ "$res" = "y" ];
  then
  echo "Please DO NOT move/edit files till the process ends!"
  cp -a build ~
  git checkout gh-pages
  if [ $? -eq 0 ];
    then
    rm fonts/*
    mv ~/build/* fonts
    rm -r ~/build
    git add fonts/*
    git commit -m "Updated fonts"
    git push
    git checkout master
    echo "Done!:) gh-pages branch succsesffuly updated!"
  else
    echo "Failed!:( Could not update gh-pages branch! "
  fi
fi
echo "Build Finished!"
