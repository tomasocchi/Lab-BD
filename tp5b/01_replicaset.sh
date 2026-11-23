podman pull docker.io/library/mongo:7
podman network create grupo1-mongo

podman run -d --name g1mongo1 --network grupo1-mongo docker.io/library/mongo:7 --replSet rsFAIBnB --bind_ip_all
podman run -d --name g1mongo2 --network grupo1-mongo docker.io/library/mongo:7 --replSet rsFAIBnB --bind_ip_all
podman run -d --name g1mongo3 --network grupo1-mongo docker.io/library/mongo:7 --replSet rsFAIBnB --bind_ip_all

podman exec -it g1mongo1 mongosh --eval 'rs.initiate({ _id: "rsFAIBnB", members: [ { _id: 0, host: "g1mongo1:27017" }, { _id: 1, host: "g1mongo2:27017" }, { _id: 2, host: "g1mongo3:27017" } ] })'

podman exec -it g1mongo1 mongosh --eval 'rs.status().members.map(m => m.name + "  " + m.stateStr)'



