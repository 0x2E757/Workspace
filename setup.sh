#!/bin/sh

function ensure_vscode_extensions_installed() {
    echo
    echo Visual Studio Code installed, ensuring extensions installed...
    check_extension_installed ms-vscode.cpptools
    check_extension_installed eamodio.gitlens
    check_extension_installed spmeesseman.vscode-taskexplorer
}

function check_extension_installed() {
    echo
    echo Inspecting Visual Studio Code extensions to contain \'$1\'...
    code --list-extensions | grep "$1" > /dev/null && echo Extensions \'$1\' already installed. || install_extension $1
}

function install_extension() {
    code --install-extension $1 2> /dev/null | grep -i "extension "
}

function ensure_template_installed() {
    echo
    echo Git installed, cloning/updating template project...
    if [ -d "template" ]; then
        cd template
        git pull origin main --quiet
        echo Done \(via pull origin main\).
    else
        git clone "https://github.com/0x2E757/Template.git" template --quiet
        echo Done \(via clone\).
    fi
}

code --version > /dev/null 2>&1 && ensure_vscode_extensions_installed || (echo && echo ERROR: Visual Studio Code not installed.)
git --version > /dev/null 2>&1 && ensure_template_installed || (echo && echo ERROR: Git not found \(via git command\).)
g++ --version > /dev/null 2>&1 && echo && echo GCC found \(via g++ command\). || (echo && echo ERROR: GCC not found \(via g++ command\).)
gdb --version > /dev/null 2>&1 && echo && echo GDB found \(via gdb command\). || (echo && echo WARNING: GDB not found \(via gdb command\).)
echo
read -rep $'Press any key to end script...\n'
echo
exit 0
