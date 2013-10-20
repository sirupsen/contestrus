require "thread"

ComedyWorker = Queue.new

def ComedyWorker.working?
  @working
end

def ComedyWorker.stop
  @working = false
  self << :kill
end

def ComedyWorker.work!
  @working = true
  Thread.start do
    while working?
      begin
        job = ComedyWorker.deq
        break if job == :kill
        job.perform
      rescue Exception => e
        $stderr.puts "Exception in background job! #{e}: #{e.message}\n#{e.backtrace.join("\n")}"
      end
    end
  end
end
