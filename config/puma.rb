bind "tcp://0.0.0.0:4000"
directory "/app"
environment ENV["RAILS_ENV"]
pidfile "/var/run/puma.pid"
stdout_redirect "/app/log/puma_stdout.log", "/app/log/puma_stderr.log", true
threads 4, 8
restart_command "/app/bin/puma"
workers 2
