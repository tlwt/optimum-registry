FROM ubuntu:18.04

RUN apt update
RUN apt install -y wget
#RUN apt install lsof

RUN wget https://github.com/smallstep/cli/releases/download/v0.14.0-rc.4/step-cli_0.14.0-rc.4_amd64.deb && dpkg -i step-cli_0.14.0-rc.4_amd64.deb
RUN wget https://github.com/smallstep/certificates/releases/download/v0.14.0-rc.9/step-certificates_0.14.0-rc.8_amd64.deb && dpkg -i step-certificates_0.14.0-rc.8_amd64.deb

RUN wget https://dl.google.com/go/go1.14.1.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.14.1.linux-amd64.tar.gz

ENV PATH=$PATH:/usr/local/go/bin

ADD password.txt password.txt
ADD srv.go srv.go
ADD starter_script.sh starter_script.sh

RUN chmod +x starter_script.sh
CMD ./starter_script.sh
