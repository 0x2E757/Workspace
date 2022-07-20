# C++ workspaces simple template

This is a simple C++ workspaces template that is made to use with minimal setup and create projects that will be built using Visual Studio Code, CMake and GNU build tools.

## Requirements

Must be installed:
* Visual Studio Code (and available from shell via `code` command)
* Git (and available from shell via `git` command)
* GCC and GDB (and available from shell via `g++` and `gdb` commands)

## Setup

In the root directory is a setup shell script that will:
* Install C/C++, GitLens and Task Explorer extensions to Visual Studio Code
* Clone/update [template](https://github.com/0x2E757/Template) project to the root directory
* Ensure `g++` and `gdb` commands working

## Creating a project

Use shell script in applications/libraries directory to make a copy of the template project. It will also automatically update project name, create include directory, remove initial LICENSE and README files, and make initial commit. Template (in the root directory) contains it's own README where you can read how to work with it.