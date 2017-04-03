#!/bin/sh
docker run -t alpine date '+%Y-%m-%d %H:%M:%S'; date -u '+%Y-%m-%d %H:%M:%S'
docker run --net=host --ipc=host --uts=host --pid=host --security-opt=seccomp=unconfined --privileged --rm alpine date -s "`date -u '+%Y-%m-%d %H:%M:%S'`"
docker run -t alpine date '+%Y-%m-%d %H:%M:%S'; date -u '+%Y-%m-%d %H:%M:%S'
