# Opensips control panel on Docker

![license](https://img.shields.io/github/license/mach1el/docker-opensips-cp?color=pink&style=plastic)
![Size](https://img.shields.io/github/repo-size/mach1el/docker-opensips-cp?style=plastic)
![imgsize](https://img.shields.io/docker/image-size/mich43l/opensips-cp?color=grey&style=plastic)

### Pull from hub
	docker pull mich43l/opensips-cp

### Build from source
	git clone https://github.com/mach1el/docker-opensips-cp.git && cd docker-opensips-cp
	docker image build -t docker-opensips-cp .
	
### Run
*	docker run -tid --rm --name=opensips-cp --network=host docker-rtpproxy
* docker run -tid --rm --name=opensips-cp --network=host -v /etc/apache2/:/etc/apache2 -v /var/www/html/opensips-cp:/var/www/html/opensips-cp
