ARG BASE=debian:buster

FROM ${BASE}

ARG PYTHON_VERSION=3.8
ARG USER=user
ARG GROUP=user
ARG USER_ID=1000
ARG GROUP_ID=1000

USER root

RUN (getent group user || groupadd -g ${GROUP_ID} ${GROUP}) && (getent passwd ${USER} || useradd -m -u ${USER_ID} -g ${GROUP} ${USER})

RUN gpasswd -a ${USER} sudo

RUN apt-get update && apt-get install -y --no-install-recommends gnupg gpg-agent dirmngr && \
        apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 55F96FCF8231B6DD \
        && echo 'deb http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu bionic main' > /etc/apt/sources.list.d/ppa_neovim_ppa_unstable_bionic.list \
        && apt-get update && apt-get install -y --no-install-recommends \
        sudo \
        ca-certificates \
        curl \
        locales \
        locales-all \
        neovim \
        less \
        git \
        git-lfs \
        exuberant-ctags \
        cmake \
        build-essential \
        tar \
        rsync \
        silversearcher-ag \
        tmux \
        bash-completion \
        ncurses-term \
        jq \
        && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

RUN sed -i 's/%sudo.\+/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers

RUN test -x /opt/conda/bin/conda || (curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install -y python=$PYTHON_VERSION && \
     /opt/conda/bin/conda clean -ya)

RUN ln -s /opt/conda/bin/pip /opt/conda/bin/pip3

USER ${USER}

ENV PATH=/home/user/.local/bin:/opt/conda/bin:$PATH

WORKDIR /home/${USER}/workspace

COPY --chown=user:user . /home/${USER}/workspace/dotfiles

RUN pip install --user ansible && cd /home/${USER}/workspace/dotfiles && ansible-playbook -i inventory.ini playbook.Debian.yml --skip-tags=system_reqs,pippackages

RUN cd /home/${USER}/workspace/dotfiles && nvim +PlugUpdate +qall

RUN cd /home/${USER}/workspace/dotfiles && ansible-playbook -i inventory.ini playbook.Debian.yml --tags=pippackages
