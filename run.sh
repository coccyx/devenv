#!/bin/sh
PWD=`pwd`
if [ "$(uname)" == "Darwin" ]; then
    DOCKERSOCK=/var/run/docker.sock
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    DOCKERSOCK=/var/run/docker.sock
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    DOCKERSOCK=//var/run/docker.sock
    PWD=`cygpath ${PWD}`
fi

for i in $(echo $PORT | sed "s/,/ /g")
do
    # call your procedure/other scripts here below
    PORTARGS="${PORTARGS} -p $i:$i"
done

if [ -z ${LOCALMOUNTDIR} ]; then
    LOCALMOUNTDIR=${PWD}
    if [[ ${LOCALMOUNTDIR} == "$HOME/go"* ]]; then
        MOUNTPOINT=$(echo ${LOCALMOUNTDIR} | sed "s*${HOME}**")
    else
        MOUNTPOINT=/$(basename ${LOCALMOUNTDIR})
    fi
fi

# Establish a home directory for this devenv
LOCALHOME=${HOME}/devenv_homes/${MOUNTPOINT}
if [ ! -d ${LOCALHOME} ]; then
    mkdir -p ${LOCALHOME}
    cp -Rp ${HOME}/.aws ${LOCALHOME}
    cp -Rp ${HOME}/.convox ${LOCALHOME}
fi

MSYS_NO_PATHCONV=1 docker run -e TERM ${PORTARGS} --privileged --rm -it -v ${LOCALHOME}:/root --tmpfs /root/.ssh -v $LOCALMOUNTDIR:$MOUNTPOINT -v ${HOME}/.ssh:/root/ssh -v ${DOCKERSOCK}:/var/run/docker.sock -w ${MOUNTPOINT} clintsharp/dev bash 
