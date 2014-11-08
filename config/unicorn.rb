worker_processes 4
base_dir = "."
shared_path = "."
working_directory base_dir
rails_env = ENV['RAILS_ENV'] || 'production'

preload_app true

# we destroy all workers who are taking too long
timeout 30

# This is where we specify the socket.
# We will point the upstream Nginx module to this socket later on
listen 3500

pid "#{shared_path}/pids/unicorn.pid"

# Set the path of the log files inside the log folder of the testapp
stderr_path "#{shared_path}/log/unicorn.stderr.log"
stdout_path "#{shared_path}/log/unicorn.stdout.log"

before_fork do |server, worker|
# This option works in together with preload_app true setting
# What is does is prevent the master process from holding
# the database connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
# Here we are establishing the connection after forking worker
# processes
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
