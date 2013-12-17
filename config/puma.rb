bind "unix:///app/shared/puma.sock"
directory "/app/current"
environment "production"
pidfile "/app/shared/puma.pid"
stdout_redirect "/app/shared/log/puma_stdout", "/app/shared/log/puma_stderr", true
threads 4, 8
restart_command "/app/current/bin/puma"
workers 2
