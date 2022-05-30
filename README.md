# GPRO
An easy to use / install solution heavily based on OpenProject.

## Install
1. Clone the repo.
2. Go into the repo.
3. run ```$ make install```.
4. run ```$ gpro install```.

## Run
Whenever you need you can run ```$ gpro run```.

## Settings
Check the 'vars' section on the script to change settings.
```
...
# [Vars]
path="/var/lib/openproject"
# ↳ Getting the path of the script and then getting the directory of the script.
exposed_port="80"
# ↳ The port that the web server will be exposed on.
...
```

## Tested env.
Tested on:
  - Ubuntu 20.04
  - WSL 1
  - WSL 2

## Dependencies
- make
- docker.io
