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

git init "!projectName!" --quiet
cd "!projectName!"
git pull ..\..\template --quiet
del LICENSE
mkdir include
attrib +h .scripts
attrib +h .vscode

powershell -Command "(gc CMakeLists.txt) -replace 'template', '!projectName!' | Out-File -encoding UTF8 CMakeLists.txt"
set "commitMessage=Updated project name in CMakeLists.txt"
git add .
git commit -m "!commitMessage!" --quiet 2> nul || git -c user.name="Eric" -c user.email="0x2E757@gmail.com" commit -m "!commitMessage!" --quiet

echo Done!
exit /b 0
