#! /bin/bash
mv Linear\ Algebra.zip Linear\ Algebra.tmp
echo "Enter Zip Password : \n"
zip -er Linear\ Algebra.zip Linear\ Algebra
git add .
git commit
git push
rm -i Linear\ Algebra.tmp
