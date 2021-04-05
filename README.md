#============================

INSTALL DOCKER : START

#============================

#--Check Kernel version

uname -r

#--Check OS architecture

uname -m

#--SET UP THE REPOSITORY

#--Update the apt package index and

#--install packages to allow apt to use a repository over HTTPS:

sudo apt-get -y update

sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

#--Add Docker’s official GPG key:

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

#--Set up the stable repository #--x86_64 / amd64

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

#--INSTALL DOCKER ENGINE #--install the latest version of Docker Engine and containerd

sudo apt-get -y install docker-ce docker-ce-cli containerd.io

#--Verify that Docker Engine is installed correctly

sudo docker run hello-world

#--Set User docker sudo

sudo groupadd docker

sudo usermod -aG docker USER

Reboot OS

#============================

INSTALL DOCKER : DONE!

#============================

#============================

DOCKER BUILD CNODE : START!

#============================

#---- STEP1 ----

docker pull cardanocommunity/cardano-node:stage1

#---- STEP2 ----

docker build --force-rm -t vnpip/cnode:stage2 -f dockerfile_stage2 .

#docker tag IMAGE vnpip/cnode:stage2

#---- STEP3 ----

**Build IMAGE have no db**

docker build --force-rm -t vnpip/cnode:stage3.0 -f dockerfile_stage3 .

docker build --force-rm --build-arg=NONEROOTUSER=vnpip -t vnpip/cnode:stage3.0 -f dockerfile_stage3 .

**Build IMAGE with db**

docker build --force-rm -t vnpip/cnode:stage3.1 -f dockerfile_stage3 .

docker build --force-rm --build-arg=NONEROOTUSER=vnpip -t vnpip/cnode:stage3.1 -f dockerfile_stage3 .

#============================

DOCKER BUILD CNODE : DONE! 

#============================

**Tag IMAGE**

docker tag IMAGE vnpips/cnode:stage3.0

#---- TESTING ----

docker run -ti --rm -p 6000:6000 -p 12798:12798 -p 9100:9100 --name relay1 vnpip/cnode:stage3.0

docker run -ti --rm -p 6000:6000 -p 12798:12798 -p 9100:9100 --name relay1 vnpip/cnode:stage3.1

docker run -ti –privileged --rm -p 6000:6000 -p 12798:12798 -p 9100:9100 --name relay1 vnpip/cnode:stage3.0

#---- RUNNING ----

docker network create cardano-mainnet

docker run -dti --privileged --network=cardano-mainnet -p 6000:6000 -p 12798:12798 -p 9100:9100 --name relay1 vnpip/cnode:stage3.0

docker run -dti --security-opt=no-new-privileges --network=cardano-mainnet -p 6000:6000 -p 12798:12798 -p 9100:9100 --name relay1 vnpip/cnode:stage3.0

# Check Docker Images

docker images

# Check Docker Container

docker ps

docker ps -a

# Docker container exec / attach

docker exec -ti CONTAINER /bin/bash

docker attach CONTAINER

#-- Container operate
tmux a

Ctrl-B / D

Ctrl-P /Ctrl-Q

# --- DOCKER HUB ---

docker login -u USER -p PASSWORD

docker tag cardanocommunity/cardano-node:stage1 truongcx/cnode:stage1

docker tag vnpip/cnode:stage2 truongcx/cnode:stage2

docker tag vnpip/cnode:stage3.0 truongcx/cnode:stage3.0

docker tag vnpip/cnode:stage3.1 truongcx/cnode:stage3.1


docker push truongcx/cnode:stage1

docker push truongcx/cnode:stage2

docker push truongcx/cnode:stage3.0

docker push truongcx/cnode:stage3.1

#Source ref 

https://hub.docker.com/r/truongcx/cnode

https://hub.docker.com/r/cardanocommunity/cardano-node

https://github.com/cardano-community/guild-operators/tree/fa29ea533c33b1b561cd3faeb60fa03255f7b43b/files/docker/node

https://gitlab.com/viper-staking/docker-containers/-/tree/master/cardano-node
