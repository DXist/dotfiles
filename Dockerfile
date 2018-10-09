FROM ubuntu:16.04

ARG python=python

RUN groupadd -g 999 user && useradd -m -u 999 -g user -G sudo user

RUN apt-get update && apt-get install -y \
        sudo \
        ${python} python-pip \
        curl \
        locales \
        && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

RUN sed -i 's/%sudo.\+/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers

RUN pip install ansible

COPY --chown=user:user . /home/user/workspace/dotfiles

USER user

WORKDIR /home/user/workspace

RUN cd /home/user/workspace/dotfiles && ansible-playbook -i inventory.ini playbook.Debian.yml

RUN cd /home/user/workspace/dotfiles && nvim +PlugUpdate +qall
