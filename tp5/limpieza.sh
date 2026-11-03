#!/bin/bash

# contenedores
sudo podman rm -f nodo1 nodo2 nodo3
sudo podman volume rm nodo1-datos nodo2-datos nodo3-datos
sudo podman network rm lbd-net
