#!/bin/bash

##############
# Init

# [Vars]
path="/var/lib/openproject"
# ↳ Getting the path of the script and then getting the directory of the script.
exposed_port="80"
# ↳ The port that the web server will be exposed on.
docker_name="openproject"
# ↳ The name of the docker container.
hostname="openproject.gpro.com"
# ↳ The hostname of the docker container.

##############
# Functions

# -> The func checks if a package is installed. If it is not installed, it will install it.
pkg_check(){
    if dpkg -s "${1}" 1> /dev/null ; then
        printf "📦 '$ '%s' found, skipping install...\n\n" "${1}"
    else
        printf "📦 '$ '%s' not found, installing '%s'...\n\n" "${1}" "${1}"
        apt-get install -q -y "${1}" 1> /dev/null
    fi
}

error_print(){
    >&2 echo -e "gpro:" "${1}"
    Help
    exit 1
}

Help(){
    echo "$ gpro install                            # Install required directories and PKGs."
    echo "$ gpro run                                # Run Open Project's Docker."
    echo "$ gpro help                               # Display GPRO's list of command."
    echo "$ gpro kill                               # Kill Open Project's Docker."
    echo "$ gpro status                             # Display Open Project's status."
}

##############
# Main

# -> Checking if the first argument is "install" and if the number of arguments is 1. If it is, it will
#    install the required packages and check if the directories are created. If not, it will create them.
if [ "${1,,}" == "install" ]; then
  if [ "${#}" -eq "1" ]; then
    # ~> Checking if the user is root. If it is not, it will ask the user if he wants to continue. If the
    #    user does not want to continue, it will exit the script.
    if [ "$(whoami)" != "root" ]; then
      printf "📌 The following installation might requires root privileges (ie. for package installation).\n"
      printf "Are you sure you want to continue? [y/N]\n"
      read -r answer
      if [ "${answer,,}" != "y" ]; then
        exit 1
      fi
    fi
    # ~> PKG Check
    apt-get update -y > /dev/null
    pkgs=("docker.io")
    for package in "${pkgs[@]}"; do
      pkg_check "${package}"
    done

    # ~> Check Dir
    if [ ! -d "${path}/pgdata" ] && [ ! -d "${path}/assets" ] ; then
      printf "📂 Directory '%s' or '%s' was not found\n\n" "${path}/pgdata" "${path}/assets"
      mkdir -p ${path}/{pgdata,assets} || error_print "Can't create folder on ${path}/pgdata or ${path}/assets"
      printf "📂 Directory '%s' and '%s' were created\n" "${path}/pgdata" "${path}/assets"
    else
      printf "📂 Directory '%s' and '%s' were found\n" "${path}/pgdata" "${path}/assets"
    fi
  # ~> Checking if the number of arguments is 1. If it is not, it will print an error message.
  else
    error_print "Too many arguments"
  fi
# -> Checking if the first argument is "run" and if the number of arguments is 1. If it is, it will
#    run the docker. If not, it will print an error message.
elif [ "${1,,}" == "run" ]; then
  if [ "${#}" -eq "1" ]; then
    if docker inspect "${docker_name}" 1> /dev/null; then
      state="$(docker inspect --format='{{.State.Running}}' "${docker_name}")"
      if [ "${state}" == "true" ]; then
        printf "🐳 '$ '%s' is already running\n" "${docker_name}"
      else
        printf "🐳 '$ '%s' is not running\n" "${docker_name}"
        docker start "${docker_name}" && printf "🐳 '$ '%s' was started\n" "${docker_name}"
      fi
    else
      printf "🐳 Deploying on port '%s' with path '%s'\n\n" "${exposed_port}" "${path}"
      docker run -d -p ${exposed_port}:80 --name "${docker_name}" \
        -e SERVER_HOSTNAME="${hostname}" \
        -e SECRET_KEY_BASE=secret \
        -v ${path}/pgdata:/var/openproject/pgdata \
        -v ${path}/assets:/var/openproject/assets \
        openproject/community:12 && printf "🐳 '$ '%s' is running\n" "${docker_name}"
    fi
  else
    error_print "Too many arguments"
  fi
# -> Killing the docker.
elif [ "${1,,}" == "kill" ]; then
  if [ "${#}" -eq "1" ]; then
    docker stop "${docker_name}" && printf "💀 Docker '%s' was killed\n" "${docker_name}"
  else
    error_print "Too many arguments"
  fi
# -> Checking if the first argument is "status" and if the number of arguments is 1. If it is, it will
#    print the state of the docker. If not, it will print an error message.
elif [ "${1,,}" == "status" ]; then
  if [ "${#}" -eq "1" ]; then
    printf "🚨 Docker '%s' is %s\n" "${docker_name}" "$(docker inspect --format='{{.State.Status}}' "${docker_name}")"
  else
    error_print "Too many arguments"
  fi
# -> Checking if the first argument is "help" and if the number of arguments is 1. If it is, it will
#    print the help message. If not, it will print an error message.
elif [ "${1,,}" == "help" ]; then
  if [ "${#}" -eq "1" ]; then
    Help
  else
    error_print "Too many arguments"
  fi
# -> Checking if the number of arguments is 0. If it is, it will print an error message.
else
  if [ "${#}" -eq "0" ]; then
    error_print "USAGE: $ gpro COMMAND\n————————"
  else
    error_print "Invalid argument(s)"
  fi
fi
