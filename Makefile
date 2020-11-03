# use those 3 commands in Linux
docker-start:
	sudo systemctl start docker.service

docker-stop:
	sudo systemctl stop docker.service

docker-restart:
	sudo systemctl restart docker.service
################################################

docker-build:
	docker-compose build

docker-upd:
	docker-compose up -d

docker-up:
	docker-compose up

docker-down:
	docker-compose down

bi: # bundle install, not needed, use docker-build, however it will build everything
	cd cn_api && docker-compose run cn_api bundle install
db_c:
	docker-compose run cn_api rails db:create