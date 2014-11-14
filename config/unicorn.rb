worker_processes 3
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

GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

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

  if defined?(EventMachine)
      unless EventMachine.reactor_running? && EventMachine.reactor_thread.alive?
        if EventMachine.reactor_running?
          EventMachine.stop_event_loop
          EventMachine.release_machine
          EventMachine.instance_variable_set("@reactor_running",false)
        end
        Thread.new { EventMachine.run }
      end
  end

  EventMachine.error_handler{ |e|
    Rollbar.log(e, 'EM handler threw exception')
  }
end

Signal.trap("INT") { EventMachine.stop }
Signal.trap("TERM") { EventMachine.stop }
