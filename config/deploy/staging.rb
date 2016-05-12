set :stage, :staging
set :branch, :master

set :rails_env, :staging

set :application, 'tricky_log_staging'
set :deploy_user, 'ubuntu'
set :thin_dir, 'tmp/pids'
set :nginx_user, 'ubuntu'

set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/#{fetch(:application)}"

set :enable_ssl, false

server '192.168.11.10', user: 'ubuntu', roles: %w{web app db}

namespace :deploy do

  desc "Upload secrets files{database.yml,secrets.yml}."
  task :copy_config_files do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read("config/database.yml")), "#{shared_path}/config/database.yml"
      upload! StringIO.new(File.read("config/secrets.yml")), "#{shared_path}/config/secrets.yml"
      upload! StringIO.new(File.read("config/thin_config.yml")), "#{shared_path}/config/thin_config.yml"
      upload! StringIO.new(File.read("config/nginx.conf")), "/etc/nginx/sites-enabled/#{fetch(:application)}"
    end
  end

  task :link_config_files do
    on roles(:app) do
      execute "ln -sf #{deploy_to}/shared/config/*.yml #{deploy_to}/current/config/"
    end
  end

  desc "Symlinks config files for Nginx and Thin"
  task :config_nginx do
    on roles(:app) do
      execute "rm -rf /etc/nginx/sites-enabled/default"
      execute "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{fetch(:application)}"
    end
  end

  # desc "Symlinks config files for current distributed version"
  # task :release do
  #   puts 'Symlink release to current (relative)'.upcase
  #   require 'pathname'
  #   rel_release_path = Pathname.new(release_path).relative_path_from(Pathname.new(deploy_to)).to_s
  #   on release_roles :all do
  #     execute :rm, '-rf', current_path
  #     execute :ln, '-s', rel_release_path, current_path
  #   end
  # end

  task :start_thin_server  do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute :bundle, "exec thin start -C #{current_path}/config/thin_config.yml"
      end
    end
  end

  task :stop_thin_server do
    on roles(:app) do
      within shared_path do
        execute :find, <<-BASH
          #{fetch(:thin_dir)} -name '*thin*' | while read line; do
            kill -s USR2 `cat $line`
          done
        BASH
      end
    end
  end

  task :restart_thin_server do
    on roles(:app) do
      invoke "deploy:stop_thin_server"
      invoke "deploy:start_thin_server"
    end
  end

  task :restart_nginx do
    on roles fetch(:nginx_user) do
      sudo :service, "nginx", "restart"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
  after :finishing, 'deploy:cleanup'

end

before :deploy, "deploy:copy_config_files"
before :deploy, "deploy:config_nginx"

# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# server 'db.example.com', user: 'deploy', roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any  hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
