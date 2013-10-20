require "thread"

ComedyWorker = Queue.new

def ComedyWorker.work!
  Thread.start do
    loop do
      begin
        ComedyWorker.deq.perform
      rescue Exception => e
        $stderr.puts "Exception in background job! #{e}: #{e.message}\n#{e.backtrace.join("\n")}"
      end
    end
  end
end
