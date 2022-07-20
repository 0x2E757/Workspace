@echo off
setLocal enableDelayedExpansion

cd /d "%~dp0"
set /p "projectName=Project name: "

if exist "!projectName!" (
	echo Error: Project "!projectName!" already exist!
	echo Press any key to end script...
	pause > nul
	exit /b 1
)

git clone ..\template "!projectName!" --quiet
cd "!projectName!"

rmdir /s /q .git
del README.md
del LICENSE

attrib +h .scripts
attrib +h .vscode

mkdir include

powershell -Command "(gc CMakeLists.txt) -replace 'template', '!projectName!' | Out-File -encoding UTF8 CMakeLists.txt"

git init --quiet
git add .
git commit -m "Initial commit" --quiet 2> nul || git -c user.name="Eric" -c user.email="0x2E757@gmail.com" commit -m "Initial commit" --quiet

echo Done!
exit /b 0
