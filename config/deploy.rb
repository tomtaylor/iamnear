set :application, "iamnear"
set :deploy_to, "/opt/capistrano/#{application}"

set :scm, :git
set :repository, "/opt/git/repositories/iamnear.git"
set :local_repository, "#{File.dirname(__FILE__)}/../"
# set :repository, "ssh://git@localhost:2222:iamnear.git"
set :branch, "master"
set :deploy_via, :remote_cache

set :user, "rails"
set :group, "rails"
set :use_sudo, false

set :location, "kusanagi.tomtaylor.co.uk"
set :port, "22"
set :ssh_options, { :forward_agent => true }

role :app, location
role :web, location
role :db,  location, :primary => true

after "deploy:update_code", "symlink:db", "symlink:data"

namespace :symlink do
  
  desc "Symlink database yaml" 
  task :db do
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
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

# namespace :deploy do
#   %w(start stop restart).each do |action| 
#      desc "#{action} the Thin processes"  
#      task action.to_sym do
#        find_and_execute_task("thin:#{action}")
#     end
#   end 
# end
# 
# namespace :thin do  
#   %w(start stop restart).each do |action| 
#   desc "#{action} the app's Thin Cluster"  
#     task action.to_sym, :roles => :app do  
#       run "thin #{action} -c #{deploy_to}/current -C #{deploy_to}/shared/config/thin.yml" 
#     end
#   end
# end