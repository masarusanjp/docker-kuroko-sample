root = File.expand_path('../../..', __FILE__)

working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

# listen '/tmp/unicorn.sock'
listen 8080
worker_processes 3
timeout 30

stderr_path "#{root}/log/unicorn_error.log"
stdout_path "#{root}/log/unicorn.log"
