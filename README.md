#PREREQ :: INSTALL DOCKER

Option1: manual install docker step by step in **docker-install-guide-manual.txt**

Option 2: automatic installl docker by run **docker-install.sh**

NEXT STEP >>

**CLONE CNODE DOCKER BUILD**

#* update git to automatically set line ending to LF

git config --global core.eol lf

git config --global core.autocrlf input

git clone https://github.com/truongcaoxuan/cnode-docker.git

#============================================================

# DOCKER BUILD CNODE : START!

#============================================================

**---- STEP1 ----**

docker pull cardanocommunity/cardano-node:stage1

**---- STEP2 ----**

docker build --force-rm -t vnpip/cnode:stage2 -f dockerfile_stage2 .

#docker tag IMAGE vnpip/cnode:stage2

**---- STEP3 ----**

**Build IMAGE have no db**

docker build --force-rm -t vnpip/cnode:stage3.0 -f dockerfile_stage3 .

docker build --force-rm --build-arg=NONEROOTUSER=vnpip -t vnpip/cnode:stage3.0 -f dockerfile_stage3 .

**Build IMAGE with db**

docker build --force-rm -t vnpip/cnode:stage3.1 -f dockerfile_stage3 .

docker build --force-rm --build-arg=NONEROOTUSER=vnpip -t vnpip/cnode:stage3.1 -f dockerfile_stage3 .

#============================================================

DOCKER BUILD CNODE : DONE! 

#============================================================

**--Tag IMAGE**

docker tag IMAGE vnpips/cnode:stage3.0

**RUNNING TEST CONTAINER**

docker network create cardano-mainnet

docker run -ti –privileged --rm --network=cardano-mainnet -p 6000:6000 -p 12798:12798 -p 9100:9100 --name relay1 vnpip/cnode:stage3.0

**RUNNING CONTAINER**

docker network create cardano-mainnet

docker run -dti --privileged --network=cardano-mainnet -p 6000:6000 -p 12798:12798 -p 9100:9100 --name relay1 vnpip/cnode:stage3.0


# --Docker Images

docker images

docker rmi IMAGES

# --Docker Container

docker ps

docker ps -a

docker rm CONTAINER

docker exec -ti CONTAINER /bin/bash

docker attach CONTAINER

**--Exit container**

Ctrl-P /Ctrl-Q

**--Start / Stop cnode**

nodestart

nodestop

**--crontab setting**

crontab -e

**--run gLiveView**

gLiveView

# --- PUSH IMAGE TO DOCKER HUB ---

docker login -u USER -p PASSWORD

**--Tag Build Images to Docker Hub Tag**

docker tag cardanocommunity/cardano-node:stage1 truongcx/cnode:stage1

docker tag vnpip/cnode:stage2 truongcx/cnode:stage2

docker tag vnpip/cnode:stage3.0 truongcx/cnode:stage3.0

docker tag vnpip/cnode:stage3.1 truongcx/cnode:stage3.1

**--Push Images to Docker Hub**

docker push truongcx/cnode:stage1

docker push truongcx/cnode:stage2

docker push truongcx/cnode:stage3.0

docker push truongcx/cnode:stage3.1

# --Source Docker Hub

https://hub.docker.com/r/truongcx/cnode

https://hub.docker.com/r/cardanocommunity/cardano-node

https://hub.docker.com/r/inputoutput/cardano-node

# --Source Dockerfile

https://github.com/cardano-community/guild-operators/tree/fa29ea533c33b1b561cd3faeb60fa03255f7b43b/files/docker/node

https://gitlab.com/viper-staking/docker-containers/-/tree/master/cardano-node
