lock '~> 3.17.0'

set :application, 'koechi'
set :repo_url, 'git@github.com:yousakamori/koechi-api.git'
set :rbenv_ruby, File.read('.ruby-version').strip
set :branch, ENV['BRANCH'] || 'main'

# Nginxの設定ファイル名と置き場所を修正
set :nginx_config_name, "#{fetch(:application)}.conf"
set :nginx_sites_enabled_path, '/etc/nginx/conf.d'

# リリースをどこまで残すか
set :keep_releases, 3

append :linked_files, 'config/master.key'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets'

# デプロイ用の追加タスク
namespace :deploy do
  # desc 'Make sure local git is in sync with remote.'
  # task :check_revision do
  #   on roles(:app) do
  #     unless `git rev-parse HEAD` == `git rev-parse origin/main`
  #       # exit
  #     end
  #   end
  # end

  # desc 'reload the database with seed data'
  # task :seed do
  #   on roles(:db) do
  #     with rails_env: fetch(:rails_env) do
  #       within release_path do
  #         execute :bundle, :exec, :rails, 'db:seed'
  #       end
  #     end
  #   end
  # end

  # before :starting,     :check_revision
  # after  :migrate,      :seed
end
