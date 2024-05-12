# dockerized-openvpn
1. Install Docker & docker-compose & make on your system
2. Start Docker daemon
## Use Makefile for basic management of openvpn server
1. ```make build``` - initiate openvpn server and generate basic config for it
2. ```make start-server```
3. To create new client: ```make create-client CLIENTNAME=YOUR_CLIENT_NAME``` 
4. May use ```make create-client-dns CLIENTNAME=YOUR_CLIENT_NAME``` to specify 8.8.8.8 8.8.4.4 DNS servers should be used.
5. May also use ```make create-client-linux CLIENTNAME=YOUR_CLIENT_NAME``` to specify 8.8.8.8 8.8.4.4 DNS server and fix linux specific DNS leak
6. Newly generated .ovpn files are stored in /keys directory and are ready to be shared to client
7. ```make clean``` to destroy service 
