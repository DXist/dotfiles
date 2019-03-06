ARG BASE=debian:buster

FROM ${BASE}

ARG USER=user
ARG GROUP=user
ARG USER_ID=1000
ARG GROUP_ID=1000

USER root

RUN (getent group user || groupadd -g ${GROUP_ID} ${GROUP}) && (getent passwd ${USER} || useradd -m -u ${USER_ID} -g ${GROUP} ${USER})

RUN gpasswd -a ${USER} sudo

RUN apt-get update && apt-get install -y \
        sudo \
        curl \
        locales \
        locales-all \
        python3-apt \
        python3-pip \
        python3-dev \
        libffi-dev \
        libssl-dev \
        && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

RUN sed -i 's/%sudo.\+/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers

RUN pip3 install setuptools
RUN pip3 install ansible

#COPY --chown=dev:dev . /home/${USER}/workspace/dotfiles
COPY . /home/${USER}/workspace/dotfiles

RUN chown -R ${USER}:${group} /home/${USER}/workspace/dotfiles


USER ${USER}

WORKDIR /home/${USER}/workspace

RUN cd /home/${USER}/workspace/dotfiles && ansible-playbook -i inventory.ini playbook.Debian.yml

RUN cd /home/${USER}/workspace/dotfiles && nvim +PlugUpdate +qall

RUN pip3 install --user \
        mypy \
        pylint \
        pylama \
        isort \
        neovim \
        pdbpp \
        ipython
