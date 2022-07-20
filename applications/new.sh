#!/bin/sh

cd "${0%/*}"
read -p "Project name: " projectName

if [ -d "$projectName" ]; then
    echo Error: Project "$projectName" already exist!
    read -p "Press any key to end script..."
    exit 1
fi

git clone ../template "$projectName" --quiet
cd "$projectName"

rm -rf .git
rm README.md
rm LICENSE

mkdir include

sed -i "s/template/$projectName/g" CMakeLists.txt

git init --quiet
git add .
git commit -m "Initial commit" --quiet 2> /dev/null || git -c user.name="Eric" -c user.email="0x2E757@gmail.com" commit -m "Initial commit" --quiet

echo Done!
exit 0
