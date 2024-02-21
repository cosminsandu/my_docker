up:
	docker compose up -d --build
down:
	docker compose down
purge:
	docker compose down --volumes
install:
	docker compose exec -u www-data web composer install --no-interaction --no-progress --no-suggest
	docker compose exec -u www-data web php bin/console cache:warmup
docker-install:
	docker compose build
	docker compose up -d
	docker compose exec -u www-data web composer install --no-interaction --no-progress --no-suggest
	docker compose exec -u www-data web php bin/console cache:warmup
	docker compose exec -u www-data web php bin/console doctrine:database:create --if-not-exists
ci:
	docker compose exec -u www-data web composer audit
	docker compose exec -u www-data web composer validate --strict
	docker compose exec -u www-data web bin/console lint:container
ssh:
	docker compose exec -u www-data web bash
ssh-root:
	docker compose exec web bash
mysql:
	docker compose exec mysql mariadb -uroot -potDtyEfdSRGkUIG
update-branch:
	git fetch -a
	git checkout $(branch)
	git pull
	docker compose exec -u www-data web php bin/console doctrine:cache:clear-metadata
	docker compose exec -u www-data web php bin/console doctrine:cache:clear-query
	docker compose exec -u www-data web php bin/console doctrine:cache:clear-result
	docker compose exec -u www-data web php bin/console doctrine:migrations:migrate -n --allow-no-migration
	docker compose exec -u www-data web composer install --no-interaction --no-progress --no-suggest
	docker compose exec -u www-data web php bin/console cache:warmup
cache-clear:
	docker compose exec -u www-data web php bin/console cache:clear
	docker compose exec -u www-data web php bin/console cache:warmup
