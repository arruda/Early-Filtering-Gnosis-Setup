#!/bin/bash

sudo steamos-readonly disable
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman -S docker
sudo docker version

sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo pacman -S docker-compose
sudo docker login registry.insight-centre.org