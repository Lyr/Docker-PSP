# Docker-PSP
Minimalist Docker Container for the psp sdk and toolchain
Enjoy

## First Time Running
```
docker run --name=psp -it belldandu/psp:psp
```
The image will start `/start.sh` which will compile the sdk and toolchain for psp.

When it's done it will start a bash session for which you can do whatever in but for now we will just type `exit` which automatically stops the container.

## Running any time after the first time
```
docker start psp -i
```
Docker will start `/start.sh` again in the container but thanks to checks in place it will only start a bash session for you which you will be attached to.

## Stopping the container
To stop the container just type exit
