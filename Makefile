RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

# use those 3 commands in Linux
docker-start:
	sudo systemctl start docker.service

docker-stop:
	sudo systemctl stop docker.service

docker-restart:
	sudo systemctl restart docker.service

################################################
# Docker ops

docker-build:
	docker-compose build

docker-upd:
	docker-compose up -d

docker-up:
	docker-compose up

docker-down:
	docker-compose down

#docker-chown:
#	cd cn_api && sudo chown -R $USER:$USER . && cd .. && cd cn_front && sudo chown -R $USER:$USER .


################################################
# RAILS

bundle-install: #if we install new gems, we will need to build docker again
	docker-compose run cn_api bundle install

rspec-i:
	docker-compose run cn_api bundle exec rails generate rspec:install

tests:
	docker-compose run cn_api bundle exec rails spec

test:
	docker-compose run cn_api bundle exec rails spec $(RUN_ARGS)

run-rails-console:
	docker-compose run cn_api bundle exec rails console

run-generate:
	docker-compose run cn_api bundle exec rails generate $(RUN_ARGS)

db-create:
	docker-compose run cn_api bundle exec rails db:create

db-migrate:
	docker-compose run cn_api bundle exec rails db:migrate

db-reset:
	docker-compose run cn_api bundle exec rails db:reset

db-up:
	docker-compose run cn_api bundle exec rails db:up

db-down:
	docker-compose run cn_api bundle exec rails db:down

add-migration:
	docker-compose run cn_api bundle exec rails g migration $(RUN_ARGS)

add-model:
	docker-compose run cn_api bundle exec rails g model $(RUN_ARGS)


# VUEJS