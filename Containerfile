FROM blackarchlinux/blackarch:latest
LABEL com.github.containers.toolbox="true"

RUN pacman --noconfirm -Sy sudo && pacman --noconfirm -Sc
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel

RUN pacman -Syu --noconfirm

COPY missing-docs /
RUN pacman -S --noconfirm --needed $(<missing-docs)
RUN rm /missing-docs

COPY extra-packages /
RUN pacman -S --noconfirm --needed $(<extra-packages)
RUN rm /extra-packages

COPY blackarch-packages /
RUN pacman -S --noconfirm --needed $(<blackarch-packages)
RUN rm /blackarch-packages
