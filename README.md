# GPRO
An easy to use / install solution heavily based on OpenProject.

## Install
0. Install Docker for your OS (Check [Docker's documentation](https://docs.docker.com/) for more help)
1. Clone the repo.
2. Go into the repo.
3. Run ```$ make install```.
4. Run ```$ gpro install```.
5. Wait until the service is up (It may take a while).
6. Connect on http://localhost (Default port is 80)
7. Connect to admin's account with default credentials: admin / admin.
8. Change admin's password when asked for.
9. Enjoy !

## Run / Stop
Whenever you need you can run ```$ gpro run```.

You can then run ```$ gpro kill```.

## Settings
Check the 'vars' section on the script to change settings.
```
...
# [Vars]
path="/var/lib/openproject"
# ↳ Getting the path of the script and then getting the directory of the script.
exposed_port="80"
# ↳ The port that the web server will be exposed on.
docker_name="openproject"
# ↳ The name of the docker container.
hostname="openproject.gpro.com"
# ↳ The hostname of the docker container.
...
```

## Commands
install: ```$ gpro install``` - Install required directories and PKGs.

run: ```$ gpro run``` - Run Open Project's Docker.

help: ```$ gpro help``` - Display GPRO's list of command.

kill: ```$ gpro kill``` - Kill Open Project's Docker.

state: ```$ gpro state``` - Display Open Project's status.

## Update
1. Pull the repo
2. Just re-run ```$ make install```.

# OpenProject & Docker

## Help
If you have any OpenProject related issue you can check [OpenProject's documentation](https://www.openproject.org/docs/getting-started/openproject-introduction/)
If you have any Docker related issue refere to the [documentation of docker](https://docs.docker.com/)

## Docker env.
Tested on:
  - [Ubuntu 20.04](https://docs.docker.com/engine/install/ubuntu/)
  - [WSL 2](https://docs.docker.com/desktop/windows/wsl/)

# Dependencies
- make
- docker.io
