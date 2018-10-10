FROM ubuntu:16.04

ARG python=python3
ARG user_id=1000
ARG group_id=1000

RUN groupadd -g ${user_id} dev && useradd -m -u ${group_id} -g dev -G sudo dev

RUN apt-get update && apt-get install -y \
        sudo \
        ${python} python-pip \
        curl \
        locales \
        && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

RUN sed -i 's/%sudo.\+/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers

RUN pip install ansible

COPY --chown=dev:dev . /home/dev/workspace/dotfiles

USER dev

WORKDIR /home/dev/workspace

RUN cd /home/dev/workspace/dotfiles && ansible-playbook -i inventory.ini playbook.Debian.yml

RUN cd /home/dev/workspace/dotfiles && nvim +PlugUpdate +qall

RUN bash -c ". /home/dev/.bash_functions && install_dev_tools"
