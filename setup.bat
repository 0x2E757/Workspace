@echo off
setLocal enableDelayedExpansion

call code --version > nul 2>&1 && call :ensure_vscode_extensions_installed || echo. && echo ERROR: Visual Studio Code not installed.
call git --version > nul 2>&1 && call :ensure_template_installed || echo. && echo ERROR: Git not found ^(via git command^).
call g++ --version > nul 2>&1 && echo. && echo GCC found ^(via g++ command^). || echo. && echo ERROR: GCC not found ^(via g++ command^).
call gdb --version > nul 2>&1 && echo. && echo GDB found ^(via gdb command^). || echo. && echo WARNING: GDB not found ^(via gdb command^).
echo.
echo Press any key to end script...
pause > nul
exit /b 0

:ensure_vscode_extensions_installed
echo.
echo Visual Studio Code installed, ensuring extensions installed...
call :check_extension_installed ms-vscode.cpptools
call :check_extension_installed eamodio.gitlens
call :check_extension_installed spmeesseman.vscode-taskexplorer
exit /b 0

:check_extension_installed
echo.
echo Inspecting Visual Studio Code extensions to contain ^'%1^'...
call code --list-extensions | find "%1" > nul && echo Extensions ^'%1^' already installed. || call :install_extension %1
exit /b 0

:install_extension
call code --install-extension %1 2> nul | find /i "extension "
exit /b 0

:ensure_template_installed
echo. 
echo Git installed, cloning/updating template project...
if exist "template" (
    cd template
    call git pull origin main --quiet
    echo Done ^(via pull origin main^).
) else (
    call git clone "https://github.com/0x2E757/Template.git" template --quiet
    echo Done ^(via clone^).
)
exit /b 0
