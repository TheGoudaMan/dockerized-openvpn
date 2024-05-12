build:
	$(eval IP_ADDRESS := $(shell curl -s https://api.ipify.org))
	docker-compose run --rm openvpn ovpn_genconfig -u udp://$(IP_ADDRESS):1194
	docker-compose run --rm openvpn ovpn_initpki

start-server:
	docker-compose up -d

clean:
	docker-compose down -v
	docker rmi -f $(shell docker images -q)

# make create-client CLIENTNAME=YOUR_CLIENT_NAME
create-client:
	docker-compose run --rm openvpn easyrsa build-client-full $(CLIENTNAME) nopass
	mkdir -p keys 
	docker-compose run --rm openvpn ovpn_getclient $(CLIENTNAME) > keys/$(CLIENTNAME).ovpn

create-client-linux:
	docker-compose run --rm openvpn easyrsa build-client-full $(CLIENTNAME) nopass
	mkdir -p keys 
	docker-compose run --rm openvpn ovpn_getclient $(CLIENTNAME) > keys/$(CLIENTNAME).ovpn
	cat linux_dns_leak >> keys/$(CLIENTNAME).ovpn

create-client-dns:
	docker-compose run --rm openvpn easyrsa build-client-full $(CLIENTNAME) nopass
	mkdir -p keys 
	docker-compose run --rm openvpn ovpn_getclient $(CLIENTNAME) > keys/$(CLIENTNAME).ovpn
	cat dns_server >> keys/$(CLIENTNAME).ovpn

revoke-client:
	docker-compose exec openvpn easyrsa revoke $(CLIENT_NAME)
	docker-compose exec openvpn easyrsa gen-crl
	docker-compose exec openvpn cp /etc/openvpn/pki/crl.pem /etc/openvpn/crl.pem
