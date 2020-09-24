build: docker-build create migrate 
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
foo:
	@echo "bar"
ops: 
	@echo "ops"
docker-build:
	@docker-compose build