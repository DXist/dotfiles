ARG BASE=python:3-stretch

FROM ${BASE}

ARG user=dev
ARG group=dev
ARG group_id=1000
ARG user_id=1000
ARG group_id=1000

RUN groupadd -g ${user_id} ${group} && useradd -m -u ${group_id} -g ${group} -G sudo ${user}

RUN apt-get update && apt-get install -y \
        sudo \
        curl \
        locales \
        python3-apt \
        python3-pip \
        && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

RUN sed -i 's/%sudo.\+/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers

RUN pip install ansible

#COPY --chown=dev:dev . /home/${user}/workspace/dotfiles
COPY . /home/${user}/workspace/dotfiles

RUN chown -R ${user}:${group} /home/${user}/workspace/dotfiles


USER ${user}

WORKDIR /home/${user}/workspace

RUN cd /home/${user}/workspace/dotfiles && ansible-playbook -i inventory.ini playbook.Debian.yml

RUN cd /home/${user}/workspace/dotfiles && nvim +PlugUpdate +qall

RUN bash -c ". /home/${user}/.bash_functions && install_dev_tools"
