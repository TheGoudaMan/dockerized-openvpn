build:
	$(eval IP_ADDRESS := $(shell curl -s https://api.ipify.org))
	docker-compose run --rm openvpn ovpn_genconfig -u udp://$(IP_ADDRESS):1194
	docker-compose run --rm openvpn ovpn_initpki

# make create-client CLIENTNAME=YOUR_CLIENT_NAME
create-client:
	docker-compose run --rm openvpn easyrsa build-client-full $(CLIENTNAME) nopass
	docker-compose run --rm openvpn ovpn_getclient $(CLIENTNAME) > keys/$(CLIENTNAME).ovpn

revoke-client:
	docker-compose exec openvpn easyrsa revoke $(CLIENT_NAME)
	docker-compose exec openvpn easyrsa gen-crl
	docker-compose exec openvpn cp /etc/openvpn/pki/crl.pem /etc/openvpn/crl.pem

revoke-client:
	docker-compose exec openvpn easyrsa revoke $(CLIENT_NAME)
	docker-compose exec openvpn easyrsa gen-crl
	docker-compose exec openvpn cp /etc/openvpn/pki/crl.pem /etc/openvpn/crl.pem
