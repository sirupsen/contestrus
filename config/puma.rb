#bind "unix:///app/shared/puma.sock"
bind "tcp://0.0.0.0:3000"
daemonize true
directory "/app/current"
environment "production"
pidfile "/app/shared/puma.pid"
state_path "/app/shared/puma.state"
stdout_redirect "/app/shared/log/puma_stdout", "/app/shared/log/puma_stderr", true
threads 8, 16
