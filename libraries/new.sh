#!/bin/sh

cd "${0%/*}"
read -p "Project name: " projectName

if [ -d "$projectName" ]; then
    echo Error: Project "$projectName" already exist!
    read -p "Press any key to end script..."
    exit 1
fi

git init "$projectName" -b master --quiet
cd "$projectName"
git pull ../../template --quiet
rm LICENSE
mkdir include

sed -i "s/template/$projectName/g" CMakeLists.txt
commitMessage="Updated project name in CMakeLists.txt"
git add .
git commit -m "$commitMessage" --quiet 2> /dev/null || git -c user.name="Eric" -c user.email="0x2E757@gmail.com" commit -m "$commitMessage" --quiet

echo Done!
exit 0
