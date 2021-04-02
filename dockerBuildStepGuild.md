
****---- STEP1 ----****
docker pull cardanocommunity/cardano-node:stage1

****---- STEP2 ----****
docker build --force-rm -t vnpip/cnode:stage2 -f dockerfile_stage2 .

#docker tag IMAGE vnpip/cnode:stage2

****---- STEP3 ----****
# Build IMAGE have no db

docker build --force-rm -t vnpip/cnode:stage3.0 -f dockerfile_stage3 .
docker build --force-rm --build-arg=NONEROOTUSER=vnpip -t vnpip/cnode:stage3.0 -f dockerfile_stage3 .

# Build IMAGE with db

docker build --force-rm -t vnpip/cnode:stage3.1 -f dockerfile_stage3 .
docker build --force-rm --build-arg=NONEROOTUSER=vnpip -t vnpip/cnode:stage3.1 -f dockerfile_stage3 .

# Tag IMAGE

docker tag IMAGE vnpips/cnode:stage3.0

****---- TESTING ----****

docker run -ti --rm -p 6000:6000 -p 12798:12798 -p 9100:9100 --name vnpip-cnode-relay vnpip/cnode:stage3.0
docker run -ti --rm -p 6000:6000 -p 12798:12798 -p 9100:9100 --name vnpip-cnode-relay vnpip/cnode:stage3.1

docker run -ti –privileged --rm -p 6000:6000 -p 12798:12798 -p 9100:9100 --name vnpip-cnode-relay vnpip/cnode:stage3.0

****---- RUNNING ----****
docker run -dti --privileged -p 6000:6000 -p 12798:12798 -p 9100:9100 --name vnpip-cnode-relay vnpip/cnode:stage3.0

docker images
docker ps
docker exec -ti CONTAINER /bin/bash
docker attach CONTAINER

tmux a
Ctrl-B / D

