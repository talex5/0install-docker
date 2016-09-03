FROM nfnty/arch-mini
RUN useradd -m user
RUN pacman --noconfirm -Sy
RUN pacman --noconfirm -S git sudo base-devel unzip
WORKDIR /home/user
RUN echo 'user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
USER user
RUN git clone https://aur.archlinux.org/package-query.git
RUN git clone https://aur.archlinux.org/yaourt.git
WORKDIR /home/user/package-query
RUN makepkg --noconfirm -si
WORKDIR /home/user/yaourt
RUN makepkg --noconfirm -si
RUN yaourt --noconfirm -Syu
# Uncomment to speed up rebuilds
#RUN yaourt --noconfirm -S opam

RUN gpg --recv-key AE07828059A53CC1
RUN echo '5DD58D70899C454A966D6A5175133C8F94F6E0CC:6:' | gpg --import-ownertrust
RUN yaourt --noconfirm -S zeroinstall-injector
