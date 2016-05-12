# config valid only for current version of Capistrano
lock '3.4.0'

# set :application, 'tricky_log'
# set :deploy_user, 'ubuntu'
# set :thin_pid, "tmp/pids/thin.0.pid"
# set :nginx_user, 'ubuntu'


set :scm, :git
set :repo_url, 'git://github.com/matrixbirds/trickylog.git'

set :rbenv_type, :user
set :rbenv_ruby, '2.3.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set :keep_releases, 1

set :linked_files, %w{config/database.yml config/secrets.yml}

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
