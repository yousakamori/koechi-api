up:
	docker-compose up -d
build:
	docker-compose build
stop:
	docker-compose stop
restart:
	docker-compose restart
down:
	docker-compose down
destroy:
	docker-compose down --rmi all --volumes
cred:
	docker-compose exec -e EDITOR=vi app bin/rails credentials:edit
ps:
	docker-compose ps
logs:
	docker-compose logs
serve:
	docker-compose exec app ash -l
rserve:
	docker-compose down && docker-compose up -d && docker-compose exec app ash -l
rapp:
	docker-compose restart app && docker-compose exec app ash -l
rdb:
	docker-compose restart db && docker-compose exec db ash -l
rsp:
	docker-compose exec app bin/rspec
bi:
	docker-compose exec app bin/bundle install
mig:
	docker-compose exec app bin/rails db:migrate
migreset:
	docker-compose exec app bin/rails db:migrate:reset
sql:
	docker-compose exec db ash -c 'psql -U postgres koechi_development'
# 終了 => ctr + P ctr + Q
atapp:
	docker attach app
# dump:
# 	docker exec db pg_dump -a --column-inserts -t talks koechi_development -U postgres > sql_backup/talks.sql
# 	docker exec db pg_dump -a --column-inserts -t comments koechi_development -U postgres > sql_backup/comments.sql