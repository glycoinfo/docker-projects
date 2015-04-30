build:
	sudo docker build -t aoki/glytoucan-site .

run:
	sudo docker run -d -p 10000:80 -h local.glytoucan-site --link mf:mf --name="glytoucan-site" aoki/glytoucan-site

runtest:
	sudo docker run -d -p 10000:80 -h local.glytoucan-site --link mf:mf --name="glycoinfo-site" aoki/glytoucan-site

runmflocal:
	sudo docker run -it --rm -p 10010:80 --name mf -v "~/workspace/molecularframework/target/site":/var/www/html aokinobu/apache

runmftest:
	sudo docker run -it --rm -p 10010:80 --name mf -v "/mnt/jenkins/workspace/MolecularFramework/target/site":/var/www/html aokinobu/apache

cleanmf:
	sudo docker stop mf
	sudo docker rm mf

bash:
	sudo docker run --rm -it -p 10001:80 -h local.glytoucan-site --link mf:mf aoki/glytoucan-site /bin/bash

ps:
	sudo docker ps

stop:
	sudo docker stop glytoucan-site

rm:
	sudo docker rm glytoucan-site

logs:
	sudo docker logs glytoucan-site

ip:
	sudo docker inspect -f "{{ .NetworkSettings.IPAddress }}" glytoucan-site

restart:
	sudo docker restart glytoucan-site

inspect:
	sudo docker inspect aoki/glytoucan-site

rerun: stop rm rund

clean: build stop rm rund

# not tested
dump:
	sudo docker export glytoucan-site > glytoucan-site.glycoinfo.tar

# not tested
load:
	cat glytoucan-site.glycoinfo.tar | docker import - aoki/docker-glytoucan-site:glytoucan-site
	
.PHONY: build run test clean
