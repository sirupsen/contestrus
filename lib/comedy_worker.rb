module ComedyWorker
  def self.perform(job)
    Thread.start do
      job.perform
    end
    nil
  end
end
