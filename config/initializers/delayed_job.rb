require "delayed_job"
require "delayed_job_active_record"

Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 1.minute
Delayed::Worker.default_queue_name = 'default'
Delayed::Worker.delay_jobs = Rails.env.production?
