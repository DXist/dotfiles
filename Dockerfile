ARG BASE=ubuntu:21.04

FROM ${BASE}

ARG PYTHON_VERSION=3.8
ARG USER=user
ARG GROUP=user
ARG USER_ID=1000
ARG GROUP_ID=1000
ENV DEBIAN_FRONTEND NONINTERACTIVE

USER root

RUN (getent group ${GROUP} || groupadd -g ${GROUP_ID} ${GROUP}) && (getent passwd ${USER} || useradd -m -u ${USER_ID} -g ${GROUP} ${USER})

RUN gpasswd -a ${USER} sudo

RUN apt-get update && apt-get install -y --no-install-recommends gnupg gpg-agent dirmngr && \
        apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 55F96FCF8231B6DD \
        && echo 'deb http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu focal main' > /etc/apt/sources.list.d/ppa_neovim_ppa_unstable_focal.list \
        && apt-get update && apt-get install -y --no-install-recommends \
        sudo \
        ca-certificates \
        curl \
        locales \
        neovim \
        less \
        git \
        git-lfs \
        ssh-client \
        exuberant-ctags \
        ripgrep \
        cmake \
        build-essential \
        rsync \
        silversearcher-ag \
        tmux \
        bash-completion \
        ncurses-term \
        jq \
        && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

RUN sed -i 's/%sudo.\+/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers

RUN mkdir -p /opt/ && chown ${USER}:${GROUP} /opt/

USER ${USER}

RUN test -x /opt/conda/bin/conda || (curl -o ~/miniconda.sh -O  https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda update --all --yes && \
     /opt/conda/bin/conda config --set auto_update_conda False && \
     /opt/conda/bin/conda install -y python=$PYTHON_VERSION && \
     /opt/conda/bin/conda clean -yaf && \
     find /opt/conda/ -follow -type f -iname '*.a' -o -iname '*.pyc' -o -iname '*.js.map' -delete \
     )
ENV PATH=/home/${USER}/.local/bin:/opt/conda/bin:$PATH

RUN curl -Lo /tmp/buildkit.tar.gz https://github.com/moby/buildkit/releases/download/v0.8.1/buildkit-v0.8.1.linux-amd64.tar.gz && tar -xzf /tmp/buildkit.tar.gz -C /tmp && mkdir -p /home/${USER}/.local/bin && mv /tmp/bin/buildctl /home/${USER}/.local/bin/ && chmod +x /home/${USER}/.local/bin/buildctl && rm -rf /tmp/*

RUN curl -Lo /tmp/docker.tar.gz https://download.docker.com/linux/static/stable/x86_64/docker-20.10.2.tgz && tar -xzf /tmp/docker.tar.gz -C /tmp && mv /tmp/docker/docker /home/${USER}/.local/bin/ && rm -rf /tmp/*

WORKDIR /home/${USER}/workspace

RUN ssh-keygen -t ed25519 -f /home/user/.ssh/id_ed25519 -P ''

COPY --chown=${USER}:${GROUP} . /home/${USER}/workspace/dotfiles

RUN pip install --user --no-cache-dir ansible && cd /home/${USER}/workspace/dotfiles && ansible-playbook -i inventory.ini playbook.Debian.yml --skip-tags=system_reqs,pippackages

RUN cd /home/${USER}/workspace/dotfiles && nvim +PlugUpdate +qall

RUN cd /home/${USER}/workspace/dotfiles && ansible-playbook -i inventory.ini playbook.Debian.yml --tags=pippackages
