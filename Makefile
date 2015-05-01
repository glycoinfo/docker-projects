build:
	sudo docker build -t aoki/glycoinfo-site .

run:
	sudo docker run -d -p 10000:80 -h local.glycoinfo-site -v /mnt/jenkins/workspace/MolecularFramework/target/site:/var/www/html/MolecularFramework -v /mnt/jenkins/workspace/glyspace/target/site:/var/www/html/glyspace -v /mnt/jenkins/workspace/batch/target/site:/var/www/html/batch --name="glycoinfo-site" aokinobu/apache

runtest:
	sudo docker run -d -p 10000:80 -h local.glycoinfo-site -v /mnt/jenkins/workspace/MolecularFramework/target/site:/var/www/html/MolecularFramework -v /mnt/jenkins/workspace/glyspace/target/site:/var/www/html/glyspace -v /mnt/jenkins/workspace/batch/target/site:/var/www/html/batch --name="glycoinfo-site" aokinobu/apache

rundev:
	sudo docker run -it --rm -p 10000:80 -h local.glycoinfo-site -v /home/aoki/workspace/molecularframework/target/site:/var/www/html/mf --name="glycoinfo-site" aokinobu/apache

runmflocal:
	sudo docker run -it --rm -p 10010:80 --name mf -v ~/workspace/molecularframework/target/site:/var/www/html/mf aokinobu/apache

runmftest:
	sudo docker run -it --rm -p 10010:80 --name mf -v "/mnt/jenkins/workspace/MolecularFramework/target/site":/var/www/html aokinobu/apache

cleanmf:
	sudo docker stop mf
	sudo docker rm mf

bash:
	sudo docker run --rm -it -p 10001:80 -h local.glycoinfo-site --link mf:mf aoki/glycoinfo-site /bin/bash

ps:
	sudo docker ps

stop:
	sudo docker stop glycoinfo-site

rm:
	sudo docker rm glycoinfo-site

logs:
	sudo docker logs glycoinfo-site

ip:
	sudo docker inspect -f "{{ .NetworkSettings.IPAddress }}" glycoinfo-site

restart:
	sudo docker restart glycoinfo-site

inspect:
	sudo docker inspect aoki/glycoinfo-site

rerun: stop rm rund

clean: build stop rm rund

# not tested
dump:
	sudo docker export glycoinfo-site > glycoinfo-site.glycoinfo.tar

# not tested
load:
	cat glycoinfo-site.glycoinfo.tar | docker import - aoki/docker-glycoinfo-site:glycoinfo-site
	
.PHONY: build run test clean
