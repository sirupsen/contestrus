namespace :submissions do
  desc "Requeue all unevaluated submissions"
  task :requeue => :environment do
    Submission.find_each do |submission|
      submission.queue_evaluation if submission.evaluations.empty?
    end
  end
end
