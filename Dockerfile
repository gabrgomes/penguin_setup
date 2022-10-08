FROM ubuntu:20.04
LABEL org.opencontainers.image.authors="gabrgomes@gmail.com"

RUN apt update && \
    apt install -y python3-pip sudo && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    pip3 install ansible

RUN mkdir -p /penguin_setup && \
    useradd penguin -d /penguin_setup -G sudo && \
    chown penguin:penguin /penguin_setup && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER penguin
WORKDIR /penguin_setup
COPY requirements.yml /penguin_setup/
RUN ansible-galaxy install -r requirements.yml

COPY . /penguin_setup/

# ENTRYPOINT ["ansible-playbook", "setup_penguin.yml"]
ENTRYPOINT ansible-playbook setup_penguin.yml -t ${TAGS-'all'}