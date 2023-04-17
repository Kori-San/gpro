# GPRO
An easy to use / install solution heavily based on OpenProject.

## Install
1. Install Docker for your OS (Check [Docker's documentation](https://docs.docker.com/) for more help)
2. Clone the repo and access it.
3. Check / Change settings by checking the vars section of 'gpro.sh'
4. Run ```$ make install```.
> Note that you need root access to install gpro as a command. You can gain root access either by using '$ sudo' or by using a user in the 'root' group.
5. Run ```$ gpro install```.
6. Run ```$ gpro run```.
7. Wait until the service is up (It may take a while).
   > Execute '$ docker logs openproject -f' if you want to know the status of your container
8. Connect on http://localhost:8080 (Default port is 8080)
9. Connect to admin's account with default credentials: admin / admin.
10. Change admin's password when asked for.
11. Enjoy !

## Run / Stop
Whenever you need to make your server operation, you can run ```$ gpro run```.

You can then run ```$ gpro kill``` to stop it.

## Update
1. Pull the repo
2. Just re-run ```$ make install```.

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

### ⚠️ **WARNING** Everytime you change a parameter be sure to re-run the ```$ make install``` command and if you change 'exposed_port' run ```$ gpro rm``` before re-running the service.

## Commands
install: ```$ gpro install``` - Install required directories and PKGs.

run: ```$ gpro run``` - Run Open Project's Docker.

help: ```$ gpro help``` - Display GPRO's list of command.

kill: ```$ gpro kill``` - Kill Open Project's Docker.

rm: ```$ gpro rm``` - Remove Open Project's Docker, it does not remove data !

state: ```$ gpro status``` - Display Open Project's status.

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

Kori-San 2022. If you enjoyed GPRO please check ['$ baley'](https://github.com/Kori-San/baley) which is a command line tool too, but for Ansible's AWX!
