#! /bin/bash
mv Linear\ Algebra.zip Linear\ Algebra.tmp

echo "Enter Zip Password"
zip -e -r Linear\ Algebra.zip Linear\ Algebra

if [[ $? -ne 0 ]];then
    mv Linear\ Algebra.tmp Linear\ Algebra.zip; exit 1
fi

echo "Finish Zip !"

git add .
git commit

if [[ $? -ne 0 ]];then
    rm Linear\ Algebra.zip;
    mv Linear\ Algebra.tmp Linear\ Algebra.zip;
    exit 1;
fi

git push
if [[ $? -ne 0 ]];then
    rm Linear\ Algebra.zip;
    mv Linear\ Algebra.tmp Linear\ Algebra.zip;
    exit 1;
fi

rm -i Linear\ Algebra.tmp
