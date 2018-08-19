#! /bin/bash
mv Linear\ Algebra.zip Linear\ Algebra.tmp
echo "Enter Zip Password :"
zip -er Linear\ Algebra.zip Linear\ Algebra
echo "Finish Zip !"
git add .
git commit
git push
rm -i Linear\ Algebra.tmp
