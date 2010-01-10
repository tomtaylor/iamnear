set :application, "iamnear"
set :deploy_to, "/srv/rails/#{application}"

set :scm, :git
set :repository, "git@github.com:tomtaylor/iamnear.git"
set :branch, "master"
set :deploy_via, :remote_cache

set :user, "rails"
set :group, "rails"
set :use_sudo, false

set :location, "glu"
set :port, "2222"
set :ssh_options, { :forward_agent => true }

role :app, location
role :web, location
role :db,  location, :primary => true

after "deploy:update_code", "symlink:db", "symlink:data", "symlink:keys"

namespace :symlink do
  
  desc "Symlink database yaml" 
  task :db do
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
  end
  
  desc "Symlink keys yaml" 
  task :keys do
    run "ln -s #{shared_path}/config/keys.yml #{release_path}/config/keys.yml" 
  end
  
  desc "Symlink data"
  task :data do
    run "ln -fs #{shared_path}/data #{release_path}"
  end

end

namespace :deploy do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
end