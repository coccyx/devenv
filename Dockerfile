FROM golang
RUN apt-get update && apt-get install -y vim graphviz bsdmainutils tmux screen netcat net-tools python-pip python-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev zlib1g-dev libyaml-dev groff mysql-client unzip
RUN pip install awscli
RUN go get github.com/uber/go-torch \
    && cd $GOPATH/src/github.com/uber/go-torch \
    && git clone https://github.com/brendangregg/FlameGraph.git \
    && go get github.com/tools/godep \
    && go get github.com/derekparker/delve/cmd/dlv
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g grunt-cli typescript webpack @angular/cli vue-cli
RUN apt-get install -y apt-transport-https ca-certificates gnupg2 \
    && apt-key adv \
       --keyserver hkp://ha.pool.sks-keyservers.net:80 \
       --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
    && echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list \
    && apt-get update && apt-get install -y docker-engine
RUN cd /tmp \
    && curl -SLO "https://s3.amazonaws.com/codeship-jet-releases/1.16.0/jet-linux_amd64_1.16.0.tar.gz" \
    && tar -xaC /usr/local/bin -f jet-linux_amd64_1.16.0.tar.gz \
    && chmod +x /usr/local/bin/jet \
    && rm jet-linux_amd64_1.16.0.tar.gz
RUN curl -Ls https://convox.com/install/linux.zip > /tmp/convox.zip \
    && unzip /tmp/convox.zip -d /usr/local/bin \
    && rm /tmp/convox.zip
COPY entrypoint.sh /entrypoint.sh
VOLUME ["/var/run/docker.sock"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
