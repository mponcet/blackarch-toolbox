FROM docker.io/blackarchlinux/blackarch:latest
LABEL com.github.containers.toolbox="true"

RUN pacman --noconfirm -Sy sudo && pacman --noconfirm -Sc
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel

RUN pacman -Syu --noconfirm && pacman -Sy --noconfirm pacman-contrib

COPY missing-docs /
RUN pacman -S --noconfirm --needed $(<missing-docs) && paccache -rk0
RUN rm /missing-docs

COPY extra-packages /
RUN pacman -S --noconfirm --needed $(<extra-packages) && paccache -rk0
RUN rm /extra-packages

COPY blackarch-packages /
RUN pacman -S --noconfirm --needed $(<blackarch-packages) && paccache -rk0
RUN rm /blackarch-packages
