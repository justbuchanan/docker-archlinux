FROM base/archlinux
MAINTAINER Justin Buchanan <justbuchanan@gmail.com>

# update packages and install some tools
RUN pacman -Syyu --noconfirm base-devel vim tmux

# upgrade db
RUN pacman-db-upgrade

# clear package cache to save disk space
RUN pacman -Scc --noconfirm

ENV PATH "/usr/bin/core_perl:$PATH"

# install pacaur
ADD /sudoers.txt /etc/sudoers
RUN useradd -m tst
RUN usermod -a -G wheel tst
COPY pacaur.sh ./
RUN su tst -c ./pacaur.sh
RUN rm pacaur.sh
