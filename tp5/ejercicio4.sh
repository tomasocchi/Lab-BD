#!/bin/bash

# caida nodo3
sudo podman kill nodo3
sudo podman ps -a

# iniciar nodo3
sudo podman start nodo3

# caida nodo2
sudo podman kill nodo2
sudo podman ps -a

# iniciar nodo2
sudo podman start nodo2
