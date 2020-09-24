install: build create migrate yarn
migrate:
	@docker-compose run --rm cashback_app bundle exec rails db:migrate
create:
	@docker-compose run --rm cashback_app bundle exec rails db:create
reset:
	@docker-compose run --rm cashback_app bundle exec rails db:reset
tests:
	@docker-compose run --rm cashback_app bundle exec rspec -f d
run:
	@docker-compose up
yarn:
	@docker-compose run --rm cashback_app yarn install
foo:
	@echo "bar"
ops: 
	@echo "ops"
build:
	@docker-compose build