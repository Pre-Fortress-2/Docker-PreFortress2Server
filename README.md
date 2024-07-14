# Pre-Fortress 2 Server with Docker
A Docker image to streamline and easily deploy new Pre-Fortress 2 servers. Requires [Docker](https://docker.com/) to be installed. Based off the [official Linux server guide](https://steamcommunity.com/sharedfiles/filedetails/?id=2737475433). The image is rebuilt automatically every week on Sunday with all the latest updates for everything.

# Tags
* [`latest`](Dockerfile.pf) - The latest basic server image of Pre-Fortress 2, with all files updated weekly.
* [`latest-sm`](Dockerfile.pfsm) - The latest server image of Pre-Fortress 2 with SourceMod, PF2-Tools and DHooks preinstalled, with all files updated weekly.
* [`_cache`](Dockerfile.cache) - The base image that is used to build the above two builds, Source SDK 2013 MP Base, and Pre-Fortress 2. Does not update often. DO NOT USE UNLESS DEBUGGING.

# Simple Guide - Setting up and deploying a simple server
0. First off, you'll want to [install Docker](https://docs.docker.com/engine/install/), this tutorial assumes you will be using Docker on some flavor of Linux, and know some basic stuff about Linux.
0. Next, you'll want to clone/download this repo, cd into the cloned repo and run `docker compose up` to run the server attached to your terminal.
0. The server will start up, first updating the SDK, then Pre-Fortress 2, and then properly start the server. You will see a message about root access, this is safe to ignore. You may also see a message about no map being specified, this is safe to ignore if a map is selected in autoexec.cfg (which there is by default, koth_crossover).
0. The output will say what its public IP is, indicating that the server is up and running an accessible. You can send a keyboard interrupt (ctrl+c) to stop the server.

Notes:
- If you want to run the server detached, you can run `docker compose up -d` to detach it from your terminal; you'll want to run `docker compose stop` if you want to stop the server if it's detached.
- You can access the server's files with the volumes created by Docker visiting [Docker Volumes instead of binds](README.md#Docker-Volumes-instead-of-binds)
- You can run `docker compose down` to remove the container and volumes for the server.
- You will still need to forward the ports 27005 and 27015 yourself on your router.

# Expert Guide - SourceMod, custom content, and more
If you know Docker pretty well or need some specific changes to the setup, you can change the [docker-compose.yml](docker-compose.yml). For example, if you'd like to run the server with SourceMod for plugins and better server management, edit the compose file to change the image tag from "latest" to "latest-sm".

To add/edit files to/on your server, certain directories for the server are exposed as Docker volumes, accessible at the `/var/lib/docker/volumes/` directory. There are volumes for the custom folder, cfg folder, and SourceMod folder, and you can use these to create more personalized servers for Pre-Fortress 2.

The Pre-Fortress 2 Docker Image bases the image off itself to simply update the files of the game. This is done with the Dockerfile.of file in the dockerfiles folder, however if you need to build the image from scratch the Dockerfile.cache file will be what you need to use.

## Troubleshooting
If you need to reset your images use `docker image prune -a` and if you need to reset containers use `docker container prune`. You can also use `docker image` or `container` for more options if you would like to remove specific images or containers instead.

## Testing local images
For PF2 we tested the docker images offline. You can create them by running `docker build . -t pfsv:latest -f ./dockerfiles/Dockerfile.cache` and then running `docker compose up`. This will run the server without connecting to docker's servers. In `docker-compose.yml` change `image: prefortress2/pfsv:latest` to `image: pfsv:latest`.


# License
This project's code is licensed under the MIT license, copyright Logan "NotQuiteApex" Hickok-Dickson. See [LICENSE.md](LICENSE.md) for more details.

This project pulls and uses assets belonging to multiple third-parties such as Valve Software or the Pre-Fortress 2 dev team. These assets do not fall under the license described above, and are subject to any terms described by the respective license holder(s).
