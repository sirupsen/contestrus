activate_control_app "unix:///app/shared/pumactl.sock"
bind "unix:///app/shared/puma.sock"
daemonize true
directory "/app/current"
environment "production"
pidfile "/app/shared/puma.pid"
state_path "/app/shared/puma.state"
stdout_redirect "/app/shared/log/puma_stdout", "/app/shared/log/puma_stderr", true
threads 4, 8

on_restart do
  ComedyWorker.stop
end
